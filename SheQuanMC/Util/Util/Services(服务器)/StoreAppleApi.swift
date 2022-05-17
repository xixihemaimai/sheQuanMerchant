//
//  StoreAppleApi.swift
//  Util
//
//  Created by mac on 2022/5/16.
//

import Foundation
import Moya
import UIKit
import AVFoundation


public enum StoreAppleApi{
    case entCert(parameters:[String:Any]) //企业认证
    case getCategoryInfoList(parameters:[String:Any]) //获取经营种类列表
    case shopAuth(parameters:[String:Any])   //店铺认证
}


extension StoreAppleApi:TargetType{
    public var baseURL: URL {
        return URL(string: sheQuanMCURL)!
    }
    
    public var path: String {
        switch self {
          case .entCert:
            return "ent/entCert"
          case .getCategoryInfoList:
            return "category/getCategoryInfoList"
         case .shopAuth:
               return "shop/shopAuth"
        }
        
    }
    
    public var method: Moya.Method {
        switch self {
           case .entCert,.getCategoryInfoList,.shopAuth:
               return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .entCert(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getCategoryInfoList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .shopAuth(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        
        switch self {
        case .getCategoryInfoList,.shopAuth:
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreAuthAndTokenTool.getTokenModel()?.accessToken ?? ""]
        default:
            return ["Accept": "*/*","Content-Type":"application/json"]
        }
    }
    
    
    public var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }
    
    
    
}
