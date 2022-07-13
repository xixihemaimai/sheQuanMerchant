//
//  CommoditySpecificationsFooterView.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util

class CommoditySpecificationsFooterView: UITableViewHeaderFooterView {
    
    
    //按键
    lazy var addSepcificationsBtn:UIButton = {
       let addSepcificationsBtn = UIButton()
        addSepcificationsBtn.setTitle("添加规格(0/2)", for: .normal)
        addSepcificationsBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        addSepcificationsBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(15), weight: .regular)
        addSepcificationsBtn.setImage(UIImage(named: "Group 2759"), for: .normal)
        return addSepcificationsBtn
    }()
    
    

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F4F4F4")
        
        contentView.addSubview(addSepcificationsBtn)
        addSepcificationsBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
        }
        
        addSepcificationsBtn.layer.cornerRadius = scale(4)
        addSepcificationsBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333").cgColor
        addSepcificationsBtn.layer.borderWidth = scale(1)
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
