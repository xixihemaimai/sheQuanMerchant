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
    public var auditReason: String?
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
        case auditReason = "auditReason"
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
        auditReason = try? values.decodeIfPresent(String.self, forKey: .auditReason)
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
    
    public var freightId:Int64?
    public var templateName:String?
    
    enum CodingKeys: String, CodingKey {
        case freightId = "applyTime"
        case templateName = "templateName"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        freightId = try? values.decode(Int64.self, forKey: .freightId)
        templateName = try? values.decodeIfPresent(String.self, forKey: .templateName)

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



