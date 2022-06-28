//
//  OrderInfoModel.swift
//  Util
//
//  Created by mac on 2022/6/21.
//

import Foundation

public struct OrederInfoModel: Codable {
    
    public var discount:String?    //优惠
    public var faceUrl:String?     //用户头像
    public var freight:String?     //运费
    public var totalAmount:String? //商品总价
    public var orderTime:String?     //下单时间
    public var payRemainingTime:Int64? //支付剩余时间
    public var refundingText:String?   //退货退款中
    
    public var nickName: String?
    public var orderId:Int64?
    public var orderNo: String?
    public var orderStatus:Int32?
    public var orderStatusText: String?
    public var payAmount: String?
    public var products:[OrederInfoProductsModel]?
    public var remarks: String?
    public var userId: Int64?
    
    enum CodingKeys: String, CodingKey {
        
        case discount = "discount"
        case faceUrl  = "faceUrl"
        case freight  = "freight"
        case totalAmount = "totalAmount"
        case orderTime = "orderTime"
        case payRemainingTime = "payRemainingTime"
        case refundingText = "refundingText"
        
        case nickName = "nickName"
        case orderId = "orderId"
        case orderNo = "orderNo"
        case orderStatus = "orderStatus"
        case orderStatusText = "orderStatusText"
        case payAmount = "payAmount"
        case products = "products"
        case remarks = "remarks"
        case userId = "userId"
    }
    
    
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        discount = try? values.decodeIfPresent(String.self, forKey: .discount)
        faceUrl = try? values.decodeIfPresent(String.self, forKey: .faceUrl)
        freight = try? values.decodeIfPresent(String.self, forKey: .freight)
        totalAmount = try? values.decodeIfPresent(String.self, forKey: .totalAmount)
        orderTime = try? values.decodeIfPresent(String.self, forKey: .orderTime)
        payRemainingTime = try? values.decodeIfPresent(Int64.self, forKey: .payRemainingTime)
        refundingText = try? values.decodeIfPresent(String.self, forKey: .refundingText)
        
        
        nickName = try? values.decodeIfPresent(String.self, forKey: .nickName)
        orderId = try? values.decodeIfPresent(Int64.self, forKey: .orderId)
        orderNo = try? values.decodeIfPresent(String.self, forKey: .orderNo)
        orderStatus = try? values.decodeIfPresent(Int32.self, forKey: .orderStatus)
        orderStatusText = try? values.decodeIfPresent(String.self, forKey: .orderStatusText)
        payAmount = try? values.decodeIfPresent(String.self, forKey: .payAmount)
        products = try? values.decodeIfPresent([OrederInfoProductsModel].self, forKey: .products)
        remarks = try? values.decodeIfPresent(String.self, forKey: .remarks)
        userId = try? values.decodeIfPresent(Int64.self, forKey: .userId)
    }
    
}

public struct OrederInfoProductsModel: Codable {
    public var price: String?
    public var productId:Int64?
    public var productName: String?
    public var qty: Int32?
    public var specs: String?
    public var productPic:String?
    
    enum CodingKeys: String, CodingKey {
        case price = "price"
        case productId = "productId"
        case productName = "productName"
        case qty = "qty"
        case specs = "specs"
        case productPic = "productPic"
    }
    
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        price = try? values.decodeIfPresent(String.self, forKey: .price)
        productId = try? values.decodeIfPresent(Int64.self, forKey: .productId)
        productName = try? values.decodeIfPresent(String.self, forKey: .productName)
        qty = try? values.decodeIfPresent(Int32.self, forKey: .qty)
        specs = try? values.decodeIfPresent(String.self, forKey: .specs)
        productPic = try? values.decodeIfPresent(String.self, forKey: .productPic)
    }
    
}





public struct CloseOrderTypeRspModel:Codable{
    public var closeReason:String?
    public var closeReasonId:Int32?
    
    enum CodingKeys: String, CodingKey {
        case closeReason = "closeReason"
        case closeReasonId = "closeReasonId"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        closeReason = try? values.decodeIfPresent(String.self, forKey: .closeReason)
        closeReasonId = try? values.decodeIfPresent(Int32.self, forKey: .closeReasonId)
    }
}



public struct chagePriceModel:Codable{
    public var freight:String?
    public var originalPrice:String?
    public var price:String?
    
    
    enum CodingKeys:String,CodingKey {
       case freight = "freight"
       case originalPrice = "originalPrice"
       case price = "price"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        freight = try? values.decodeIfPresent(String.self, forKey: .freight)
        originalPrice = try? values.decodeIfPresent(String.self, forKey: .originalPrice)
        price = try? values.decodeIfPresent(String.self, forKey: .price)
    }
}





public struct LogisticsModel:Codable{
    public var logisticsId:Int32?
    public var logisticsName:String?
    public var usageCount:Int32?
    
    enum CodingKeys:String,CodingKey {
       case logisticsId = "logisticsId"
       case logisticsName = "logisticsName"
        case usageCount = "usageCount"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        logisticsId = try? values.decodeIfPresent(Int32.self, forKey: .logisticsId)
        logisticsName = try? values.decodeIfPresent(String.self, forKey: .logisticsName)
        usageCount = try? values.decodeIfPresent(Int32.self, forKey: .usageCount)
    }
}



public struct ViewLogisticsModel: Codable {
    public var logisticsName:String?
    public var tracks:[ViewLogisticsListModel]?
    public var waybillNo: String?
    
    
    enum CodingKeys:String,CodingKey {
       case logisticsName = "logisticsName"
       case tracks = "tracks"
        case waybillNo = "waybillNo"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        logisticsName = try? values.decodeIfPresent(String.self, forKey: .logisticsName)
        tracks = try? values.decodeIfPresent([ViewLogisticsListModel].self, forKey: .tracks)
        waybillNo = try? values.decodeIfPresent(String.self, forKey: .waybillNo)
    }
}

public struct ViewLogisticsListModel: Codable {
    public var trackName: String?
    public var trackStatus: String?
    public var trackStatusText: String?
    public var trackTime: String?
    
    
    enum CodingKeys:String,CodingKey {
       case trackName = "trackName"
       case trackStatus = "trackStatus"
       case trackStatusText = "trackStatusText"
       case trackTime = "trackTime"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trackName = try? values.decodeIfPresent(String.self, forKey: .trackName)
        trackStatus = try? values.decodeIfPresent(String.self, forKey: .trackStatus)
        trackStatusText = try? values.decodeIfPresent(String.self, forKey: .trackStatusText)
        trackTime = try? values.decodeIfPresent(String.self, forKey: .trackTime)
    }
    
}



public struct ProductOrderCountModel:Codable{
    public var orderCount: Int32?
    public var orderStatus: Int32?
    enum CodingKeys:String,CodingKey {
       case orderStatus = "orderStatus"
       case orderCount = "orderCount"
    }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orderStatus = try? values.decodeIfPresent(Int32.self, forKey: .orderStatus)
        orderCount = try? values.decodeIfPresent(Int32.self, forKey: .orderCount)
    }
}



