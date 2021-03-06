// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: ProtobufMessage.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30004
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30004 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class DLMContactCardMsgReq;
@class DLMFileMsgReq;
@class DLMGifMsgReq;
@class DLMImgMsgReq;
@class DLMImgTextMsgReq;
@class DLMLbsMsgReq;
@class DLMMessageLiteReq;
@class DLMOffLineMsgRsp;
@class DLMRedPacketMsgReq;
@class DLMRemindMsgReq;
@class DLMSightMsgReq;
@class DLMTextMsgReq;
@class DLMVcMsgReq;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - DLMProtobufMessageRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
GPB_FINAL @interface DLMProtobufMessageRoot : GPBRootObject
@end

#pragma mark - DLMMessageLiteReq

typedef GPB_ENUM(DLMMessageLiteReq_FieldNumber) {
  DLMMessageLiteReq_FieldNumber_MsgId = 1,
  DLMMessageLiteReq_FieldNumber_FromUserId = 2,
  DLMMessageLiteReq_FieldNumber_TargetId = 3,
  DLMMessageLiteReq_FieldNumber_PushType = 4,
  DLMMessageLiteReq_FieldNumber_NotifyType = 5,
  DLMMessageLiteReq_FieldNumber_SendTime = 6,
  DLMMessageLiteReq_FieldNumber_EventType = 7,
  DLMMessageLiteReq_FieldNumber_PreMsgId = 8,
  DLMMessageLiteReq_FieldNumber_TextMsg = 10,
  DLMMessageLiteReq_FieldNumber_ImgMsg = 11,
  DLMMessageLiteReq_FieldNumber_VcMsg = 12,
  DLMMessageLiteReq_FieldNumber_GifMsg = 13,
  DLMMessageLiteReq_FieldNumber_ImgTextMsg = 14,
  DLMMessageLiteReq_FieldNumber_FileMsg = 15,
  DLMMessageLiteReq_FieldNumber_LbsMsg = 16,
  DLMMessageLiteReq_FieldNumber_SightMsg = 17,
  DLMMessageLiteReq_FieldNumber_RedPacketMsg = 18,
  DLMMessageLiteReq_FieldNumber_RemindMsg = 19,
  DLMMessageLiteReq_FieldNumber_ContactCardMsg = 20,
};

typedef GPB_ENUM(DLMMessageLiteReq_MsgBody_OneOfCase) {
  DLMMessageLiteReq_MsgBody_OneOfCase_GPBUnsetOneOfCase = 0,
  DLMMessageLiteReq_MsgBody_OneOfCase_TextMsg = 10,
  DLMMessageLiteReq_MsgBody_OneOfCase_ImgMsg = 11,
  DLMMessageLiteReq_MsgBody_OneOfCase_VcMsg = 12,
  DLMMessageLiteReq_MsgBody_OneOfCase_GifMsg = 13,
  DLMMessageLiteReq_MsgBody_OneOfCase_ImgTextMsg = 14,
  DLMMessageLiteReq_MsgBody_OneOfCase_FileMsg = 15,
  DLMMessageLiteReq_MsgBody_OneOfCase_LbsMsg = 16,
  DLMMessageLiteReq_MsgBody_OneOfCase_SightMsg = 17,
  DLMMessageLiteReq_MsgBody_OneOfCase_RedPacketMsg = 18,
  DLMMessageLiteReq_MsgBody_OneOfCase_RemindMsg = 19,
  DLMMessageLiteReq_MsgBody_OneOfCase_ContactCardMsg = 20,
};

/**
 * ?????????????????????
 **/
GPB_FINAL @interface DLMMessageLiteReq : GPBMessage

/** ???????????????Id */
@property(nonatomic, readwrite) uint64_t msgId;

/** ???????????????userId */
@property(nonatomic, readwrite) uint64_t fromUserId;

/** ???????????????(userId???groupId) */
@property(nonatomic, readwrite) uint64_t targetId;

/** ??????????????????(1???Single???2???Group???3???Broadcast) */
@property(nonatomic, readwrite) int32_t pushType;

/** ????????????(0??????????????????1????????????2????????????) */
@property(nonatomic, readwrite) int32_t notifyType;

/** ???????????? */
@property(nonatomic, readwrite) uint64_t sendTime;

/** ?????? com.github.yi.chat.socket.model.enums.EventType */
@property(nonatomic, readwrite) int32_t eventType;

/** ???????????????Id */
@property(nonatomic, readwrite) uint64_t preMsgId;

/** ????????? */
@property(nonatomic, readonly) DLMMessageLiteReq_MsgBody_OneOfCase msgBodyOneOfCase;

/** ???????????? */
@property(nonatomic, readwrite, strong, null_resettable) DLMTextMsgReq *textMsg;

/** ???????????? */
@property(nonatomic, readwrite, strong, null_resettable) DLMImgMsgReq *imgMsg;

/** ???????????? */
@property(nonatomic, readwrite, strong, null_resettable) DLMVcMsgReq *vcMsg;

/** GIF ???????????? */
@property(nonatomic, readwrite, strong, null_resettable) DLMGifMsgReq *gifMsg;

/** ???????????? */
@property(nonatomic, readwrite, strong, null_resettable) DLMImgTextMsgReq *imgTextMsg;

/** ???????????? */
@property(nonatomic, readwrite, strong, null_resettable) DLMFileMsgReq *fileMsg;

/** ???????????? */
@property(nonatomic, readwrite, strong, null_resettable) DLMLbsMsgReq *lbsMsg;

/** ??????????????? */
@property(nonatomic, readwrite, strong, null_resettable) DLMSightMsgReq *sightMsg;

/** ???????????? */
@property(nonatomic, readwrite, strong, null_resettable) DLMRedPacketMsgReq *redPacketMsg;

/** ???????????? */
@property(nonatomic, readwrite, strong, null_resettable) DLMRemindMsgReq *remindMsg;

/** ?????????????????? */
@property(nonatomic, readwrite, strong, null_resettable) DLMContactCardMsgReq *contactCardMsg;

@end

/**
 * Clears whatever value was set for the oneof 'msgBody'.
 **/
void DLMMessageLiteReq_ClearMsgBodyOneOfCase(DLMMessageLiteReq *message);

#pragma mark - DLMLocalMsgReq

typedef GPB_ENUM(DLMLocalMsgReq_FieldNumber) {
  DLMLocalMsgReq_FieldNumber_OpenId = 1,
  DLMLocalMsgReq_FieldNumber_TargetId = 2,
  DLMLocalMsgReq_FieldNumber_AckId = 3,
  DLMLocalMsgReq_FieldNumber_MsgId = 4,
  DLMLocalMsgReq_FieldNumber_MessageLite = 5,
  DLMLocalMsgReq_FieldNumber_SendTime = 6,
};

/**
 *
 **/
GPB_FINAL @interface DLMLocalMsgReq : GPBMessage

/** OpendId */
@property(nonatomic, readwrite, copy, null_resettable) NSString *openId;

/** targetId */
@property(nonatomic, readwrite, copy, null_resettable) NSString *targetId;

/** ackId */
@property(nonatomic, readwrite) uint64_t ackId;

/** ??????Id */
@property(nonatomic, readwrite) uint64_t msgId;

/** ???????????? */
@property(nonatomic, readwrite, strong, null_resettable) DLMMessageLiteReq *messageLite;
/** Test to see if @c messageLite has been set. */
@property(nonatomic, readwrite) BOOL hasMessageLite;

/** ???????????? */
@property(nonatomic, readwrite) uint64_t sendTime;

@end

#pragma mark - DLMOffLineMsgListReq

typedef GPB_ENUM(DLMOffLineMsgListReq_FieldNumber) {
  DLMOffLineMsgListReq_FieldNumber_LastOffLineId = 1,
};

/**
 * ?????????????????????EventType.OffLineMsgList???
 **/
GPB_FINAL @interface DLMOffLineMsgListReq : GPBMessage

/** ?????????????????????Id */
@property(nonatomic, readwrite) uint64_t lastOffLineId;

@end

#pragma mark - DLMOffLineMsgListRsp

typedef GPB_ENUM(DLMOffLineMsgListRsp_FieldNumber) {
  DLMOffLineMsgListRsp_FieldNumber_OffLinesArray = 1,
};

/**
 * ??????????????????(EventType.OffLineMsgList)
 **/
GPB_FINAL @interface DLMOffLineMsgListRsp : GPBMessage

/** ???????????? */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<DLMOffLineMsgRsp*> *offLinesArray;
/** The number of items in @c offLinesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger offLinesArray_Count;

@end

#pragma mark - DLMOffLineMsgRsp

typedef GPB_ENUM(DLMOffLineMsgRsp_FieldNumber) {
  DLMOffLineMsgRsp_FieldNumber_OffLineId = 1,
  DLMOffLineMsgRsp_FieldNumber_TargetId = 2,
  DLMOffLineMsgRsp_FieldNumber_PullType = 3,
  DLMOffLineMsgRsp_FieldNumber_OffLineType = 4,
};

/**
 * ??????????????????
 **/
GPB_FINAL @interface DLMOffLineMsgRsp : GPBMessage

/** */
@property(nonatomic, readwrite) uint64_t offLineId;

/**
 * *
 * ??????????????????(UserId???GroupId)
 * ???pullType???1??????UserId
 * ???pullType???2??????GroupId
 **/
@property(nonatomic, readwrite) uint64_t targetId;

/** ?????????????????????1????????????2????????????3???????????? */
@property(nonatomic, readwrite) int32_t pullType;

/**
 * *
 * ??????????????????(1????????????????????????????????????2?????????????????????????????????)
 * ???pullType???1?????????offLineType???1?????????????????????????????????
 * ???pullType???1?????????offLineType???2???????????????????????????????????????
 * ???pullType???1?????????offLineType???3????????????????????????????????????????????????????????????????????????????????????????????????
 * -----------------------------------------------------------------------------
 * ???pullType???2?????????offLineType???1????????????????????????????????????????????????
 * ???pullType???2?????????offLineType???2????????????????????????????????????
 * ???pullType???2?????????offLineType???3????????????????????????????????????????????????????????????????????????????????????????????????????????????
 **/
@property(nonatomic, readwrite) int32_t offLineType;

@end

#pragma mark - DLMPullOffLineInfoReq

typedef GPB_ENUM(DLMPullOffLineInfoReq_FieldNumber) {
  DLMPullOffLineInfoReq_FieldNumber_TargetId = 1,
  DLMPullOffLineInfoReq_FieldNumber_PullType = 2,
  DLMPullOffLineInfoReq_FieldNumber_LastMsgId = 3,
};

/**
 * ??????????????????(EventType.PullOffLineInfo)
 **/
GPB_FINAL @interface DLMPullOffLineInfoReq : GPBMessage

/**
 * *
 * ??????????????????(UserId???GroupId)
 * ???pullType???1??????UserId
 * ???pullType???2??????GroupId
 **/
@property(nonatomic, readwrite) uint64_t targetId;

/** ?????????????????????1????????????2????????????3???????????? */
@property(nonatomic, readwrite) int32_t pullType;

/** ?????????????????????Id */
@property(nonatomic, readwrite) uint64_t lastMsgId;

@end

#pragma mark - DLMMessageLiteListRsp

typedef GPB_ENUM(DLMMessageLiteListRsp_FieldNumber) {
  DLMMessageLiteListRsp_FieldNumber_MessageLitesArray = 1,
};

/**
 * ??????????????????
 **/
GPB_FINAL @interface DLMMessageLiteListRsp : GPBMessage

/** ???????????? */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<DLMMessageLiteReq*> *messageLitesArray;
/** The number of items in @c messageLitesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger messageLitesArray_Count;

@end

#pragma mark - DLMRemindMsgReq

typedef GPB_ENUM(DLMRemindMsgReq_FieldNumber) {
  DLMRemindMsgReq_FieldNumber_RemindId = 1,
  DLMRemindMsgReq_FieldNumber_RemindType = 2,
  DLMRemindMsgReq_FieldNumber_Icon = 3,
  DLMRemindMsgReq_FieldNumber_Content = 4,
  DLMRemindMsgReq_FieldNumber_Ext = 5,
  DLMRemindMsgReq_FieldNumber_UserIdsArray = 6,
};

/**
 * ???????????????EventType.RemindMsg???
 **/
GPB_FINAL @interface DLMRemindMsgReq : GPBMessage

/**
 * *
 * ??????Id
 * ???remindType???2?????????????????????Id???redPacketId???
 * ???remindType???3?????????????????????Id???redPacketId???
 * ???remindType???7?????????????????????Id???redPacketId???
 * ???remindType???8?????????????????????Id???redPacketId???
 * ???remindType???9?????????????????????Id???redPacketId???
 **/
@property(nonatomic, readwrite) uint64_t remindId;

/**
 * *
 * 1???????????????
 * 2???????????????
 * 3??????????????????              -- ???ext??????????????????????????????????????????ext???
 * 4???\@??????
 * 5???????????????????????????        -- ??????????????????????????????????????????
 * 6??????????????????             -- ???????????????(???)?????????,????????????????????????.
 * 7?????????????????????           -- ?????????????????????????????????????????????????????????
 * 8?????????-??????????????????       -- ???ext??????????????????????????????????????????ext???
 * 9????????????????????????????????????????????????-- ???ext??????????????????????????????????????????ext???
 **/
@property(nonatomic, readwrite) int32_t remindType;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *icon;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *content;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *ext;

/** ??????Id */
@property(nonatomic, readwrite, strong, null_resettable) GPBUInt64Array *userIdsArray;
/** The number of items in @c userIdsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger userIdsArray_Count;

@end

#pragma mark - DLMTextMsgReq

typedef GPB_ENUM(DLMTextMsgReq_FieldNumber) {
  DLMTextMsgReq_FieldNumber_Content = 1,
  DLMTextMsgReq_FieldNumber_AtUserIdsArray = 2,
};

/**
 * ???????????????EventType.TextMsg???
 **/
GPB_FINAL @interface DLMTextMsgReq : GPBMessage

/** ????????????????????????????????????????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *content;

/**
 * *
 * atUserIds ?????????????????????
 * ?????? \@ ?????????????????????????????? \@ALL(0)???????????????0
 * ?????????????????????????????????????????????\@?????? denny(1) ??? lucy(2) ??????????????????????????????\@?????????(0)???atUserIds ??? [0,1,2]
 **/
@property(nonatomic, readwrite, strong, null_resettable) GPBUInt64Array *atUserIdsArray;
/** The number of items in @c atUserIdsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger atUserIdsArray_Count;

@end

#pragma mark - DLMImgMsgReq

typedef GPB_ENUM(DLMImgMsgReq_FieldNumber) {
  DLMImgMsgReq_FieldNumber_ThumbURL = 1,
  DLMImgMsgReq_FieldNumber_ImgURL = 2,
  DLMImgMsgReq_FieldNumber_Width = 3,
  DLMImgMsgReq_FieldNumber_Height = 4,
  DLMImgMsgReq_FieldNumber_Size = 5,
};

/**
 * ???????????????EventType.ImgMsg???
 **/
GPB_FINAL @interface DLMImgMsgReq : GPBMessage

/** ????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *thumbURL;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *imgURL;

/** ???????????? */
@property(nonatomic, readwrite) int32_t width;

/** ???????????? */
@property(nonatomic, readwrite) int32_t height;

/** ???????????????????????????????????? Byte */
@property(nonatomic, readwrite) double size;

@end

#pragma mark - DLMVcMsgReq

typedef GPB_ENUM(DLMVcMsgReq_FieldNumber) {
  DLMVcMsgReq_FieldNumber_VoiceURL = 1,
  DLMVcMsgReq_FieldNumber_Duration = 2,
};

/**
 * ???????????????EventType.VcMsg???
 **/
GPB_FINAL @interface DLMVcMsgReq : GPBMessage

/** ????????????????????????????????????????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *voiceURL;

/** ????????????????????????????????? 60 ????????????????????? */
@property(nonatomic, readwrite) int32_t duration;

@end

#pragma mark - DLMGifMsgReq

typedef GPB_ENUM(DLMGifMsgReq_FieldNumber) {
  DLMGifMsgReq_FieldNumber_ImgURL = 1,
  DLMGifMsgReq_FieldNumber_Width = 2,
  DLMGifMsgReq_FieldNumber_Height = 3,
  DLMGifMsgReq_FieldNumber_Size = 4,
};

/**
 * GIF ???????????????EventType.GifMsg???
 **/
GPB_FINAL @interface DLMGifMsgReq : GPBMessage

/** ???????????????????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *imgURL;

/** ???????????? */
@property(nonatomic, readwrite) int32_t width;

/** ???????????? */
@property(nonatomic, readwrite) int32_t height;

/** ???????????????????????????????????? Byte */
@property(nonatomic, readwrite) double size;

@end

#pragma mark - DLMImgTextMsgReq

typedef GPB_ENUM(DLMImgTextMsgReq_FieldNumber) {
  DLMImgTextMsgReq_FieldNumber_Title = 1,
  DLMImgTextMsgReq_FieldNumber_Content = 2,
  DLMImgTextMsgReq_FieldNumber_Thumbnail = 3,
  DLMImgTextMsgReq_FieldNumber_ImgURL = 4,
  DLMImgTextMsgReq_FieldNumber_LinkURL = 5,
};

/**
 * ???????????????EventType.ImgTextMsg???
 **/
GPB_FINAL @interface DLMImgTextMsgReq : GPBMessage

/** ??????????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *title;

/** ????????????????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *content;

/** ??????????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *thumbnail;

/** ??????????????????????????????????????????120 x 120 ?????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *imgURL;

/** ?????????????????????????????? URL ?????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *linkURL;

@end

#pragma mark - DLMFileMsgReq

typedef GPB_ENUM(DLMFileMsgReq_FieldNumber) {
  DLMFileMsgReq_FieldNumber_Name = 1,
  DLMFileMsgReq_FieldNumber_Type = 2,
  DLMFileMsgReq_FieldNumber_Size = 3,
  DLMFileMsgReq_FieldNumber_FileURL = 4,
  DLMFileMsgReq_FieldNumber_Unit = 5,
};

/**
 * ???????????????EventType.FileMsg???
 **/
GPB_FINAL @interface DLMFileMsgReq : GPBMessage

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *type;

/** ???????????? */
@property(nonatomic, readwrite) double size;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *fileURL;

/** ?????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *unit;

@end

#pragma mark - DLMLbsMsgReq

typedef GPB_ENUM(DLMLbsMsgReq_FieldNumber) {
  DLMLbsMsgReq_FieldNumber_Content = 1,
  DLMLbsMsgReq_FieldNumber_Latitude = 2,
  DLMLbsMsgReq_FieldNumber_Longitude = 3,
  DLMLbsMsgReq_FieldNumber_Poi = 4,
};

/**
 * ???????????????EventType.LbsMsg???
 **/
GPB_FINAL @interface DLMLbsMsgReq : GPBMessage

/** ??????????????????????????????????????? JPG?????? Base64 ?????? Encode ?????????????????? \\r\\n ??? \\r ??? \\n ??????????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *content;

/** ?????????????????? */
@property(nonatomic, readwrite) double latitude;

/** ?????????????????? */
@property(nonatomic, readwrite) double longitude;

/** ??????????????? poi ?????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *poi;

@end

#pragma mark - DLMSightMsgReq

typedef GPB_ENUM(DLMSightMsgReq_FieldNumber) {
  DLMSightMsgReq_FieldNumber_Name = 1,
  DLMSightMsgReq_FieldNumber_Type = 2,
  DLMSightMsgReq_FieldNumber_Size = 3,
  DLMSightMsgReq_FieldNumber_SightURL = 4,
  DLMSightMsgReq_FieldNumber_Duration = 5,
  DLMSightMsgReq_FieldNumber_SnapshotURL = 6,
  DLMSightMsgReq_FieldNumber_Width = 7,
  DLMSightMsgReq_FieldNumber_Height = 8,
};

/**
 * ??????????????????EventType.SightMsg???
 **/
GPB_FINAL @interface DLMSightMsgReq : GPBMessage

/** ?????????????????????????????????????????????????????? MP4 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

/** ?????????????????? mp4 mov ??? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *type;

/** ?????????????????? Byte */
@property(nonatomic, readwrite) double size;

/** ?????????????????????????????????????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *sightURL;

/** ??????????????????????????? */
@property(nonatomic, readwrite) uint64_t duration;

/** ???????????????????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *snapshotURL;

/** ???????????????????????? */
@property(nonatomic, readwrite) int32_t width;

/** ???????????????????????? */
@property(nonatomic, readwrite) int32_t height;

@end

#pragma mark - DLMRedPacketMsgReq

typedef GPB_ENUM(DLMRedPacketMsgReq_FieldNumber) {
  DLMRedPacketMsgReq_FieldNumber_RedPacketId = 1,
  DLMRedPacketMsgReq_FieldNumber_BestWishes = 2,
  DLMRedPacketMsgReq_FieldNumber_Cover = 3,
};

/**
 * ???????????????EventType.RedPacketMsg???
 **/
GPB_FINAL @interface DLMRedPacketMsgReq : GPBMessage

/** ??????Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bestWishes;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *cover;

@end

#pragma mark - DLMReadMsgReq

typedef GPB_ENUM(DLMReadMsgReq_FieldNumber) {
  DLMReadMsgReq_FieldNumber_MsgId = 1,
};

/**
 * ???????????????EventType.ReadMsg???
 **/
GPB_FINAL @interface DLMReadMsgReq : GPBMessage

/** ??????Id */
@property(nonatomic, readwrite) uint64_t msgId;

@end

#pragma mark - DLMRecallMsgReq

typedef GPB_ENUM(DLMRecallMsgReq_FieldNumber) {
  DLMRecallMsgReq_FieldNumber_FromUserId = 1,
  DLMRecallMsgReq_FieldNumber_ToUserId = 2,
  DLMRecallMsgReq_FieldNumber_MsgId = 3,
};

/**
 * ?????????????????????EventType.RecallMsg???
 **/
GPB_FINAL @interface DLMRecallMsgReq : GPBMessage

/** ???????????????userId */
@property(nonatomic, readwrite) uint64_t fromUserId;

/** ?????????????????????userId */
@property(nonatomic, readwrite) uint64_t toUserId;

/** ????????????Id */
@property(nonatomic, readwrite) uint64_t msgId;

@end

#pragma mark - DLMContactCardMsgReq

typedef GPB_ENUM(DLMContactCardMsgReq_FieldNumber) {
  DLMContactCardMsgReq_FieldNumber_UserId = 1,
  DLMContactCardMsgReq_FieldNumber_NickName = 2,
  DLMContactCardMsgReq_FieldNumber_FaceURL = 3,
  DLMContactCardMsgReq_FieldNumber_RegionName = 4,
  DLMContactCardMsgReq_FieldNumber_Sign = 5,
  DLMContactCardMsgReq_FieldNumber_Card = 6,
};

/**
 * ?????????????????????EventType.ContactCardMsg???
 **/
GPB_FINAL @interface DLMContactCardMsgReq : GPBMessage

/** ??????Id */
@property(nonatomic, readwrite) uint64_t userId;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *nickName;

/** ???????????? url */
@property(nonatomic, readwrite, copy, null_resettable) NSString *faceURL;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *regionName;

/** ?????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *sign;

/** ???????????????????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *card;

@end

#pragma mark - DLMSingleMsgInfo

typedef GPB_ENUM(DLMSingleMsgInfo_FieldNumber) {
  DLMSingleMsgInfo_FieldNumber_EventType = 1,
  DLMSingleMsgInfo_FieldNumber_MsgId = 2,
  DLMSingleMsgInfo_FieldNumber_UserId = 3,
  DLMSingleMsgInfo_FieldNumber_FriendUserId = 4,
  DLMSingleMsgInfo_FieldNumber_Data_p = 5,
};

/**
 * Im ??????????????????
 **/
GPB_FINAL @interface DLMSingleMsgInfo : GPBMessage

/** ???????????? */
@property(nonatomic, readwrite) int32_t eventType;

/** ??????Id */
@property(nonatomic, readwrite) uint64_t msgId;

/** ??????UserId */
@property(nonatomic, readwrite) uint64_t userId;

/** ??????UserId */
@property(nonatomic, readwrite) uint64_t friendUserId;

/** ?????????????????????????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSData *data_p;
/** Test to see if @c data_p has been set. */
@property(nonatomic, readwrite) BOOL hasData_p;

@end

#pragma mark - DLMGroupMsgInfo

typedef GPB_ENUM(DLMGroupMsgInfo_FieldNumber) {
  DLMGroupMsgInfo_FieldNumber_EventType = 1,
  DLMGroupMsgInfo_FieldNumber_MsgId = 2,
  DLMGroupMsgInfo_FieldNumber_UserId = 3,
  DLMGroupMsgInfo_FieldNumber_GroupId = 4,
  DLMGroupMsgInfo_FieldNumber_Data_p = 5,
};

/**
 * Im ??????????????????
 **/
GPB_FINAL @interface DLMGroupMsgInfo : GPBMessage

/** ???????????? */
@property(nonatomic, readwrite) int32_t eventType;

/** ??????Id */
@property(nonatomic, readwrite) uint64_t msgId;

/** UserId */
@property(nonatomic, readwrite) uint64_t userId;

/** ??????Id */
@property(nonatomic, readwrite) uint64_t groupId;

/** ?????????????????????????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSData *data_p;
/** Test to see if @c data_p has been set. */
@property(nonatomic, readwrite) BOOL hasData_p;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
