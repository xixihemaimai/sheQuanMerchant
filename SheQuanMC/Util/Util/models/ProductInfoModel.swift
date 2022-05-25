//
//  ProductInfoModel.swift
//  Util
//
//  Created by mac on 2022/5/23.
//

import Foundation


public struct ProductInfoModel: Codable {
    //实际金额
    public let actualAmount: String?
    //订单单号
    public let orderNo: String?
    //订单状态
    public let orderStatus: Int32?
    //商品id
    public let productId: String?
    //商品名称
    public let productName: String?
    //商品图片
    public let productPic: String?
    //商品规格
    public let productSpecs: String?
    //购买数量
    public let qty: Int32?
    //店铺头像
    public let shopAvatar: String?
    //店铺id
    public let shopId: Int64?
    //店铺名称
    public let shopName: String?
    //订单状态
    public let statusText: String?
    
    
    enum CodingKeys: String, CodingKey {
        case actualAmount = "actualAmount"
        case orderNo = "orderNo"
        case orderStatus = "orderStatus"
        case productId = "productId"
        case productName = "productName"
        case productPic = "productPic"
        
        case productSpecs = "productSpecs"
        case qty = "qty"
        case shopAvatar = "shopAvatar"
        case shopId = "shopId"
        case shopName = "shopName"
        case statusText = "statusText"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        actualAmount = try? values.decodeIfPresent(String.self, forKey: .actualAmount)
        orderNo = try? values.decodeIfPresent(String.self, forKey: .orderNo)
        orderStatus = try? values.decodeIfPresent(Int32.self, forKey: .orderStatus)
        productId = try? values.decodeIfPresent(String.self, forKey: .productId)
        productName = try? values.decodeIfPresent(String.self, forKey: .productName)
        productPic = try? values.decodeIfPresent(String.self, forKey: .productPic)
        productSpecs = try? values.decodeIfPresent(String.self, forKey: .productSpecs)
        qty = try? values.decodeIfPresent(Int32.self, forKey: .qty)
        shopAvatar = try? values.decodeIfPresent(String.self, forKey: .shopAvatar)
        shopId = try? values.decodeIfPresent(Int64.self, forKey: .shopId)
        shopName = try? values.decodeIfPresent(String.self, forKey: .shopName)
        statusText = try? values.decodeIfPresent(String.self, forKey: .statusText)
    }
    
    
}



