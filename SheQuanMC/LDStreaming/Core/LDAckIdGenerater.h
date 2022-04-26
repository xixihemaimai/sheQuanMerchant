//
//  LDAckIdGenerater.h
//  LDStreaming
//
//  Created by 千亦 on 2021/7/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDAckIdGenerater : NSObject

+ (uint64_t)generateId; /// 生命周期内唯一整数ID

@end

NS_ASSUME_NONNULL_END
