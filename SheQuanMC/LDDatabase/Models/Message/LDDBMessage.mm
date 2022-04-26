//
//  LDDBMessage.m
//  Alamofire
//
//  Created by Milker on 2021/8/8.
//

#import "LDDBMessage.h"
#import <WCDB/WCDB.h>
#import "LDDBMessage+WCTTableCoding.h"

@implementation LDDBMessage

WCDB_IMPLEMENTATION(LDDBMessage)

WCDB_SYNTHESIZE(LDDBMessage, msgId)
WCDB_SYNTHESIZE(LDDBMessage, fromUserId)
WCDB_SYNTHESIZE(LDDBMessage, targetId)
WCDB_SYNTHESIZE(LDDBMessage, pushType)
WCDB_SYNTHESIZE(LDDBMessage, notifyType)
WCDB_SYNTHESIZE(LDDBMessage, sendTime)
WCDB_SYNTHESIZE(LDDBMessage, status)

WCDB_PRIMARY_AUTO_INCREMENT(LDDBMessage, msgId)

@end
