//
//  LoginViewController.swift
//  App
//
//  Created by mac on 2022/4/24.
//

import UIKit
import Util
import JFPopup


class LoginViewController: BaseViewController {

   
    //这边图片
    lazy var shopSheQuanImage:UIImageView = {
        let shopSheQuanImage = UIImageView()
        shopSheQuanImage.image = UIImage(named: "奢圈 1")
        return shopSheQuanImage
    }()
    
    //商户版
    lazy var shopLabel:UILabel = {
       let shopLabel = UILabel()
        shopLabel.text = "商户版"
        shopLabel.textAlignment = .center
        shopLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        shopLabel.font = UIFont.systemFont(ofSize: scale(18), weight: .semibold)
        return shopLabel
    }()
    
    //账号
    lazy var accountLabel:UILabel = {
       let accountLabel = UILabel()
        accountLabel.text = "账号"
        accountLabel.textAlignment = .left
        accountLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .semibold)
        accountLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return accountLabel
    }()
    
    //输入框
    lazy var accountTextField:UITextField = {
       let accountTextField = UITextField()
        accountTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        accountTextField.placeholder = "请输入账号（手机号）"
        return accountTextField
    }()
    
    //分割线
    lazy var accountDiviver:UIView = {
       let accountDiviver = UIView()
        accountDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#CBCBCB ")
        return accountDiviver
    }()
    
    //密码
    lazy var passwordLabel:UILabel = {
       let passwordLabel = UILabel()
        passwordLabel.text = "密码"
        passwordLabel.textAlignment = .left
        passwordLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .semibold)
        passwordLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return passwordLabel
    }()
    
    
    //输入框
    lazy var passwordTextField:UITextField = {
       let passwordTextField = UITextField()
        passwordTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        passwordTextField.placeholder = "请输入密码"
        return passwordTextField
    }()
    
    //显示密码还是隐藏密码 或者是获取验证码
    lazy var showPasswordBtn:UIButton = {
       let showPasswordBtn = UIButton()
        showPasswordBtn.setImage(UIImage(named: "隐藏"), for: .normal)
        showPasswordBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        showPasswordBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        //有图片和验证码文字
        return showPasswordBtn
    }()
    
    //密码分割线
    lazy var passwordDiviver:UIView = {
       let passwordDiviver = UIView()
        passwordDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#CBCBCB ")
        return passwordDiviver
    }()
    
    //登录
    lazy var loginBtn:UIButton = {
       let loginBtn = UIButton()
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        loginBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E1E1E1")
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        loginBtn.isEnabled = false
        return loginBtn
    }()
    
    //验证码登录
    lazy var codeLoginBtn:UIButton = {
       let codeLoginBtn = UIButton()
        codeLoginBtn.setTitle("验证码登录", for: .normal)
        codeLoginBtn.contentHorizontalAlignment = .left
        codeLoginBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        codeLoginBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return codeLoginBtn
    }()
    
    //忘记密码
    lazy var forgetPasswordLoginBtn:UIButton = {
       let forgetPasswordLoginBtn = UIButton()
        forgetPasswordLoginBtn.contentHorizontalAlignment = .right
        forgetPasswordLoginBtn.setTitle("忘记登录", for: .normal)
        forgetPasswordLoginBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        forgetPasswordLoginBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return forgetPasswordLoginBtn
    }()
    
    
    
    //显示错误
    lazy var showErrerLabel:UILabel = {
       let showErrerLabel = UILabel()
        return showErrerLabel
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        //奢圈商户版
        view.addSubview(shopSheQuanImage)
        view.addSubview(shopLabel)
        
        shopSheQuanImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(Height_NavBar + scale(6))
            make.width.equalTo(scale(77))
            make.height.equalTo(scale(38))
        }
        
        shopLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(shopSheQuanImage.snp.bottom).offset(scale(6))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(scale(25)))
        }
        
        //账号
        view.addSubview(accountLabel)
        view.addSubview(accountTextField)
        view.addSubview(accountDiviver)
        
        accountLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.top.equalTo(shopLabel.snp.bottom).offset(scale(52))
            make.width.equalTo(scale(scale(40)))
            make.height.equalTo(scale(scale(20)))
        }
        
        
        accountTextField.snp.makeConstraints { make in
            make.left.equalTo(accountLabel.snp.right).offset(scale(10))
            make.right.equalTo(-scale(30))
            make.top.equalTo(shopLabel.snp.bottom).offset(scale(52))
            make.height.equalTo(scale(20))
        }
        
        accountDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(accountLabel.snp.bottom).offset(scale(10))
        }
        
        
        //密码或者验证码
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(showPasswordBtn)
        view.addSubview(passwordDiviver)
        
        
        passwordLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.top.equalTo(accountDiviver.snp.bottom).offset(scale(26))
            make.width.equalTo(scale(scale(40)))
            make.height.equalTo(scale(20))
        }
        
        
        passwordTextField.snp.makeConstraints { make in
            make.left.equalTo(passwordLabel.snp.right).offset(scale(10))
            make.right.equalTo(-scale(30))
            make.top.equalTo(accountDiviver.snp.bottom).offset(scale(26))
            make.height.equalTo(scale(20))
        }
        
        
        showPasswordBtn.snp.makeConstraints { make in
            make.top.equalTo(accountDiviver.snp.bottom).offset(scale(26))
            make.right.equalTo(-scale(30))
            make.height.width.equalTo(scale(20))
        }
        
        showPasswordBtn.addTarget(self, action: #selector(hideAndSendCodeAction), for: .touchUpInside)
        
        
        passwordDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(passwordLabel.snp.bottom).offset(scale(10))
        }
        
        //显示错误信息
        view.addSubview(showErrerLabel)
        showErrerLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.top.equalTo(passwordDiviver.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(20))
        }
        
        //登录
        view.addSubview(loginBtn)
        
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(showErrerLabel.snp.bottom).offset(scale(57))
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.height.equalTo(scale(40))
        }
        
        
        loginBtn.layer.cornerRadius = scale(4)
        loginBtn.addTarget(self, action: #selector(loginAppAction), for: .touchUpInside)
        
        
        //验证码登录
        view.addSubview(codeLoginBtn)
        //忘记密码
        view.addSubview(forgetPasswordLoginBtn)
        
        codeLoginBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.top.equalTo(loginBtn.snp.bottom).offset(scale(16))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(20))
        }
        codeLoginBtn.addTarget(self, action: #selector(codeAction), for: .touchUpInside)
        
        
        forgetPasswordLoginBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(30))
            make.top.equalTo(loginBtn.snp.bottom).offset(scale(16))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(20))
        }
        
        
        forgetPasswordLoginBtn.addTarget(self, action: #selector(forgetPasswordLoginBtnAction), for: .touchUpInside)
    }
    
    //验证码登录
    @objc func codeAction(btn:UIButton){
        //这边要变化
        if btn.currentTitle == "验证码登录"{
            btn.setTitle("密码登录", for: .normal)
            forgetPasswordLoginBtn.isHidden = true
            accountLabel.text = "+86v"
            accountTextField.placeholder = "请输入手机号"
            passwordLabel.isHidden = true
            accountTextField.text = ""
            passwordTextField.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(scale(30))
                make.top.equalTo(accountDiviver.snp.bottom).offset(scale(26))
            }
            passwordTextField.text = ""
            showPasswordBtn.setTitle("获取验证码", for: .normal)
            showPasswordBtn.setImage(UIImage(), for: .normal)
            showPasswordBtn.snp.remakeConstraints({ make in
                make.width.equalTo(scale(100))
                make.right.equalTo(-scale(30))
                make.top.equalTo(accountDiviver.snp.bottom).offset(scale(26))
            })
            passwordTextField.placeholder = "请输入验证码"
            loginBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            loginBtn.isEnabled = true
        }else{
            
            passwordTextField.snp.remakeConstraints { make in
                make.left.equalTo(passwordLabel.snp.right).offset(scale(10))
                make.top.equalTo(accountDiviver.snp.bottom).offset(scale(26))
            }
            accountTextField.text = ""
            passwordTextField.text = ""
            showPasswordBtn.setTitle("", for: .normal)
            showPasswordBtn.setImage(UIImage(named: "隐藏"), for: .normal)
            showPasswordBtn.snp.remakeConstraints({ make in
                make.height.width.equalTo(scale(20))
                make.right.equalTo(-scale(30))
                make.top.equalTo(accountDiviver.snp.bottom).offset(scale(26))
            })
            
            passwordTextField.placeholder = "请输入密码"
            passwordLabel.isHidden = false
            accountTextField.placeholder = "请输入账号(手机号)"
            accountLabel.text = "账号"
            forgetPasswordLoginBtn.isHidden = false
            btn.setTitle("验证码登录", for: .normal)
            loginBtn.isEnabled = false
            loginBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E1E1E1")
        }
    }
    
    //忘记密码
    @objc func forgetPasswordLoginBtnAction(btn:UIButton){
        
    }
    
    
    //隐藏和显示密码  发送验证码
    @objc func hideAndSendCodeAction(btn:UIButton){
        if btn.currentTitle == "获取验证码"{
            //这边要做得事情要先判断手机号是否正确
            if !(accountTextField.text?.isValidMobile ?? true){
                JFPopup.toast(hit: "手机号码错误")
            }else{
                //这边是正确获取验证码的步骤
                CountDown.countDown(60, btn: btn)
            }
        }else{
           //显示和展示密码
            btn.isSelected = !btn.isSelected
            passwordTextField.isSecureTextEntry = btn.isSelected
        }
    }
    
    
    //登录APP
    @objc func loginAppAction(btn:UIButton){
        //这边要判读很多东西
        if codeLoginBtn.currentTitle == "验证码登录"{
            //密码登录
            //密码是否满足有数字和必须有字母的配合才能使用
               
        }else{
            //验证码登录
            
               
        }
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = MainViewController()
    }
}
