//
//  PerfectInfoViewController.swift
//  App
//
//  Created by mac on 2022/7/7.
//

import UIKit
import Util

class PerfectInfoViewController: BaseViewController {
    
    
    lazy var nameTextField:UITextField = {
       let nameTextField = UITextField()
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.placeholder = "请输入姓名"
        nameTextField.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        nameTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入姓名", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        return nameTextField
    }()
    
    
    lazy var codeTextField:UITextField = {
        let codeTextField = UITextField()
        codeTextField.clearButtonMode = .whileEditing
        codeTextField.placeholder = "请输入身份证号"
        codeTextField.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        codeTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入身份证号", attributes: [
             NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
         return codeTextField
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

     
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        //请完善身份信息
        let titleInfoLabel = UILabel()
        titleInfoLabel.text = "请完善身份信息"
        titleInfoLabel.textAlignment = .center
        titleInfoLabel.font = UIFont.systemFont(ofSize: scale(20), weight: .medium)
        titleInfoLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        view.addSubview(titleInfoLabel)
        
        
        titleInfoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(26))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(28))
        }
        
        //请填写您本人的身份信息
        let selfTitleInfoLabel = UILabel()
        selfTitleInfoLabel.text = "请填写您本人的身份信息"
        selfTitleInfoLabel.textAlignment = .center
        selfTitleInfoLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        selfTitleInfoLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        view.addSubview(selfTitleInfoLabel)
        
        
        selfTitleInfoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(titleInfoLabel.snp.bottom).offset(scale(8))
            make.height.equalTo(scale(17))
        }
        
        //姓名
        let nameLabel = UILabel()
        nameLabel.text = "姓名"
        nameLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        nameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        nameLabel.textAlignment = .left
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(selfTitleInfoLabel.snp.bottom).offset(scale(64))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(50))
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right).offset(scale(24))
            make.right.equalTo(-scale(16))
            make.top.equalTo(selfTitleInfoLabel.snp.bottom).offset(scale(64))
            make.height.equalTo(scale(22))
        }
        
        let nameView = UIView()
        nameView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(nameView)
        
        nameView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(nameLabel.snp.bottom).offset(scale(16))
        }
        
        
        //身份证
        let codeLabel = UILabel()
        codeLabel.text = "身份证"
        codeLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        codeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        codeLabel.textAlignment = .left
        view.addSubview(codeLabel)
        
        codeLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(nameView.snp.bottom).offset(scale(16))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(50))
        }
        
        view.addSubview(codeTextField)
        codeTextField.snp.makeConstraints { make in
            make.left.equalTo(codeLabel.snp.right).offset(scale(24))
            make.right.equalTo(-scale(16))
            make.top.equalTo(nameView.snp.bottom).offset(scale(16))
            make.height.equalTo(scale(22))
        }
        
        let codeView = UIView()
        codeView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(codeView)
        
        codeView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(codeLabel.snp.bottom).offset(scale(16))
        }
        
        let alertLabel = UILabel()
        alertLabel.numberOfLines = 2
        alertLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        alertLabel.text = "为保证你的资金安全，请确保输入为本人真实有效的信息，认证后不可更改，更改实名信息需联系客服操作"
        alertLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#9A9A9A")
        alertLabel.textAlignment = .left
        view.addSubview(alertLabel)
        
        alertLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(codeView.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(38))
        }
        
        
        //下一步
        let nextBtn = UIButton()
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        nextBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        view.addSubview(nextBtn)
        
        nextBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        nextBtn.layer.cornerRadius = scale(4)
        
        nextBtn.addTarget(self, action: #selector(nextPersonFaceAction), for: .touchUpInside)
        
    }
    
    
    //下一步
    @objc func nextPersonFaceAction(nextBtn:UIButton){
        
    }
    
    
}
