//
//  InputCodeView.swift
//  App
//
//  Created by mac on 2022/7/20.
//

import UIKit
import Util

class InputCodeView: UIView {

    
    
    
    
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
        titleLabel.text = "请输入验证码"
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
        let codeView = CodeView(frame: CGRect(x: scale(22), y: scale(80), width: frame.size.width - scale(44), height: scale(80)), codeNumber: 6, style: .CodeStyle_border, contentStyle: .CodeContentStyle_number, labelTextColor: UIColor.colorWithDyColorChangObject(lightColor: "#333333"), mainColor: UIColor.colorWithDyColorChangObject(lightColor: "#333333"), normalColor: UIColor.colorWithDyColorChangObject(lightColor: "#EDEDED"), margin: scale(8))
        addSubview(codeView)
        codeView.codeBlock = {[weak self] code in
            LXFLog("+==============\(code)")
        }
        
        let sendCodeBtn = UIButton()
        sendCodeBtn.setTitle("60S", for: .normal)
        sendCodeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF"), for: .normal)
        sendCodeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        sendCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addSubview(sendCodeBtn)
        sendCodeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-scale(36))
            make.width.equalTo(scale(152))
            make.height.equalTo(scale(44))
        }
        sendCodeBtn.layer.cornerRadius = scale(4)
        CountDown.countDown(60, btn: sendCodeBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func cancelAction(cancelBtn:UIButton){
        
        
    }
    

}
