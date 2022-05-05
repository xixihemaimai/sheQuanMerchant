//
//  AddSpecificationsView.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util

class AddSpecificationsView: UIView {

    
    //这边要进行修改这类的动作
    

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        let specificationLabel = UILabel()
        specificationLabel.text = "添加规格"
        specificationLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        specificationLabel.font = UIFont.systemFont(ofSize: scale(17), weight: .regular)
        addSubview(specificationLabel)
        
        specificationLabel.snp.makeConstraints { make in
            make.top.equalTo(scale(15))
            make.centerX.equalToSuperview()
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(24))
        }
        
        let cancelBtn = UIButton()
        cancelBtn.setBackgroundImage(UIImage(named: "关闭1 1"), for: .normal)
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(16))
            make.width.height.equalTo(scale(22))
        }
        
        
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
