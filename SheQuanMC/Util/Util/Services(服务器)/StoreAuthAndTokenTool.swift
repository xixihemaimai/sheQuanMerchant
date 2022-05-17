//
//  StoreAuthAndTokenTool.swift
//  Util
//
//  Created by mac on 2022/5/17.
//

import Foundation


let TOKEN_KEY = "tokenModel"

public class StoreAuthAndTokenTool{
    
    //判断是否登录了这个token 要和新传入的token对
    
    
    //判断是否登录了
    public static func isLogin() -> Bool{
        if let model = self.getTokenModel(){
            if model.accessToken != nil{
               return true
            }else{
               return false
            }
        }
        return false
    }
    
    
    //判断是否店铺认证过
    public static func isStoreAuth() -> Bool{
        if let model = self.getTokenModel(){
            if model.shopAuth == true{
                return true
            }else{
                return false
            }
        }
        return false
    }
    
    
    //存入nsuserstard
    public static func saveTokenModel(_ model:StoreAuthTokenModel){
        let data:Data = NSKeyedArchiver.archivedData(withRootObject: model)
        UserDefaults.standard.set(data, forKey: TOKEN_KEY)
        UserDefaults.standard.synchronize()
    }
    
    
    
    
    //取
    public static func getTokenModel() -> StoreAuthTokenModel?{
        let user = UserDefaults.standard
        guard let data = user.object(forKey: TOKEN_KEY) as? Data else {
            return nil
        }
        let model:StoreAuthTokenModel = NSKeyedUnarchiver.unarchiveObject(with: data) as! StoreAuthTokenModel
        user.synchronize()
        return model
    }
    
    
    //改
    
    public static func refreshToken(_ model:StoreAuthTokenModel){
        let data:Data = NSKeyedArchiver.archivedData(withRootObject: model)
        UserDefaults.standard.set(data, forKey: TOKEN_KEY)
        UserDefaults.standard.synchronize()
    }
    
    
    
    //删
    public static func cleanTokenModel(){
        UserDefaults.standard.removeObject(forKey: TOKEN_KEY)
        UserDefaults.standard.synchronize()
    }
    
    
}




