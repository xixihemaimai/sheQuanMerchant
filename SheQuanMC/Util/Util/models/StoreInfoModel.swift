//
//  StoreInfoModel.swift
//  Util
//
//  Created by mac on 2022/5/18.
//

import Foundation


public struct StoreInfoModel:Codable{
    /**
     accessToken    string
     店铺Token
     //申请状态     integer($int32)
     审核状态(0：未认证、1：审核中、2：认证成功、3：已驳回)
     @objc public dynamic var auditStatus = 0
     //经营种类ID
     @objc public dynamic var categoryId = 0
     //经营种类名称
     @objc public dynamic var categoryName = ""
     //身份证号
     @objc public dynamic var certNo = ""
     //国家地区
     @objc public dynamic var countryId = 0
     //信用代码
     @objc public dynamic var creditCode = ""
     //电子邮件
     @objc public dynamic var email = ""
     //entAddress 企业地址
     @objc public dynamic var entAddress = ""
     //企业名称
     @objc public dynamic var entName = ""
     //身份证正面
     @objc public dynamic var frontPic = ""
     //法人姓名
     @objc public dynamic var legalName = ""
     //营业执照
     @objc public dynamic var licencePic = ""
     //手机号
     @objc public dynamic var mobile = ""
     //注册时间（开通时间）
     @objc public dynamic var regTime = ""
     //驳回原因
     @objc public dynamic var rejectReason = ""
     //身份证反面
     @objc public dynamic var reversePic = ""
     //店铺认证（false：未认证、true：已认证）--头像、店铺名称、经营品类
     @objc public dynamic var shopAuth = false
     //店铺头像
     @objc public dynamic var shopAvatar = ""
     //店铺ID
     @objc public dynamic var shopId = 0
     //店铺名称
     @objc public dynamic var shopName = ""
     
     
     */
    public let accessToken:String?
    public let auditStatus: Int32?
    public let categoryId: Int32?
    public let categoryName: String?
    public let certNo: String?
    public let countryId: Int32?
    
    public let creditCode: String?
    public let email: String?
    public let entAddress: String?
    public let entName: String?
    public let frontPic: String?
    
    public let legalName: String?
    public let licencePic: String?
    public let mobile: String?
    public let regTime: String?
    public let rejectReason: String?
    
    public let reversePic: String?
    public let shopAuth:Bool?
    public let shopAvatar: String?
    public let shopId: Int64?
    public let shopName: String?
    
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case auditStatus = "auditStatus"
        case categoryId = "categoryId"
        case categoryName = "categoryName"
        case certNo = "certNo"
        case countryId = "countryId"
        
        case creditCode = "creditCode"
        case email = "email"
        case entAddress = "entAddress"
        case entName = "entName"
        case frontPic = "frontPic"
        
        case legalName = "legalName"
        case licencePic = "licencePic"
        case mobile = "mobile"
        case regTime = "regTime"
        case rejectReason = "rejectReason"
        
        case reversePic = "reversePic"
        case shopAuth = "shopAuth"
        case shopAvatar = "shopAvatar"
        case shopId = "shopId"
        case shopName = "shopName"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        accessToken = try? values.decodeIfPresent(String.self, forKey: .accessToken)
        
        auditStatus = try? values.decodeIfPresent(Int32.self, forKey: .auditStatus)
        categoryId = try? values.decodeIfPresent(Int32.self, forKey: .categoryId)
        categoryName = try? values.decodeIfPresent(String.self, forKey: .categoryName)
        certNo = try? values.decodeIfPresent(String.self, forKey: .certNo)
        countryId = try? values.decodeIfPresent(Int32.self, forKey: .countryId)
        
        
        creditCode = try? values.decodeIfPresent(String.self, forKey: .creditCode)
        email = try? values.decodeIfPresent(String.self, forKey: .email)
        entAddress = try? values.decodeIfPresent(String.self, forKey: .entAddress)
        entName = try? values.decodeIfPresent(String.self, forKey: .entName)
        frontPic = try? values.decodeIfPresent(String.self, forKey: .frontPic)
        
        legalName = try? values.decodeIfPresent(String.self, forKey: .legalName)
        licencePic = try? values.decodeIfPresent(String.self, forKey: .licencePic)
        mobile = try? values.decodeIfPresent(String.self, forKey: .mobile)
        regTime = try? values.decodeIfPresent(String.self, forKey: .regTime)
        rejectReason = try? values.decodeIfPresent(String.self, forKey: .rejectReason)
        
        reversePic = try? values.decodeIfPresent(String.self, forKey: .reversePic)
        
        shopAuth = try? values.decodeIfPresent(Bool.self, forKey: .shopAuth)
        
        shopAvatar = try? values.decodeIfPresent(String.self, forKey: .shopAvatar)
        
        shopId = try? values.decodeIfPresent(Int64.self, forKey: .shopId)
        
        shopName = try? values.decodeIfPresent(String.self, forKey: .shopName)
        
    }

}
