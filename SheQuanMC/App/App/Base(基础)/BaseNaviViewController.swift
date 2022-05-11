//
//  BaseNaviViewController.swift
//  SheQuanMC
//
//  Created by mac on 2022/4/24.
//

import UIKit


open class BaseNaviViewController: UINavigationController {

    var popDelegate:AnyObject?
    //这边对一些导航栏的设置和控制
   open override func viewDidLoad() {
        super.viewDidLoad()
       
       self.popDelegate = self.interactivePopGestureRecognizer?.delegate
       self.delegate = self
        //设置导航栏底部横线
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = UIColor.white
        //不会有透明的问题
        navigationBar.isTranslucent = false
       
       
       
       if #available(iOS 15.0, *){
           let apperance = UINavigationBarAppearance()
           apperance.backgroundColor = UIColor.white
           apperance.shadowImage = UIImage()
           apperance.shadowColor = nil
           UINavigationBar.appearance().standardAppearance = apperance
           UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance
       }
       
    }
    
}


extension BaseNaviViewController:UINavigationControllerDelegate{
    
   
   open func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
       //这边对需要隐藏导航栏的控制器进行设置
       var isShowNavigationBar:Bool = false
       if viewController.isKind(of: StartPageViewController.self) || viewController.isKind(of: ShopViewController.self) || viewController.isKind(of: MyViewController.self) || viewController.isKind(of: CommoditySearchViewController.self) || viewController.isKind(of: OrderSearchViewController.self){
           isShowNavigationBar = true
       }else{
           isShowNavigationBar = false
       }
//       if viewController == viewControllers[0]{
//           self.setNavigationBarHidden(true, animated: true)
//       }else{
//           self.setNavigationBarHidden(false, animated: true)
//       }
       self.setNavigationBarHidden(isShowNavigationBar, animated: true)
    }
    
   open func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
       
       if viewController == self.viewControllers[0]{
           self.interactivePopGestureRecognizer?.delegate = self.popDelegate as? UIGestureRecognizerDelegate
       }else{
           self.interactivePopGestureRecognizer?.delegate = viewController as? UIGestureRecognizerDelegate
       }
    }
    
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //这边要判断是否需要是
         if children.count > 0 {
             viewController.hidesBottomBarWhenPushed = true
             // 设置返回按键
             viewController.navigationItem.leftBarButtonItem = UIBarButtonItem().backItemSetting(setImage: "返回", setBackgroundImage: "", target: self, action: #selector(backAction))
         }
        super.pushViewController(viewController, animated: true)
    }
    
    
    //返回
    @objc open func backAction(){
//        self.popViewController(animated: true)
        self.popViewController(animated: true)
    }
    
}
