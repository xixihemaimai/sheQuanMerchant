//
//  Util.swift
//  Util
//
//  Created by mac on 2022/4/24.
//

import Foundation
import UIKit

public class Util {
    
    public static func getCurrentVc() -> UIViewController {
        let rootVc = UIApplication.shared.keyWindow?.rootViewController
        let currentVc = getCurrentVcFrom(rootVc!)
        return currentVc
    }
    
    public static func getCurrentVcFrom(_ rootVc:UIViewController) -> UIViewController{
      var currentVc:UIViewController
      var rootCtr = rootVc
      if(rootCtr.presentedViewController != nil) {
        rootCtr = rootVc.presentedViewController!
      }
      if let tabBarPage = rootVc as? UITabBarController,
         let selectPage = tabBarPage.selectedViewController {
        currentVc = getCurrentVcFrom(selectPage)
      }else if rootVc.isKind(of:UINavigationController.classForCoder()){
        currentVc = getCurrentVcFrom((rootVc as! UINavigationController).visibleViewController!)
      }else{
        currentVc = rootCtr
      }
      return currentVc
    }
    
    public static func getKeyWindow() -> UIWindow {
        return UIApplication.shared.keyWindow ?? UIApplication.shared.windows.first!
    }
    
    
    public static func popToMainViewControllerAnimated(animated: Bool, completion: ((_ isOK: Bool, _ data: [String: Any]?) -> ())?) -> Void {
        let vc = Util.getCurrentVc()
        if vc.navigationController == UIApplication.shared.delegate?.window??.rootViewController {
            vc.navigationController?.popToRootViewController(animated: animated)
            if let _completion = completion {
                _completion(true, nil)
            }
        } else {
            vc.navigationController?.dismiss(animated: animated, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
                Util.popToMainViewControllerAnimated(animated: animated, completion: completion)
            }
        }
    }
}
