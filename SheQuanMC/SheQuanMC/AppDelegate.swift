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
import JFPopup
import AliyunIdentityManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var allowRotion:Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let _ = AliyunSdk.init()
//        let view = JFPopupView()
//        view.config.autoDismissDuration = JFTimerDuration.seconds(value: 1)
//        view.config.isDismissible = false
         //这边获取系统版本
        NetWorkResultRequest(LoginApi.systemVersion, needShowFailAlert: true) { result, data in
            do{
                print("========23=2=3======\(data)")
                let json = try JSON(data: data)
                
                
                var config = shopConfig.share
                config.apiVerId = json["data"]["apiVerId"].string
                config.appVerId = json["data"]["appVerId"].string
                config.upgradeAppVerId = json["data"]["upgradeAppVerId"].string
            
                let user = UserDefaults.standard
                user.removeObject(forKey: "appVerId")
                user.set(json["data"]["appVerId"].string ?? "1.0.0", forKey: "appVerId")
                LXFLog(user.object(forKey: "appVerId"))
                user.removeObject(forKey: "apiVerId")
                user.setValue(json["data"]["apiVerId"].string ?? "1.0.0", forKey: "apiVerId")
                user.removeObject(forKey: "upgradeAppVerId")
                user.setValue(json["data"]["upgradeAppVerId"].string ?? "1.0.0", forKey: "upgradeAppVerId")
                user.synchronize()
                
            }catch{}
        } failureCallback: { error, code in
        }
        Thread.sleep(forTimeInterval: 0.4)
        //这边要对用户数据进行判断是否有用户数据过
        if StoreService.shared.isLogin(){
            let startPageVc = StartPageViewController()
            let navi = BaseNaviViewController(rootViewController: startPageVc)
            self.window?.rootViewController = navi
            //这边要判断重新获取店铺信息
            NetWorkResultRequest(shopApi.getShopInfo, needShowFailAlert: true) { result, data in
//                 do{
//                    let json = try JSON(data: data)
                    //需不需要删除数据库
//                    StoreService.shared.delete()
                    guard let model = try? JSONDecoder().decode(GenericResponse<StoreInfoModel>.self, from: data) else{
                        return
                    }
//                  if let data = model.data {
//                     StoreService.shared.updateShopInfo(data)
//                  }
                    guard let neWData = model.data else {
                        return
                    }
//                LXFLog(neWData.auditStatus)
                    StoreService.shared.updateShopInfo(neWData)
//                    LXFLog(neWData.auditStatus)
                    if neWData.auditStatus == 2{
                        self.window?.rootViewController = MainViewController()
                    }else if neWData.auditStatus == 1{
                        //审核中
                        let enterPriseVc = EnterpriseAuditViewController()
                        enterPriseVc.audit = 1
                        Coordinator.shared?.pushViewController(startPageVc, enterPriseVc, animated: false)
//                        self.window?.rootViewController = MainViewController()
                    }else if neWData.auditStatus == 3{
                        //审核失败
                        let enterPriseVc = EnterpriseAuditViewController()
                        enterPriseVc.audit = 2
//                      self.window?.rootViewController = BaseNaviViewController(rootViewController: enterPriseVc)
                        Coordinator.shared?.pushViewController(startPageVc, enterPriseVc, animated: false)
                    }else{
                        let storeOccupancyVC = StoreOccupancyViewController()
                        storeOccupancyVC.audit = 0
//                      let navi = BaseNaviViewController(rootViewController: storeOccupancyVC)
//                      self.window?.rootViewController = navi
                        Coordinator.shared?.pushViewController(startPageVc, storeOccupancyVC, animated: true)
                    }
                
                    //获取企业信息
                    NetWorkResultRequest(StoreAppleApi.getEntInfo, needShowFailAlert: true) { result, data in
                      guard let model = try? JSONDecoder().decode(GenericResponse<StoreInfoModel>.self, from: data) else{
                         return
                      }
                      guard let neWData = model.data else {
                         return
                      }
                      StoreService.shared.updateShopInfo(neWData)
                    } failureCallback: { error, code in
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

