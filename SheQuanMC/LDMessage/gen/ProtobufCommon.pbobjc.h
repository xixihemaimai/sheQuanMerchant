// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: ProtobufCommon.proto

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

@class DLMReportImageReq;
@class DLMReportSceneInfoRsp;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - DLMProtobufCommonRoot

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
GPB_FINAL @interface DLMProtobufCommonRoot : GPBRootObject
@end

#pragma mark - DLMReportSceneListReq

/**
 * 举报场景列表（EventType.ReportSceneList）
 **/
GPB_FINAL @interface DLMReportSceneListReq : GPBMessage

@end

#pragma mark - DLMReportSceneListRsp

typedef GPB_ENUM(DLMReportSceneListRsp_FieldNumber) {
  DLMReportSceneListRsp_FieldNumber_ScenesArray = 1,
};

/**
 * 举报场景列表应答
 **/
GPB_FINAL @interface DLMReportSceneListRsp : GPBMessage

/** 举报场景列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<DLMReportSceneInfoRsp*> *scenesArray;
/** The number of items in @c scenesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger scenesArray_Count;

@end

#pragma mark - DLMReportSceneInfoRsp

typedef GPB_ENUM(DLMReportSceneInfoRsp_FieldNumber) {
  DLMReportSceneInfoRsp_FieldNumber_ReportId = 1,
  DLMReportSceneInfoRsp_FieldNumber_ReportName = 2,
};

/**
 * 举报场景信息应答
 **/
GPB_FINAL @interface DLMReportSceneInfoRsp : GPBMessage

/** 举报Id */
@property(nonatomic, readwrite) int32_t reportId;

/** 举报名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *reportName;

@end

#pragma mark - DLMSubmitReportReq

typedef GPB_ENUM(DLMSubmitReportReq_FieldNumber) {
  DLMSubmitReportReq_FieldNumber_ReportId = 1,
  DLMSubmitReportReq_FieldNumber_ReportDesc = 5,
  DLMSubmitReportReq_FieldNumber_ImagesArray = 10,
};

/**
 * 提交举报（EventType.SubmitReport）
 **/
GPB_FINAL @interface DLMSubmitReportReq : GPBMessage

/** 举报Id */
@property(nonatomic, readwrite) int32_t reportId;

/** 举报描述 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *reportDesc;

/** 举报图片 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<DLMReportImageReq*> *imagesArray;
/** The number of items in @c imagesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger imagesArray_Count;

@end

#pragma mark - DLMReportImageListReq

typedef GPB_ENUM(DLMReportImageListReq_FieldNumber) {
  DLMReportImageListReq_FieldNumber_ImagesArray = 1,
};

/**
 * 举报图片列表
 **/
GPB_FINAL @interface DLMReportImageListReq : GPBMessage

/** 图片列表 */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<DLMReportImageReq*> *imagesArray;
/** The number of items in @c imagesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger imagesArray_Count;

@end

#pragma mark - DLMReportImageReq

typedef GPB_ENUM(DLMReportImageReq_FieldNumber) {
  DLMReportImageReq_FieldNumber_ThumbURL = 1,
  DLMReportImageReq_FieldNumber_ImgURL = 2,
  DLMReportImageReq_FieldNumber_Width = 3,
  DLMReportImageReq_FieldNumber_Height = 4,
};

/**
 * 举报图片
 **/
GPB_FINAL @interface DLMReportImageReq : GPBMessage

/** 缩略图 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *thumbURL;

/** 原图地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *imgURL;

/** 图片宽度 */
@property(nonatomic, readwrite) int32_t width;

/** 图片高度 */
@property(nonatomic, readwrite) int32_t height;

@end

#pragma mark - DLMVerifyCodeReq

typedef GPB_ENUM(DLMVerifyCodeReq_FieldNumber) {
  DLMVerifyCodeReq_FieldNumber_VerifyType = 1,
};

/**
 * 获取验证码（EventType.VerifyCode）
 **/
GPB_FINAL @interface DLMVerifyCodeReq : GPBMessage

/** 验证类型（1：支付验证码） */
@property(nonatomic, readwrite) int32_t verifyType;

@end

#pragma mark - DLMVerifyCodeRsp

typedef GPB_ENUM(DLMVerifyCodeRsp_FieldNumber) {
  DLMVerifyCodeRsp_FieldNumber_VerifyId = 1,
};

/**
 * 获取验证码响应信息
 **/
GPB_FINAL @interface DLMVerifyCodeRsp : GPBMessage

/** 验证Id */
@property(nonatomic, readwrite, copy, null_resettable) NSString *verifyId;

@end

#pragma mark - DLMCheckVerifyCodeReq

typedef GPB_ENUM(DLMCheckVerifyCodeReq_FieldNumber) {
  DLMCheckVerifyCodeReq_FieldNumber_VerifyId = 1,
  DLMCheckVerifyCodeReq_FieldNumber_VerifyCode = 2,
};

/**
 * 校验验证码（EventType.CheckVerifyCode）
 **/
GPB_FINAL @interface DLMCheckVerifyCodeReq : GPBMessage

/** 验证Id */
@property(nonatomic, readwrite, copy, null_resettable) NSString *verifyId;

/** 验证码 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *verifyCode;

@end

#pragma mark - DLMCheckVerifyCodeRsp

typedef GPB_ENUM(DLMCheckVerifyCodeRsp_FieldNumber) {
  DLMCheckVerifyCodeRsp_FieldNumber_CertifyId = 1,
};

/**
 * 校验验证码响应信息
 **/
GPB_FINAL @interface DLMCheckVerifyCodeRsp : GPBMessage

/** 认证Id */
@property(nonatomic, readwrite, copy, null_resettable) NSString *certifyId;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
