//
//  CommodityModel.swift
//  Util
//
//  Created by mac on 2022/5/26.
//

import Foundation



public struct CommodityModel: Codable {
    public var categoryId:Int32?
    public var freeRefundIn7Days:Bool?
    public var freightInsure:Bool?
    public var freightTempId:Int32?
    public var multiSpec: Bool?
    public var productCode: String?
    //商品描述
    public var productDesc: String?
    public var productId: String?
    public var productName: String?
    //图片
    public var productPics:[String]?
    public var seqNo:Int32?
    public var shopId:Int64?
    public var skus:[Skus]?
    public var specs:[Specs]?
    public var spus:[Spus]?
    public var stock:Int32?
    public var stockDeductType:Int32?
    
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "categoryId"
        case freeRefundIn7Days = "freeRefundIn7Days"
        case freightInsure = "freightInsure"
        case freightTempId = "freightTempId"
        case multiSpec = "multiSpec"
        case productCode = "productCode"
        case productDesc = "productDesc"
        case productId = "productId"
        case productName = "productName"
        case productPics = "productPics"
        case seqNo = "seqNo"
        case shopId = "shopId"
        case skus = "skus"
        case specs = "specs"
        case spus = "spus"
        case stock = "stock"
        case stockDeductType = "stockDeductType"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try? values.decodeIfPresent(Int32.self, forKey: .categoryId)
        freeRefundIn7Days = try? values.decodeIfPresent(Bool.self, forKey: .freeRefundIn7Days)
        freightInsure = try? values.decodeIfPresent(Bool.self, forKey: .freightInsure)
        freightTempId = try? values.decodeIfPresent(Int32.self, forKey: .freightTempId)
        multiSpec = try? values.decodeIfPresent(Bool.self, forKey: .multiSpec)
        productCode = try? values.decodeIfPresent(String.self, forKey: .productCode)
        productDesc = try? values.decodeIfPresent(String.self, forKey: .productDesc)
        productId = try? values.decodeIfPresent(String.self, forKey: .productId)
        productName = try? values.decodeIfPresent(String.self, forKey: .productName)
        productPics = try? values.decodeIfPresent([String].self, forKey: .productPics)
        seqNo = try? values.decodeIfPresent(Int32.self, forKey: .seqNo)
        shopId = try? values.decodeIfPresent(Int64.self, forKey: .shopId)
        skus = try? values.decodeIfPresent([Skus].self, forKey: .skus)
        specs = try? values.decodeIfPresent([Specs].self, forKey: .specs)
        spus = try? values.decodeIfPresent([Spus].self, forKey: .spus)
        stock = try? values.decodeIfPresent(Int32.self, forKey: .stock)
        stockDeductType = try? values.decodeIfPresent(Int32.self, forKey: .stockDeductType)
    }
    
    
    public init(categoryId:Int32? = 0,freeRefundIn7Days:Bool? = false,freightInsure:Bool? = false,freightTempId:Int32? = 0,multiSpec:Bool? = false,productCode:String? = "",productDesc:String? = "",productId:String? = "",productName:String? = "",productPics:[String]? = [String](),sepNo:Int32? = 0,shopId:Int64 = 0,skus:[Skus]? = [Skus](),specs:[Specs]? = [Specs](),spus:[Spus]? = [Spus](),stock:Int32? = 0,stockDeductType:Int32? = 0){
        self.categoryId = categoryId
        self.freeRefundIn7Days = freeRefundIn7Days
        self.freightInsure = freightInsure
        self.freightTempId = freightTempId
        self.multiSpec = multiSpec
        self.productCode = productCode
        self.productDesc = productDesc
        self.productId = productId
        self.productName = productName
        self.productPics = productPics
        self.seqNo = sepNo
        self.shopId = shopId
        self.skus = skus
        self.specs = specs
        self.spus = spus
        self.stock = stock
        self.stockDeductType = stockDeductType
    }
    
    
    
}


//价格库存
public struct Skus: Codable {
    public var mixPurchase:Int32?
    public var price:Decimal?
    public var restrictedQty:Int32?
    public var skuCode: String?
    public var skuId: String?
    //图片
    public var skuPics:[String]?
    public var specs:[Specs]?
    public var stock:Int32?
    
    
    enum CodingKeys: String, CodingKey {
        case mixPurchase = "mixPurchase"
        case price = "price"
        case restrictedQty = "restrictedQty"
        case skuCode = "skuCode"
        case skuId = "skuId"
        case skuPics = "skuPics"
        case specs = "specs"
        case stock = "stock"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mixPurchase = try? values.decodeIfPresent(Int32.self, forKey: .mixPurchase)
        price = try? values.decodeIfPresent(Decimal.self, forKey: .price)
        restrictedQty = try? values.decodeIfPresent(Int32.self, forKey: .restrictedQty)
        skuCode = try? values.decodeIfPresent(String.self, forKey: .skuCode)
        skuId = try? values.decodeIfPresent(String.self, forKey: .skuId)
        skuPics = try? values.decodeIfPresent([String].self, forKey: .skuPics)
        specs = try? values.decodeIfPresent([Specs].self, forKey: .specs)
        stock = try? values.decodeIfPresent(Int32.self, forKey: .stock)
    }
    
    
    
    public init(mixPurchase:Int32,price:Decimal? = 0,restrictedQty:Int32? = 0,skuCode:String? = "",skuId:String? = "",skuPics:[String]? = [String](),specs:[Specs]? = [Specs](),stock:Int32? = 0){
        self.mixPurchase = mixPurchase
        self.price = price
        self.restrictedQty = restrictedQty
        self.skuCode = skuCode
        self.skuId = skuId
        self.skuPics = skuPics
        self.specs = specs
        self.stock = stock
    }
    
    
}


public struct Specs: Codable {
    public var specAttrId: Int32?
    public var specId: String?
    public var specName:String?
    public var specValue: String?
   
    enum CodingKeys: String, CodingKey {
        case specAttrId = "specAttrId"
        case specId = "specId"
        case specName = "specName"
        case specValue = "specValue"

    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        specAttrId = try? values.decodeIfPresent(Int32.self, forKey: .specAttrId)
        specId = try? values.decodeIfPresent(String.self, forKey: .specId)
        specName = try? values.decodeIfPresent(String.self, forKey: .specName)
        specValue = try? values.decodeIfPresent(String.self, forKey: .specValue)
    }
    
    
    public init(specAttrId:Int32? = 0,specId:String? = "",specName:String? = "",specValue:String? = ""){
        self.specAttrId = specAttrId
        self.specId = specId
        self.specName = specName
        self.specValue = specValue
    }
    
    
}


public struct Spus: Codable {
    public var length:Int32?
    public var required:Bool?
    public var spuAttrId:Int32?
    public var spuAttrName: String?
    public var spuId: String?
    public var spuType:Int32?
    public var spuValue: String?
    
    
    enum CodingKeys: String, CodingKey {
        case length = "length"
        case required = "required"
        case spuAttrId = "spuAttrId"
        case spuAttrName = "spuAttrName"
        case spuId = "spuId"
        case spuType = "spuType"
        case spuValue = "spuValue"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        length = try? values.decodeIfPresent(Int32.self, forKey: .length)
        required = try? values.decodeIfPresent(Bool.self, forKey: .required)
        spuAttrId = try? values.decodeIfPresent(Int32.self, forKey: .spuAttrId)
        spuAttrName = try? values.decodeIfPresent(String.self, forKey: .spuAttrName)
        spuId = try? values.decodeIfPresent(String.self, forKey: .spuId)
        spuType = try? values.decodeIfPresent(Int32.self, forKey: .spuType)
        spuValue = try? values.decodeIfPresent(String.self, forKey: .spuValue)
    }
    
    
    
    public init(length:Int32? = 0,required:Bool? = false,spuAttrId:Int32? = 0,spuAttrName:String? = "",spuId:String? = "",spuType:Int32? = 0,spuValue:String? = ""){
        self.length = length
        self.required = required
        self.spuAttrId = spuAttrId
        self.spuAttrName = spuAttrName
        self.spuId = spuId
        self.spuType = spuType
        self.spuValue = spuValue
    }
}


//价格规格商品规格
//public struct SkusSpecs: Codable {
//    public var specAttrId: Int32?
//    public var specId: String?
//    public var specValue: String?
//
//    enum CodingKeys: String, CodingKey {
//        case specAttrId = "specAttrId"
//        case specId = "specId"
//        case specValue = "specValue"
//    }
//
//    public init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        specAttrId = try? values.decodeIfPresent(Int32.self, forKey: .specAttrId)
//        specId = try? values.decodeIfPresent(String.self, forKey: .specId)
//        specValue = try? values.decodeIfPresent(String.self, forKey: .specValue)
//    }
//
//    public init(specAttrId:Int32? = 0,specId:String? = "",specValue:String? = ""){
//        self.specAttrId = specAttrId
//        self.specId = specId
//        self.specValue = specValue
//    }
//}
