//
//  LDDBUserInfo.m
//  Pods
//
//  Created by Milker on 2021/8/17.
//

#import "LDDBUserInfo.h"
#import <WCDB/WCDB.h>
#import "LDDBUserInfo+WCTTableCoding.h"

@implementation LDDBUserInfo
WCDB_IMPLEMENTATION(LDDBUserInfo)

WCDB_SYNTHESIZE(LDDBUserInfo, userid)
//WCDB_SYNTHESIZE(LDDBUserInfo, nickname)
//WCDB_SYNTHESIZE(LDDBUserInfo, headimg)
WCDB_SYNTHESIZE(LDDBUserInfo, remark)
 
WCDB_PRIMARY(LDDBUserInfo, userid)
@end
