//
//  TemplateContentViewController.swift
//  App
//
//  Created by mac on 2022/5/12.
//

import UIKit
import Util

class TemplateContentViewController: BaseViewController {

    
    //模板名称
    lazy var templateNameTextFiled:UITextField = {
       let templateNameTextFiled = UITextField()
        templateNameTextFiled.placeholder = "请输入"
        templateNameTextFiled.clearButtonMode = .whileEditing
        templateNameTextFiled.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        templateNameTextFiled.clearButtonMode = .whileEditing
        templateNameTextFiled.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        return templateNameTextFiled
    }()
    
    //包邮按键
    lazy var freeBtn:UIButton = {
        let freeBtn = UIButton()
        freeBtn.setBackgroundImage(UIImage(named: "Ellipse 38"), for: .normal)
        freeBtn.setBackgroundImage(UIImage(named: "Group 2742"), for: .selected)
        freeBtn.addTarget(self, action: #selector(choiceFreeAction), for: .touchUpInside)
        return freeBtn
    }()
    
    //自定义运费按键
    lazy var customFreightBtn:UIButton = {
        let customFreightBtn = UIButton()
        customFreightBtn.setBackgroundImage(UIImage(named: "Ellipse 38"), for: .normal)
        customFreightBtn.setBackgroundImage(UIImage(named: "Group 2742"), for: .selected)
        customFreightBtn.addTarget(self, action: #selector(choiceCustomAction), for: .touchUpInside)
        return customFreightBtn
    }()
    
    
    //不配送区域的btn
    lazy var noDisBtn:UIButton = {
       let noDisBtn = UIButton()
        noDisBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        noDisBtn.addTarget(self, action: #selector(noDisAction), for: .touchUpInside)
        return noDisBtn
    }()
    
    
    //暂未设置label
    lazy var noSettingLabeL:UILabel = {
       let noSettingLabeL = UILabel()
        noSettingLabeL.text = "暂未设置"
        noSettingLabeL.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
        noSettingLabeL.textAlignment = .left
        noSettingLabeL.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return noSettingLabeL
    }()
    
    // 计费方式的view
    lazy var typeView:UIView = {
       let typeView = UIView()
        typeView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return typeView
    }()

    
    //运费配置uibutton
    lazy var freightConfigureBtn:UIButton = {
       let freightConfigureBtn = UIButton()
        freightConfigureBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        freightConfigureBtn.addTarget(self, action: #selector(freightConfigureAction), for: .touchUpInside)
        return freightConfigureBtn
    }()
    
    //运费方式配置
    lazy var freightConfigureLabel:UILabel = {
       let freightConfigureLabel = UILabel()
        freightConfigureLabel.text = "未配置"
        freightConfigureLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
        freightConfigureLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        freightConfigureLabel.textAlignment = .left
        return freightConfigureLabel
    }()
    
    
    //底部
    
    lazy var bottomView:UIView = {
       let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        return bottomView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        
        let templateName = UILabel()
        templateName.text = "模板名称"
        templateName.textAlignment = .left
        templateName.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        templateName.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        view.addSubview(templateName)
        
        templateName.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(topView.snp.bottom).offset(scale(16))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
        }
        
        
        view.addSubview(templateNameTextFiled)
        templateNameTextFiled.snp.makeConstraints { make in
            make.left.equalTo(templateName.snp.right).offset(scale(28))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
            make.top.equalTo(topView.snp.bottom).offset(scale(16))
        }
        
        let templateView = UIView()
        templateView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(templateView)
        templateView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(templateNameTextFiled.snp.bottom).offset(scale(16))
        }
        
        
        
        let freeStyleLabel = UILabel()
        freeStyleLabel.text = "运费类型"
        freeStyleLabel.textAlignment = .left
        freeStyleLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        freeStyleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        view.addSubview(freeStyleLabel)
        
        freeStyleLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(templateView.snp.bottom).offset(scale(16))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
        }
        
        
        view.addSubview(freeBtn)
        freeBtn.snp.makeConstraints { make in
            make.left.equalTo(freeStyleLabel.snp.right).offset(scale(28))
            make.top.equalTo(templateView.snp.bottom).offset(scale(19))
            make.width.height.equalTo(scale(16))
        }
        

        let freeLabel = UILabel()
        freeLabel.text = "包邮"
        freeLabel.textAlignment = .left
        freeLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        freeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        view.addSubview(freeLabel)
        freeLabel.snp.makeConstraints { make in
            make.left.equalTo(freeBtn.snp.right).offset(scale(3))
            make.top.equalTo(templateView.snp.bottom).offset(scale(16))
            make.width.equalTo(scale(40))
            make.height.equalTo(scale(22))
        }

        view.addSubview(customFreightBtn)
        customFreightBtn.snp.makeConstraints { make in
            make.left.equalTo(freeLabel.snp.right).offset(scale(24))
            make.width.height.equalTo(scale(16))
            make.top.equalTo(templateView.snp.bottom).offset(scale(19))
        }
        
        let customLabel = UILabel()
        customLabel.text = "自定义运费"
        customLabel.textAlignment = .left
        customLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        customLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        view.addSubview(customLabel)

        customLabel.snp.makeConstraints { make in
            make.left.equalTo(customFreightBtn.snp.right).offset(scale(3))
            make.top.equalTo(templateView.snp.bottom).offset(scale(16))
            make.width.equalTo(scale(85))
            make.height.equalTo(scale(22))
        }



        let customView = UIView()
        customView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(customView)

        customView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(freeStyleLabel.snp.bottom).offset(scale(16))
        }


        view.addSubview(noDisBtn)
        noDisBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(customView.snp.bottom)
            make.height.equalTo(scale(54))
        }
        
        //点击
        
        
        let noDistributionLabel = UILabel()
        noDistributionLabel.text = "不配送区域"
        noDistributionLabel.textAlignment = .left
        noDistributionLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        noDistributionLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        noDisBtn.addSubview(noDistributionLabel)
        
        
        noDistributionLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(85))
        }
        

        noDisBtn.addSubview(noSettingLabeL)
        noSettingLabeL.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(noDistributionLabel.snp.right).offset(scale(10))
            make.right.equalTo(-scale(40))
            make.height.equalTo(scale(22))
        }
        
        
        let rightImage = UIImageView()
        rightImage.image = UIImage(named: "Frame-right")
        noDisBtn.addSubview(rightImage)
        
        rightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
        }
        
        
        
        let noDisView = UIView()
        noDisView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        noDisBtn.addSubview(noDisView)
        
        noDisView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.bottom.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        
        
        
        
        view.addSubview(typeView)
        typeView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(noDisBtn.snp.bottom)
            make.height.equalTo(scale(54))
        }
        
        
        let typeLabel = UILabel()
        typeLabel.text = "计费方式"
        typeLabel.textAlignment = .left
        typeLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        typeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        typeView.addSubview(typeLabel)
        
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
        }
        
        
        let pieceLabel = UILabel()
        pieceLabel.text = "按件计费"
        pieceLabel.textAlignment = .left
        pieceLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        pieceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        typeView.addSubview(pieceLabel)
        
        
        pieceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(typeLabel.snp.right).offset(scale(26))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
        }
        
        
        let typeDiviver = UIView()
        typeDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        typeView.addSubview(typeDiviver)
        
        typeDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.bottom.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        
        
        //freightConfigureBtn
        
        view.addSubview(freightConfigureBtn)
        freightConfigureBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(typeView.snp.bottom)
            make.height.equalTo(scale(54))
        }
        
        
        
        
        let freightLabel = UILabel()
        freightLabel.text = "运费配置"
        freightLabel.textAlignment = .left
        freightLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        freightLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        freightConfigureBtn.addSubview(freightLabel)
        
        freightLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
        }
        
        freightConfigureBtn.addSubview(freightConfigureLabel)
        freightConfigureLabel.snp.makeConstraints { make in
            make.left.equalTo(freightLabel.snp.right).offset(scale(26))
            make.centerY.equalToSuperview()
            make.height.equalTo(scale(22))
            make.right.equalTo(-scale(40))
        }
        
        let freighImage = UIImageView()
        freighImage.image = UIImage(named: "Frame-right")
        freightConfigureBtn.addSubview(freighImage)
        
        freighImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(freightConfigureBtn.snp.bottom)
            make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
        }
        
        
        
        let completeBtn = UIButton()
        completeBtn.setTitle("完成", for: .normal)
        completeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        completeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        completeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        completeBtn.addTarget(self, action: #selector(completeAction), for: .touchUpInside)
        view.addSubview(completeBtn)
        
        completeBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        completeBtn.layer.cornerRadius = scale(4)
        
        
    }
    
    
    //完成
    @objc func completeAction(completeBtn:UIButton){
        
        
    }
    
    //不配送区域
    @objc func noDisAction(noDisBtn:UIButton){
        let noDeliveryVc = NoDeliveryViewController()
        Coordinator.shared?.pushViewController(self, noDeliveryVc, animated: true)
    }
    
    //运费配置
    @objc func freightConfigureAction(freightConfigureBtn:UIButton){
        let freightAllocationVc = FreightAllocationViewController()
        Coordinator.shared?.pushViewController(self, freightAllocationVc, animated: true)
    }
    
    //包邮
    @objc func choiceFreeAction(freeBtn:UIButton){
        freeBtn.isSelected = !freeBtn.isSelected
        customFreightBtn.isSelected = false
        typeView.isHidden = true
        freightConfigureBtn.isHidden = true
        bottomView.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(noDisBtn.snp.bottom)
            make.bottom.equalTo(-scale(92))
        }
    }
    
    
    //自定义运费
    @objc func choiceCustomAction(customFreightBtn:UIButton){
        customFreightBtn.isSelected = !customFreightBtn.isSelected
        freeBtn.isSelected = false
        typeView.isHidden = false
        freightConfigureBtn.isHidden = false
        bottomView.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(freightConfigureBtn.snp.bottom)
            make.bottom.equalTo(-scale(92))
        }
    }

}
