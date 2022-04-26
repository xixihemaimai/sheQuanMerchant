//
//  MsgInfo.m
//  LDMessage
//
//  Created by Milker on 2021/8/10.
//

#import "MsgInfo.h"
#import "gen/ProtobufEventType.pbobjc.h"

@implementation MsgInfo
+ (NSString *)eventName:(int32_t)v {
    NSString *name = [DLMEventType_EnumDescriptor() enumNameForValue:v];
    return [NSString stringWithFormat:@"%@ (%d)", name ?: @"null", v];
}
@end
