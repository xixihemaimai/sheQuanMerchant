//
//  LDDBMessage.h
//  Alamofire
//
//  Created by Milker on 2021/8/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDDBMessage : NSObject

/** 客户端消息Id */
@property uint64_t msgId;
/** 消息发送方userId */
@property uint64_t fromUserId;
/** 消息接收方(userId、groupId) */
@property uint64_t targetId;
/** 推送消息类型(1：Single、2：Group、3：Broadcast) */
@property int32_t pushType;
/** 通知类型(0：普通消息、1：通知、2：群公告) */
@property int32_t notifyType;
/** 发送时间 */
@property uint64_t sendTime;
/** 消息状态（0：实时消息、1：离线消息） */
@property int32_t status;
/** 消息内容 */
@property(retain) NSString *content;

@end

NS_ASSUME_NONNULL_END
