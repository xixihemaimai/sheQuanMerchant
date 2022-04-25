//
//  Coordinator.swift
//  Util
//
//  Created by mac on 2022/4/25.
//

import Foundation
import UIKit

public class Coordinator {
  
//    private let navController: BaseNaviViewController
    
//    public init(_ navController: BaseNaviViewController) {
//        self.navController = navController
//    }
    
    public init(){
        
    }
    
    
    public func pushViewController(_ vc:UIViewController, _ OtherVc: UIViewController, animated: Bool) {
//        navController.pushViewController(vc, animated: animated)
        vc.navigationController?.pushViewController(OtherVc, animated: true)
    }
    
//    public func popViewController(_ animated: Bool) {
//        navController.popViewController(animated: animated)
//    }
//
//    public func setViewControllers(_ vcs: [UIViewController], animated: Bool) {
//        navController.setViewControllers(vcs, animated: animated)
//
//    }
//
//    public func present(_ vc: UIViewController, animated: Bool, completion: (() -> Void)?) {
//        navController.present(vc, animated: animated, completion: completion)
//    }
//
//    public func dismiss(_ animated: Bool, completion: (() -> Void)?) {
//        navController.dismiss(animated: animated, completion: completion)
//    }
    
    public static var shared: Coordinator?
    
}


