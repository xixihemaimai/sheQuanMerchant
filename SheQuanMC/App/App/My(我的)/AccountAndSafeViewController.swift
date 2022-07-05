//
//  AccountAndSafeViewController.swift
//  App
//
//  Created by mac on 2022/7/5.
//

import UIKit
import Util

class AccountAndSafeViewController: BaseViewController {

    
    //绑定手机
    lazy var bindPhoneLabel:UILabel = {
       let bindPhoneLabel = UILabel()
        bindPhoneLabel.text = "未设置"
        bindPhoneLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        bindPhoneLabel.font = UIFont.systemFont(ofSize: scale(15), weight: .regular)
        bindPhoneLabel.textAlignment = .right
        return bindPhoneLabel
    }()
    
    //登录密码
    lazy var loginPwdLabel:UILabel = {
       let loginPwdLabel = UILabel()
        loginPwdLabel.text = "未设置"
        loginPwdLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        loginPwdLabel.font = UIFont.systemFont(ofSize: scale(15), weight: .regular)
        loginPwdLabel.textAlignment = .right
        return loginPwdLabel
    }()
    
    //支付密码
    lazy var payPwdLabel:UILabel = {
       let payPwdLabel = UILabel()
        payPwdLabel.text = "未设置"
        payPwdLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        payPwdLabel.font = UIFont.systemFont(ofSize: scale(15), weight: .regular)
        payPwdLabel.textAlignment = .right
        return payPwdLabel
    }()
    
    //实名认证
    lazy var realAuthenLabel:UILabel = {
        let realAuthenLabel = UILabel()
        realAuthenLabel.text = "未设置"
        realAuthenLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        realAuthenLabel.font = UIFont.systemFont(ofSize: scale(15), weight: .regular)
        realAuthenLabel.textAlignment = .right
        return realAuthenLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "账号与安全"
       
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        
        let phoneBtn = UIButton()
        phoneBtn.setTitle("    绑定手机", for: .normal)
        phoneBtn.contentHorizontalAlignment = .left
        phoneBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        phoneBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        phoneBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        phoneBtn.tag = 0
        view.addSubview(phoneBtn)
        
        phoneBtn.addTarget(self, action: #selector(jumpChangeAction), for: .touchUpInside)
        phoneBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(0.5))
            make.height.equalTo(scale(48))
        }
        
        phoneBtn.addSubview(bindPhoneLabel)
        bindPhoneLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(48))
            make.left.equalTo(scale(80))
            make.height.equalTo(scale(21))
        }
        
        let phoneRight = UIImageView()
        phoneRight.image = UIImage(named: "Frame-my-right")
        phoneBtn.addSubview(phoneRight)
        
        phoneRight.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
        }
        
        //登录密码
        let loginPwdBtn = UIButton()
        loginPwdBtn.setTitle("    登录密码", for: .normal)
        loginPwdBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        loginPwdBtn.contentHorizontalAlignment = .left
        loginPwdBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        loginPwdBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        view.addSubview(loginPwdBtn)
        loginPwdBtn.tag = 1
        
        loginPwdBtn.addTarget(self, action: #selector(jumpChangeAction), for: .touchUpInside)
        
        
        loginPwdBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(phoneBtn.snp.bottom).offset(scale(0.5))
            make.height.equalTo(scale(48))
        }
        
        loginPwdBtn.addSubview(loginPwdLabel)
        loginPwdLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(48))
            make.left.equalTo(scale(80))
            make.height.equalTo(scale(21))
        }
        
        let loginPwdRight = UIImageView()
        loginPwdRight.image = UIImage(named: "Frame-my-right")
        loginPwdBtn.addSubview(loginPwdRight)
        
        loginPwdRight.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
        }
        
        
        
        //支付密码
        let payPwdBtn = UIButton()
        payPwdBtn.setTitle("    支付密码", for: .normal)
        payPwdBtn.contentHorizontalAlignment = .left
        payPwdBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        payPwdBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        payPwdBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        view.addSubview(payPwdBtn)
        payPwdBtn.tag = 2
        payPwdBtn.addTarget(self, action: #selector(jumpChangeAction), for: .touchUpInside)
        payPwdBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(loginPwdBtn.snp.bottom).offset(scale(0.5))
            make.height.equalTo(scale(48))
        }
        
        payPwdBtn.addSubview(payPwdLabel)
        payPwdLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(48))
            make.left.equalTo(scale(80))
            make.height.equalTo(scale(21))
        }
        
        let payPwdRight = UIImageView()
        payPwdRight.image = UIImage(named: "Frame-my-right")
        payPwdBtn.addSubview(payPwdRight)
        
        payPwdRight.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
        }
        
        
        
        //实名认证
        let realBtn = UIButton()
        realBtn.setTitle("    实名认证", for: .normal)
        realBtn.contentHorizontalAlignment = .left
        realBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        realBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        realBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        view.addSubview(realBtn)
        realBtn.tag = 3
        realBtn.addTarget(self, action: #selector(jumpChangeAction), for: .touchUpInside)
        realBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(payPwdBtn.snp.bottom).offset(scale(0.5))
            make.height.equalTo(scale(48))
        }
        
        realBtn.addSubview(realAuthenLabel)
        realAuthenLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(48))
            make.left.equalTo(scale(80))
            make.height.equalTo(scale(21))
        }
        
        let  realRight = UIImageView()
        realRight.image = UIImage(named: "Frame-my-right")
        realBtn.addSubview(realRight)
        realRight.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
        }
        
     
    }
    
    
    
    @objc func jumpChangeAction(btn:UIButton){
        LXFLog("=================\(btn.tag)")
        if btn.tag == 0{
            let changeBindPhoneVc = ChangeBindPhoneViewController()
            Coordinator.shared?.pushViewController(self, changeBindPhoneVc, animated: true)
        }else if btn.tag == 2{
            let changePayPasswordVc = ChangePayPasswordViewController()
            Coordinator.shared?.pushViewController(self, changePayPasswordVc, animated: true)
        }
    }
    
    
    
}


