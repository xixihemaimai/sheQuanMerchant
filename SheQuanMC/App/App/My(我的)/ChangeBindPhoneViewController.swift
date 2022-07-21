//
//  ChangeBindPhoneViewController.swift
//  App
//
//  Created by mac on 2022/7/5.
//

import UIKit
import Util
import JFPopup

class ChangeBindPhoneViewController: BaseViewController {

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
    
    
    lazy var phoneLabel:UILabel = {
       let phoneLabel = UILabel()
        phoneLabel.text = "原手机号"
        phoneLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        phoneLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        phoneLabel.textAlignment = .left
        return phoneLabel
    }()
    
    
    lazy var nextBtn:UIButton = {
       let nextBtn = UIButton()
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        nextBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        nextBtn.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        return nextBtn
    }()
    
    
    lazy var bottomView:UIView = {
       let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return bottomView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "更改绑定手机号"
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        
        let phoneView = UIView()
        phoneView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(phoneView)
        phoneView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(0.5))
            make.height.equalTo(scale(48))
        }
        
        phoneView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(22))
        }
        
        phoneView.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(phoneLabel.snp.right).offset(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
        }
        
        let codeView = UIView()
        codeView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(codeView)
        codeView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(phoneView.snp.bottom).offset(scale(0.5))
            make.height.equalTo(scale(48))
        }
        
        let codeLabel = UILabel()
        codeLabel.text = "验证码"
        codeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        codeLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        codeLabel.textAlignment = .left
        codeView.addSubview(codeLabel)
        codeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(22))
        }
        
        codeView.addSubview(codeTextField)
        codeTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(codeLabel.snp.right).offset(scale(16))
            make.width.right.equalTo(-scale(118))
            make.height.equalTo(scale(22))
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
        
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(iPhoneX ? scale(92) : scale(54))
        }
        
        
        bottomView.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
            make.height.equalTo(scale(44))
        }
        nextBtn.layer.cornerRadius = scale(4)
    }
    
    
    
    
    
    
    @objc func nextAction(nextBtn:UIButton){
        
        if phoneTextField.text?.isValidMobile == false{
            JFPopup.toast(hit: "请填写正确的手机号")
            return
        }
        if (codeTextField.text?.count ?? 0) < 1{
            JFPopup.toast(hit: "请填写验证码")
            return
        }
        
        //下一步
        let changeBindPhoneVC = ChangeBindPhoneViewController()
        changeBindPhoneVC.nextBtn.setTitle("确定", for: .normal)
        changeBindPhoneVC.phoneLabel.text = "新手机号"
        Coordinator.shared?.pushViewController(self, changeBindPhoneVC, animated: true)
    }
    
}


extension ChangeBindPhoneViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxNum = 6
        if textField == phoneTextField {
                maxNum = 11
        }
//        限制个数
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= maxNum
    }
}
