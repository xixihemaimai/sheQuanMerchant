//
//  LDClient.h
//  LDStreaming
//
//  Created by 千亦 on 2021/7/13.
//

#import <Foundation/Foundation.h>

@class DLMPacketInfo, LDStreamingRequest, LDClient;

@protocol LDSocketMessageListener <NSObject>

- (void)onReceiveMessage:(DLMPacketInfo *)data;

@end

@protocol LDSocketEvent <NSObject>

- (void)onConnect:(LDClient *)data;
- (void)onDisConnect:(LDClient *)data;
- (void)onLogoff:(LDClient *)data;

@end


@interface LDClient : NSObject

+ (void)setupWithListener:(id<LDSocketEvent>) delegate;
+ (void)stop;
/// 发送消息
+ (BOOL)request:(LDStreamingRequest *)request;

// 注册消息接收的监听
+ (void)registeMessageListenerWithTag:(int32_t)tag listener:(id<LDSocketMessageListener>)listener;

@end
