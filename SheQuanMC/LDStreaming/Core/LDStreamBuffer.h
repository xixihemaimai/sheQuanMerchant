//
//  LDStreamBuffer.h
//  LDStreaming
//
//  Created by 千亦 on 2021/7/13.
//

#import <Foundation/Foundation.h>
@class DLMPacketInfo;

NS_ASSUME_NONNULL_BEGIN

@protocol LDStreamBufferDelegate <NSObject>

- (void)didReadPackage:(DLMPacketInfo *)message;

@optional
- (void)didReadError:(NSError *)error;

@end

@interface LDStreamBuffer : NSObject

@property(nonatomic, weak) id<LDStreamBufferDelegate> delegate;

- (void)appendData:(NSData*)data;

+ (NSData *)packData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
