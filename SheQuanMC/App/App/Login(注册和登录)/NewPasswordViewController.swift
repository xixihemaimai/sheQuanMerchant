//
//  NewPasswordViewController.swift
//  App
//
//  Created by mac on 2022/4/26.
//

import UIKit
import Util
import JFPopup

class NewPasswordViewController: BaseViewController {
    
    
    
    //账号
    lazy var newPasswordLabel:UILabel = {
       let newPasswordLabel = UILabel()
        newPasswordLabel.text = "新密码"
        newPasswordLabel.textAlignment = .left
        newPasswordLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .semibold)
        newPasswordLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return newPasswordLabel
    }()
    
    //输入框
    lazy var newPasswordTextField:UITextField = {
       let newPasswordTextField = UITextField()
        newPasswordTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        newPasswordTextField.clearButtonMode = .whileEditing
        newPasswordTextField.placeholder = "请输入新密码"
        newPasswordTextField.isSecureTextEntry = !newPasswordTextField.isSecureTextEntry
        newPasswordTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入新密码", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        newPasswordTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        newPasswordTextField.delegate = self
        return newPasswordTextField
    }()
    
    //分割线
    lazy var newPasswordDiviver:UIView = {
       let newPasswordDiviver = UIView()
        newPasswordDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#CBCBCB")
        return newPasswordDiviver
    }()
    
    //密码
    lazy var againPasswordLabel:UILabel = {
       let againPasswordLabel = UILabel()
        againPasswordLabel.text = "确认密码"
        againPasswordLabel.textAlignment = .left
        againPasswordLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .semibold)
        againPasswordLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return againPasswordLabel
    }()
    
    
    //输入框
    lazy var againPasswordTextField:UITextField = {
       let againPasswordTextField = UITextField()
        againPasswordTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        againPasswordTextField.clearButtonMode = .whileEditing
        againPasswordTextField.placeholder = "二次输入确认密码"
        againPasswordTextField.isSecureTextEntry = !againPasswordTextField.isSecureTextEntry
        againPasswordTextField.attributedPlaceholder = NSAttributedString.init(string:"二次输入确认密码", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
//        againPasswordTextField.isSecureTextEntry = true
        againPasswordTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        againPasswordTextField.delegate = self
        return againPasswordTextField
    }()
    
    //密码分割线
    lazy var againPasswordDiviver:UIView = {
       let againPasswordDiviver = UIView()
        againPasswordDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#CBCBCB")
        return againPasswordDiviver
    }()
    
    
    //显示错误
    lazy var showErrerLabel:UILabel = {
       let showErrerLabel = UILabel()
        showErrerLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F33A2F")
        showErrerLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        showErrerLabel.textAlignment = .left
        showErrerLabel.isHidden = true
        return showErrerLabel
    }()
    
    //登录
    lazy var sureModifyBtn:UIButton = {
       let sureModifyBtn = UIButton()
        sureModifyBtn.setTitle("确认修改", for: .normal)
        sureModifyBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        sureModifyBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        sureModifyBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return sureModifyBtn
    }()
    
    
    //验证码返回的verifyId的值
    var verifyId:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        self.title = "设置新密码"
        
        
        
        view.addSubview(newPasswordLabel)
        view.addSubview(newPasswordTextField)
        view.addSubview(newPasswordDiviver)
        
        newPasswordLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.top.equalTo(scale(55))
            make.width.equalTo(scale(scale(70)))
            make.height.equalTo(scale(scale(20)))
        }
        
        
        newPasswordTextField.snp.makeConstraints { make in
            make.left.equalTo(newPasswordLabel.snp.right).offset(scale(10))
            make.right.equalTo(-scale(30))
            make.top.equalTo(scale(55))
            make.height.equalTo(scale(20))
        }
        
        newPasswordDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(newPasswordLabel.snp.bottom).offset(scale(10))
        }
        
        
        //密码或者验证码
        view.addSubview(againPasswordLabel)
        view.addSubview(againPasswordTextField)
        view.addSubview(againPasswordDiviver)
        
        
        againPasswordLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.top.equalTo(newPasswordDiviver.snp.bottom).offset(scale(26))
            make.width.equalTo(scale(scale(70)))
            make.height.equalTo(scale(20))
        }
        
        
        againPasswordTextField.snp.makeConstraints { make in
            make.left.equalTo(againPasswordLabel.snp.right).offset(scale(10))
            make.right.equalTo(-scale(30))
            make.top.equalTo(newPasswordDiviver.snp.bottom).offset(scale(26))
            make.height.equalTo(scale(20))
        }
        
        againPasswordDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(againPasswordLabel.snp.bottom).offset(scale(10))
        }
        
        
        
        view.addSubview(showErrerLabel)
        showErrerLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.top.equalTo(againPasswordDiviver.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(20))
        }
        
        
        view.addSubview(sureModifyBtn)
        sureModifyBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.top.equalTo(showErrerLabel.snp.bottom).offset(scale(40))
            make.height.equalTo(scale(40))
        }
        sureModifyBtn.layer.cornerRadius = scale(4)
        sureModifyBtn.addTarget(self, action: #selector(modifyPasswordAction), for: .touchUpInside)
    }
    
    
    //确认修改
    @objc func modifyPasswordAction(sureModifyBtn:UIButton){
        
        if !(newPasswordTextField.text?.isPassword ?? true){
            showErrerLabel.isHidden = false
//            JFPopup.toast(hit: "密码错误，6-16位字母数字组合")
            showErrerLabel.text = "密码必须为8-16位，同时带有字母、数字组合"
            return
        }
        
        if !(againPasswordTextField.text?.isPassword ?? true){
            showErrerLabel.isHidden = false
            showErrerLabel.text = "密码必须为8-16位，同时带有字母、数字组合"
            return
        }
        
        if newPasswordTextField.text != againPasswordTextField.text{
            showErrerLabel.isHidden = false
            showErrerLabel.text = "两次密码不一致，请重新输入"
            return
        }
        
//        JFPopup.toast(hit: "密码已重置")
//        {
//          "confirmPass": "string",
//          "password": "string",
//          "verifyId": "string"
//        }
        let parameters = ["confirmPass":againPasswordTextField.text ?? "","password":newPasswordTextField.text ?? "","verifyId":verifyId] as [String:String]
        NetWorkResultRequest(shopApi.changePass(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
            LXFLog(data)
            JFPopup.toast(hit: "密码已重置", icon: .success)
            StoreService.shared.delete()
            guard let popVc = self?.navigationController?.viewControllers[1] as? LoginViewController else{return}
            Coordinator.shared?.popToViewController(self!, popVc, true)
        } failureCallback: { error,code in
            StoreService.shared.delete()
//            JFPopup.toast(hit: "修改密码失败", icon: .fail)
        }
    }
}

extension NewPasswordViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            var maxNum = 11
        if textField ==  newPasswordTextField{
            maxNum = 16
        }else if textField == againPasswordTextField{
            maxNum = 16
        }
//        限制个数
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= maxNum
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        showErrerLabel.isHidden = true
    }
    
    
}
