//
//  LDSocket.m
//  LDStreaming
//
//  Created by 千亦 on 2021/7/13.
//

#import "LDSocket.h"
#import "LDStreamBuffer.h"
#import <CocoaLumberjack/DDLog.h>
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
#import <LDMessage/ProtobufPacket.pbobjc.h>
#import "LDMessage.h"

#define kTENetworkKitOperationTimeOutInSeconds 5
#define kHeartBeatSendInterval 5
#define kTagHeartBeat 1001

@interface LDSocket() <GCDAsyncSocketDelegate, LDStreamBufferDelegate>

@property (nonatomic,strong) LDStreamBuffer *streamBuffer;

@property (nonatomic,strong) NSTimer* heartBeatTimer;

@end


@implementation LDSocket {
    GCDAsyncSocket *_socket;
    dispatch_queue_t _socketQueue;
    NSUInteger _dataLength;
    NSDictionary *_tempHeader;
    NSMutableDictionary *_tempCallback;
}


- (LDStreamBuffer *)streamBuffer {
    if (!_streamBuffer) {
        _streamBuffer = [LDStreamBuffer new];
        _streamBuffer.delegate = self;
    }

    return _streamBuffer;
}

- (BOOL)connectToHost:(NSString *)host onPort:(uint16_t)port error:(NSError **)errPtr {
    if (_socket) {
        return NO;
    }
    if (!_socketQueue) {
        _socketQueue = dispatch_queue_create("socket-queue", DISPATCH_QUEUE_SERIAL);
    }
    _socket = [[GCDAsyncSocket alloc] initWithDelegate:self
                                         delegateQueue:_socketQueue];

    if (![_socket connectToHost:host onPort:port withTimeout:kTENetworkKitOperationTimeOutInSeconds error:errPtr]) {
        _socket = nil;
        [self.delegate socket:self didDisconnectWithError:*errPtr];
        NSLog(@"socket error %@", *errPtr);
        return NO;
    }
    return YES;
}

- (void)close {
    [_socket disconnect];
    _socket = nil;
}

- (BOOL)isConnected {
    return _socket != nil;
}

#pragma mark - heatbeat

- (void)startHeartBeatTimer {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.heartBeatTimer =  [NSTimer scheduledTimerWithTimeInterval:kHeartBeatSendInterval
                                                                target:self
                                                              selector:@selector(ping:)
                                                              userInfo:nil
                                                               repeats:YES];
    });
}

- (void)cancelHeartBeatTimer{
    if (self.heartBeatTimer) {
        [self.heartBeatTimer invalidate];
        self.heartBeatTimer = nil;
    }
}

#pragma mark - gcd socket delegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"connect111");
    _socket = sock;
    [self.delegate socket:self didConnectToHost:host port:port];
    [self startHeartBeatTimer];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    [self.streamBuffer appendData:data];
    [sock readDataWithTimeout:-1 tag:tag];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"disconnect111 %@", err);
    _socket = nil;
    [self.delegate socket:self didDisconnectWithError:err];
    [self cancelHeartBeatTimer];
}

- (BOOL)writeData:(NSData *)data {
    if (!_socket) {return NO;}
    [_socket writeData:[LDStreamBuffer packData:data] withTimeout:-1 tag:-1];
    [_socket readDataWithTimeout:-1 tag:-1];
    return YES;
}

- (void)ping:(NSTimer*)timer {    
    LDStreamingRequest *req = [LDStreamingRequest new];
    req.eventType = EventPing;
    req.body = DLMPingInfo.new;
    req.messageType = @"Ping";
    [self writeData:req.data];
}

#pragma mark - buffer delegate

- (void)didReadPackage:(DLMMessage *)message {
    [self.delegate socket:self didReadPackage:message];
}

- (void)didReadError:(NSError *)error {
    NSLog(@"read error %@", error);
}

@end
