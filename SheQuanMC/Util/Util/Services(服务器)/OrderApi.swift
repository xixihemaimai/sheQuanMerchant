//
//  OrderApi.swift
//  Util
//
//  Created by mac on 2022/5/19.
//

import Foundation
import Moya


public enum OrderApi{
    case getOrderSalesInfo  //获取订单销售数据（首页) (1)
    case getProductInfo(parameters:[String:Any])  //获取商品信息
    case SearchProduct(parameters:[String:String])//搜索商品
    case productPublish(parameters:[String:Any])  //发布商品
    case getProductCategoryList(parameters:[String:Any])//获取商品类目列表 (1)
    case getProductBrandList(parameters:[String:Any]) //获取商品品牌列表
    case getProductSpuList(parameters:[String:Any])  //获取商品参数
    
}



extension OrderApi:TargetType{
   public var baseURL: URL {
        return URL(string: sheQuanMCURL)!
    }
    
    public var path: String {
        switch self {
        case .getOrderSalesInfo:
            return "order/getOrderSalesInfo"
        case .getProductInfo:
            return "product/getProductInfo"
        case .SearchProduct:
            return "product/search"
        case .productPublish:
            return "product/publish"
        case .getProductCategoryList:
            return "category/getProductCategoryList"
        case .getProductBrandList:
            return "brand/getProductBrandList"
        case .getProductSpuList:
            return "spu/getProductSpuList"
        }
    }
    
    public var method:Moya.Method{
        return .post
    }
    
    public var task: Task {
        switch self {
        case .getOrderSalesInfo:
            return .requestPlain
        case .getProductInfo(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .SearchProduct(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .productPublish(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getProductCategoryList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getProductBrandList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getProductSpuList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        
        switch self {
        case .getOrderSalesInfo:
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time,nonce,deviceId),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        case .getProductInfo(let parameters),.getProductCategoryList(let parameters),.getProductBrandList(let parameters),.getProductSpuList(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getJSONStringFromData(obj: parameters,isEscape: false)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
            
        case .SearchProduct(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            let parm = dictSory(parameters)
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,parm),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        case .productPublish(let parameters):
            
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            let parm = getJSONStringFromPushblish(obj: parameters, isEscape: true)
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,parm),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
            
        default:
           return ["Accept": "*/*","Content-Type":"application/json"]
        }
        
       
    }
    
    
    public var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }
    
    
}





