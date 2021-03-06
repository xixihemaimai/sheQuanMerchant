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
 * ???????????????EventType.SendRedPacket???
 **/
GPB_FINAL @interface DLMSendRedPacketReq : GPBMessage

/** ??????MsgId */
@property(nonatomic, readwrite) uint64_t msgId;

/** ?????????????????????(1???Single???2???Group) */
@property(nonatomic, readwrite) int32_t targetType;

/** ???????????????(userId???groupId) */
@property(nonatomic, readwrite) uint64_t targetId;

/** ??????Id */
@property(nonatomic, readwrite) uint64_t payId;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *payPwd;

/**
 * *
 * ???????????????
 * 1??????????????????
 * 2???????????????
 * 3???????????????
 **/
@property(nonatomic, readwrite) int32_t redPacketType;

/** ??????????????? */
@property(nonatomic, readwrite) float amount;

/** ???????????? */
@property(nonatomic, readwrite) int32_t quantity;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bestWishes;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *cover;

/** ??????Id???IOS???Android??? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *appId;

/** ????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceId;

@end

#pragma mark - DLMSnatchRedPacketReq

typedef GPB_ENUM(DLMSnatchRedPacketReq_FieldNumber) {
  DLMSnatchRedPacketReq_FieldNumber_RedPacketId = 1,
  DLMSnatchRedPacketReq_FieldNumber_DeviceId = 2,
};

/**
 * ????????????EventType.SnatchRedPacket???
 **/
GPB_FINAL @interface DLMSnatchRedPacketReq : GPBMessage

/** ??????Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** ????????? */
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
 * ????????????EventType.DismantleRedPacket???
 **/
GPB_FINAL @interface DLMDismantleRedPacketReq : GPBMessage

/** ??????Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** ??????Id????????????RedPacketRsp?????????authId */
@property(nonatomic, readwrite, copy, null_resettable) NSString *authId;

/** ?????????????????????RedPacketRsp?????????timeStamp */
@property(nonatomic, readwrite) uint64_t timeStamp;

/** ????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceId;

@end

#pragma mark - DLMRedPacketListReq

typedef GPB_ENUM(DLMRedPacketListReq_FieldNumber) {
  DLMRedPacketListReq_FieldNumber_RedPacketId = 1,
  DLMRedPacketListReq_FieldNumber_AuthId = 2,
  DLMRedPacketListReq_FieldNumber_TimeStamp = 3,
};

/**
 * ???????????????EventType.RedPacketList???
 **/
GPB_FINAL @interface DLMRedPacketListReq : GPBMessage

/** ??????Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** ??????Id????????????RedPacketRsp?????????authId */
@property(nonatomic, readwrite, copy, null_resettable) NSString *authId;

/** ?????????????????????RedPacketRsp?????????timeStamp */
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
 * ????????????
 **/
GPB_FINAL @interface DLMRedPacketRsp : GPBMessage

/** ???????????????Id */
@property(nonatomic, readwrite) uint64_t userId;

/** ??????Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/**
 * *
 * ????????????
 * 1??????????????????
 * 2???????????????
 * 3???????????????
 **/
@property(nonatomic, readwrite) int32_t redPacketType;

/** ???????????????${??????}+?????????????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *redPacketTitle;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *headImg;

/** ??????Id */
@property(nonatomic, readwrite, copy, null_resettable) NSString *authId;

/** ????????? */
@property(nonatomic, readwrite) uint64_t timeStamp;

/**
 * *
 * ????????????
 * 0????????????
 * 1????????????
 * 2????????????
 * 3????????????
 **/
@property(nonatomic, readwrite) int32_t claimStatus;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *claimAmount;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *amountUnit;

/**
 * *
 * ????????????
 * 0???????????? --???bestWishes
 * 1???????????? --???claimAmount+amountUnit
 * 2???????????? --????????????
 * 3???????????? --?????????????????????24????????????????????????????????????????????????????????????
 **/
@property(nonatomic, readwrite, copy, null_resettable) NSString *copywriting;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *showProgress;

/**
 * *
 * ????????????????????????????????????
 * 1?????????????????????
 * 2??????????????????
 **/
@property(nonatomic, readwrite) BOOL showDetails;

/**
 * *
 * ????????????????????????????????????false?????????????????????true???????????????????????????
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
 * ??????????????????
 **/
GPB_FINAL @interface DLMSendRedPacketRsp : GPBMessage

/** ??????Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** ?????????MsgId */
@property(nonatomic, readwrite) uint64_t msgId;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bestWishes;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *cover;

@end

#pragma mark - DLMRedPacketDetailInfoRsp

typedef GPB_ENUM(DLMRedPacketDetailInfoRsp_FieldNumber) {
  DLMRedPacketDetailInfoRsp_FieldNumber_RedPacket = 1,
  DLMRedPacketDetailInfoRsp_FieldNumber_UserRedPacketsArray = 2,
};

/**
 * ??????????????????
 **/
GPB_FINAL @interface DLMRedPacketDetailInfoRsp : GPBMessage

/** ???????????? */
@property(nonatomic, readwrite, strong, null_resettable) DLMRedPacketRsp *redPacket;
/** Test to see if @c redPacket has been set. */
@property(nonatomic, readwrite) BOOL hasRedPacket;

/** ???????????????????????? */
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
 * ??????????????????
 **/
GPB_FINAL @interface DLMUserRedPacketRsp : GPBMessage

/** ??????Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *nickName;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *headImg;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *claimAmount;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *amountUnit;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *claimTime;

/** ?????????????????? */
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

/** ??????Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** ???????????? */
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

/** ??????Id */
@property(nonatomic, readwrite) uint64_t redPacketId;

/** ??????UserId */
@property(nonatomic, readwrite) uint64_t userId;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *faceURL;

/** ????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *userName;

/** ????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *mobile;

/** ????????????????????????????????? */
@property(nonatomic, readwrite) int32_t claimAmount;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *merchantNo;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *tradeName;

/** ???????????? */
@property(nonatomic, readwrite, copy, null_resettable) NSString *tradeDesc;

/** ??????Id */
@property(nonatomic, readwrite) uint64_t payId;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
