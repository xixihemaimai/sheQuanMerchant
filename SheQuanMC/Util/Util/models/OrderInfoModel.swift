//
//  OrderInfoModel.swift
//  Util
//
//  Created by mac on 2022/6/21.
//

import Foundation


//订单详情和订单列表
public struct OrederInfoModel: Codable {
    
    public var discount:String?    //优惠
    public var faceUrl:String?     //用户头像
    public var freight:String?     //运费
    public var logisticsTrack:ViewLogisticsListModel? //物流信息
    public var nickName: String?   //用户昵称
    public var orderId:Int64?      //订单id
    public var orderNo: String?    //订单号
    public var orderRemarks:String? //订单备注( 关闭原因后自动收货合理发货，请勿虚假发货，请及时发货未付款则自动关闭订单
    public var orderStatus:Int32?   //订单状态
    public var totalAmount:String? //商品总价
    public var orderTime:String?     //下单时间
    public var payRemainingTime:Int64? //支付剩余时间
    public var refundingText:String?   //退货退款中
    public var payTime:String?      //付款时间
    public var payType:String?      //付款方式
    public var tradeNo:String?      //付款编码
    public var closeTime:String?    //关闭时间
    public var recAddress:RecAddressModel? //地址
    public var orderStatusText: String?
    public var payAmount: String?
    public var products:[OrederInfoProductsModel]?
    public var remarks: String?
    public var userId: Int64?
    
    enum CodingKeys: String, CodingKey {
        case discount = "discount"
        case faceUrl  = "faceUrl"
        case freight  = "freight"
        case logisticsTrack = "logisticsTrack"
        case nickName = "nickName"
        case orderId = "orderId"
        case orderNo = "orderNo"
        case totalAmount = "totalAmount"
        case orderTime = "orderTime"
        case payRemainingTime = "payRemainingTime"
        case refundingText = "refundingText"
        case closeTime = "closeTime"
        case orderRemarks = "orderRemarks"
        case recAddress = "recAddress"
        case orderStatus = "orderStatus"
        case orderStatusText = "orderStatusText"
        case payAmount = "payAmount"
        case products = "products"
        case remarks = "remarks"
        case userId = "userId"
        case payTime = "payTime"
        case payType = "payType"
        case tradeNo = "tradeNo"
    }
    
    
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        discount = try? values.decodeIfPresent(String.self, forKey: .discount)
        faceUrl = try? values.decodeIfPresent(String.self, forKey: .faceUrl)
        freight = try? values.decodeIfPresent(String.self, forKey: .freight)
        logisticsTrack = try? values.decodeIfPresent(ViewLogisticsListModel.self, forKey: .logisticsTrack)
        nickName = try? values.decodeIfPresent(String.self, forKey: .nickName)
        orderId = try? values.decodeIfPresent(Int64.self, forKey: .orderId)
        orderNo = try? values.decodeIfPresent(String.self, forKey: .orderNo)
        orderRemarks = try? values.decodeIfPresent(String.self, forKey: .orderRemarks)
        
        totalAmount = try? values.decodeIfPresent(String.self, forKey: .totalAmount)
        orderTime = try? values.decodeIfPresent(String.self, forKey: .orderTime)
        payRemainingTime = try? values.decodeIfPresent(Int64.self, forKey: .payRemainingTime)
        refundingText = try? values.decodeIfPresent(String.self, forKey: .refundingText)
        payTime = try? values.decodeIfPresent(String.self, forKey: .payTime)
        payType = try? values.decodeIfPresent(String.self, forKey: .payType)
        tradeNo = try? values.decodeIfPresent(String.self, forKey: .tradeNo)
        closeTime = try? values.decodeIfPresent(String.self, forKey: .closeTime)
        recAddress = try? values.decodeIfPresent(RecAddressModel.self, forKey: .recAddress)
        orderStatus = try? values.decodeIfPresent(Int32.self, forKey: .orderStatus)
        orderStatusText = try? values.decodeIfPresent(String.self, forKey: .orderStatusText)
        payAmount = try? values.decodeIfPresent(String.self, forKey: .payAmount)
        products = try? values.decodeIfPresent([OrederInfoProductsModel].self, forKey: .products)
        remarks = try? values.decodeIfPresent(String.self, forKey: .remarks)
        userId = try? values.decodeIfPresent(Int64.self, forKey: .userId)
    }
    
}


//退货地址模型
public struct RecAddressModel:Codable{
    public var address:String? //详细地址
    public var cityId:Int32?   //城市id
    public var cityName:String? //城市名称
    public var consignee:String? //收件人
    public var isDef:Bool?      //是否默认 （0：否、1：是）
    public var mobile:String?   //手机号
    public var provinceId:Int32?   //省份ID
    public var provinceName:String? //省份名称
    public var regionId:Int32?     //地区ID
    public var regionName:String?   //地区名称
    public var recAddressId:Int64?  //退货地址ID
    public var zipCode:String?      //邮编地址
    public var streetId:Int32?      //街道
    public var streetName:String?   //街道名称

    
    enum CodingKeys:String,CodingKey {
       case address = "address"
       case cityId = "cityId"
       case cityName = "cityName"
       case consignee = "consignee"
       case isDef = "isDef"
       case mobile = "mobile"
       case provinceId = "provinceId"
       case provinceName = "provinceName"
       case regionId = "regionId"
       case regionName = "regionName"
       case recAddressId = "recAddressId"
       case zipCode = "zipCode"
       case streetId = "streetId"
       case streetName = "streetName"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try? values.decodeIfPresent(String.self, forKey: .address)
        cityId = try? values.decodeIfPresent(Int32.self, forKey: .cityId)
        cityName = try? values.decodeIfPresent(String.self, forKey: .cityName)
        consignee = try? values.decodeIfPresent(String.self, forKey: .consignee)
        isDef = try? values.decodeIfPresent(Bool.self, forKey: .isDef)
        mobile = try? values.decodeIfPresent(String.self, forKey: .mobile)
        provinceId = try? values.decodeIfPresent(Int32.self, forKey: .provinceId)
        provinceName = try? values.decodeIfPresent(String.self, forKey: .provinceName)
        regionId = try? values.decodeIfPresent(Int32.self, forKey: .regionId)
        regionName = try? values.decodeIfPresent(String.self, forKey: .regionName)
        recAddressId = try? values.decodeIfPresent(Int64.self, forKey: .recAddressId)
        zipCode = try? values.decodeIfPresent(String.self, forKey: .zipCode)
        streetId = try? values.decodeIfPresent(Int32.self, forKey: .streetId)
        streetName = try? values.decodeIfPresent(String.self, forKey: .streetName)
    }
}








//订单商品信息
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




//关闭订单列表
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


//改变价格
public struct chagePriceModel:Codable{
    public var freight:String?
    public var originalPrice:String?
    public var price:String?
    public var discount:String?
    enum CodingKeys:String,CodingKey {
       case freight = "freight"
       case originalPrice = "originalPrice"
       case price = "price"
        case discount = "discount"
    }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        freight = try? values.decodeIfPresent(String.self, forKey: .freight)
        originalPrice = try? values.decodeIfPresent(String.self, forKey: .originalPrice)
        price = try? values.decodeIfPresent(String.self, forKey: .price)
        discount = try? values.decodeIfPresent(String.self, forKey: .discount)
    }
}




//物流列表
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


//查看物流第一组
public struct ViewLogisticsModel: Codable {
    public var logisticsName:String?
    public var tracks:[ViewLogisticsListModel]?
    public var expressNo: String?
    enum CodingKeys:String,CodingKey {
       case logisticsName = "logisticsName"
       case tracks = "tracks"
       case expressNo = "expressNo"
    }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        logisticsName = try? values.decodeIfPresent(String.self, forKey: .logisticsName)
        tracks = try? values.decodeIfPresent([ViewLogisticsListModel].self, forKey: .tracks)
        expressNo = try? values.decodeIfPresent(String.self, forKey: .expressNo)
    }
}

//查看物流动态列表
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




//订单数
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


//获取订单物流
public struct OrderLogisticsModel:Codable{
    public var logistics:LogisticsInfoModel?
    public var products:[OrederInfoProductsModel]?
    public var retAddress:RetAddressInfoModel?
    public var totalAmount:String?
    
    enum CodingKeys:String,CodingKey {
        case logistics = "logistics"
        case products = "products"
        case retAddress = "retAddress"
        case totalAmount = "totalAmount"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        logistics = try? values.decodeIfPresent(LogisticsInfoModel.self, forKey: .logistics)
        products = try? values.decodeIfPresent([OrederInfoProductsModel].self, forKey: .products)
        retAddress = try? values.decodeIfPresent(RetAddressInfoModel.self, forKey: .retAddress)
        totalAmount = try? values.decodeIfPresent(String.self, forKey: .totalAmount)
    }
}




//订单物流
public struct LogisticsInfoModel:Codable{
    public var expressNo:String? //快递单号
    public var logisticsId:Int32? //物流Id
    public var logisticsName:String? //物流名称
    public var logisticsType:Int32? //物流方式
    public var logisticsTypeText:String? //物流方式名称
    
    enum CodingKeys:String,CodingKey {
       case expressNo = "expressNo"
       case logisticsId = "logisticsId"
       case logisticsType = "logisticsType"
       case logisticsName = "logisticsName"
       case logisticsTypeText = "logisticsTypeText"
    }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        expressNo = try? values.decodeIfPresent(String.self, forKey: .expressNo)
        logisticsId = try? values.decodeIfPresent(Int32.self, forKey: .logisticsId)
        logisticsType = try? values.decodeIfPresent(Int32.self, forKey: .logisticsType)
        logisticsName = try? values.decodeIfPresent(String.self, forKey: .logisticsName)
        logisticsTypeText = try? values.decodeIfPresent(String.self, forKey: .logisticsTypeText)
    }
}


//退货地址模型
public struct RetAddressInfoModel:Codable{
    public var address:String? //详细地址
    public var cityId:Int32?   //城市id
    public var cityName:String? //城市名称
    public var consignee:String? //收件人
    public var isDef:Bool?      //是否默认 （0：否、1：是）
    public var mobile:String?   //手机号
    public var provinceId:Int32?   //省份ID
    public var provinceName:String? //省份名称
    public var regionId:Int32?     //地区ID
    public var regionName:String?   //地区名称
    public var retAddressId:Int64?  //退货地址ID
    public var zipCode:String?      //邮编地址
    public var streetId:Int32?      //街道
    public var streetName:String?   //街道名称

    
    enum CodingKeys:String,CodingKey {
       case address = "address"
       case cityId = "cityId"
       case cityName = "cityName"
       case consignee = "consignee"
       case isDef = "isDef"
       case mobile = "mobile"
       case provinceId = "provinceId"
       case provinceName = "provinceName"
       case regionId = "regionId"
       case regionName = "regionName"
       case retAddressId = "retAddressId"
       case zipCode = "zipCode"
       case streetId = "streetId"
       case streetName = "streetName"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try? values.decodeIfPresent(String.self, forKey: .address)
        cityId = try? values.decodeIfPresent(Int32.self, forKey: .cityId)
        cityName = try? values.decodeIfPresent(String.self, forKey: .cityName)
        consignee = try? values.decodeIfPresent(String.self, forKey: .consignee)
        isDef = try? values.decodeIfPresent(Bool.self, forKey: .isDef)
        mobile = try? values.decodeIfPresent(String.self, forKey: .mobile)
        provinceId = try? values.decodeIfPresent(Int32.self, forKey: .provinceId)
        provinceName = try? values.decodeIfPresent(String.self, forKey: .provinceName)
        regionId = try? values.decodeIfPresent(Int32.self, forKey: .regionId)
        regionName = try? values.decodeIfPresent(String.self, forKey: .regionName)
        retAddressId = try? values.decodeIfPresent(Int64.self, forKey: .retAddressId)
        zipCode = try? values.decodeIfPresent(String.self, forKey: .zipCode)
        streetId = try? values.decodeIfPresent(Int32.self, forKey: .streetId)
        streetName = try? values.decodeIfPresent(String.self, forKey: .streetName)
    }
    
    
    public init(address:String? = "",cityId:Int32? = 0,cityName:String? = "",consignee:String? = "",isDef:Bool? = false,mobile:String? = "",provinceId:Int32? = 0,provinceName:String? = "",regionId:Int32? = 0,regionName:String? = "",retAddressId:Int64? = 0,streetId:Int32? = 0,streetName:String? = "",zipCode:String? = ""){
        self.address = address
        self.cityId = cityId
        self.cityName = cityName
        self.consignee = consignee
        self.isDef = isDef
        self.mobile = mobile
        self.provinceId = provinceId
        self.provinceName = provinceName
        self.regionId = regionId
        self.regionName = regionName
        self.retAddressId = retAddressId
        self.streetId = streetId
        self.streetName = streetName
        self.zipCode = zipCode
    }
    
}
