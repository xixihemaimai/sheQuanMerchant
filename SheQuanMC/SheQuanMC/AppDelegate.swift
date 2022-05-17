//
//  AppDelegate.swift
//  SheQuanMC
//
//  Created by mac on 2022/4/22.
//

import UIKit
import App
import Util
import IQKeyboardManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    var allowRotion:Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //这边要对用户数据进行判断是否有用户数据过
         
        
        if StoreAuthAndTokenTool.isLogin(){
            //登录了
            if StoreAuthAndTokenTool.isStoreAuth(){
                //店铺认证过了
                LXFLog("0--------------")
                window?.rootViewController = MainViewController()
            }else{
                //店铺认证还没有过
                LXFLog("1--------------")
                let storeOccupancy = StoreOccupancyViewController()
                let navi = BaseNaviViewController(rootViewController: storeOccupancy)
                window?.rootViewController = navi
            }
        }else{
            //还没有登录
            LXFLog("2--------------")
            let startPageVc = StartPageViewController()
            let navi = BaseNaviViewController(rootViewController: startPageVc)
            window?.rootViewController = navi
        }
        
        
        
//        let isLogin = false
//        if isLogin == false{
//
//        }else{
//
//        }
        Coordinator.shared = Coordinator()
        window?.makeKeyAndVisible()
        keyBoardManager()
        return true
    }
    //设置IQKeyBoardManager开启
    func keyBoardManager(){
        let keyBoard = IQKeyboardManager.shared()
        keyBoard.isEnabled = true
    }
    
    
    
    //设置方向
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if allowRotion{
            return .all
        }else{
            return .portrait
        }
    }
    
    
    //设置状态栏
    
}

