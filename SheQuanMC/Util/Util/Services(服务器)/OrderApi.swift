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
    case getRegionInfoList(parameters:[String:Any])      //获取行政地区列表
    
    
    case getOrderSalesInfo                                //获取订单销售数据（首页) (1)
    case getCloseReasonList                               //获取关闭订单原因列表 (1)
    case geSearchProductList(parameters:[String:Any])     //获取搜索订单商品列表
    case getOrderProductList(parameters:[String:Any])     //获取订单商品列表 (1)
    case getOrderDetailInfo(parameters:[String:Any])      //获取订单详情 (1)
    case closeOrder(parameters:[String:Any])              //关闭订单  (1)
    case getChangePrice(parameters:[String:Any])          //获取修改价格 (1)
    case modifyPrice(parameters:[String:Any])             //确定修改价格  (1)
    case getProductOrderCount                             //订单数     (1)
    case confirmShipment(parameters:[String:Any])         //确认发货
                                  
    case getLogisticsList(parameters:[String:Any])       //获取物流列表 (1)
    case modiyLogistics(parameters:[String:Any])         //修改物流
    case viewLogistics(parameters:[String:Any])          //查看物流    (1)
    case getOrderLogisticsInfo(parameters:[String:Any])  //获取订单物流
    case getOrderConsigneeSalesInfo(parameters:[String:Any])//获取订单收货地址
    case updateConsignee(parameters:[String:Any])        //更新订单收货地址
    
    
    case getRetAddressList                               //获取退货地址列表 (1)
    case delRetAddressInfo(parameters:[String:Any])      //删除退货地址
    case updateRetAddress(parameters:[String:Any])       //添加、更新退货地址信息
    case getRetAddressInfo(parameters:[String:Any])      //获取退货地址信息
    
    
    
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
            return "prod/manage/getProductInfoList"
        case .cancelApply:
            return "prod/manage/cancelApply"
        case .delProduct:
            return "prod/manage/delProduct"
        case .lowerShelf:
            return "prod/manage/lowerShelf"
        case .upShelf:
            return "prod/manage/upShelf"
        case .repairStock:
            return "prod/manage/repairStock"
        case .getSoldOutSkuList:
            return "prod/manage/getSoldOutSkuList"
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
        case .getRegionInfoList:
            return "region/getRegionInfoList"
            
            
        //订单
        case .getOrderProductList:
            return "order/manage/getOrderProductList"
        case .getOrderDetailInfo:
            return "order/manage/getOrderDetailInfo"
        case .getCloseReasonList:
            return "order/manage/getCloseOrderReasonList"
        case .closeOrder:
            return "order/manage/closeOrder"
        case .getChangePrice:
            return "order/manage/getChangePrice"
        case .modifyPrice:
            return "order/manage/modifyPrice"
        case .getProductOrderCount:
            return "order/manage/getProductOrderCount"
        case .confirmShipment:
            return "order/manage/confirmShipment"
        case .getOrderLogisticsInfo:
            return "order/manage/getOrderLogisticsInfo"
        case .geSearchProductList:
            return "order/manage/geSearchProductList"
        case .getOrderConsigneeSalesInfo:
            return "order/consignee/getOrderConsigneeInfo"
        case .updateConsignee:
            return "order/consignee/updateConsignee"
        
            
        //物流
        case .getLogisticsList:
            return "logistics/getLogisticsList"
        case .modiyLogistics:
            return "logistics/modifyLogistics"
        case .viewLogistics:
            return "logistics/viewLogistics"
        
            
        //地址
        case .getRetAddressList:
            return "ret/getRetAddressList"
        case .delRetAddressInfo:
            return "ret/delRetAddressInfo"
        case .updateRetAddress:
            return "ret/updateRetAddress"
        case .getRetAddressInfo:
            return "ret/getRetAddressInfo"
            
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
        case .getRegionInfoList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
            
        case .getOrderProductList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getOrderDetailInfo(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getCloseReasonList:
            return .requestPlain
        case .closeOrder(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getChangePrice(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .modifyPrice(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getProductOrderCount:
            return .requestPlain
        case .confirmShipment(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .geSearchProductList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
            
        case .getLogisticsList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .modiyLogistics(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .viewLogistics(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getOrderLogisticsInfo(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .getOrderConsigneeSalesInfo(let parameters):
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .updateConsignee(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        
        
            
        case .getRetAddressList:
            return .requestPlain
        case .delRetAddressInfo(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .updateRetAddress(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getRetAddressInfo(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        
        switch self {
            //,.getProductFreightList
        case .getOrderSalesInfo,.getFreightInfoList,.getCloseReasonList,.getProductOrderCount,.getRetAddressList:
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time,nonce,deviceId),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        case .getProductCategoryList(let parameters),.getProductBrandList(let parameters),.getProductSpuList(let parameters),.getProductSpecList(let parameters),.getProductInfoList(let parameters),.defFreightTemplate(let parameters),.getFreightInfo(let parameters),.getOrderProductList(let parameters),.closeOrder(let parameters),.getChangePrice(let parameters),.modifyPrice(let parameters),.getOrderDetailInfo(let parameters),.getLogisticsList(let parameters),.modiyLogistics(let parameters),.viewLogistics(let parameters),.confirmShipment(let parameters),.getOrderLogisticsInfo(let parameters),.delRetAddressInfo(let parameters),.updateRetAddress(let parameters),.getRetAddressInfo(let parameters),.geSearchProductList(let parameters),.getOrderConsigneeSalesInfo(let parameters),.updateConsignee(let parameters),.getRegionInfoList(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getJSONStringFromData(obj: parameters,isEscape: false)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        case .productPublish(let parameters),.draft(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            LXFLog("=============\(parameters)")
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





