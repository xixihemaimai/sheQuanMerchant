//
//  LDSocket.h
//  LDStreaming
//
//  Created by 千亦 on 2021/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LDSocket,DLMMessage;

@protocol LDSocketDelegate <NSObject>

- (void)socket:(LDSocket *)socket didConnectToHost:(NSString *)host port:(uint16_t)port;
- (void)socket:(LDSocket *)socket didDisconnectWithError:(NSError *)err;
- (void)socket:(LDSocket *)socket didReadPackage:(DLMMessage *)message;

@end

/**
 底层消息库：通道连接，消息的装包、拆包，消息分发
 */
@interface LDSocket : NSObject

@property (nonatomic, weak) id<LDSocketDelegate> delegate;

- (BOOL)connectToHost:(NSString *)host onPort:(uint16_t)port error:(NSError **)errPtr;
- (BOOL)writeData:(NSData *)data;
- (void)close;
- (BOOL)isConnected;

@end

NS_ASSUME_NONNULL_END
