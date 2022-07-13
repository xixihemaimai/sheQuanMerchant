//
//  ForgetPasswordViewController.swift
//  App
//
//  Created by mac on 2022/4/26.
//

import UIKit
import Util
import JFPopup
import SwiftyJSON

class ForgetPasswordViewController: BaseViewController {

    
    //账号
//    lazy var phoneLabel:UILabel = {
//       let phoneLabel = UILabel()
//        phoneLabel.text = "+86v"
//        phoneLabel.textAlignment = .left
//        phoneLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .semibold)
//        phoneLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
//        return phoneLabel
//    }()
    
    
    lazy var accountImage:UIImageView = {
       let accountImage = UIImageView()
        accountImage.image = UIImage(named: "86")
        return accountImage
    }()
    
    
    //输入框
    lazy var phoneTextField:UITextField = {
       let phoneTextField = UITextField()
        phoneTextField.keyboardType = .phonePad
        phoneTextField.clearButtonMode = .whileEditing
        phoneTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        phoneTextField.placeholder = "请输入手机号"
        phoneTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入手机号", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        phoneTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        phoneTextField.delegate = self
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
        codeTextField.keyboardType = .numberPad
        codeTextField.clearButtonMode = .whileEditing
        codeTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        codeTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入验证码", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        codeTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        codeTextField.delegate = self
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
    
    
    //下一步
    lazy var nextBtn:UIButton = {
       let nextBtn = UIButton()
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        nextBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return nextBtn
    }()
    
    
    
    //验证码返回的verifyId的值
    var verifyId:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        self.title = "忘记密码"
 
        //电话号码
//        view.addSubview(phoneLabel)
        view.addSubview(accountImage)
        view.addSubview(phoneTextField)
        view.addSubview(phoneDiviver)
        
        accountImage.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.top.equalTo(scale(65))
            make.width.equalTo(scale(scale(34)))
            make.height.equalTo(scale(scale(11)))
        }
        
//        phoneLabel.snp.makeConstraints { make in
//            make.left.equalTo(scale(30))
//            make.top.equalTo(scale(60))
//            make.width.equalTo(scale(scale(40)))
//            make.height.equalTo(scale(scale(20)))
//        }
        
        phoneTextField.snp.makeConstraints { make in
            make.left.equalTo(accountImage.snp.right).offset(scale(10))
            make.right.equalTo(-scale(30))
            make.top.equalTo(scale(60))
            make.height.equalTo(scale(20))
        }
        
        phoneDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(accountImage.snp.bottom).offset(scale(10))
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
        
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.top.equalTo(codeDiviver.snp.bottom).offset(scale(56))
            make.height.equalTo(scale(40))
        }
        nextBtn.layer.cornerRadius = scale(4)
        nextBtn.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        
    }
    
    
    //获取验证码
    @objc func redCodeAction(reCodeBtn:UIButton){
        if !(phoneTextField.text?.isValidMobile ?? true){
            JFPopup.toast(hit: "手机号码错误")
        }else{
            //这边是正确获取验证码的步骤
            CountDown.countDown(60, btn: reCodeBtn)
            //网络请求并发送发送短信
//            JFPopup.toast(hit: "发送验证码成功")
            let parameters = ["captchaType":3,"mobile":phoneTextField.text ?? ""] as [String : Any]
            NetWorkResultRequest(LoginApi.phoneCode(parameters: parameters), needShowFailAlert: true) {result, data in
                do{
                    LXFLog(data)
                    let json = try JSON(data: data)
                    self.verifyId = json["data"]["verifyId"].string ?? ""
//                    LXFLog("----------\(self.verifyId)")
                }catch{}
              
            } failureCallback: { error,code in
                self.verifyId = ""
            }
        }
    }
    
    
    //下一步
    @objc func nextAction(btn:UIButton){
        if !(phoneTextField.text?.isValidMobile ?? true){
            JFPopup.toast(hit: "请输入正确的手机号")
           return
        }

        if (codeTextField.text?.count ?? 0) < 1{
            JFPopup.toast(hit: "验证码错误")
            return
        }
        let parameters = ["countryId":0,"mobile":phoneTextField.text ?? "","verifyCode":codeTextField.text ?? "","verifyId":verifyId] as [String:Any]
        NetWorkResultRequest(shopApi.forgetPass(parameters: parameters), needShowFailAlert: true) { result, data in
//            LXFLog(data)
            let newPasswordVc = NewPasswordViewController()
            newPasswordVc.verifyId = self.verifyId
            Coordinator.shared?.pushViewController(self, newPasswordVc, animated: true)
            
            
            
            
            
            
        } failureCallback: { error,code in
        }
    }
    
}


extension ForgetPasswordViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            var maxNum = 11
        if textField ==  phoneTextField{
            maxNum = 11
        }else if textField == codeTextField{
            maxNum = 6
        }
//        限制个数
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= maxNum
    }
    
}
