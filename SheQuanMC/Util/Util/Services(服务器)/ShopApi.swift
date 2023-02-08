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
    case regAccount(parameters:[String:Any])    //注册账号  (1)
    case getShopInfo                            //获取店铺信息(1)
    case logoff                                 //注销账号
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
          case .logoff:
               return "shop/logoff"       //注销账号
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .forgetPass,.changePass,.regAccount,.getShopInfo,.logoff:
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
           case .getShopInfo,.logoff:
                return .requestPlain
        }
    }

    
    
    public var headers: [String : String]? {
        switch self {
        case .getShopInfo,.logoff:
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
//            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time,nonce,deviceId),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce": nonce,"timeStamp":time,"deviceId":deviceId]
            
            return returnParameters(time, nonce, deviceId)
            
        case .changePass(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            let returnStr = dictSory(parameters)
//            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time, nonce, deviceId,true,returnStr),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
            return returnParameters(time, nonce, deviceId,true,returnStr)
            
            
        case .regAccount(let parameters),.forgetPass(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
//            let returnStr = dictSory(parameters)
//            return ["Accept":"*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time, nonce, deviceId,true,getJSONStringFromData(obj: parameters,isEscape: false)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
            
            return returnParameters(time, nonce, deviceId,true,getJSONStringFromData(obj: parameters,isEscape: false))
            
            
            
        default:
            return ["Accept": "*/*","Content-Type":"application/json"]
        }
    }
    
    
    public var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }
   
}







