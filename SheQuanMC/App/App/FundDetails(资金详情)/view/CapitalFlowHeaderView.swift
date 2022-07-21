//
//  CapitalFlowHeaderView.swift
//  App
//
//  Created by mac on 2022/7/21.
//

import UIKit
import Util

class CapitalFlowHeaderView: UITableViewHeaderFooterView {

    lazy var captialFlowLabel:UILabel = {
       let captialFlowLabel = UILabel()
        captialFlowLabel.text = "2022年1月"
        captialFlowLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        captialFlowLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        captialFlowLabel.textAlignment = .left
        return captialFlowLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        
        contentView.addSubview(captialFlowLabel)
        captialFlowLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(20))
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

