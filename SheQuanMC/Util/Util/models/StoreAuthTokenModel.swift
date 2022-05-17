//
//  StoreAuthTokenModel.swift
//  Util
//
//  Created by mac on 2022/5/17.
//

import Foundation

public class StoreAuthTokenModel: NSObject,NSCoding {
    
    
    public var accessToken:String?
    public var shopAuth:Bool?
    
    public init(accessToken:String,shopAuth:Bool) {
        self.accessToken = accessToken
        self.shopAuth = shopAuth
        super.init()
    }
    
    
   
    public func encode(with coder: NSCoder) {
        coder.encode(accessToken, forKey: "accessToken")
        coder.encode(shopAuth, forKey: "shopAuth")
        
    }
    
    
    public required init?(coder: NSCoder) {
        accessToken = coder.decodeObject(forKey: "accessToken") as? String
        shopAuth = coder.decodeObject(forKey: "shopAuth") as? Bool
    }
    
    
    
    
    
    
    
    
//    enum CodingKeys:String,CodingKey{
//        case accessToken = "accessToken"
//        case shopAuth = "shopAuth"
//    }
//
//    public init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        accessToken = try? values.decodeIfPresent(String.self, forKey: .accessToken)
//        shopAuth = try? values.decodeIfPresent(Bool.self, forKey: .shopAuth)
//    }
}

