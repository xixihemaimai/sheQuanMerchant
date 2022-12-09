//
//  LoginApi.swift
//  测试暗黑和白天模式
//
//  Created by mac on 2022/3/16.
//

import Foundation
import Moya
import UIKit


//let moya = MoyaProvider<API>()


public enum LoginApi{
    case phonelogin(parameters:[String:Any]) //手机号登录 （1）
    case phoneCode(parameters:[String:Any]) //获取验证码   （1）
    case passwordLogin(parameters:[String:String]) //密码登录 (1)
    case systemVersion  //系统相关接口(1)
}


extension LoginApi:TargetType{
    //服务器地址
    public var baseURL: URL{
//        return URL(string: "123")!
        return URL(string: sheQuanMCURL)!
    }
    
    
    //网络请求路径
    
    public var path: String{
        switch self{
        case .phonelogin:
            return "login/mobileLogin" // 手机号登录
        case .phoneCode:
            return "captcha/getCaptchaCode" //获取手机验证码
        case .passwordLogin:
            return "login/passLogin"  //密码登录
        case .systemVersion:
            return "system/getSysConfInfo"   //获取系统版本
        }
    }
    
    //网络请求的方法
    public var method: Moya.Method {
        switch self{
        case .phonelogin,.phoneCode,.passwordLogin:
            return .post
        case .systemVersion:
            return .get
        }
    }
    //参数
    public var task: Task {
        
        switch self{
        case .phonelogin(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .phoneCode(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .passwordLogin(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .systemVersion:
            return .requestPlain
        }
    }
    
    
    //公共请求头
    public var headers: [String : String]? {
        switch self {
        case .systemVersion:
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time,nonce,deviceId),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        case .passwordLogin(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            let returnStr = dictSory(parameters)
            //obtainSignValueData(time, nonce, deviceId,returnStr)
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time, nonce, deviceId,true,returnStr),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        case .phoneCode(let parameters),.phonelogin(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
//          let returnStr = dictSory(parameters)
            //obtainSignValueData(time, nonce, deviceId,getJSONStringFromData(obj: parameters,isEscape: false))
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time, nonce, deviceId,true,getJSONStringFromData(obj: parameters,isEscape: false)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        default:
            return ["Accept": "*/*","Content-Type":"application/json"]
        }
    }
    
    //解析格式
    public var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }
    

}
