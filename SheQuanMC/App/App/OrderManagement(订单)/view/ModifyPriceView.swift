//
//  ModifyPriceView.swift
//  App
//
//  Created by mac on 2022/5/7.
//

import UIKit
import Util

class ModifyPriceView: UIView {

    var cancelBlock:(()->Void)?
    
    
    
    //订单原价修改
    lazy var originTextfield:UITextField = {
       let originTextfield = UITextField()
        originTextfield.placeholder = "请输入"
        originTextfield.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        originTextfield.keyboardType = .numberPad
        originTextfield.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        originTextfield.addTarget(self, action: #selector(originInput), for: .editingChanged)
        return originTextfield
    }()
    
    
    //运费修改
    lazy var freightTextfield:UITextField = {
       let freightTextfield = UITextField()
        freightTextfield.placeholder = "请输入"
        freightTextfield.keyboardType = .numberPad
        freightTextfield.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        freightTextfield.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        freightTextfield.addTarget(self, action: #selector(freightInput), for: .editingChanged)
        return freightTextfield
    }()
    
    
    //修改后的价格
    lazy var underLabel:UILabel = {
        let underLabel = UILabel()
        underLabel.text = "----"
        underLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F13232")
        underLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        underLabel.textAlignment = .center
        return underLabel
    }()
    
    //确定修改
    lazy var sureModifyBtn:UIButton = {
        let sureModifyBtn = UIButton()
        sureModifyBtn.setTitle("确定修改", for: .normal)
        sureModifyBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
//        sureModifyBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        sureModifyBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E1E1E1")
        sureModifyBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        sureModifyBtn.addTarget(self, action: #selector(sureModifyAction), for: .touchUpInside)
        sureModifyBtn.isEnabled = false
        return sureModifyBtn
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            
        
        let titleLabel = UILabel()
        titleLabel.text = "修改价格"
        titleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        titleLabel.font = UIFont.systemFont(ofSize: scale(17), weight: .regular)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scale(15))
            make.width.equalTo(scale(150))
            make.height.equalTo(scale(24))
        }
        
        let cancelBtn = UIButton()
        cancelBtn.setBackgroundImage(UIImage(named: "关闭1 1"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelAddAction), for: .touchUpInside)
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(16))
            make.width.height.equalTo(scale(22))
        }
        
        
        //订单原价(含运费):¥30
        
        let origilView = UIView()
        origilView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        addSubview(origilView)
        
        
        origilView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(scale(16))
            make.height.equalTo(scale(346))
        }
        
        
        let origilLabel = UILabel()
        origilLabel.text = "订单原价(含运费):¥30"
        origilLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        origilLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        origilLabel.textAlignment = .left
        origilView.addSubview(origilLabel)
        
        origilLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(13))
            make.height.equalTo(scale(22))
        }
        
        let priceView = UIView()
        priceView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        origilView.addSubview(priceView)
        
        priceView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(origilLabel.snp
                .bottom).offset(scale(13))
            make.height.equalTo(scale(48))
        }
        
        
        //价格
        let priceLabel = UILabel()
        priceLabel.text = "价格 ¥20"
        priceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        priceLabel.textAlignment = .left
        priceLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        priceView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
        }
        
        
        
        let modifyView = UIView()
        modifyView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        origilView.addSubview(modifyView)
        
        modifyView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(priceView.snp.bottom).offset(scale(1))
            make.height.equalTo(scale(48))
        }
        
        //修改后的价格
        let modifyLabel = UILabel()
        modifyLabel.text = "修改后价格"
        modifyLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        modifyLabel.textAlignment = .left
        modifyLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        modifyView.addSubview(modifyLabel)
        modifyLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(90))
            make.height.equalTo(scale(22))
        }
        
        //¥
        let modifyUnitLabel = UILabel()
        modifyUnitLabel.text = "¥"
        modifyUnitLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        modifyUnitLabel.textAlignment = .center
        modifyUnitLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        modifyView.addSubview(modifyUnitLabel)
        
        modifyUnitLabel.snp.makeConstraints { make in
            make.left.equalTo(modifyLabel.snp.right).offset(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(10))
            make.height.equalTo(scale(22))
        }
        
        //输入
        
        modifyView.addSubview(originTextfield)
        originTextfield.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.left.equalTo(modifyUnitLabel.snp.right).offset(scale(4))
            make.height.equalTo(scale(22))
        }
        
        
        
 
        //运费
        
        let freightView = UIView()
        freightView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        origilView.addSubview(freightView)
        
        freightView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(modifyView.snp.bottom).offset(scale(8))
            make.height.equalTo(scale(48))
        }
        
        let freightLabel = UILabel()
        freightLabel.text = "运费 ¥10"
        freightLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        freightLabel.textAlignment = .left
        freightLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        freightView.addSubview(freightLabel)
        
        freightLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
        }
        
        
        let modifyFreightView = UIView()
        modifyFreightView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        origilView.addSubview(modifyFreightView)
        modifyFreightView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(freightView.snp.bottom).offset(scale(1))
            make.height.equalTo(scale(48))
        }
        
        //
        
        let modifysLabel = UILabel()
        modifysLabel.text = "修改后运费"
        modifysLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        modifysLabel.textAlignment = .left
        modifysLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        modifyFreightView.addSubview(modifysLabel)
        modifysLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(90))
            make.height.equalTo(scale(22))
        }
        
        //¥
        let modifyUnitsLabel = UILabel()
        modifyUnitsLabel.text = "¥"
        modifyUnitsLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        modifyUnitsLabel.textAlignment = .center
        modifyUnitsLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        modifyFreightView.addSubview(modifyUnitsLabel)
        
        modifyUnitsLabel.snp.makeConstraints { make in
            make.left.equalTo(modifysLabel.snp.right).offset(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(10))
            make.height.equalTo(scale(22))
        }
        
        //输入
        modifyFreightView.addSubview(freightTextfield)
        freightTextfield.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.left.equalTo(modifyUnitsLabel.snp.right).offset(scale(4))
            make.height.equalTo(scale(22))
        }
        
        //下滑线
        origilView.addSubview(underLabel)
        underLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.bottom.equalTo(-scale(52))
            make.width.equalTo(scale(60))
            make.height.equalTo(scale(22))
        }
        
        //修改后总价（含运费）:
        
        let modifyTitleLabel = UILabel()
        modifyTitleLabel.text = "修改后总价(含运费)："
        modifyTitleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        modifyTitleLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        modifyTitleLabel.textAlignment = .right
        origilView.addSubview(modifyTitleLabel)
        
        modifyTitleLabel.snp.makeConstraints { make in
            make.right.equalTo(underLabel.snp.left).offset(-scale(4))
            make.width.equalTo(scale(160))
            make.height.equalTo(scale(22))
            make.bottom.equalTo(-scale(52))
        }
        
        
        //确定修改
        addSubview(sureModifyBtn)
        sureModifyBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        sureModifyBtn.layer.cornerRadius = scale(4)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //取消
    @objc func cancelAddAction(cancelBtn:UIButton){
       cancelBlock!()
    }
    
    //确认修改
    @objc func sureModifyAction(sureModifyBtn:UIButton){
        
        
    }
    
    
    //订单价格输入
    
    @objc func originInput(originTextfield:UITextField){
        //这边要进行相加，并赋值到underLabel 并对确定修改按键进行更改
        let number = (originTextfield.text?.toCGFloat() ?? 0.0)
        let freightNumber = (freightTextfield.text?.toCGFloat() ?? 0.0)
        let total = number + freightNumber
        underLabel.text = String(format: "¥%.1f", total)
        if underLabel.text != "----"{
            sureModifyBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
            sureModifyBtn.isEnabled = true
        }else{
            sureModifyBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E1E1E1")
            sureModifyBtn.isEnabled = false
        }
    }
    
    
    //运费价格输入
    @objc func freightInput(freightTextfield:UITextField){
        //这边要进行相加，并赋值到underLabel 并对确定修改按键进行更改
        let number = (originTextfield.text?.toCGFloat() ?? 0.0)
        let freightNumber = (freightTextfield.text?.toCGFloat() ?? 0.0)
        let total = number + freightNumber
        underLabel.text = String(format: "¥%.1f", total)
        if underLabel.text != "----"{
            sureModifyBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
            sureModifyBtn.isEnabled = true
        }else{
            sureModifyBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E1E1E1")
            sureModifyBtn.isEnabled = false
        }
    }
}
