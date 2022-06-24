//
//  OrderApi.swift
//  Util
//
//  Created by mac on 2022/5/19.
//

import Foundation
import Moya


public enum OrderApi{
   
    case getProductInfo(parameters:[String:Any])        //获取商品信息    (1)
    case productPublish(parameters:[String:Any])        //发布商品       (1)
    case getProductCategoryList(parameters:[String:Any])//获取商品类目列表 (1)
    case getProductBrandList(parameters:[String:Any])   //获取商品品牌列表 (1)
    case getProductSpuList(parameters:[String:Any])     //获取商品参数    (1)
    case addSpecGroup(paramters:[String:Any])           //添加商品规格组   (1)
    case getProductInfoList(parameters:[String:Any])     //获取商品列表   （1）
    case cancelApply(parameters:[String:Any])            //取消申请       (1)
    case delProduct(parameters:[String:Any])             //删除商品      （1）
    case lowerShelf(parameters:[String:Any])             //商品下架       （1）
    case upShelf(parameters:[String:Any])                //商品上架       （1）
    case repairStock(parameters:[String:Any])            //补库存
    case getSoldOutSkuList(parameters:[String:Any])      //获取售罄商品规格  (1)
    case draft(parameters:[String:Any])                  //存为草稿        (1)
    case getProductSpecList(parameters:[String:Any])     //获取商品规格列表  (1)
    
//    case getProductFreightList                         //获取商品运费模板列表 （1）
    case getFreightInfoList                              //获取运费模板列表   (1)
    case defFreightTemplate(parameters:[String:Any])     //默认运费模版      (1)
    case delFreightStatus(parameters:[String:Any])       //删除运费模版      (1)
    case freightTemplate(parameters:[String:Any])        //新建/更新运费模板  (1)
    case getFreightInfo(parameters:[String:Any])         //获取运费模板      (1)
    case getFreightRegionList(parameters:[String:Any])   //获取行政地区列表  （1）
    case getNoDeliveryRegionList(parameters:[String:Any])//获取不配送区域列表 （1）
    
    
    case getOrderSalesInfo                                //获取订单销售数据（首页) (1)
    
    case getOrderProductList(parameters:[String:Any])     //获取订单商品列表
    case getOrderDetailInfo(parameters:[String:Any])      //获取订单详情
    case getCloseOrderReasonList                          //获取关闭订单原因列表
    case closeOrder(parameters:[String:Any])              //关闭订单
    case getChangePrice(parameters:[String:Any])          //获取修改价格
    case modifyPrice(parameters:[String:Any])             //确定修改价格
    
    ///sqshop/api/logistics/getLogisticsList
                                  
    case getLogisticsList(parameters:[String:Any])       //获取物流列表 (1)
    case modiyLogistics(parameters:[String:Any])         //修改物流
    case viewLogistics(parameters:[String:Any])          //查看物流
    
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
            
//        case .getProductFreightList:
//            return "freight/getProductFreightList"
            
            
        //运费模板
        case .getFreightInfoList:
            return "freight/getFreightInfoList"
        case .defFreightTemplate:
            return "freight/defFreightTemplate"
        case .delFreightStatus:
            return "freight/delFreightStatus"
        case .freightTemplate:
            return "freight/freightTemplate"
        case .getFreightInfo:
            return "freight/getFreightInfo"
        case .getFreightRegionList:
            return "region/getFreightRegionList"
        case .getNoDeliveryRegionList:
            return "region/getNoDeliveryRegionList"
            
            
        //订单
        case .getOrderProductList:
            return "ordermanage/getOrderProductList"
        case .getOrderDetailInfo:
            return "ordermanage/getOrderDetailInfo"
        case .getCloseOrderReasonList:
            return "ordermanage​/getCloseOrderReasonList"
        case .closeOrder:
            return "ordermanage/closeOrder"
        case .getChangePrice:
            return "ordermanage/getChangePrice"
        case .modifyPrice:
            return "ordermanage/modifyPrice"
            
            
            
        //物流
            
        case .getLogisticsList:
            return "logistics/getLogisticsList"
        case .modiyLogistics:
            return "logistics/modifyLogistics"
        case .viewLogistics:
            return "logistics/viewLogistics"
        
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
            
            
//        case .getProductFreightList:
//            return .requestPlain
        case .getFreightInfoList:
            return .requestPlain
        case .defFreightTemplate(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .delFreightStatus(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .freightTemplate(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getFreightInfo(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .getFreightRegionList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getNoDeliveryRegionList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
            
        case .getOrderProductList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getOrderDetailInfo(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getCloseOrderReasonList:
            return .requestPlain
        case .closeOrder(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getChangePrice(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .modifyPrice(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
            
        case .getLogisticsList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .modiyLogistics(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .viewLogistics(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        
        }
    }
    
    public var headers: [String : String]? {
        
        switch self {
            //,.getProductFreightList
        case .getOrderSalesInfo,.getFreightInfoList,.getCloseOrderReasonList:
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time,nonce,deviceId),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        case .getProductCategoryList(let parameters),.getProductBrandList(let parameters),.getProductSpuList(let parameters),.getProductSpecList(let parameters),.getProductInfoList(let parameters),.defFreightTemplate(let parameters),.getFreightInfo(let parameters),.getOrderProductList(let parameters),.closeOrder(let parameters),.getChangePrice(let parameters),.modifyPrice(let parameters),.getOrderDetailInfo(let parameters),.getLogisticsList(let parameters),.modiyLogistics(let parameters),.viewLogistics(let parameters):
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
            
        case .getProductInfo(let parameters),.cancelApply(let parameters),.delProduct(let parameters),.lowerShelf(let parameters),.upShelf(let parameters),.getSoldOutSkuList(let parameters),.delFreightStatus(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getJSONStringFromData(obj: parameters,isEscape: false)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        
        case .repairStock(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getArrayJSONStringFromAddSpec(obj: parameters)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
            
            
        //获取运费模板列表（新）
//        case .getFreightInfoList(let parameters):
//            let time = Date().currentMilliStamp
//            let nonce = String.nonce
//            let deviceId = String.deviceUUID
//            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getFreightJSONStringFromAddSpec(obj: parameters)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
            
        //新建/更新运费模版
        case .freightTemplate(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getArrayJSONStringFromUpdateAndNewTemplate(obj:parameters)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
            
        //获取行政区域
        case .getFreightRegionList(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getJSONStringFromData(obj: parameters,isEscape: false)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
            
        //获取不配送区域的列表
        case .getNoDeliveryRegionList(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getArrayJSONStringFromAddSpec(obj: parameters)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
            
            
            
        //获取订单信息列表
//        case .getOrderInfoList(let parameters):
            
       
            
        default:
           return ["Accept": "*/*","Content-Type":"application/json"]
        }
        
       
    }
    
    
    public var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }
    
    
}





