//
//  OrderApi.swift
//  Util
//
//  Created by mac on 2022/5/19.
//

import Foundation
import Moya


public enum OrderApi{
    case getOrderSalesInfo
}



extension OrderApi:TargetType{
   public var baseURL: URL {
        return URL(string: sheQuanMCURL)!
    }
    
    public var path: String {
        switch self {
        case .getOrderSalesInfo:
            return "order/getOrderSalesInfo"
        }
    }
    
    public var method:Moya.Method{
        return .post
    }
    
    public var task: Task {
        switch self {
        case .getOrderSalesInfo:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
       return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? ""]
    }
    
    
    public var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }
    
    
}





