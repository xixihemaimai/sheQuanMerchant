//
//  LDMessage.h
//  LDStreaming
//
//  Created by 千亦 on 2021/7/13.
//

#import <Foundation/Foundation.h>
#import <Protobuf/GPBProtocolBuffers.h>

@class DLMMessage, LDStreamingResponse;
@class DLMPacketInfo;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, EventType) {
    EventNone = 0, // "None"),
    EventPing = 1, // "Ping"),
    EventConnect = 2, // "Connect"),
    EventClose = 3, // "Close"),
    EventDisconnect = 4, // "Disconnect"),
    EventAck = 5, // "ACK"),
    EventUpgrade = 7, // "Upgrade"),
    EventError = 8, // "Error"),
    
//    47
};

typedef NS_ENUM(NSInteger, ResponseStatus) {
    ResponseSuccess = 200,  // "操作成功"),
    ResponseUnAuthorized = 401, // "用户Token过期，请重新登录."),
    ResponseUnknown = 500, //"系统异常，请稍后重试.");
};

typedef void (^LDResponseCallback)(DLMPacketInfo *resp);

@interface LDStreamingRequest : NSObject

@property(nonatomic, assign) int32_t eventType;
@property(nonatomic, strong) GPBMessage *body;
@property(nonatomic, copy) NSString *messageType;

@property(nonatomic, copy) LDResponseCallback response;/// 需要响应的时候使用

@property(nonatomic, assign, readonly) int64_t ackId;

@property(nonatomic, assign) BOOL isFinished; // 已结束

- (NSData *)data;

- (void)errorWithTimeout;
- (void)errorWithNetError;

@end

@interface LDStreamingResponse : NSObject

@property(nonatomic, assign) int32_t status;
@property(nonatomic, copy) NSString *msg;
@property(nonatomic, copy) NSString *messageType;
@property(nonatomic, strong) NSData *body;
@property(nonatomic, strong) NSError *error;

@end

@interface LDMessage : NSObject

@end

NS_ASSUME_NONNULL_END
