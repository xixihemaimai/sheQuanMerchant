//
//  ChangePayPasswordViewController.swift
//  App
//
//  Created by mac on 2022/7/5.
//

import UIKit
import Util

class ChangePayPasswordViewController: BaseViewController {

    lazy var phoneTextField:UITextField = {
       let phoneTextField = UITextField()
        phoneTextField.clearButtonMode = .whileEditing
        phoneTextField.keyboardType = .phonePad
        phoneTextField.placeholder = "请填写手机号"
        phoneTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        phoneTextField.font = UIFont.systemFont(ofSize: scale(15), weight: .regular)
        phoneTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入手机号", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        phoneTextField.delegate = self
        return phoneTextField
    }()
    
    
    lazy var codeTextField:UITextField = {
        let codeTextField = UITextField()
        codeTextField.clearButtonMode = .whileEditing
        codeTextField.keyboardType = .numberPad
        codeTextField.placeholder = "请填写验证码"
        codeTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        codeTextField.font = UIFont.systemFont(ofSize: scale(15), weight: .regular)
        codeTextField.attributedPlaceholder = NSAttributedString.init(string:"请填写验证码", attributes: [
             NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        codeTextField.delegate = self
        return codeTextField
    }()
    
    
    
    lazy var newPwdTextField:UITextField = {
       let newPwdTextField = UITextField()
        newPwdTextField.clearButtonMode = .whileEditing
//        codeTextField.keyboardType = .numberPad
        newPwdTextField.placeholder = "请输入支付密码"
        newPwdTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        newPwdTextField.font = UIFont.systemFont(ofSize: scale(15), weight: .regular)
        newPwdTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入支付密码", attributes: [
             NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        newPwdTextField.delegate = self
       return newPwdTextField
    }()
    
    
    lazy var againPwdTextField:UITextField = {
       let againPwdTextField = UITextField()
        againPwdTextField.clearButtonMode = .whileEditing
//        codeTextField.keyboardType = .numberPad
        againPwdTextField.placeholder = "请再次输入支付密码"
        againPwdTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        againPwdTextField.font = UIFont.systemFont(ofSize: scale(15), weight: .regular)
        againPwdTextField.attributedPlaceholder = NSAttributedString.init(string:"请再次输入支付密码", attributes: [
             NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        againPwdTextField.delegate = self
       return againPwdTextField
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "更改支付密码"
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        
        //手机号
        let phoneView = UIView()
        phoneView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(phoneView)
        phoneView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(0.5))
            make.height.equalTo(scale(48))
        }
        
        let phoneNumLabel = UILabel()
        phoneNumLabel.text = "手机号"
        phoneNumLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        phoneNumLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        phoneNumLabel.textAlignment = .left
        phoneView.addSubview(phoneNumLabel)
        
        phoneNumLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(22))
        }
        
        phoneView.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.left.equalTo(phoneNumLabel.snp.right).offset(scale(16))
            make.right.equalTo(-scale(16))
            make.centerY.equalToSuperview()
            make.height.equalTo(scale(22))
        }
        
        
        
        
        //验证码
        let codeView = UIView()
        codeView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(codeView)
        codeView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(phoneView.snp.bottom).offset(scale(0.5))
            make.height.equalTo(scale(48))
        }
        
        let codeNameLabel = UILabel()
        codeNameLabel.text = "验证码"
        codeNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        codeNameLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        codeNameLabel.textAlignment = .left
        codeView.addSubview(codeNameLabel)
        
        codeNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(22))
        }
        
        
        codeView.addSubview(codeTextField)
        codeTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(codeNameLabel.snp.right).offset(scale(16))
            make.height.equalTo(scale(22))
            make.right.equalTo(-scale(118))
        }
        
        let sendCodeBtn = UIButton()
        sendCodeBtn.setTitle("获取验证码", for: .normal)
        sendCodeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        sendCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        codeView.addSubview(sendCodeBtn)
        sendCodeBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.equalTo(scale(102))
            make.height.equalTo(scale(32))
        }
        sendCodeBtn.layer.borderWidth = scale(1)
        sendCodeBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        sendCodeBtn.layer.cornerRadius = scale(4)
        
        //新密码
        let newPwdView = UIView()
        newPwdView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(newPwdView)
        
        newPwdView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(codeView.snp.bottom).offset(scale(0.5))
            make.height.equalTo(scale(48))
        }
        
        let newPwdLabel = UILabel()
        newPwdLabel.text = "新密码"
        newPwdLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        newPwdLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        newPwdLabel.textAlignment = .left
        newPwdView.addSubview(newPwdLabel)
        
        newPwdLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(22))
        }
        
        
        newPwdView.addSubview(newPwdTextField)
        newPwdTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(newPwdLabel.snp.right).offset(scale(16))
            make.right.equalTo(-scale(32))
            make.height.equalTo(scale(21))
        }
        
        let newPwdShopBtn = UIButton()
        newPwdShopBtn.setImage(UIImage(named: "隐藏"), for: .normal)
        newPwdShopBtn.setImage(UIImage(named: "Group 2785"), for: .selected)
        newPwdView.addSubview(newPwdShopBtn)
        
        newPwdShopBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(16))
        }
        
        //确认密码
        let againPwdView = UIView()
        againPwdView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(againPwdView)
        
        againPwdView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(newPwdView.snp.bottom).offset(scale(0.5))
            make.height.equalTo(scale(48))
        }
        
        let againLabel = UILabel()
        againLabel.text = "确认密码"
        againLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        againLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        againLabel.textAlignment = .left
        againPwdView.addSubview(againLabel)
        
        againLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(22))
        }
        
        
        againPwdView.addSubview(againPwdTextField)
        againPwdTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(againLabel.snp.right).offset(scale(16))
            make.right.equalTo(-scale(32))
            make.height.equalTo(scale(21))
        }
        
        let againShopBtn = UIButton()
        againShopBtn.setImage(UIImage(named: "隐藏"), for: .normal)
        againShopBtn.setImage(UIImage(named: "Group 2785"), for: .selected)
        againPwdView.addSubview(againShopBtn)
        
        againShopBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(16))
        }
        
        
        
        
        //底部
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(iPhoneX ? scale(92) : scale(58))
        }
        
        
        let sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        sureBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        bottomView.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        sureBtn.layer.cornerRadius = scale(4)
    }
    

   

}


extension ChangePayPasswordViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxNum = 6
        if textField == phoneTextField {
                maxNum = 11
        }else if textField == newPwdTextField || textField == againPwdTextField{
            maxNum = 18
        }
//        限制个数
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= maxNum
    }
}
