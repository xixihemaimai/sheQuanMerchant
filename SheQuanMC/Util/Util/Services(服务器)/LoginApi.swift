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
    case phonelogin(parameters:[String:Any]) //手机号登录
    case phoneCode(parameters:[String:Any]) //获取验证码
    case passwordLogin(parameters:[String:Any]) //密码登录
   
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
//        case .login(let userName, let password):
//            return "login" + userName + password
        case .phonelogin:
            return "login/mobileLogin" // 手机号登录
        case .phoneCode:
            return "captcha/getCaptchaCode" //获取手机验证码
        case .passwordLogin:
            return "login/mobileLogin"  //密码登录
        
 //        case .homeGoodList:
//            return "homeGoodList"
//         case .goodDetail:
//            return "goodDetail"
        }
    }
    
    //网络请求的方法
    public var method: Moya.Method {
        
        switch self{
        case .phonelogin,.phoneCode,.passwordLogin:
            return .post
        }
        
        
//        switch self{
//        case .login(parameter: [String : String]):
//            return .post
//        default:
//            break
//        case .homeGoodList: return .post
//        case .goodDetail: return .get
//        }
    }
    //参数
    public var task: Task {
        
        switch self{
        case .phonelogin(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .phoneCode(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .passwordLogin(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
//        var paramters:[String:Any] = [:]
//        switch self{
//        case .login(let userName, let password):
//            paramters.updateValue(userName, forKey: "userName")
//            paramters.updateValue(password, forKey: "password")
//        case .homeGoodList(let paramter):
//            paramters = paramter
//        case .goodDetail(let paramter):
//            paramters = paramter
//        }
    }
    
    
    //公共请求头
    public var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
    
    //解析格式
    public var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }
    

}
