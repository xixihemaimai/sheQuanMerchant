// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: ProtobufRedPacket.proto

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

@class DLMRedPacketRsp;
@class DLMUserRedPacketRsp;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - DLMProtobufRedPacketRoot

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
GPB_FINAL @interface DLMProtobufRedPacketRoot : GPBRootObject
@end

#pragma mark - DLMSendRedPacketReq

typedef GPB_ENUM(DLMSendRedPacketReq_FieldNumber) {
  DLMSendRedPacketReq_FieldNumber_MsgId = 1,
  DLMSendRedPacketReq_FieldNumber_TargetType = 2,
  DLMSendRedPacketReq_FieldNumber_TargetId = 3,
  DLMSendRedPacketReq_FieldNumber_PayId = 4,
  DLMSendRedPacketReq_FieldNumber_PayPwd = 5,
  DLMSendRedPacketReq_FieldNumber_RedPacketType = 6,
  DLMSendRedPacketReq_FieldNumber_Amount = 7,
  DLMSendRedPacketReq_FieldNumber_Quantity = 8,
  DLMSendRedPacketReq_FieldNumber_BestWishes = 9,
  DLMSendRedPacketReq_FieldNumber_Cover = 10,
  DLMSendRedPacketReq_FieldNumber_AppId = 11,
  DLMSendRedPacketReq_FieldNumber_DeviceId = 12,
};

/**
 * 发送红包（EventType.SendRedPacket）
 **/
GPB_FINAL @interface DLMSendRedPacketReq : GPBMessage

/** 消息MsgId */
@property(nonatomic, readwrite) uint64_t msgId;

/** 消息接收方类型(1：Single、2：Group) */
@property(nonatomic, readwrite) int32_t targetType;

/** 消息接收方(userId、groupId) */
@property(nonatomic, readwrite) uint64_t targetId;

/** 支付Id */
@property(nonatomic, readwrite) uint64_t payId;

/** 支付密码 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *payPwd;

/**
 * *
 * 红包类型：
 * 1、拼手气红包
 * 2、普通红包
 * 3、专属红包
 **/
@property(nonatomic, readwrite) int32_t redPacketType;

/** 红包总金额 */
@property(nonatomic, readwrite) float amount;

/** 红包个数 */
@property(nonatomic, readwrite) int32_t quantity;

/** 红包描述 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bestWishes;

/** 红包封面 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *cover;

/** 设备Id（IOS、Android） */
@property(nonatomic, readwrite, copy, null_resettable) NSString *appId;

/** 设备号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceId;

@end

#pragma mark - DLMSnatchRedPacketReq

typedef GPB_ENUM(DLMSnatchRedPacketReq_FieldNumber) {
  DLMSnatchRedPacketReq_FieldNumber_RedPacketId = 1,
  DLMSnatchRedPacketReq_FieldNumber_DeviceId = 2,
};

/**
 * 抢红包（EventType.SnatchRedPacket）
 **/
GPB_FINAL @interface DLMSnatchRedPacketReq : GPBMessage

/** 红包Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** 设备号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceId;

@end

#pragma mark - DLMDismantleRedPacketReq

typedef GPB_ENUM(DLMDismantleRedPacketReq_FieldNumber) {
  DLMDismantleRedPacketReq_FieldNumber_RedPacketId = 1,
  DLMDismantleRedPacketReq_FieldNumber_AuthId = 2,
  DLMDismantleRedPacketReq_FieldNumber_TimeStamp = 3,
  DLMDismantleRedPacketReq_FieldNumber_DeviceId = 4,
};

/**
 * 拆红包（EventType.DismantleRedPacket）
 **/
GPB_FINAL @interface DLMDismantleRedPacketReq : GPBMessage

/** 红包Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** 身份Id，该值是RedPacketRsp返回的authId */
@property(nonatomic, readwrite, copy, null_resettable) NSString *authId;

/** 时间戳，该值是RedPacketRsp返回的timeStamp */
@property(nonatomic, readwrite) uint64_t timeStamp;

/** 设备号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceId;

@end

#pragma mark - DLMRedPacketListReq

typedef GPB_ENUM(DLMRedPacketListReq_FieldNumber) {
  DLMRedPacketListReq_FieldNumber_RedPacketId = 1,
  DLMRedPacketListReq_FieldNumber_AuthId = 2,
  DLMRedPacketListReq_FieldNumber_TimeStamp = 3,
};

/**
 * 红包列表（EventType.RedPacketList）
 **/
GPB_FINAL @interface DLMRedPacketListReq : GPBMessage

/** 红包Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** 身份Id，该值是RedPacketRsp返回的authId */
@property(nonatomic, readwrite, copy, null_resettable) NSString *authId;

/** 时间戳，该值是RedPacketRsp返回的timeStamp */
@property(nonatomic, readwrite) uint64_t timeStamp;

@end

#pragma mark - DLMRedPacketRsp

typedef GPB_ENUM(DLMRedPacketRsp_FieldNumber) {
  DLMRedPacketRsp_FieldNumber_UserId = 1,
  DLMRedPacketRsp_FieldNumber_RedPacketId = 2,
  DLMRedPacketRsp_FieldNumber_RedPacketType = 3,
  DLMRedPacketRsp_FieldNumber_RedPacketTitle = 4,
  DLMRedPacketRsp_FieldNumber_HeadImg = 5,
  DLMRedPacketRsp_FieldNumber_AuthId = 6,
  DLMRedPacketRsp_FieldNumber_TimeStamp = 7,
  DLMRedPacketRsp_FieldNumber_ClaimStatus = 8,
  DLMRedPacketRsp_FieldNumber_ClaimAmount = 9,
  DLMRedPacketRsp_FieldNumber_AmountUnit = 10,
  DLMRedPacketRsp_FieldNumber_Copywriting = 11,
  DLMRedPacketRsp_FieldNumber_ShowProgress = 12,
  DLMRedPacketRsp_FieldNumber_ShowDetails = 13,
  DLMRedPacketRsp_FieldNumber_JumpDetailPage = 14,
};

/**
 * 红包信息
 **/
GPB_FINAL @interface DLMRedPacketRsp : GPBMessage

/** 发送都用户Id */
@property(nonatomic, readwrite) uint64_t userId;

/** 红包Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/**
 * *
 * 红包类型
 * 1、拼手气红包
 * 2、普通红包
 * 3、专属红包
 **/
@property(nonatomic, readwrite) int32_t redPacketType;

/** 红包标题（${昵称}+发出的红包） */
@property(nonatomic, readwrite, copy, null_resettable) NSString *redPacketTitle;

/** 用户头像 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *headImg;

/** 身份Id */
@property(nonatomic, readwrite, copy, null_resettable) NSString *authId;

/** 时间戳 */
@property(nonatomic, readwrite) uint64_t timeStamp;

/**
 * *
 * 领取状态
 * 0、未领取
 * 1、已领取
 * 2、已抢光
 * 3、已过期
 **/
@property(nonatomic, readwrite) int32_t claimStatus;

/** 领取金额 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *claimAmount;

/** 金额单位 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *amountUnit;

/**
 * *
 * 显示文案
 * 0、未领取 --》bestWishes
 * 1、已领取 --》claimAmount+amountUnit
 * 2、已抢光 --》已抢完
 * 3、已过期 --》该红包已超过24小时。如已领取，可在“红包记录”中查看。
 **/
@property(nonatomic, readwrite, copy, null_resettable) NSString *copywriting;

/** 显示进度 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *showProgress;

/**
 * *
 * 是否显示“查看领取详情”
 * 1、自己发的红包
 * 2、已领取红包
 **/
@property(nonatomic, readwrite) BOOL showDetails;

/**
 * *
 * 直接“跳转详情列表页”（false：拆红包页面、true：直接跳转详情页）
 **/
@property(nonatomic, readwrite) BOOL jumpDetailPage;

@end

#pragma mark - DLMSendRedPacketRsp

typedef GPB_ENUM(DLMSendRedPacketRsp_FieldNumber) {
  DLMSendRedPacketRsp_FieldNumber_RedPacketId = 1,
  DLMSendRedPacketRsp_FieldNumber_MsgId = 2,
  DLMSendRedPacketRsp_FieldNumber_BestWishes = 3,
  DLMSendRedPacketRsp_FieldNumber_Cover = 4,
};

/**
 * 红包应答消息
 **/
GPB_FINAL @interface DLMSendRedPacketRsp : GPBMessage

/** 红包Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** 客户端MsgId */
@property(nonatomic, readwrite) uint64_t msgId;

/** 红包描述 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bestWishes;

/** 红包封面 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *cover;

@end

#pragma mark - DLMRedPacketDetailInfoRsp

typedef GPB_ENUM(DLMRedPacketDetailInfoRsp_FieldNumber) {
  DLMRedPacketDetailInfoRsp_FieldNumber_RedPacket = 1,
  DLMRedPacketDetailInfoRsp_FieldNumber_UserRedPacketsArray = 2,
};

/**
 * 红包详情信息
 **/
GPB_FINAL @interface DLMRedPacketDetailInfoRsp : GPBMessage

/** 红包信息 */
@property(nonatomic, readwrite, strong, null_resettable) DLMRedPacketRsp *redPacket;
/** Test to see if @c redPacket has been set. */
@property(nonatomic, readwrite) BOOL hasRedPacket;

/** 抢到红包用户列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<DLMUserRedPacketRsp*> *userRedPacketsArray;
/** The number of items in @c userRedPacketsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger userRedPacketsArray_Count;

@end

#pragma mark - DLMUserRedPacketRsp

typedef GPB_ENUM(DLMUserRedPacketRsp_FieldNumber) {
  DLMUserRedPacketRsp_FieldNumber_RedPacketId = 1,
  DLMUserRedPacketRsp_FieldNumber_NickName = 2,
  DLMUserRedPacketRsp_FieldNumber_HeadImg = 3,
  DLMUserRedPacketRsp_FieldNumber_ClaimAmount = 4,
  DLMUserRedPacketRsp_FieldNumber_AmountUnit = 5,
  DLMUserRedPacketRsp_FieldNumber_ClaimTime = 6,
  DLMUserRedPacketRsp_FieldNumber_Best = 7,
};

/**
 * 用户红包信息
 **/
GPB_FINAL @interface DLMUserRedPacketRsp : GPBMessage

/** 红包Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** 用户昵称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *nickName;

/** 用户头像 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *headImg;

/** 领取金额 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *claimAmount;

/** 金额单位 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *amountUnit;

/** 领取时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *claimTime;

/** 是否手气最佳 */
@property(nonatomic, readwrite) BOOL best;

@end

#pragma mark - DLMAckRedPacketInfo

typedef GPB_ENUM(DLMAckRedPacketInfo_FieldNumber) {
  DLMAckRedPacketInfo_FieldNumber_RedPacketId = 1,
  DLMAckRedPacketInfo_FieldNumber_Msg = 2,
};

/**
 *
 **/
GPB_FINAL @interface DLMAckRedPacketInfo : GPBMessage

/** 红包Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** 金额单位 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *msg;

@end

#pragma mark - DLMRedPacketMsgInfo

typedef GPB_ENUM(DLMRedPacketMsgInfo_FieldNumber) {
  DLMRedPacketMsgInfo_FieldNumber_RedPacketId = 1,
  DLMRedPacketMsgInfo_FieldNumber_UserId = 2,
  DLMRedPacketMsgInfo_FieldNumber_FaceURL = 3,
  DLMRedPacketMsgInfo_FieldNumber_UserName = 4,
  DLMRedPacketMsgInfo_FieldNumber_Mobile = 5,
  DLMRedPacketMsgInfo_FieldNumber_ClaimAmount = 6,
  DLMRedPacketMsgInfo_FieldNumber_MerchantNo = 7,
  DLMRedPacketMsgInfo_FieldNumber_TradeName = 8,
  DLMRedPacketMsgInfo_FieldNumber_TradeDesc = 9,
  DLMRedPacketMsgInfo_FieldNumber_PayId = 10,
};

/**
 *
 **/
GPB_FINAL @interface DLMRedPacketMsgInfo : GPBMessage

/** 红包Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** 用户UserId */
@property(nonatomic, readwrite) uint64_t userId;

/** 用户头像 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *faceURL;

/** 用户名 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *userName;

/** 手机号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *mobile;

/** 领取金额（单位为：分） */
@property(nonatomic, readwrite) int32_t claimAmount;

/** 商户单号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *merchantNo;

/** 交易名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *tradeName;

/** 交易说明 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *tradeDesc;

/** 支付Id */
@property(nonatomic, readwrite) uint64_t payId;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
