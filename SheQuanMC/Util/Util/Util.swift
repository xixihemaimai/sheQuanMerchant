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
}
