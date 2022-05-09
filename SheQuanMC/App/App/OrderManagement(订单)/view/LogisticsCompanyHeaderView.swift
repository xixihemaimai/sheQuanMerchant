//
//  LogisticsCompanyHeaderView.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class LogisticsCompanyHeaderView: UITableViewHeaderFooterView {

    lazy var titleCompanyLabel:UILabel = {
       let titleCompanyLabel = UILabel()
        titleCompanyLabel.text = "常用物流"
        titleCompanyLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        titleCompanyLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        titleCompanyLabel.textAlignment = .left
        return titleCompanyLabel
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        
        
        contentView.addSubview(titleCompanyLabel)
        titleCompanyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(18))
            make.bottom.equalTo(-scale(10))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

