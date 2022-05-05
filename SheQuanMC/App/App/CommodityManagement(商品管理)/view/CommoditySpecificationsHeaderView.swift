//
//  CommoditySpecificationsHeaderView.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util

class CommoditySpecificationsHeaderView: UITableViewHeaderFooterView {

    
    //设置规格
    lazy var contentLabel:UILabel = {
       let contentLabel = UILabel()
        contentLabel.text = "设置规格"
        contentLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        contentLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        contentLabel.textAlignment = .left
        return contentLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(18))
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
