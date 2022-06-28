//
//  ModifyShopNameViewController.swift
//  App
//
//  Created by mac on 2022/6/28.
//

import UIKit
import Util

class ModifyShopNameViewController: BaseViewController {
    
    lazy var modifyTextField:UITextField = {
        let modifyTextField = UITextField()
        modifyTextField.placeholder = StoreService.shared.currentUser?.shopName
        modifyTextField.attributedPlaceholder = NSAttributedString.init(string:StoreService.shared.currentUser?.shopName ?? "", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        modifyTextField.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        modifyTextField.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return modifyTextField
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "修改店铺名"
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        view.addSubview(modifyTextField)
        modifyTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(164))
        }
        
        let bottomview = UIView()
        bottomview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(bottomview)
        bottomview.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(iPhoneX ? scale(92) : scale(58))
        }
        
        let saveBtn = UIButton()
        saveBtn.setTitle("保存", for: .normal)
        saveBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF"), for: .normal)
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        bottomview.addSubview(saveBtn)
        saveBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        saveBtn.layer.cornerRadius = scale(4)
        
        saveBtn.addTarget(self, action: #selector(modifyShopNameAction), for: .touchUpInside)
        
    }
    
    
    //修改店铺名称
    @objc func modifyShopNameAction(saveBtn:UIButton){
        //这边要返回数据
    }
    
}
