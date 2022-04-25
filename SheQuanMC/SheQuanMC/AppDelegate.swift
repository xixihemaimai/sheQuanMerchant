//
//  AppDelegate.swift
//  SheQuanMC
//
//  Created by mac on 2022/4/22.
//

import UIKit
import App
import Util

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    var allowRotion:Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //这边要对用户数据进行判断是否有用户数据过
        let isLogin = false
        if isLogin == false{
            let startPageVc = StartPageViewController()
            let navi = BaseNaviViewController(rootViewController: startPageVc)
            window?.rootViewController = navi
        }else{
            window?.rootViewController = MainViewController()
        }
        Coordinator.shared = Coordinator()
        window?.makeKeyAndVisible()
        
        return true
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

