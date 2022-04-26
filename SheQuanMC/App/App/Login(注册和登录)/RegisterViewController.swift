//
//  RegisterViewController.swift
//  App
//
//  Created by mac on 2022/4/26.
//

import UIKit
import Util
import JFPopup

class RegisterViewController: BaseViewController {

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
    lazy var phoneLabel:UILabel = {
       let phoneLabel = UILabel()
        phoneLabel.text = "+86v"
        phoneLabel.textAlignment = .left
        phoneLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .semibold)
        phoneLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return phoneLabel
    }()
    
    //输入框
    lazy var phoneTextField:UITextField = {
       let phoneTextField = UITextField()
        phoneTextField.keyboardType = .phonePad
        phoneTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        phoneTextField.placeholder = "请输入手机号"
        phoneTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        phoneTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入手机号", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        phoneTextField.addTarget(self, action: #selector(textfieldContent), for: .editingChanged)
        return phoneTextField
    }()
    
    //分割线
    lazy var phoneDiviver:UIView = {
       let phoneDiviver = UIView()
        phoneDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#CBCBCB")
        return phoneDiviver
    }()
    
    //验证码
    lazy var codeTextField:UITextField = {
       let codeTextField = UITextField()
        codeTextField.placeholder = "请输入验证码"
        codeTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        codeTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入验证码", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        codeTextField.addTarget(self, action: #selector(textfieldContent), for: .editingChanged)
        codeTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return codeTextField
    }()
    
    //获取验证码按键
    lazy var reCodeBtn:UIButton = {
       let reCodeBtn = UIButton()
        reCodeBtn.setTitle("获取验证码", for: .normal)
        reCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        reCodeBtn.contentHorizontalAlignment = .right
        reCodeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        return reCodeBtn
    }()
  
    //验证码分割线
    lazy var codeDiviver:UIView = {
       let codeDiviver = UIView()
        codeDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#CBCBCB")
        return codeDiviver
    }()

    //输入框
    lazy var passwordTextField:UITextField = {
       let passwordTextField = UITextField()
        passwordTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        passwordTextField.placeholder = "请设置登录密码，6-16位字母数字组合"
        passwordTextField.attributedPlaceholder = NSAttributedString.init(string:"请设置登录密码，6-16位字母数字组合", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(textfieldContent), for: .editingChanged)
        passwordTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return passwordTextField
    }()
    
    //显示密码还是隐藏密码 或者是获取验证码
    lazy var showPasswordBtn:UIButton = {
       let showPasswordBtn = UIButton()
        showPasswordBtn.setImage(UIImage(named: "Frame"), for: .normal)
        showPasswordBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        showPasswordBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        //有图片和验证码文字
        showPasswordBtn.isHidden = true
        return showPasswordBtn
    }()
    
    //密码分割线
    lazy var passwordDiviver:UIView = {
       let passwordDiviver = UIView()
        passwordDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#CBCBCB")
        return passwordDiviver
    }()
    
    
    //显示错误
    lazy var showErrerLabel:UILabel = {
       let showErrerLabel = UILabel()
        showErrerLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F33A2F")
        showErrerLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        showErrerLabel.textAlignment = .left
        return showErrerLabel
    }()
    
    
    //前往开店
    lazy var openShopBtn:UIButton = {
       let openShopBtn = UIButton()
        openShopBtn.setTitle("前往开店", for: .normal)
        openShopBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
//        openShopBtn.setBackGroundColor(color: UIColor.colorWithDyColorChangObject(lightColor: "#313336"), .normal)
        openShopBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        openShopBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return openShopBtn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        //奢圈商户版
        view.addSubview(shopSheQuanImage)
        view.addSubview(shopLabel)
        
        shopSheQuanImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scale(6))
            make.width.equalTo(scale(77))
            make.height.equalTo(scale(38))
        }
        
        shopLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(shopSheQuanImage.snp.bottom).offset(scale(6))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(scale(25)))
        }
        
        //电话号码
        view.addSubview(phoneLabel)
        view.addSubview(phoneTextField)
        view.addSubview(phoneDiviver)
        
        phoneLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.top.equalTo(shopLabel.snp.bottom).offset(scale(52))
            make.width.equalTo(scale(scale(40)))
            make.height.equalTo(scale(scale(20)))
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.left.equalTo(phoneLabel.snp.right).offset(scale(10))
            make.right.equalTo(-scale(30))
            make.top.equalTo(shopLabel.snp.bottom).offset(scale(52))
            make.height.equalTo(scale(20))
        }
        
        phoneDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(phoneLabel.snp.bottom).offset(scale(10))
        }
        
        //验证码
        view.addSubview(codeTextField)
        view.addSubview(reCodeBtn)
        view.addSubview(codeDiviver)
        
        codeTextField.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.top.equalTo(phoneDiviver.snp.bottom).offset(scale(26))
            make.width.equalTo(scale(scale(200)))
            make.height.equalTo(scale(20))
        }
        
        
        reCodeBtn.snp.makeConstraints { make in
            make.left.equalTo(codeTextField.snp.right).offset(scale(10))
            make.right.equalTo(-scale(30))
            make.top.equalTo(phoneDiviver.snp.bottom).offset(scale(26))
            make.height.equalTo(scale(20))
        }
        reCodeBtn.addTarget(self, action: #selector(redCodeAction), for: .touchUpInside)
        
        
        codeDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(codeTextField.snp.bottom).offset(scale(10))
        }
        
        
        //密码
        view.addSubview(passwordTextField)
        view.addSubview(showPasswordBtn)
        view.addSubview(passwordDiviver)
        
        passwordTextField.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.top.equalTo(codeDiviver.snp.bottom).offset(scale(34))
            make.width.equalTo(scale(scale(300)))
            make.height.equalTo(scale(20))
        }
        
        showPasswordBtn.snp.makeConstraints { make in
            make.top.equalTo(codeDiviver.snp.bottom).offset(scale(34))
            make.right.equalTo(-scale(30))
            make.width.height.equalTo(scale(16))
        }
        
        showPasswordBtn.addTarget(self, action: #selector(clearPasswordContentAction), for: .touchUpInside)
        
        passwordDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(passwordTextField.snp.bottom).offset(scale(10))
        }
        
        
        //显示错误信息
        view.addSubview(showErrerLabel)
        showErrerLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.top.equalTo(passwordDiviver.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(20))
        }
        
        
        //按键（前往开店）
        view.addSubview(openShopBtn)
        openShopBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.height.equalTo(scale(40))
            make.top.equalTo(showErrerLabel.snp.bottom).offset(scale(34))
        }
        
        openShopBtn.layer.cornerRadius = scale(4)
        openShopBtn.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        
    }
    
    
    //获取验证码
    @objc func redCodeAction(reCodeBtn:UIButton){
        if !(phoneTextField.text?.isValidMobile ?? true){
            JFPopup.toast(hit: "手机号码错误")
        }else{
            //这边是正确获取验证码的步骤
            CountDown.countDown(60, btn: reCodeBtn)
            //网络请求并发送发送短信
            
        }
    }
    
    //监听手机号，验证码，密码
    @objc func textfieldContent(textfield:UITextField){
        if textfield === phoneTextField{
            //电话号码
            LXFLog("===1=========\(phoneTextField.text)")
        }else if textfield === codeTextField{
            //验证码
            LXFLog("===2=========\(codeTextField.text)")
        }else{
            //密码
            //密码这边需要对隐藏的显示
            LXFLog("===3=========\(passwordTextField.text)")
            if (passwordTextField.text?.count ?? 0) > 0{
                showPasswordBtn.isHidden = false
            }else{
                showPasswordBtn.isHidden = true
            }
        }
    }
    
    //清除密码输入的值
    @objc func clearPasswordContentAction(btn:UIButton){
        passwordTextField.text = ""
        btn.isHidden = true
    }
    
    //注册（开店）
    @objc func registerAction(openShopBtn:UIButton){
        
        //showErrerLabel
        //密码错误 手机号 验证码
        
//        if !(phoneTextField.text?.isValidMobile ?? true){
//            showErrerLabel.text = "请输入正确的手机号"
//            return
//        }
//
//        if !(passwordTextField.text?.isPassword ?? true){
//            showErrerLabel.text = "请设置登录密码，6-16位字母数字组合"
//            return
//        }
//
//        if (codeTextField.text?.count ?? 0) < 1{
//            showErrerLabel.text = "验证码错误"
//            return
//        }
        
        //网络请求有登录成功和该手机号已被注册
//        JFPopup.toast(hit: "注册成功")
        self.popup.alert {
            [.title("该手机号已被注册"),
             .cancelAction([
                .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999")),
                .text("取消"),
                .tapActionCallback({
                })
              ]),
             .confirmAction([
                .text("前往登录"),
                .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                .tapActionCallback({
                    let login = LoginViewController()
                    Coordinator.shared?.pushViewController(self, login, animated: true)
                })
              ])
            ]
        }
    }
}
