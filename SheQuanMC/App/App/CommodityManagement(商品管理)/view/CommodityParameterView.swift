//
//  CommodityParameterView.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util


class CommodityParameterView: UIView {

    
    //输入uitextview
    lazy var textView:UITextView = {
       let textView = UITextView()
        textView.placeholder = "请输入"
        textView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor: "#d2d2d2")
        return textView
    }()
    
    
    
    //完成按键
    lazy var completeBtn:UIButton = {
       let completeBtn = UIButton()
        completeBtn.setTitle("完成", for: .normal)
        completeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF"), for: .normal)
        completeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        completeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        return completeBtn
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textView)
        addSubview(completeBtn)
        
        textView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(100))
        }
        
        completeBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(textView.snp.bottom)
            make.height.equalTo(scale(44))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
