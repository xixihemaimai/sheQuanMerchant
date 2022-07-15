//
//  AgreenRefundView.swift
//  App
//
//  Created by mac on 2022/7/15.
//

import UIKit
import Util

class AgreenRefundView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            
        
        let titleLabel = UILabel()
        titleLabel.text = "同意退款"
        titleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        titleLabel.font = UIFont.systemFont(ofSize: scale(17), weight: .regular)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scale(15))
            make.width.equalTo(scale(150))
            make.height.equalTo(scale(24))
        }
        
        
        
        let cancelBtn = UIButton()
        cancelBtn.setBackgroundImage(UIImage(named: "关闭1 1"), for: .normal)
//        cancelBtn.addTarget(self, action: #selector(cancelAddAction), for: .touchUpInside)
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(16))
            make.width.height.equalTo(scale(22))
        }
        
        
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        addSubview(midView)
        
        midView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(scale(15))
            make.height.equalTo(scale(0.5))
        }
        
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
