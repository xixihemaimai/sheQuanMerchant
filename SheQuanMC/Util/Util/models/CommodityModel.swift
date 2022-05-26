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
    public var productDesc: String?
    public var productId: String?
    public var productName: String?
    //图片
    public var productPics:[String]?
    public var skus:[Skus]?
    public var specs:[Specs]?
    public var spus:[Spus]?
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
        case skus = "skus"
        case specs = "specs"
        case spus = "spus"
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
        skus = try? values.decodeIfPresent([Skus].self, forKey: .skus)
        specs = try? values.decodeIfPresent([Specs].self, forKey: .specs)
        spus = try? values.decodeIfPresent([Spus].self, forKey: .spus)
        stockDeductType = try? values.decodeIfPresent(Int32.self, forKey: .stockDeductType)
    }
    
    
    public init(categoryId:Int32? = 0,freeRefundIn7Days:Bool? = false,freightInsure:Bool? = false,freightTempId:Int32? = 0,multiSpec:Bool? = false,productCode:String? = "",productDesc:String? = "",productId:String? = "",productName:String? = "",productPics:[String]? = [String](),skus:[Skus]? = [Skus](),specs:[Specs]? = [Specs](),spus:[Spus]? = [Spus](),stockDeductType:Int32? = 0){
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
        self.skus = skus
        self.specs = specs
        self.spus = spus
        self.stockDeductType = stockDeductType
    }
    
    
    
}


//价格库存
public struct Skus: Codable {
    public var price:Decimal?
    public var restrictedQty:Int32?
    public var skuCode: String?
    public var skuId: String?
    //图片
    public var skuPics:[String]?
    public var specs:[SkusSpecs]?
    public var stock:Int32?
    
    
    enum CodingKeys: String, CodingKey {
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
        price = try? values.decodeIfPresent(Decimal.self, forKey: .price)
        restrictedQty = try? values.decodeIfPresent(Int32.self, forKey: .restrictedQty)
        skuCode = try? values.decodeIfPresent(String.self, forKey: .skuCode)
        skuId = try? values.decodeIfPresent(String.self, forKey: .skuId)
        skuPics = try? values.decodeIfPresent([String].self, forKey: .skuPics)
        specs = try? values.decodeIfPresent([SkusSpecs].self, forKey: .specs)
        stock = try? values.decodeIfPresent(Int32.self, forKey: .stock)
    }
    
    
    
    public init(price:Decimal? = 0,restrictedQty:Int32? = 0,skuCode:String? = "",skuId:String? = "",skuPics:[String]? = [String](),specs:[SkusSpecs]? = [SkusSpecs](),stock:Int32? = 0){
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
    public var specValue: String?
   
    enum CodingKeys: String, CodingKey {
        case specAttrId = "specAttrId"
        case specId = "specId"
        case specValue = "specValue"

    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        specAttrId = try? values.decodeIfPresent(Int32.self, forKey: .specAttrId)
        specId = try? values.decodeIfPresent(String.self, forKey: .specId)
        specValue = try? values.decodeIfPresent(String.self, forKey: .specValue)
    }
    
    
    public init(specAttrId:Int32? = 0,specId:String? = "",specValue:String? = ""){
        self.specAttrId = specAttrId
        self.specId = specId
        self.specValue = specValue
    }
    
    
}


public struct Spus: Codable {
    public var spuAttrId:Int32?
    public var spuAttrName: String?
    public var spuId: String?
    public var spuValue: String?
    
    
    enum CodingKeys: String, CodingKey {
        case spuAttrId = "spuAttrId"
        case spuAttrName = "spuAttrName"
        case spuId = "spuId"
        case spuValue = "spuValue"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        spuAttrId = try? values.decodeIfPresent(Int32.self, forKey: .spuAttrId)
        spuAttrName = try? values.decodeIfPresent(String.self, forKey: .spuAttrName)
        spuId = try? values.decodeIfPresent(String.self, forKey: .spuId)
        spuValue = try? values.decodeIfPresent(String.self, forKey: .spuValue)
    }
    
    
    
    public init(spuAttrId:Int32? = 0,spuAttrName:String? = "",spuId:String? = "",spuValue:String? = ""){
        self.spuAttrId = spuAttrId
        self.spuAttrName = spuAttrName
        self.spuId = spuId
        self.spuValue = spuValue
    }
}


//价格规格商品规格
public struct SkusSpecs: Codable {
    public var specAttrId: Int32?
    public var specId: String?
    public var specValue: String?
    
    enum CodingKeys: String, CodingKey {
        case specAttrId = "specAttrId"
        case specId = "specId"
        case specValue = "specValue"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        specAttrId = try? values.decodeIfPresent(Int32.self, forKey: .specAttrId)
        specId = try? values.decodeIfPresent(String.self, forKey: .specId)
        specValue = try? values.decodeIfPresent(String.self, forKey: .specValue)
    }
    
    public init(specAttrId:Int32? = 0,specId:String? = "",specValue:String? = ""){
        self.specAttrId = specAttrId
        self.specId = specId
        self.specValue = specValue
    }
}
