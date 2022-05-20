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
import SwiftyJSON

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    var allowRotion:Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        //这边要对用户数据进行判断是否有用户数据过
//        window?.rootViewController = MainViewController()
        if StoreService.shared.isLogin(){
            let startPageVc = StartPageViewController()
            let navi = BaseNaviViewController(rootViewController: startPageVc)
            self.window?.rootViewController = navi
            //这边要判断重新获取店铺信息
            let parameters = [String:Any]()
            NetWorkResultRequest(shopApi.getShopInfo(parameters: parameters), needShowFailAlert: true) { result, data in
//                do{
//                    let json = try JSON(data: data)
                    guard let model = try? JSONDecoder().decode(GenericResponse<StoreInfoModel>.self, from: data) else{
                        return
                    }
//                    if let data = model.data {
//                        StoreService.shared.updateShopInfo(data)
//                    }
                    guard let neWData = model.data else {
                        return
                    }
                    StoreService.shared.updateShopInfo(neWData)
                    
//                    LXFLog(neWData.auditStatus)
                    if neWData.auditStatus == 2{
                        self.window?.rootViewController = MainViewController()
                    }else if neWData.auditStatus == 1{
                        //审核中
                        let enterPriseVc = EnterpriseAuditViewController()
                        enterPriseVc.audit = 1
//                        self.window?.rootViewController = BaseNaviViewController(rootViewController: enterPriseVc)
                        Coordinator.shared?.pushViewController(startPageVc, enterPriseVc, animated: false)
                    }else if neWData.auditStatus == 3{
                        //审核失败
                        let enterPriseVc = EnterpriseAuditViewController()
                        enterPriseVc.audit = 2
//                        self.window?.rootViewController = BaseNaviViewController(rootViewController: enterPriseVc)
                        Coordinator.shared?.pushViewController(startPageVc, enterPriseVc, animated: false)
                    }else{
                        let storeOccupancyVC = StoreOccupancyViewController()
                        storeOccupancyVC.audit = 0
//                        let navi = BaseNaviViewController(rootViewController: storeOccupancyVC)
//                        self.window?.rootViewController = navi
                        Coordinator.shared?.pushViewController(startPageVc, storeOccupancyVC, animated: true)
                    }
//                    LXFLog(json)
//                    if json["data"]["auditStatus"].int32Value == 2{
//                        self.window?.rootViewController = MainViewController()
//                    }else if json["data"]["auditStatus"].int32Value == 1{
//                        //审核中
//                        let enterPriseVc = EnterpriseAuditViewController()
//                        enterPriseVc.audit = 1
////                        self.window?.rootViewController = BaseNaviViewController(rootViewController: enterPriseVc)
//                        Coordinator.shared?.pushViewController(startPageVc, enterPriseVc, animated: false)
//                    }else if json["data"]["auditStatus"].int32Value == 3{
//                        //审核失败
//                        let enterPriseVc = EnterpriseAuditViewController()
//                        enterPriseVc.audit = 2
////                        self.window?.rootViewController = BaseNaviViewController(rootViewController: enterPriseVc)
//                        Coordinator.shared?.pushViewController(startPageVc, enterPriseVc, animated: false)
//                    }else{
//                        let storeOccupancyVC = StoreOccupancyViewController()
//                        storeOccupancyVC.audit = 0
////                        let navi = BaseNaviViewController(rootViewController: storeOccupancyVC)
////                        self.window?.rootViewController = navi
//                        Coordinator.shared?.pushViewController(startPageVc, storeOccupancyVC, animated: true)
//                    }
//                }catch{}
            } failureCallback: { error,code in
                StoreService.shared.delete()
                let startPageVc = StartPageViewController()
                let navi = BaseNaviViewController(rootViewController: startPageVc)
                self.window?.rootViewController = navi
            }
        }else{
            //还没有登录
            StoreService.shared.delete()
            let startPageVc = StartPageViewController()
            let navi = BaseNaviViewController(rootViewController: startPageVc)
            self.window?.rootViewController = navi
        }
        Coordinator.shared = Coordinator()
        self.window?.makeKeyAndVisible()
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

