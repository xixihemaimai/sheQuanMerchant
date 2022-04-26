//
//  StartPageViewController.swift
//  xieyi
//
//  Created by mac on 2022/4/14.
//

import UIKit
import Util
import JFPopup

open class StartPageViewController: BaseViewController {

    //轮播图
//    var banner:bannerView = bannerView()
    lazy var bannerImageView:UIImageView = {
       let bannerImageView = UIImageView()
        bannerImageView.image = UIImage(named: "1 1361598361")
        return bannerImageView
    }()
    
    //0元开店按键
    lazy var zernOpen:UIButton = {
       let zernOpen = UIButton()
        zernOpen.setTitle("0元开店", for: .normal)
        zernOpen.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        zernOpen.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor:"#313336")
        zernOpen.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return zernOpen
    }()
    //登录
    lazy var loginBtn:UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor:"#333333 "), for: .normal)
        loginBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor:"#333333"), for: .selected)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return loginBtn
    }()
    
    
    lazy var agreeBtn:UIButton = {
       let agreenBtn = UIButton()
        agreenBtn.setBackgroundImage(UIImage(named: ""), for: .normal)
        agreenBtn.setBackgroundImage(UIImage(named: "Group 2770"), for: .selected)
        return agreenBtn
    }()
    
    
    lazy var agreeLabel:UILabel = {
       let agreeLabel = UILabel()
        agreeLabel.text = "已阅读并同意"
        agreeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        agreeLabel.textAlignment = .left
        agreeLabel.font = UIFont.systemFont(ofSize: scale(12))
        return agreeLabel
    }()
    
    
    //用户协议
    lazy var userAgreementBtn:UIButton = {
       let userAgreenMentBtn = UIButton()
        userAgreenMentBtn.setTitle("用户协议", for: .normal)
        userAgreenMentBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        userAgreenMentBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(12))
        userAgreenMentBtn.contentHorizontalAlignment = .left
        return userAgreenMentBtn
    }()
    
    //和
    lazy var andLabel:UILabel = {
       let agreeLabel = UILabel()
        agreeLabel.text = "和"
        agreeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        agreeLabel.textAlignment = .left
        agreeLabel.font = UIFont.systemFont(ofSize: scale(12))
        return agreeLabel
    }()
    
    
    
    //隐私政策
    lazy var privacyPolicytBtn:UIButton = {
       let privacyPolicytBtn = UIButton()
        privacyPolicytBtn.setTitle("隐私政策", for: .normal)
        privacyPolicytBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        privacyPolicytBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(12))
        privacyPolicytBtn.contentHorizontalAlignment = .left
        return privacyPolicytBtn
    }()
    
    
   public override func viewDidLoad() {
        super.viewDidLoad()
 
        view.addSubview(bannerImageView)
        bannerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view).offset(scale(107))
            make.width.height.equalTo(scale(232))
        }
        
        view.addSubview(zernOpen)
        view.addSubview(loginBtn)
        
        zernOpen.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bannerImageView.snp.bottom).offset(scale(79))
            make.width.equalTo(scale(286))
            make.height.equalTo(scale(44))
        }
        
        zernOpen.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        zernOpen.layer.cornerRadius = scale(4)
        
        
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(zernOpen.snp.bottom).offset(scale(16))
            make.width.equalTo(scale(286))
            make.height.equalTo(scale(44))
        }
        
        loginBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C6C6C6").cgColor
        loginBtn.layer.borderWidth = scale(1)
        loginBtn.layer.cornerRadius = scale(4)
        loginBtn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
       
       view.addSubview(agreeBtn)
       agreeBtn.snp.makeConstraints { make in
           make.left.equalTo(scale(52))
           make.top.equalTo(loginBtn.snp.bottom).offset(scale(23))
           make.width.height.equalTo(scale(10))
       }
       
       agreeBtn.addTarget(self, action: #selector(agreeReadAction), for: .touchUpInside)
       
       
       print(agreeLabel.text!.rectWidth(font: UIFont.systemFont(ofSize: scale(12)), size: CGSize(width:CGFloat(MAXFLOAT), height: scale(17))))
       
       view.addSubview(agreeLabel)
       agreeLabel.snp.makeConstraints { make in
           make.left.equalTo(agreeBtn.snp.right).offset(scale(5))
           make.top.equalTo(loginBtn.snp.bottom).offset(scale(20))
           make.height.equalTo(scale(17))
           make.width.equalTo(scale(80))
       }
       
       view.addSubview(userAgreementBtn)
       userAgreementBtn.snp.makeConstraints { make in
           make.left.equalTo(agreeLabel.snp.right)
           make.top.equalTo(loginBtn.snp.bottom).offset(scale(20))
           make.height.equalTo(scale(17))
           make.width.equalTo(scale(50))
       }
       
       view.addSubview(andLabel)
       andLabel.snp.makeConstraints { make in
           make.left.equalTo(userAgreementBtn.snp.right)
           make.top.equalTo(loginBtn.snp.bottom).offset(scale(20))
           make.height.equalTo(scale(17))
           make.width.equalTo(scale(15))
       }
       
       view.addSubview(privacyPolicytBtn)
       privacyPolicytBtn.snp.makeConstraints { make in
           make.left.equalTo(andLabel.snp.right)
           make.top.equalTo(loginBtn.snp.bottom).offset(scale(20))
           make.height.equalTo(scale(17))
           make.width.equalTo(scale(50))
       }
    }
    
    //注册
    @objc public func registerAction(zernBtn:UIButton){
//        if agreeBtn.isSelected {
            let registerVc = RegisterViewController()
            Coordinator.shared?.pushViewController(self, registerVc, animated: true)
//        }else{
//            JFPopup.toast(hit: "请阅读并勾选下方协议")
//        }
    }
    
    //登录
    @objc public func loginAction(loginBtn:UIButton){
//        if agreeBtn.isSelected{
            let loginVc = LoginViewController()
            Coordinator.shared?.pushViewController(self, loginVc, animated: true)
//        }else{
//            JFPopup.toast(hit: "请阅读并勾选下方协议")
//        }
    }
    
    
    //是否已阅读
    @objc func agreeReadAction(agreenBtn:UIButton){
        agreenBtn.isSelected = !agreenBtn.isSelected
    }
    
    
}



