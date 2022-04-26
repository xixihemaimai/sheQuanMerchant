//
//  LDConfig.h
//  LDStreaming
//
//  Created by 千亦 on 2021/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDConfig : NSObject

+ (instancetype)shared;

@property (nonatomic, copy) NSString *host;
@property (nonatomic, assign) NSInteger port;

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *versionId;
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appVer;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *sign;


@property (nonatomic, assign) NSTimeInterval keepliveInterval;  // seconds
@property (nonatomic, assign) NSTimeInterval writeTimeout;      // seconds

@end

NS_ASSUME_NONNULL_END
