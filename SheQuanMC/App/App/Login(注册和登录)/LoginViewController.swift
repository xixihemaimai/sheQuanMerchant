//
//  LoginViewController.swift
//  App
//
//  Created by mac on 2022/4/24.
//

import UIKit
import Util
import JFPopup
import SwiftyJSON


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
        accountLabel.text = "+86v"
        accountLabel.textAlignment = .left
        accountLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .semibold)
        accountLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return accountLabel
    }()
    
    //输入框
    lazy var accountTextField:UITextField = {
       let accountTextField = UITextField()
        accountTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        accountTextField.placeholder = "请输入手机号"
        accountTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
//        accountTextField.keyboardType = .phonePad
        accountTextField.clearButtonMode = .whileEditing
        accountTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入手机号", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        accountTextField.addTarget(self, action: #selector(accountTextFieldInput), for: .editingChanged)
        return accountTextField
    }()
    
    //分割线
    lazy var accountDiviver:UIView = {
       let accountDiviver = UIView()
        accountDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#CBCBCB")
        return accountDiviver
    }()
    
    //密码
    lazy var passwordLabel:UILabel = {
       let passwordLabel = UILabel()
        passwordLabel.text = "密码"
        passwordLabel.textAlignment = .left
        passwordLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .semibold)
        passwordLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        passwordLabel.isHidden = true
        return passwordLabel
    }()
    
    
    //输入框
    lazy var passwordTextField:UITextField = {
       let passwordTextField = UITextField()
        passwordTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        passwordTextField.placeholder = "请输入验证码"
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        passwordTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入验证码", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        passwordTextField.addTarget(self, action: #selector(accountTextFieldInput), for: .editingChanged)
        return passwordTextField
    }()
    
    //显示密码还是隐藏密码 或者是获取验证码
    lazy var showPasswordBtn:UIButton = {
       let showPasswordBtn = UIButton()
//        showPasswordBtn.setImage(UIImage(named: "隐藏"), for: .normal)
        showPasswordBtn.setTitle("获取验证码", for: .normal)
        showPasswordBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        showPasswordBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
//        showPasswordBtn.isHidden = true
        //有图片和验证码文字
        return showPasswordBtn
    }()
    
    //密码分割线
    lazy var passwordDiviver:UIView = {
       let passwordDiviver = UIView()
        passwordDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#CBCBCB")
        return passwordDiviver
    }()
    
    //登录
    lazy var loginBtn:UIButton = {
       let loginBtn = UIButton()
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        loginBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        loginBtn.isEnabled = false
        return loginBtn
    }()
    
    //验证码登录
    lazy var codeLoginBtn:UIButton = {
       let codeLoginBtn = UIButton()
        codeLoginBtn.setTitle("密码登录", for: .normal)
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
        forgetPasswordLoginBtn.isHidden = true
        return forgetPasswordLoginBtn
    }()
    
    
    
    //显示错误
//    lazy var showErrerLabel:UILabel = {
//       let showErrerLabel = UILabel()
//        return showErrerLabel
//    }()
    
    
    //验证码返回的verifyId的值
    var verifyId:String = ""
    
    
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
        
        
//        passwordTextField.snp.makeConstraints { make in
//            make.left.equalTo(passwordLabel.snp.right).offset(scale(10))
//            make.right.equalTo(-scale(30))
//            make.top.equalTo(accountDiviver.snp.bottom).offset(scale(26))
//            make.height.equalTo(scale(20))
//        }
        
        passwordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(scale(30))
            make.top.equalTo(accountDiviver.snp.bottom).offset(scale(26))
            make.right.equalTo(-scale(130))
        }
        
//        showPasswordBtn.snp.makeConstraints { make in
//            make.top.equalTo(accountDiviver.snp.bottom).offset(scale(26))
//            make.right.equalTo(-scale(30))
//            make.height.width.equalTo(scale(20))
//        }
        
        showPasswordBtn.snp.makeConstraints({ make in
            make.width.equalTo(scale(100))
            make.right.equalTo(-scale(30))
            make.top.equalTo(accountDiviver.snp.bottom).offset(scale(26))
        })
        
        showPasswordBtn.addTarget(self, action: #selector(hideAndSendCodeAction), for: .touchUpInside)
        
        
        passwordDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(passwordLabel.snp.bottom).offset(scale(10))
        }
        
        //显示错误信息
//        view.addSubview(showErrerLabel)
//        showErrerLabel.snp.makeConstraints { make in
//            make.left.equalTo(scale(30))
//            make.right.equalTo(-scale(30))
//            make.top.equalTo(passwordDiviver.snp.bottom).offset(scale(12))
//            make.height.equalTo(scale(20))
//        }
        
        //登录
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(passwordDiviver.snp.bottom).offset(scale(77))
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
                make.right.equalTo(-scale(130))
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
            
            accountTextField.keyboardType = .phonePad
            
        }else{
            
            passwordTextField.snp.remakeConstraints { make in
                make.left.equalTo(passwordLabel.snp.right).offset(scale(10))
                make.top.equalTo(accountDiviver.snp.bottom).offset(scale(26))
                make.right.equalTo(-scale(50))
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
            
            accountTextField.keyboardType = .default
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
        let forgetPasswordVc = ForgetPasswordViewController()
        Coordinator.shared?.pushViewController(self, forgetPasswordVc, animated: true)
    }
    
    
    //隐藏和显示密码  发送验证码
    @objc func hideAndSendCodeAction(btn:UIButton){
        
        if btn.currentTitle == "获取验证码"{
            //这边要做得事情要先判断手机号是否正确
            if !(accountTextField.text?.isValidMobile ?? true){
                JFPopup.toast(hit: "手机号码错误")
            }else{
                //这边是正确获取验证码的步骤
//                JFPopup.toast(hit: "发送验证码成功")
                CountDown.countDown(60, btn: btn)
                //网络请求并发送发送短信
                let parameters = ["captchaType":2,"mobile":accountTextField.text ?? ""] as [String : Any]
                NetWorkResultRequest(LoginApi.phoneCode(parameters: parameters), needShowFailAlert: true) {result,data in
                    do{
                        LXFLog(data)
                        let json = try JSON(data: data)
                        self.verifyId = json["data"]["verifyId"].string ?? ""
                    }catch{}
                } failureCallback: { error,code in
                    self.verifyId = ""
                }
            }
        }else{
           //显示和展示密码
            btn.isSelected = !btn.isSelected
            //这边还需要对这个按键的图片进行设置
            if btn.isSelected{
                //这边看不到
                showPasswordBtn.setImage(UIImage(named: "Group 2785"), for: .normal)
            }else{
                showPasswordBtn.setImage(UIImage(named: "隐藏"), for: .normal)
            }
            passwordTextField.isSecureTextEntry = btn.isSelected
        }
    }
    
    
    //登录APP
    @objc func loginAppAction(btn:UIButton){
        //这边要判读很多东西
        if codeLoginBtn.currentTitle == "验证码登录"{
            //账号和密码登录
            //密码是否满足有数字和必须有字母的配合才能使用
            if(accountTextField.text?.count ?? 0) < 1{
                JFPopup.toast(hit: "账号错误")
                return
            }
            if !(passwordTextField.text?.isPassword ?? true){
                JFPopup.toast(hit: "密码错误，6-16位字母数字组合")
                return
            }
            
            JFPopupView.popup.loading()
            //这边是网络请求
            let parameters = ["loginPass":passwordTextField.text ?? "","mobile":accountTextField.text ?? ""] as [String : String]
            NetWorkResultRequest(LoginApi.passwordLogin(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
//                do{
//                    let json = try JSON(data: data)
                    StoreService.shared.delete() //这个不知道需不需要删除
                    guard let model = try? JSONDecoder().decode(GenericResponse<StoreInfoModel>.self, from: data) else{
                        return
                    }
                
                LXFLog(model)
//                    if let data = model.data {
////                        StoreService.shared.delete()
//                        StoreService.shared.updateShopInfo(data)
//                    }
//                    if json["data"]["auditStatus"].int32 == 2{
//                        let window = UIApplication.shared.keyWindow
//                        window?.rootViewController = MainViewController()
//                    }else if json["data"]["auditStatus"].int32 == 1{
//                        //审核中
//                        let enterPriseVc = EnterpriseAuditViewController()
//                        enterPriseVc.audit = 1
//                        Coordinator.shared?.pushViewController(self, enterPriseVc, animated: true)
//                    }else if json["data"]["auditStatus"].int32 == 3{
//                        //审核失败
//                        let enterPriseVc = EnterpriseAuditViewController()
//                        enterPriseVc.audit = 2
//                        Coordinator.shared?.pushViewController(self, enterPriseVc, animated: true)
//                    }else{
//                        let storeOccupancyVC = StoreOccupancyViewController()
//                        storeOccupancyVC.audit = 0
//                        Coordinator.shared?.pushViewController(self, storeOccupancyVC, animated: true)
//                    }
                    
                    guard let neWData = model.data else {
                        return
                    }
                    StoreService.shared.updateShopInfo(neWData)
                    if neWData.auditStatus == 2{
                        let window = UIApplication.shared.keyWindow
                        window?.rootViewController = MainViewController()
                    }else if neWData.auditStatus == 1{
                        //审核中
                        let enterPriseVc = EnterpriseAuditViewController()
                        enterPriseVc.audit = 1
//                        self.window?.rootViewController = BaseNaviViewController(rootViewController: enterPriseVc)
                        Coordinator.shared?.pushViewController(self!, enterPriseVc, animated: false)
                        
                        self?.removeNavigationController()
                        
                        
                    }else if neWData.auditStatus == 3{
                        //审核失败
                        let enterPriseVc = EnterpriseAuditViewController()
                        enterPriseVc.audit = 2
//                        self.window?.rootViewController = BaseNaviViewController(rootViewController: enterPriseVc)
                        Coordinator.shared?.pushViewController(self!, enterPriseVc, animated: false)
                        
                        self?.removeNavigationController()
                        
                    }else{
                        let storeOccupancyVC = StoreOccupancyViewController()
                        storeOccupancyVC.audit = 0
//                        let navi = BaseNaviViewController(rootViewController: storeOccupancyVC)
//                        self.window?.rootViewController = navi
                        Coordinator.shared?.pushViewController(self!, storeOccupancyVC, animated: true)
                        self?.removeNavigationController()
                    }
                
                //获取企业信息
                NetWorkResultRequest(StoreAppleApi.getEntInfo, needShowFailAlert: true) { result, data in
                    guard let model = try? JSONDecoder().decode(GenericResponse<StoreInfoModel>.self, from: data) else{
                        return
                    }
                    guard let neWData = model.data else {
                        return
                    }
                    StoreService.shared.updateShopInfo(neWData)
//                    LXFLog(StoreService.shared.currentUser)
                } failureCallback: { error, code in
                }
//                }catch{}
                JFPopupView.popup.hideLoading()
            } failureCallback: { error,code in
//                LXFLog("错误")
                JFPopupView.popup.hideLoading()
//                JFPopup.toast(hit: "登录失败", icon: .fail)
            }
        }else{
            //验证码登录
            //手机号和验证码
            if !(accountTextField.text?.isValidMobile ?? true){
                JFPopup.toast(hit: "手机号错误")
                return
            }
            if (passwordTextField.text?.count ?? 0) < 1 {
                JFPopup.toast(hit: "验证码错误")
                return
            }

            JFPopupView.popup.loading()
            //这边是网络请求
            let parameters = ["countryId":0,"mobile":accountTextField.text ?? "","verifyCode":passwordTextField.text ?? "","verifyId":verifyId] as [String : Any]
            NetWorkResultRequest(LoginApi.phonelogin(parameters: parameters), needShowFailAlert: true) {[weak self] resutl, data in
//                do{
//                    let json = try JSON(data: data)
                    StoreService.shared.delete() //这个不知道需不需要删除
                    guard let model = try? JSONDecoder().decode(GenericResponse<StoreInfoModel>.self, from: data) else{
                        return
                    }
                  LXFLog(model)
//                    if let data = model.data {
////                        StoreService.shared.delete()
//                        StoreService.shared.updateShopInfo(data)
//                    }
//                    //这里有个token值需要拿到
//                    if json["data"]["auditStatus"].int32 == 2{
//                        let window = UIApplication.shared.keyWindow
//                        window?.rootViewController = MainViewController()
//                    }else if json["data"]["auditStatus"].int32 == 1{
//                        //审核中
//                        let enterPriseVc = EnterpriseAuditViewController()
//                        enterPriseVc.audit = 1
//                        Coordinator.shared?.pushViewController(self, enterPriseVc, animated: true)
//                    }else if json["data"]["auditStatus"].int32 == 3{
//                        //审核失败
//                        let enterPriseVc = EnterpriseAuditViewController()
//                        enterPriseVc.audit = 2
//                        Coordinator.shared?.pushViewController(self, enterPriseVc, animated: true)
//                    }else{
//                        let storeOccupancyVC = StoreOccupancyViewController()
//                        storeOccupancyVC.audit = 0
//                        Coordinator.shared?.pushViewController(self, storeOccupancyVC, animated: true)
//                    }
                    
                    guard let neWData = model.data else {
                        return
                    }
                    StoreService.shared.updateShopInfo(neWData)
                    LXFLog(neWData.auditStatus)
                    if neWData.auditStatus == 2{
                        let window = UIApplication.shared.keyWindow
                        window?.rootViewController = MainViewController()
                    }else if neWData.auditStatus == 1{
                        //审核中
                        let enterPriseVc = EnterpriseAuditViewController()
                        enterPriseVc.audit = 1
//                        self.window?.rootViewController = BaseNaviViewController(rootViewController: enterPriseVc)
                        Coordinator.shared?.pushViewController(self!, enterPriseVc, animated: false)
                        self?.removeNavigationController()
                        
                    }else if neWData.auditStatus == 3{
                        //审核失败
                        let enterPriseVc = EnterpriseAuditViewController()
                        enterPriseVc.audit = 2
//                        self.window?.rootViewController = BaseNaviViewController(rootViewController: enterPriseVc)
                        Coordinator.shared?.pushViewController(self!, enterPriseVc, animated: false)
                        
                        self?.removeNavigationController()
                       
                        
                    }else{
                        let storeOccupancyVC = StoreOccupancyViewController()
                        storeOccupancyVC.audit = 0
//                        let navi = BaseNaviViewController(rootViewController: storeOccupancyVC)
//                        self.window?.rootViewController = navi
                        Coordinator.shared?.pushViewController(self!, storeOccupancyVC, animated: true)
                        
                        self?.removeNavigationController()
                        
                    }
                
                
                //获取企业信息
                NetWorkResultRequest(StoreAppleApi.getEntInfo, needShowFailAlert: true) { result, data in
                    guard let model = try? JSONDecoder().decode(GenericResponse<StoreInfoModel>.self, from: data) else{
                        return
                    }
                        
                    guard let neWData = model.data else {
                        return
                    }
                    StoreService.shared.updateShopInfo(neWData)
                } failureCallback: { error, code in
                }
//                }catch{}
                JFPopupView.popup.hideLoading()
            } failureCallback: { error,code in
                JFPopupView.popup.hideLoading()
//                JFPopup.toast(hit: "登录失败", icon: .fail)
            }
      }
    }
    
    //删除当前的控制器
    func removeNavigationController(){
        let mutableArr = NSMutableArray(array:navigationController?.viewControllers ?? [])
        for i in 0..<mutableArr.count {
            let vc = mutableArr[i] as! UIViewController
            if vc.isKind(of: LoginViewController.self){
                mutableArr.removeObject(at: i)
                break
            }
        }
        navigationController?.viewControllers = mutableArr as! [UIViewController]
    }
    
    
    
    
    @objc func accountTextFieldInput(textField:UITextField){
        if codeLoginBtn.currentTitle == "验证码登录"{
            if (textField.text?.count ?? 0) > 0{
                LXFLog(textField.text?.count ?? 0)
                loginBtn.isEnabled = true
                loginBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            }else{
                loginBtn.isEnabled = false
                loginBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E1E1E1")
            }
        }
    }
    
    
}

