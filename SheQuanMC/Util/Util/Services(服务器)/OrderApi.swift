//
//  OrderApi.swift
//  Util
//
//  Created by mac on 2022/5/19.
//

import Foundation
import Moya


public enum OrderApi{
    case getOrderSalesInfo                              //获取订单销售数据（首页) (1)
    case getProductInfo(parameters:[String:Any])        //获取商品信息    (1)
    case productPublish(parameters:[String:Any])        //发布商品       (1)
    case getProductCategoryList(parameters:[String:Any])//获取商品类目列表 (1)
    case getProductBrandList(parameters:[String:Any])   //获取商品品牌列表 (1)
    case getProductSpuList(parameters:[String:Any])     //获取商品参数    (1)
    case addSpecGroup(paramters:[String:Any])           //添加商品规格组   (1)
    case getProductInfoList(parameters:[String:Any])     //获取商品列表   （1）
    case cancelApply(parameters:[String:Any])            //取消申请       (1)
    case delProduct(parameters:[String:Any])             //删除商品      （1）
    case lowerShelf(parameters:[String:Any])             //商品下架
    case upShelf(parameters:[String:Any])                //商品上架
    case repairStock(parameters:[String:Any])            //补库存
    case getSoldOutSkuList(parameters:[String:Any])      //获取售罄商品规格
    case draft(parameters:[String:Any])                  //存为草稿        (1)
    case getProductSpecList(parameters:[String:Any])     //获取商品规格列表  (1)
//    case getFreightInfo(parameters:[String:Any])         //获取运费模板
    case getProductFreightList                           //获取商品运费模板列表
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
        case .productPublish:
            return "product/publish"
        case .getProductCategoryList:
            return "category/getProductCategoryList"
        case .getProductBrandList:
            return "brand/getProductBrandList"
        case .getProductSpuList:
            return "spu/getProductSpuList"
        case .addSpecGroup:
            return "spec/addSpecGroup"
        case .getProductInfoList:
            return "prodmanage/getProductInfoList"
        case .cancelApply:
            return "prodmanage/cancelApply"
        case .delProduct:
            return "prodmanage/delProduct"
        case .lowerShelf:
            return "prodmanage/lowerShelf"
        case .upShelf:
            return "prodmanage/upShelf"
        case .repairStock:
            return "prodmanage/repairStock"
        case .getSoldOutSkuList:
            return "prodmanage/getSoldOutSkuList"
        case .draft:
            return "product/draft"
        case .getProductSpecList:
            return "spec/getProductSpecList"
//        case .getFreightInfo:
//            return "freight/getFreightInfo"
        case .getProductFreightList:
            return "freight/getProductFreightList"
        
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
        case .productPublish(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getProductCategoryList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getProductBrandList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getProductSpuList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .addSpecGroup(let paramters):
            return .requestParameters(parameters: paramters, encoding: JSONEncoding.default)
        case .getProductInfoList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .cancelApply(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .delProduct(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .lowerShelf(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .upShelf(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .repairStock(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getSoldOutSkuList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .draft(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getProductSpecList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
//        case .getFreightInfo(let parameters):
//            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getProductFreightList:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        
        switch self {
        case .getOrderSalesInfo,.getProductFreightList:
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time,nonce,deviceId),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        case .getProductInfo(let parameters),.getProductCategoryList(let parameters),.getProductBrandList(let parameters),.getProductSpuList(let parameters),.getProductSpecList(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getJSONStringFromData(obj: parameters,isEscape: false)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        case .productPublish(let parameters),.draft(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            let parm = getJSONStringFromPushblish(obj: parameters, isEscape: true)
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,parm),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        case .addSpecGroup(let paramters):
            //添加商品规格组
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getArrayJSONStringFromAddSpec(obj: paramters)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        case .getProductInfoList(let parameters),.cancelApply(let parameters),.delProduct(let parameters),.lowerShelf(let parameters),.upShelf(let parameters),.getSoldOutSkuList(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getJSONStringFromData(obj: parameters,isEscape: false)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        
        case .repairStock(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getJSONStringFromData(obj: parameters,isEscape: false)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
            
            
//        case .getFreightInfo(let parameters):
//            let time = Date().currentMilliStamp
//            let nonce = String.nonce
//            let deviceId = String.deviceUUID
//            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getJSONStringFromData(obj: parameters,isEscape: false)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
            
        default:
           return ["Accept": "*/*","Content-Type":"application/json"]
        }
        
       
    }
    
    
    public var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }
    
    
}





