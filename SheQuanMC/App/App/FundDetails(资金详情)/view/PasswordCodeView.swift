//
//  PasswordCodeView.swift
//  App
//
//  Created by mac on 2022/7/20.
//

import UIKit
import Util

class PasswordCodeView: UIView {
    
    
    lazy var priceLabel:UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "¥12.00"
        priceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        priceLabel.font = UIFont.systemFont(ofSize: scale(32), weight: .semibold)
        priceLabel.textAlignment = .center
        return priceLabel
    }()
    
    
    lazy var servicePriceLabel:UILabel = {
        let servicePriceLabel = UILabel()
        servicePriceLabel.text = "¥2.00"
        servicePriceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        servicePriceLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        servicePriceLabel.textAlignment = .right
        return servicePriceLabel
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let cancelBtn = UIButton()
        cancelBtn.setBackgroundImage(UIImage(named: "关闭1 1"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(20))
            make.top.equalTo(scale(24))
            make.width.height.equalTo(scale(22))
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "请输入支付密码"
        titleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        titleLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scale(24))
            make.width.equalTo(scale(150))
            make.height.equalTo(scale(20))
        }
        
        let rechargLabel = UILabel()
        rechargLabel.text = "提现"
        rechargLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        rechargLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        rechargLabel.textAlignment = .center
        addSubview(rechargLabel)
        
        rechargLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(scale(28))
            make.height.equalTo(scale(22))
        }
        
        
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(rechargLabel.snp.bottom).offset(scale(4))
            make.height.equalTo(scale(45))
        }
        
        
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        addSubview(midView)
        
        midView.snp.makeConstraints { make in
            make.left.equalTo(scale(22))
            make.right.equalTo(-scale(22))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(priceLabel.snp.bottom).offset(scale(29))
        }
        
        let serviceLabel = UILabel()
        serviceLabel.text = "服务费"
        serviceLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        serviceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        serviceLabel.textAlignment = .left
        addSubview(serviceLabel)
        
        serviceLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(22))
            make.top.equalTo(midView.snp.bottom).offset(scale(3))
            make.height.equalTo(scale(17))
            make.width.equalTo(scale(50))
        }
        
        addSubview(servicePriceLabel)
        servicePriceLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(22))
            make.top.equalTo(midView.snp.bottom).offset(scale(3))
            make.height.equalTo(scale(17))
            make.left.equalTo(serviceLabel.snp.right)
        }
        
        
        let codeView =  CodeView(frame: CGRect(x: scale(22), y: scale(213), width: frame.size.width - scale(44), height: scale(80)), codeNumber: 6, style: .CodeStyle_border, contentStyle: .CodeContentStyle_password, labelTextColor: UIColor.colorWithDyColorChangObject(lightColor: "#333333"), mainColor: UIColor.colorWithDyColorChangObject(lightColor: "#333333"), normalColor: UIColor.colorWithDyColorChangObject(lightColor: "#EDEDED"), margin: scale(8))
        addSubview(codeView)
        codeView.codeBlock = {[weak self] code in
            LXFLog("+==============\(code)")
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func cancelAction(cancelBtn:UIButton){
        
        
    }

}
