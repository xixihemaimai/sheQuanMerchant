//
//  OrderModel.swift
//  Util
//
//  Created by mac on 2022/6/1.
//

import Foundation




public struct BrandModel: Codable{
    public let brandId:Int32? //品牌ID
    public let brandName:String? //品牌名称
    
    enum CodingKeys: String, CodingKey {
        case brandId = "brandId"
        case brandName = "brandName"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        brandId = try? values.decodeIfPresent(Int32.self, forKey: .brandId)
        brandName = try? values.decodeIfPresent(String.self, forKey: .brandName)
    }
}


public struct productListModel: Codable {
    public var applyTime: String?
    public var auditOpinion: String?
    public var auditStatus: Int32?
    public var auditStatusText: String?
    public var productId: Int64?
    public var productName: String?
    public var productPic: String?
    public var productStatus:Int32?
    public var productSpecs: [String]?
    public var rejectType: String?
    public var sales: Int32?
    public var sortTime: Int64?
    public var stock: Int32?
    
    enum CodingKeys: String, CodingKey {
        case applyTime = "applyTime"
        case auditOpinion = "auditOpinion"
        case auditStatus = "auditStatus"
        case auditStatusText = "auditStatusText"
        case productId = "productId"
        case productName = "productName"
        case productPic = "productPic"
        case productStatus = "productStatus"
        case productSpecs = "productSpecs"
        case rejectType = "rejectType"
        case sales = "sales"
        case sortTime = "sortTime"
        case stock = "stock"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        applyTime = try? values.decodeIfPresent(String.self, forKey: .applyTime)
        auditOpinion = try? values.decodeIfPresent(String.self, forKey: .auditOpinion)
        auditStatus = try? values.decodeIfPresent(Int32.self, forKey: .auditStatus)
        auditStatusText = try? values.decodeIfPresent(String.self, forKey: .auditStatusText)
        productId = try? values.decode(Int64.self, forKey: .productId)
        productName = try? values.decodeIfPresent(String.self, forKey: .productName)
        productPic = try? values.decodeIfPresent(String.self, forKey: .productPic)
        productStatus = try? values.decodeIfPresent(Int32.self, forKey: .productStatus)
        productSpecs = try? values.decodeIfPresent([String].self, forKey: .productSpecs)
        rejectType = try? values.decodeIfPresent(String.self, forKey: .rejectType)
        sales = try? values.decodeIfPresent(Int32.self, forKey: .sales)
        sortTime = try? values.decodeIfPresent(Int64.self, forKey: .sortTime)
        stock = try? values.decodeIfPresent(Int32.self, forKey: .stock)
    }
}



public struct FreightListModel:Codable{
    public var chargeType:Int32?             //计费类型（1,按件计费）
    public var chargeTypeText:String?        //计费类型(1.按件计费)
    public var defTemp:Bool?                 //默认模版（false：取消默认、true：默认）
    public var freightConf:freightConfModel? //运费配置
    public var freightId:Int64?              //运费Id
    public var freightType:Int32?            //运费类型 （1、包邮：2、自定义）
    public var freightTypeText:String?       //运费类型（1、包邮：2、自定义）
    public var freightVerId:Int32?           //运费版本Id
    public var noDeliveryRegionIds:[Int32]?    //不配送区域
    public var templateName:String?          //模版名称
    
    
    enum CodingKeys: String, CodingKey {
        case chargeType = "chargeType"
        case chargeTypeText = "chargeTypeText"
        case defTemp = "defTemp"
        case freightConf = "freightConf"
        case freightId = "freightId"
        case freightType = "freightType"
        case freightTypeText = "freightTypeText"
        case freightVerId = "freightVerId"
        case noDeliveryRegionIds = "noDeliveryRegionIds"
        case templateName = "templateName"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chargeType = try? values.decodeIfPresent(Int32.self, forKey: .chargeType)
        chargeTypeText = try? values.decodeIfPresent(String.self, forKey: .chargeTypeText)
        defTemp = try? values.decodeIfPresent(Bool.self, forKey: .defTemp)
        freightConf = try? values.decodeIfPresent(freightConfModel.self, forKey: .freightConf)
        freightId = try? values.decode(Int64.self, forKey: .freightId)
        freightType = try? values.decodeIfPresent(Int32.self, forKey: .freightType)
        freightTypeText = try? values.decodeIfPresent(String.self, forKey: .freightTypeText)
        freightVerId = try? values.decodeIfPresent(Int32.self, forKey: .freightVerId)
        noDeliveryRegionIds = try? values.decodeIfPresent([Int32].self, forKey: .noDeliveryRegionIds)
        templateName = try? values.decodeIfPresent(String.self, forKey: .templateName)
    }
    
    
    
//    public init(price:Decimal? = 0,skuCode:String? = "",skuId:Int64? = 0,skuPics:[String]? = [String](),specs:[Specs]? = [Specs](),stock:Int32? = 0){
//        self.price = price
//        self.skuCode = skuCode
//        self.skuId = skuId
//        self.skuPics = skuPics
//        self.specs = specs
//        self.stock = stock
//    }
    
    
    
    public init(chargeType:Int32? = 0,chargeTypeText:String? = "",defTemp:Bool? = false,freightConf:freightConfModel? = freightConfModel(firstPiece: 0, freight: 0, parcelConditions: 0, renewal: 0, renewalFreight: 0),freightId:Int64? = 0,freightType:Int32? = 0,freightTypeText:String? = "",freightVerId:Int32? = 0,noDeliveryRegionIds:[Int32]? = [Int32](),templateName:String? = ""){
        
        self.chargeType = chargeType
        self.chargeTypeText = chargeTypeText
        self.defTemp = defTemp
        self.freightConf = freightConf
        self.freightId = freightId
        self.freightType = freightType
        self.freightTypeText = freightTypeText
        self.freightVerId = freightVerId
        self.noDeliveryRegionIds = noDeliveryRegionIds
        self.templateName = templateName
    }
}



public struct freightConfModel:Codable{
    public var firstPiece:Int32? //首件
    public var freight:Decimal?  //运费
    public var freightConfId:Int64? //运费配置Id
    public var parcelConditions:Int32? //   包邮条件(件）
    public var renewal:Int32?    //续件
    public var renewalFreight:Decimal?  //续件运费
    
    enum CodingKeys: String, CodingKey {
        case firstPiece = "firstPiece"
        case freight = "freight"
        case freightConfId = "freightConfId"
        case parcelConditions = "parcelConditions"
        case renewal = "renewal"
        case renewalFreight = "renewalFreight"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstPiece = try? values.decodeIfPresent(Int32.self, forKey: .firstPiece)
        freight = try? values.decodeIfPresent(Decimal.self, forKey: .freight)
        freightConfId = try? values.decodeIfPresent(Int64.self, forKey: .freightConfId)
        parcelConditions = try? values.decodeIfPresent(Int32.self, forKey: .parcelConditions)
        renewal = try? values.decodeIfPresent(Int32.self, forKey: .renewal)
        renewalFreight = try? values.decodeIfPresent(Decimal.self, forKey: .renewalFreight)
    }
    
    
    public init(firstPiece:Int32? = 0,freight:Decimal? = 0,freightConfId:Int64? = 0,parcelConditions:Int32? = 0,renewal:Int32? = 0,renewalFreight:Decimal? = 0){
        self.firstPiece = firstPiece
        self.freight = freight
        self.freightConfId = freightConfId
        self.parcelConditions = parcelConditions
        self.renewal = renewal
        self.renewalFreight = renewalFreight
    }
    
    
}




public struct soldOutSkuListModel: Codable {
    public var productId: Int64?
    public var productName: String?
    public var productPic: String?
    public var skus:[skusModel]?
    
    
    enum CodingKeys: String, CodingKey {
        case productId = "productId"
        case productName = "productName"
        case productPic = "productPic"
        case skus = "skus"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productId = try? values.decode(Int64.self, forKey: .productId)
        productName = try? values.decodeIfPresent(String.self, forKey: .productName)
        productPic = try? values.decodeIfPresent(String.self, forKey: .productPic)
        skus = try? values.decodeIfPresent([skusModel].self, forKey: .skus)
    }
}

public struct skusModel: Codable {
    public var productSpecs: String?
    public var skuId:Int64?
    
    enum CodingKeys: String, CodingKey {
        case productSpecs = "productSpecs"
        case skuId = "skuId"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productSpecs = try? values.decodeIfPresent(String.self, forKey: .productSpecs)
        skuId = try? values.decodeIfPresent(Int64.self, forKey: .skuId)
    }
    
}

public struct SkuStockInfoModel:Codable{
    public var skuId:Int64?
    public var stock: Int32?
    
    enum CodingKeys: String, CodingKey {
        case skuId = "skuId"
        case stock = "stock"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        skuId = try? values.decodeIfPresent(Int64.self, forKey: .skuId)
        stock = try? values.decodeIfPresent(Int32.self, forKey: .stock)
    }
    
    public init(skuId:Int64? = 0,stock:Int32? = 0){
        self.skuId = skuId
        self.stock = stock
    }
    
    
}



