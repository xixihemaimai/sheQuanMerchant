//
//  LDDBUserInfo+WCTTableCoding.h
//  Pods
//
//  Created by Milker on 2021/8/17.
//

#import "LDDBUserInfo.h"
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDDBUserInfo (WCTTableCoding)<WCTTableCoding>
WCDB_PROPERTY(userid)
//WCDB_PROPERTY(nickname)
//WCDB_PROPERTY(headimg)
WCDB_PROPERTY(remark)
@end

NS_ASSUME_NONNULL_END
