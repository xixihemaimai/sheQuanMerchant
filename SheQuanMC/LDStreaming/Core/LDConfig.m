//
//  LDConfig.m
//  LDStreaming
//
//  Created by 千亦 on 2021/7/13.
//

#import "LDConfig.h"

@implementation LDConfig

static LDConfig *obj;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (obj == nil) {
            obj = [super allocWithZone:zone];
            
            obj.writeTimeout = 5;
        }
    });
    return obj;
}
 
+ (instancetype)shared {
    return [[self alloc] init];
}
 
- (id)copyWithZone:(NSZone *)zone{
    return obj;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return obj;
}


@end
