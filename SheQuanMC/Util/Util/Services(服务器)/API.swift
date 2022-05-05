//
//  API.swift
//  测试暗黑和白天模式
//
//  Created by mac on 2022/3/16.
//

import Foundation
import Moya
import UIKit


let moya = MoyaProvider<API>()


enum API{
    case login(String,String) //登录
    case homeGoodList(Parameters:[String:Any]) //首页商品信息
    case goodDetail(Parameters:[String:Any]) //首页商品的详情信息
}


extension API:TargetType{
    //服务器地址
    public var baseURL: URL{
        return URL(string: "123")!
    }
    
    
    //网络请求路径
    
    var path: String{
        switch self{
        case .login(let userName, let password):
            return "login" + userName + password
        case .homeGoodList:
            return "homeGoodList"
         case .goodDetail:
            return "goodDetail"
        }
    }
    
    //网络请求的方法
    var method: Moya.Method {
        switch self{
        case .login:return .post
        case .homeGoodList: return .post
        case .goodDetail: return .get
        }
    }
    //参数
    var task: Task {
        var paramters:[String:Any] = [:]
        switch self{
        case .login(let userName, let password):
            paramters.updateValue(userName, forKey: "userName")
            paramters.updateValue(password, forKey: "password")
        case .homeGoodList(let paramter):
            paramters = paramter
        case .goodDetail(let paramter):
            paramters = paramter
        }
        
        return .requestParameters(parameters: paramters, encoding: URLEncoding.default)
    }
    
    
    //公共请求头
    var headers: [String : String]? {
        
        return nil
//        return ["devtype","ios","devid":UIDevice().identifierForVendor ?? UUID ??]
    }
    
    //解析格式
    var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }
    
   
    
    
   
    
}
