//
//  shopConfig.swift
//  Util
//
//  Created by 杨冰 on 2022/12/8.
//

import Foundation


public class shopConfig:NSObject{
    
    public static let share = shopConfig()
    //api版本
    public var apiVerId:String?
    //app版本
    public var appVerId:String?
    //app版本更新
    public var upgradeAppVerId:String?
    //APP的类型判断
    public var appId:String = "IOS"
    
}
