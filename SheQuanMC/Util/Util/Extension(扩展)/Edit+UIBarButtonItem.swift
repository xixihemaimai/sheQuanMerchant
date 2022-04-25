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
    func backItemSetting(setImage:String,setBackgroundImage:String,target:Any, action: Selector) -> UIBarButtonItem{
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
