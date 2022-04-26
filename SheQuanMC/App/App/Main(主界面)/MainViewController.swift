//
//  MainViewController.swift
//  App
//
//  Created by mac on 2022/4/22.
//

import UIKit
import SnapKit
import Util

open class MainViewController: UITabBarController {
    
    

   public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
       //设置底部tabbar没有横线
       tabBar.backgroundImage = UIImage()
       tabBar.shadowImage = UIImage()
       tabBar.isTranslucent = false
        //iOS13之后, 首次打开App并尝试切换底部tabbar选中下标, 字体颜色都是可以的, 但是如果push了新的页面再回到主页面, 文字高亮颜色默认是系统的高亮蓝色
        tabBar.tintColor = tabbarSelectColor
        tabBar.unselectedItemTintColor = tabbarNormalColor
       //这边是创建多个控制器
       //这边有多少个就执行多少次
        let titleS:[[String:String]] = [["name": "店铺","normal":"Group 2757","select":"Group 2757"],["name":"我的","normal":"Group 2755","select":"Group 2755"]]
       for i in 0..<titleS.count {
           let dict = titleS[i]
           let Vc = creatViewController(title: dict["name"]!, normalString:dict["normal"]!, selectString: dict["select"]!)
         self.addChild(Vc)
       }
    }
    public func creatViewController(title:String,normalString:String,selectString:String)->UIViewController{
         var VC:UIViewController
         if title == "店铺"{
             VC = ShopViewController()
         }else{
             VC = MyViewController()
         }
         let navi = BaseNaviViewController(rootViewController: VC)
         navi.tabBarItem.title = title
         Coordinator.shared = Coordinator()
         navi.tabBarItem.image = UIImage(named:normalString)
         navi.tabBarItem.selectedImage = UIImage(named: selectString)?.withRenderingMode(.alwaysOriginal)
         return navi
     }

}
