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
    case forgetPass(parameters:[String:Any]) //忘记密码
    case changePass(parameters:[String:Any]) //修改密码
    case regAccount(parameters:[String:Any]) //注册账号
    case getShopInfo(parameters:[String:Any])//获取店铺信息
    case shopAuth(parameters:[String:Any])   //店铺认证
    
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
        case .shopAuth:
               return "shop/shopAuth"     //店铺认证
        
        }
   
    }
    
    public var method: Moya.Method {
        switch self {
        case .forgetPass,.changePass,.regAccount,.getShopInfo,.shopAuth:
            return .post
            
        }
    }
    
    public var task: Task {
        switch self{
           case .forgetPass(let parameters):
               return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
           case .changePass(let parameters):
               return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
           case .regAccount(let parameters):
               return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
           case .getShopInfo(let parameters):
               return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
           case .shopAuth(let parameters):
               return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    
    
    public var headers: [String : String]? {
        ["Content-Type":"application/json"]
    }
    
    
    public var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }
    
    
    
    
    
}
