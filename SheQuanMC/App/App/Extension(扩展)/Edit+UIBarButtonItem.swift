//
//  Edit+UIBarButtonItem.swift
//  newShiLaiShiWang
//
//  Created by mac on 2021/12/22.
//

import Foundation
import UIKit
import Util

extension UIBarButtonItem{
    public func backItemSetting(setImage:String,setBackgroundImage:String,target:Any, action: Selector) -> UIBarButtonItem{
        let backBtn = UIButton()
        backBtn.addTarget(target, action: action, for: .touchUpInside)
        backBtn.setImage(UIImage(named: setImage), for: .normal)
        backBtn.setBackgroundImage(UIImage(named: setBackgroundImage), for: .normal)
        backBtn.frame = CGRect(x: 0, y: 0, width: scale(40), height: scale(40))
        backBtn.layer.borderWidth = 0
        backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -scale(16), bottom: 0, right: 0)
        let backItem = UIBarButtonItem(customView: backBtn)
        return backItem
    }
}


extension Int{
    func loginOut(){
        if self == 201{
             let startVc = StartPageViewController()
            let window = UIApplication.shared.keyWindow
            window?.rootViewController = BaseNaviViewController(rootViewController: startVc)
        }
//        else if self == 9999{
//          LXFLog("===============================\("测试")")
//            let noNetVc = NoNetViewController()
//            Coordinator.shared?.pushViewController(UIViewController.current(), noNetVc, animated: true)
//            //这个界面要进行跳转到无网络的界面
//        }
    }
}



extension UIViewController {
    /** 获取当前控制器 */
    static func current() -> UIViewController {
        let vc = UIApplication.shared.keyWindow?.rootViewController
        return UIViewController.findBest(vc: vc!)
    }
    
    private static func findBest(vc: UIViewController) -> UIViewController {
        if vc.presentedViewController != nil {
            return UIViewController.findBest(vc: vc.presentedViewController!)
        } else if vc.isKind(of: UISplitViewController.self) {
            let svc = vc as! UISplitViewController
            if svc.viewControllers.count > 0 {
                return UIViewController.findBest(vc: svc.viewControllers.last!)
            } else {
                return vc
            }
        } else if vc.isKind(of: UINavigationController.self) {
            let svc = vc as! UINavigationController
            if svc.viewControllers.count > 0 {
                return UIViewController.findBest(vc: svc.topViewController!)
            } else {
                return vc
            }
        } else if vc.isKind(of: UITabBarController.self) {
            let svc = vc as! UITabBarController
            if (svc.viewControllers?.count ?? 0) > 0 {
                return UIViewController.findBest(vc: svc.selectedViewController!)
            } else {
                return vc
            }
        } else {
            return vc
        }
    }
}
