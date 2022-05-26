//
//  ShopApi.swift
//  Util
//
//  Created by mac on 2022/5/16.
//

import Foundation
import Moya
import UIKit


public enum shopApi{
    case forgetPass(parameters:[String:Any])    //忘记密码 （1）
    case changePass(parameters:[String:String]) //修改密码 （1）
    case regAccount(parameters:[String:Any])    //注册账号
    case getShopInfo                            //获取店铺信息(1)
}





extension shopApi:TargetType{
    public var baseURL: URL {
        return URL(string: sheQuanMCURL)!
    }
    
    public var path: String {
        switch self {
          case .forgetPass:
               return "shop/forgetPass"   //忘记密码
          case .changePass:
               return "shop/changePass"   //修改密码
          case .regAccount:
               return "shop/regAccount"   //注册账号
          case .getShopInfo:
               return "shop/getShopInfo"  //获取店铺信息
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .forgetPass,.changePass,.regAccount,.getShopInfo:
            return .post
        }
    }
    
    public var task: Task {
        switch self{
           case .forgetPass(let parameters):
               return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
           case .changePass(let parameters):
               return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
           case .regAccount(let parameters):
               return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
           case .getShopInfo:
               return .requestPlain
        }
    }

    
    
    public var headers: [String : String]? {
        switch self {
        case .getShopInfo:
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce": nonce,"timeStamp":time,"deviceId":deviceId,"accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time,nonce,deviceId)]
        case .changePass(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            let returnStr = dictSory(parameters)
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,returnStr),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        case .regAccount(let parameters),.forgetPass(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
//            let returnStr = dictSory(parameters)
            return ["Accept":"*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getJSONStringFromData(obj: parameters,isEscape: false)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
//        case .changePass(let parameters):
//            let time = Date().currentMilliStamp
//            let nonce = String.nonce
//            let deviceId = String.deviceUUID
//            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getJSONStringFromData(obj: parameters)),"appId":"IOS","appVer":String.appVersion,"apiVer":"1.0.0","nonce":nonce,"timeStamp":time,"deviceId":deviceId]
//        case .regAccount(let parameters):
//            let time = Date().currentMilliStamp
//            let nonce = String.nonce
//            let deviceId = String.deviceUUID
//            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValueData(time, nonce, deviceId,getJSONStringFromData(obj: parameters)),"appId":"IOS","appVer":String.appVersion,"apiVer":"1.0.0","nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        default:
            return ["Accept": "*/*","Content-Type":"application/json"]
        }
    }
    
    
    public var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }
   
}







