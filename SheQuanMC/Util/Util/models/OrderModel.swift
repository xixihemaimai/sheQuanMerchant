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
