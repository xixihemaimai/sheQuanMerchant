//
//  Config.swift
//  Util
//
//  Created by mac on 2022/4/24.
//

import Foundation
import UIKit


public let SCW = UIScreen.main.bounds.size.width
public let SCH = UIScreen.main.bounds.size.height


//通知展示隐私政策和用户协议
public let ShowUserPrivacy = NSNotification.Name("showUserPrivacy")
//是否展示第一次安装弹窗显示隐私政策和用户协议的
public let isFristLaunchScreen = "isFristLaunchScreen"
//通知改变订单显示次数的变化
public let ChangeOrderCount = NSNotification.Name("changeOrderCount")
//通知修改店铺头像
public let ModifyShopAvater = NSNotification.Name("modifyShopAvater")
//通知修改店铺名称
public let ModifyShopName = NSNotification.Name("modifyShopName")
//售后修改地址
public let ModifyAfterSalesAddress = NSNotification.Name("modifyAfterSalesAddress")


//这边还需要判断是不是iphonex 以上的机型
//iphone6 ,7,8,se
public let isIphone6:Bool = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 640, height: 960).equalTo((UIScreen.main.currentMode?.size)!) : false
//iphone6 plus,7 plus, 8 plus
public let isIphone6Plus:Bool = UIScreen.instancesRespond(to: #selector(getter:UIScreen.main.currentMode)) ?
CGSize(width: 1242, height: 2208).equalTo((UIScreen.main.currentMode?.size)!) : false
//iPhoneX
public let isIphoneX:Bool = UIScreen.instancesRespond(to: #selector(getter:UIScreen.main.currentMode)) ?
CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false
//iPHoneXr | 11
public let isIphoneXR:Bool = UIScreen.instancesRespond(to: #selector(getter:UIScreen.main.currentMode)) ?
CGSize(width: 828, height: 1792).equalTo((UIScreen.main.currentMode?.size)!) : false
//iPhoneXs | 11Pro
public let isIphoneXS:Bool = UIScreen.instancesRespond(to: #selector(getter:UIScreen.main.currentMode)) ?
CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false
//iphonexs max iphone11 promax
public let isIphoneXS_MAX:Bool = UIScreen.instancesRespond(to: #selector(getter:UIScreen.main.currentMode)) ?
CGSize(width: 1242, height: 2688).equalTo((UIScreen.main.currentMode?.size)!) : false
//iphone12mini iphone13mini
public let isIphone12_MINI:Bool = UIScreen.instancesRespond(to: #selector(getter:UIScreen.main.currentMode)) ? CGSize(width: 1080, height: 2340).equalTo((UIScreen.main.currentMode?.size)!) : false
//iphone12 iphone13 iphone12pro iphone13pro 14
public let isIphone12:Bool = UIScreen.instancesRespond(to: #selector(getter:UIScreen.main.currentMode)) ?
CGSize(width: 1170, height: 2532).equalTo((UIScreen.main.currentMode?.size)!) : false
//12promax|| 13promax || 14 plus
public let isIphone12_PROMAX = UIScreen.instancesRespond(to: #selector(getter:UIScreen.main.currentMode)) ?
CGSize(width: 1284, height: 2778).equalTo((UIScreen.main.currentMode?.size)!) : false
//14pro
public let isIphone14_PRO = UIScreen.instancesRespond(to: #selector(getter:UIScreen.main.currentMode)) ?
CGSize(width: 1179, height: 2556).equalTo((UIScreen.main.currentMode?.size)!) : false
//14pro max
public let isIphone14_PROMax = UIScreen.instancesRespond(to: #selector(getter:UIScreen.main.currentMode)) ?
CGSize(width: 1290, height: 2796).equalTo((UIScreen.main.currentMode?.size)!) : false



public let iPhoneX:Bool = isIphoneX || isIphoneXR || isIphoneXS || isIphoneXS_MAX || isIphone12_MINI || isIphone12 || isIphone12_PROMAX || isIphone14_PRO || isIphone14_PROMax
//状态栏高度
//(isIphoneX == true || isIphoneXR == true || isIphoneXS == true || isIphoneXS_MAX == true || isIphone12_MINI == true) ? 44 : 20
public let Height_StatusBar:CGFloat = UIApplication.shared.statusBarFrame.height

public let isIsPhoneX:Bool = SCH > 812
//tabbar高度加载安全高度
public let Height_TabBar:CGFloat = Height_bottomSafe + 49
//底部安全距离
//public let Height_bottomSafeArea:CGFloat = iPhoneX == true ? 34 : 0.0
//新的底部安全区域高度
public let Height_bottomSafe:CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 > 0 ? (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 34) : 0.0
//新的顶部安全区域高度
public let Height_topSafe:CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 0 ? (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 44) : 20.0
//状态栏和导航栏一起高度
//public let Height_NavBar:CGFloat = ((isIphoneXR == true || isIphoneXS == true || isIphoneXS_MAX == true || isIphone12_MINI == true) ? 88 : (isIphoneX == true) ? 92 : (isIphone12 == true || isIphone12_PROMAX == true) ? 91 : 64)
public let Height_NavBar:CGFloat = Height_topSafe + 44.0
//适配等比计算方法
public func scale(_ number:CGFloat)->CGFloat{
    return  number * CGFloat(SCW/375)
}
//控制器默认背景颜色
public let viewControllerBackGroundColor:UIColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
//tabbaritem默认没有选中的颜色
public let tabbarNormalColor:UIColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
//tabbaritem选中的颜色
public let tabbarSelectColor:UIColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
//控制器部分界面是白色的颜色
public let viewControllerWhiteColor:UIColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")


// MARK:- 自定义打印方法
public func LXFLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):(\(lineNum))-\(message)")
        
    #endif
}

