//
//  ModifyShopNameViewController.swift
//  App
//
//  Created by mac on 2022/6/28.
//

import UIKit
import Util

class ModifyShopNameViewController: BaseViewController {
    
    lazy var modifyTextView:UITextView = {
        let modifyTextView = UITextView()
        modifyTextView.placeholder = StoreService.shared.currentUser?.shopName
        modifyTextView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")
        modifyTextView.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        modifyTextView.textContainer.lineFragmentPadding = scale(16)
        modifyTextView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        modifyTextView.contentInset = UIEdgeInsets.zero
        modifyTextView.delegate = self
        return modifyTextView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "修改店铺名"
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        view.addSubview(modifyTextView)
        modifyTextView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
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
        saveBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
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


extension ModifyShopNameViewController:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "" && range.length > 0{
            return true
        }
        if textView.text.count > 14{
            return false
        }
        return true
    }
}
