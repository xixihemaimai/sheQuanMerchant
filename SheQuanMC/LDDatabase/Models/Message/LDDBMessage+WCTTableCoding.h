//
//  LDDBMessage+WCTTableCoding.h
//  Alamofire
//
//  Created by Milker on 2021/8/8.
//


#import <WCDB/WCDB.h>
#import "LDDBMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDDBMessage (WCTTableCoding)<WCTTableCoding>
WCDB_PROPERTY(msgId)
WCDB_PROPERTY(fromUserId)
WCDB_PROPERTY(targetId)
WCDB_PROPERTY(pushType)
WCDB_PROPERTY(notifyType)
WCDB_PROPERTY(sendTime)
WCDB_PROPERTY(status)
WCDB_PROPERTY(content)
@end

NS_ASSUME_NONNULL_END
