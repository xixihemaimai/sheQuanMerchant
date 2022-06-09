//
//  CommodityModel.swift
//  Util
//
//  Created by mac on 2022/5/26.
//

import Foundation



public struct CommodityModel: Codable {
    public var categoryId:Int32?       //类目ID
    public var freeRefundIn7Days:Bool? //七天无理由退货（false:关,true:开）
    public var categoryName:String?    //类目名称
    public var freightId:Int64?        //运费模板ID
    public var freightInsure:Bool?     //退换货运费险（false:关，true:开）
    public var freightName:String?     //运费模版
    public var multiSpec: Bool?        //多规格（false:关,true:开）
    public var price:Decimal?          //价格（只限于单规格）
    public var productCode: String?    //商品编码
    public var productDesc: String?    //商品描述
    public var productId: Int64?       //商品ID
    public var productName: String?    //商品名称
    public var productPics:[String]?   //商品主图
    public var seqNo:Int32?            //商品序号
    public var skus:[Skus]?            //价格库存
    public var specGroups:[SpecGroups]?//商品规格组
    public var spus:[Spus]?            //商品参数
    public var stock:Int32?            //库存（只限于单规格）
    public var stockDeductText:String? //库存扣减方式(1：拍下减库存、2：支付减库存)
    public var stockDeductType:Int32?  //库存扣减方式(1：拍下减库存、2：支付减库存)
    
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "categoryId"
        case categoryName = "categoryName"
        case freeRefundIn7Days = "freeRefundIn7Days"
        case freightInsure = "freightInsure"
        case freightName = "freightName"
        case freightId = "freightId"
        case multiSpec = "multiSpec"
        case price = "price"
        case productCode = "productCode"
        case productDesc = "productDesc"
        case productId = "productId"
        case productName = "productName"
        case productPics = "productPics"
        case seqNo = "seqNo"
        case skus = "skus"
        case specGroups = "specGroups"
        case spus = "spus"
        case stock = "stock"
        case stockDeductText = "stockDeductText"
        case stockDeductType = "stockDeductType"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try? values.decodeIfPresent(Int32.self, forKey: .categoryId)
        categoryName = try? values.decodeIfPresent(String.self, forKey: .categoryName)
        freeRefundIn7Days = try? values.decodeIfPresent(Bool.self, forKey: .freeRefundIn7Days)
        freightInsure = try? values.decodeIfPresent(Bool.self, forKey: .freightInsure)
        freightName = try? values.decodeIfPresent(String.self, forKey: .freightName)
        freightId = try? values.decodeIfPresent(Int64.self, forKey: .freightId)
        multiSpec = try? values.decodeIfPresent(Bool.self, forKey: .multiSpec)
        price = try? values.decodeIfPresent(Decimal.self, forKey: .price)
        productCode = try? values.decodeIfPresent(String.self, forKey: .productCode)
        productDesc = try? values.decodeIfPresent(String.self, forKey: .productDesc)
        productId = try? values.decodeIfPresent(Int64.self, forKey: .productId)
        productName = try? values.decodeIfPresent(String.self, forKey: .productName)
        productPics = try? values.decodeIfPresent([String].self, forKey: .productPics)
        seqNo = try? values.decodeIfPresent(Int32.self, forKey: .seqNo)
        skus = try? values.decodeIfPresent([Skus].self, forKey: .skus)
        specGroups = try? values.decodeIfPresent([SpecGroups].self, forKey: .specGroups)
        spus = try? values.decodeIfPresent([Spus].self, forKey: .spus)
        stock = try? values.decodeIfPresent(Int32.self, forKey: .stock)
        stockDeductText = try? values.decodeIfPresent(String.self, forKey: .stockDeductText)
        stockDeductType = try? values.decodeIfPresent(Int32.self, forKey: .stockDeductType)
    }
    
    
    public init(categoryId:Int32? = 0,categoryName:String? = "",freeRefundIn7Days:Bool? = false,freightId:Int64? = 0,freightInsure:Bool? = false,freightName:String? = "",multiSpec:Bool? = false,price:Decimal? = 0.0,productCode:String? = "",productDesc:String? = "",productId:Int64? = 0,productName:String? = "",productPics:[String]? = [String](),sepNo:Int32? = 0,skus:[Skus]? = [Skus](),specGroups:[SpecGroups]? = [SpecGroups](),spus:[Spus]? = [Spus](),stock:Int32? = 0,stockDeductText:String? = "",stockDeductType:Int32? = 0){
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.freeRefundIn7Days = freeRefundIn7Days
        self.freightInsure = freightInsure
        self.freightId = freightId
        self.freightName = freightName
        self.multiSpec = multiSpec
        self.price = price
        self.productCode = productCode
        self.productDesc = productDesc
        self.productId = productId
        self.productName = productName
        self.productPics = productPics
        self.seqNo = sepNo
        self.skus = skus
        self.specGroups = specGroups
        self.spus = spus
        self.stock = stock
        self.stockDeductText = stockDeductText
        self.stockDeductType = stockDeductType
    }
    
    
    
}


//商品规格组
public struct SpecGroups:Codable{
    public var specGroupId:Int64?    //规格组Id
    public var specGroupName:String? //规格组名
    public var specs:[String]?       //规格项
    
    enum CodingKeys: String, CodingKey {
        case specGroupId = "specGroupId"
        case specGroupName = "specGroupName"
        case specs = "specs"
    }
    
    
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        specGroupId = try? values.decodeIfPresent(Int64.self, forKey: .specGroupId)
        specGroupName = try? values.decodeIfPresent(String.self, forKey: .specGroupName)
        specs = try? values.decodeIfPresent([String].self, forKey: .specs)
    }
    
    
    
    public init(specGroupId:Int64? = 0,specGroupName:String? = "",specs:[String]? = [String]()){
        self.specGroupId = specGroupId
        self.specGroupName = specGroupName
        self.specs = specs
    }
}



//价格库存
public struct Skus: Codable {
    public var price:Decimal?   //价格
    public var skuCode: String? //Sku编码
    public var skuId: Int64?    //SkuId
    public var skuPics:[String]?//Sku图片
    public var specs:[Specs]?   //商品规格
    public var stock:Int32?     //库存
    
    
    enum CodingKeys: String, CodingKey {
        case price = "price"
        case skuCode = "skuCode"
        case skuId = "skuId"
        case skuPics = "skuPics"
        case specs = "specs"
        case stock = "stock"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        price = try? values.decodeIfPresent(Decimal.self, forKey: .price)
        skuCode = try? values.decodeIfPresent(String.self, forKey: .skuCode)
//        skuId = try? values.decodeIfPresent(String.self, forKey: .skuId)
        skuId = try? values.decodeIfPresent(Int64.self, forKey: .skuId)
        
        skuPics = try? values.decodeIfPresent([String].self, forKey: .skuPics)
        specs = try? values.decodeIfPresent([Specs].self, forKey: .specs)
        stock = try? values.decodeIfPresent(Int32.self, forKey: .stock)
    }
    
    
    
    public init(price:Decimal? = 0,skuCode:String? = "",skuId:Int64? = 0,skuPics:[String]? = [String](),specs:[Specs]? = [Specs](),stock:Int32? = 0){
        self.price = price
        self.skuCode = skuCode
        self.skuId = skuId
        self.skuPics = skuPics
        self.specs = specs
        self.stock = stock
    }
    
    
}


public struct Specs: Codable {
    public var specGroupId: Int64?  //规格组Id
    public var specValue: String?   //规格值
   
    enum CodingKeys: String, CodingKey {
        case specGroupId = "specGroupId"
        case specValue = "specValue"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        specGroupId = try? values.decodeIfPresent(Int64.self, forKey: .specGroupId)
        specValue = try? values.decodeIfPresent(String.self, forKey: .specValue)
    }
    
    
    public init(specGroupId:Int64? = 0,specValue:String? = ""){
        self.specGroupId = specGroupId
        self.specValue = specValue
    }
    
    
}


public struct Spus: Codable {
    public var length:Int32?          //字符长度
    public var required:Bool?         //是否必填（false：非必填、true：必填）
    public var spuAttrId:Int64?       //商品参数属性Id
    public var spuAttrName: String?   //商品参数名称
    public var spuId: Int64?          //商品参数Id
    public var spuType:Int32?         //商品参数类型（0：自定义、1：品牌、2：正品证书）
    public var spuValue: String?      //Spu属性值
    
    
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
        spuAttrId = try? values.decodeIfPresent(Int64.self, forKey: .spuAttrId)
        spuAttrName = try? values.decodeIfPresent(String.self, forKey: .spuAttrName)
        spuId = try? values.decodeIfPresent(Int64.self, forKey: .spuId)
        spuType = try? values.decodeIfPresent(Int32.self, forKey: .spuType)
        spuValue = try? values.decodeIfPresent(String.self, forKey: .spuValue)
    }
    
    
    
    public init(length:Int32? = 0,required:Bool? = false,spuAttrId:Int64? = 0,spuAttrName:String? = "",spuId:Int64? = 0,spuType:Int32? = 0,spuValue:String? = ""){
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
