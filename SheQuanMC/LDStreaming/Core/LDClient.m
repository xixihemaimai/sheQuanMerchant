//
//  LDClient.m
//  LDStreaming
//
//  Created by 千亦 on 2021/7/13.
//

#import "LDClient.h"
#import "LDConfig.h"
#import "LDMessage.h"
#import "LDSocket.h"
#import "LDAckIdGenerater.h"
#import <LDMessage/ProtobufPacket.pbobjc.h>
#import <LDMessage/MsgInfo.h>

@interface LDClient() <LDSocketDelegate>

@property (nonatomic, strong) LDConfig *config;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSHashTable *> *observers;
@property (nonatomic, strong) NSMutableDictionary<NSString *, LDStreamingRequest *> *acks;

@property (nonatomic, weak) id<LDSocketEvent> delegate;

@end

@implementation LDClient {
    LDSocket *_socket;
    BOOL _stop;
    dispatch_queue_t _socketsQueue;
    dispatch_queue_t _opQueue;
}

+ (instancetype)shared {
    static LDClient *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[super allocWithZone:NULL] init];
    });
    return _sharedSingleton;
}

#pragma mark - config and setup

+ (void)setupWithListener:(id<LDSocketEvent>) delegate {
    LDClient *client = [LDClient shared];
    client.delegate = delegate;
    [client connect];
}

- (instancetype)init {
    self = [super init];
    
    _socketsQueue = dispatch_queue_create("LDClient.sockets", DISPATCH_QUEUE_SERIAL);
    _opQueue = dispatch_queue_create("LDClient.op", DISPATCH_QUEUE_SERIAL);
    
    
    self.observers = [NSMutableDictionary new];
    self.acks = [NSMutableDictionary new];
    
    return self;
}

+ (void)stop {
    [[LDClient shared] stop];
}

- (void)stop {
    dispatch_async(_opQueue, ^{
        _stop = YES;
        [self->_socket close];
        self->_socket = nil;
    });
}

- (void)start {
    [self connect];
}

- (void)connect {
    dispatch_async(_opQueue, ^{
        _stop = NO;
        if (self->_socket) {
            return;
        }
        
        self->_socket = [[LDSocket alloc] init];
        self->_socket.delegate = self;
        
        NSError* connectError;
        NSLog(@"connect to host %@", LDConfig.shared.host);
        if (![self->_socket connectToHost:LDConfig.shared.host
                                   onPort:LDConfig.shared.port
                                    error:&connectError]) {
            NSLog(@"connect error %@", connectError);
            [self reConnect];
        }
    });
}

- (void)reConnect {
    if (_stop) return;
    self->_socket = nil;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(LDConfig.shared.keepliveInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self connect];
    });
}

#pragma mark - socket delegate

- (void)socket:(LDSocket *)socket didConnectToHost:(NSString *)host port:(uint16_t)port {
    _socket = socket;
    NSLog(@"connect success");
    if ([self.delegate respondsToSelector:@selector(onConnect:)]){
        [self.delegate onConnect:self];
    }
}

- (void)socket:(LDSocket *)socket didDisconnectWithError:(NSError *)err {
    NSLog(@"connect lost %@", err);
    [self stop];
    [self reConnect];
    if ([self.delegate respondsToSelector:@selector(onDisConnect:)]) {
        [self.delegate onDisConnect:self];
    }
}

- (void)socket:(LDSocket *)socket didReadPackage:(DLMPacketInfo *)message {
    NSLog(@"msg read ====== : %@", [MsgInfo eventName:message.eventType]);
    NSLog(@"msg data: %@", message);
    int64_t type = message.eventType;
    int64_t ackId = message.ackId;
    if (message.status == ResponseUnAuthorized) {
        if ([self.delegate respondsToSelector:@selector(onLogoff:)]) {
            [self.delegate onLogoff:self];
        }
        return;
    }
    if (type == EventConnect) {
    }
    else if (type == EventDisconnect) {
    }
    else if (type == EventAck) {
        [self doResponse:message];
    }
    else if (type >= 100) {
        [self doEvents:message];
    }
}

- (void)doResponse:(DLMPacketInfo *)message {
    LDStreamingRequest *request = [self popRequest:message.ackId];
    if (!request) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        request.response(message);
    });
}

- (void)doEvents:(DLMPacketInfo *)message {
    int32_t eventType = message.eventType;
    NSString *eventKey = @(eventType).stringValue;
    NSHashTable *obs = [self.observers valueForKey:eventKey];
    dispatch_async(dispatch_get_main_queue(), ^{
        for(id<LDSocketMessageListener> ob in obs.objectEnumerator) {
            [ob onReceiveMessage:message];
        }
    });
}

#pragma mark - message actions

+ (BOOL)sendData:(NSData *)data {
    return [LDClient.shared sendData:data];
}

- (BOOL)sendData:(NSData *)data {
    if (!_socket) {
        return NO;
    }
    return [self->_socket writeData:data];
}

+ (BOOL)request:(LDStreamingRequest *)request {
    LDClient *client = [self shared];
    if (![client->_socket isConnected]) {
        [request errorWithNetError];
        return NO;
    }
    if (request.response) {
        [LDClient.shared pushRequest:request];
    }
    [self sendData:request.data];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)),
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [request errorWithTimeout];
    });
    NSLog(@"%@", request);
    return YES;
}

#pragma mark - listener

+ (void)registeMessageListenerWithTag:(NSInteger)tag listener:(id<LDSocketMessageListener>)listener {
    [LDClient.shared registeMessageListenerWithTag:tag listener:listener];
}

- (void)registeMessageListenerWithTag:(NSInteger)tag listener:(id<LDSocketMessageListener>)listener {
    @synchronized (self) {
        NSString *key = [@(tag) stringValue];
        NSHashTable *tb = [self.observers valueForKey:key] ?: [NSHashTable weakObjectsHashTable];
        [tb addObject:listener];
        [self.observers setObject:tb forKey:key];
    }
}

#pragma mark - ack utils

- (void)pushRequest:(LDStreamingRequest *)request {
    @synchronized (self) {
        [self.acks setValue:request forKey:@(request.ackId).stringValue];
    }
}

- (LDStreamingRequest *)popRequest:(int64_t)ackId {
    LDStreamingRequest *res = nil;
    @synchronized (self) {
        res = [self.acks valueForKey:@(ackId).stringValue];
        [self.acks removeObjectForKey:@(ackId).stringValue];
    }
    if (res.isFinished) {
        return nil;
    }
    res.isFinished = YES;
    return res;
}

@end
