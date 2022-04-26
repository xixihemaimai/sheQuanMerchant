//
//  LDAckIdGenerater.m
//  LDStreaming
//
//  Created by 千亦 on 2021/7/19.
//

#import "LDAckIdGenerater.h"

@interface LDAckIdGenerater ()
@property (atomic, assign) int value;
@end

@implementation LDAckIdGenerater

static LDAckIdGenerater *gNum;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (gNum == nil) {
            gNum = [super allocWithZone:zone];
            gNum.value = 100;
        }
    });
    return gNum;
}
 
+ (instancetype)shared {
    return [[self alloc] init];
}
 
- (id)copyWithZone:(NSZone *)zone{
    return gNum;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return gNum;
}
 
- (int)get {
    ++self.value;
    return self.value;
}

+ (uint64_t)generateId {
    return [[LDAckIdGenerater shared] get];
}
@end
