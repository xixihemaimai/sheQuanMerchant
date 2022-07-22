//
//  AddBankViewController.swift
//  App
//
//  Created by mac on 2022/7/20.
//

import UIKit
import Util
import JFPopup
import AliyunIdentityManager

class AddBankViewController: BaseViewController {
        
    lazy var ownCodeTextField:UITextField = {
       let ownCodeTextField = UITextField()
        ownCodeTextField.placeholder = "请输入持卡人"
        ownCodeTextField.clearButtonMode = .whileEditing
        ownCodeTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#666666")
        ownCodeTextField.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        ownCodeTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入持卡人", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        ownCodeTextField.delegate = self
        return ownCodeTextField
    }()
    
    lazy var bankCodeTextField:UITextField = {
       let bankCodeTextField = UITextField()
        bankCodeTextField.placeholder = "请输入持卡人本人银行卡号"
        bankCodeTextField.clearButtonMode = .whileEditing
        bankCodeTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#666666")
        bankCodeTextField.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        bankCodeTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入持卡人本人银行卡号", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        bankCodeTextField.delegate = self
        return bankCodeTextField
    }()
    
    
    
    lazy var phoneNumTextField:UITextField = {
       let phoneNumTextField = UITextField()
        phoneNumTextField.placeholder = "请输入银行预留手机号"
        phoneNumTextField.keyboardType = .phonePad
        phoneNumTextField.clearButtonMode = .whileEditing
        phoneNumTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#666666")
        phoneNumTextField.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        phoneNumTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入银行预留手机号", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        phoneNumTextField.delegate = self
        return phoneNumTextField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named: "关闭1 1"), for: .normal)
        backBtn.backgroundColor = UIColor.clear
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(iPhoneX ? scale(60) : scale(32))
            make.width.height.equalTo(scale(24))
        }
        
        backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        
        
        let addTitleLabel = UILabel()
        addTitleLabel.text = "添加银行卡"
        addTitleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        addTitleLabel.font = UIFont.systemFont(ofSize: scale(22), weight: .semibold)
        addTitleLabel.textAlignment = .center
        view.addSubview(addTitleLabel)

        addTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(iPhoneX ? scale(140) : scale(108))
            make.height.equalTo(scale(31))
        }
        
        
        let subTitleLabel = UILabel()
        subTitleLabel.text = "请绑定法人名下的银行卡"
        subTitleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        subTitleLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        subTitleLabel.textAlignment = .center
        view.addSubview(subTitleLabel)
        
        subTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(addTitleLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(22))
        }
        
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(midView)
        midView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(subTitleLabel.snp.bottom).offset(scale(43))
        }
        
        
        
        let ownCodeLabel = UILabel()
        ownCodeLabel.text = "持卡人"
        ownCodeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        ownCodeLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        ownCodeLabel.textAlignment = .left
        view.addSubview(ownCodeLabel)
        ownCodeLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(midView.snp.bottom)
            make.width.equalTo(scale(70))
            make.height.equalTo(scale(scale(54)))
        }
        
        view.addSubview(ownCodeTextField)
        ownCodeTextField.snp.makeConstraints { make in
            make.left.equalTo(ownCodeLabel.snp.right).offset(scale(12))
            make.right.equalTo(-scale(16))
            make.top.equalTo(midView.snp.bottom)
            make.height.equalTo(scale(54))
        }
        
        let ownView = UIView()
        ownView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(ownView)
        ownView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(ownCodeLabel.snp.bottom)
            make.height.equalTo(scale(0.5))
        }
        
        
        
        let bankCodeLabel = UILabel()
        bankCodeLabel.text = "银行卡号"
        bankCodeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        bankCodeLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        bankCodeLabel.textAlignment = .left
        view.addSubview(bankCodeLabel)
        bankCodeLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(ownView.snp.bottom)
            make.width.equalTo(scale(70))
            make.height.equalTo(scale(scale(54)))
        }
        
        view.addSubview(bankCodeTextField)
        bankCodeTextField.snp.makeConstraints { make in
            make.left.equalTo(bankCodeLabel.snp.right).offset(scale(12))
            make.right.equalTo(-scale(16))
            make.top.equalTo(ownView.snp.bottom)
            make.height.equalTo(scale(54))
        }
        
        let bankView = UIView()
        bankView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(bankView)
        bankView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(bankCodeLabel.snp.bottom)
            make.height.equalTo(scale(0.5))
        }
        
        
        let phoneNumlabel = UILabel()
        phoneNumlabel.text = "手机号"
        phoneNumlabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        phoneNumlabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        phoneNumlabel.textAlignment = .left
        view.addSubview(phoneNumlabel)
        phoneNumlabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(bankView.snp.bottom)
            make.width.equalTo(scale(70))
            make.height.equalTo(scale(scale(54)))
        }
        
        view.addSubview(phoneNumTextField)
        phoneNumTextField.snp.makeConstraints { make in
            make.left.equalTo(phoneNumlabel.snp.right).offset(scale(12))
            make.right.equalTo(-scale(16))
            make.top.equalTo(bankView.snp.bottom)
            make.height.equalTo(scale(54))
        }
        
        let phoneView = UIView()
        phoneView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(phoneView)
        phoneView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(phoneNumlabel.snp.bottom)
            make.height.equalTo(scale(0.5))
        }
        
        
        let nextBtn = UIButton()
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        nextBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        view.addSubview(nextBtn)
        
        nextBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(phoneView.snp.bottom).offset(scale(44))
            make.height.equalTo(scale(44))
        }
        
        nextBtn.layer.cornerRadius = scale(4)
        nextBtn.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
    
    //下一步
    @objc func nextAction(nextBtn:UIButton){
        
//        if (ownCodeTextField.text?.count ?? 0) < 1{
//            JFPopup.toast(hit: "请填写收货人")
//            return
//        }
//
//        if (bankCodeTextField.text?.count ?? 0) < 1{
//            JFPopup.toast(hit: "请填写银行卡号")
//            return
//        }
//
//        if phoneNumTextField.text?.isValidMobile == false{
//            JFPopup.toast(hit: "请填写正取的手机号")
//            return
//        }
        
        let session = AliyunSdk.getMobileSession()
        let extParams: [String : Any] = ["currentCtr": self]
        AliyunIdentityManager.sharedInstance().verify(with: "sha94c81e357a836588a7a5aef5e7242", extParams: extParams) { (aresp) in
            if (aresp != nil && aresp?.code == ZIMResponseCode.ZIMResponseSuccess) {
                LXFLog("======")
                // 认证成功
                //callback(true, "认证成功", certifyId);
            } else {
                LXFLog("------")
                // 认证失败
                //callback(false, aresp?.reason, nil);
            }
        }
        
    }
    
    /**

     JFPopupView.popup.alert {[
     //1.请求过于频繁，请稍后再试
     2.人脸认证失败，请核对后再试
     3.手机号与银行卡预留不一致，请核对后再试
     4.验证码错误，请重试
                .subTitle(""),
                .showCancel(false),
                .confirmAction([
                    .text("我知道了"),
                    .tapActionCallback({
                    })
                ])
            ]}
     */
    
    @objc func backAction(backBtn:UIButton){
        Coordinator.shared?.popViewController(self, true)
    }

    

}

extension AddBankViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxNum = 6
        if textField == phoneNumTextField {
            maxNum = 11
        }else if textField == bankCodeTextField{
            maxNum = 18
        }else if textField == ownCodeTextField{
            maxNum = 25
        }
//        限制个数
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= maxNum
    }
    
    
    
}
