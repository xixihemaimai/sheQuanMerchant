//
//  FreightAllocationViewController.swift
//  App
//
//  Created by mac on 2022/5/12.
//

import UIKit
import Util
import JFPopup

class FreightAllocationViewController: BaseViewController {
    //运费配置的模型
    var freightConf:freightConfModel?
    //回掉
    var inputBlock:((_ freightConf:freightConfModel)->Void)?
    
    //件数
    lazy var numberTextField:UITextField = {
        let numberTextField = UITextField()
        numberTextField.clearButtonMode = .whileEditing
        numberTextField.keyboardType = .numberPad
        numberTextField.placeholder = "请输入"
        numberTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        numberTextField.font = UIFont.systemFont(ofSize: scale(18), weight: .regular)
        numberTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        numberTextField.tag = 0
        numberTextField.addTarget(self, action: #selector(freightConfEditChangeAction), for: .editingChanged)
        return numberTextField
    }()
    
    //运费
    lazy var freeNumberTextField:UITextField = {
        let freeNumberTextField = UITextField()
        freeNumberTextField.clearButtonMode = .whileEditing
        freeNumberTextField.keyboardType = .decimalPad
        freeNumberTextField.placeholder = "请输入"
        freeNumberTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        freeNumberTextField.font = UIFont.systemFont(ofSize: scale(18), weight: .regular)
        freeNumberTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        freeNumberTextField.tag = 1
        freeNumberTextField.delegate = self
        freeNumberTextField.addTarget(self, action: #selector(freightConfEditChangeAction), for: .editingChanged)
        return freeNumberTextField
    }()
    
    //增加件
    lazy var addNumberTextField:UITextField = {
        let addNumberTextField = UITextField()
        addNumberTextField.clearButtonMode = .whileEditing
        addNumberTextField.keyboardType = .numberPad
        addNumberTextField.placeholder = "请输入"
        addNumberTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        addNumberTextField.font = UIFont.systemFont(ofSize: scale(18), weight: .regular)
        addNumberTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        addNumberTextField.tag = 2
        addNumberTextField.addTarget(self, action: #selector(freightConfEditChangeAction), for: .editingChanged)
        return addNumberTextField
    }()
    
    //运费增加
    lazy var addFreeNumberTextField:UITextField = {
        let addFreeNumberTextField = UITextField()
        addFreeNumberTextField.clearButtonMode = .whileEditing
        addFreeNumberTextField.keyboardType = .decimalPad
        addFreeNumberTextField.placeholder = "请输入"
        addFreeNumberTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        addFreeNumberTextField.font = UIFont.systemFont(ofSize: scale(18), weight: .regular)
        addFreeNumberTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        addFreeNumberTextField.tag = 3
        addFreeNumberTextField.delegate = self
        addFreeNumberTextField.addTarget(self, action: #selector(freightConfEditChangeAction), for: .editingChanged)
        return addFreeNumberTextField
    }()
    
    //包邮条件
    lazy var packageTextField:UITextField = {
        let packageTextField = UITextField()
        packageTextField.clearButtonMode = .whileEditing
        packageTextField.keyboardType = .numberPad
        packageTextField.placeholder = "请输入"
        packageTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        packageTextField.font = UIFont.systemFont(ofSize: scale(18), weight: .regular)
        packageTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        packageTextField.tag = 4
        packageTextField.addTarget(self, action: #selector(freightConfEditChangeAction), for: .editingChanged)
        return packageTextField
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "运费配置"
        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        
        let chargePriceLabel = UILabel()
        chargePriceLabel.text = "按件计费"
        chargePriceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        chargePriceLabel.font = UIFont.systemFont(ofSize: scale(17), weight: .medium)
        chargePriceLabel.textAlignment = .left
        view.addSubview(chargePriceLabel)
        chargePriceLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(16))
            make.height.equalTo(scale(24))
            make.width.equalTo(scale(70))
        }
        
        let defaultRuleLabel = UILabel()
        defaultRuleLabel.text = "(默认规则)"
        defaultRuleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        defaultRuleLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        defaultRuleLabel.textAlignment = .center
        view.addSubview(defaultRuleLabel)
        
        defaultRuleLabel.snp.makeConstraints { make in
            make.left.equalTo(chargePriceLabel.snp.right)
            make.top.equalTo(scale(16))
            make.height.equalTo(scale(24))
            make.width.equalTo(scale(96))
        }
        
        
        let contentView = UIView()
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(chargePriceLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(196))
        }
        
        // 首件
        let firstLabel = UILabel()
        firstLabel.text = "首件"
        firstLabel.textAlignment = .left
        firstLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
        firstLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        contentView.addSubview(firstLabel)
        
        firstLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(16))
            make.width.equalTo(scale(30))
            make.height.equalTo(scale(20))
        }
        
        
        let numberLabel = UILabel()
        numberLabel.text = "件数(件)"
        numberLabel.textAlignment = .left
        numberLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        numberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        contentView.addSubview(numberLabel)
        
        numberLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(firstLabel.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(61))
            make.height.equalTo(scale(20))
        }
        
        let int32Value = Int32(truncating: freightConf?.firstPiece as? NSNumber ?? 0)
        if int32Value <= 0{
            numberTextField.text = ""
        }else{
            numberTextField.text = String(format: "%d", int32Value)
        }
        //numberTextField.text = freightConf?.firstPiece
        
        contentView.addSubview(numberTextField)
        numberTextField.snp.makeConstraints { make in
            make.left.equalTo(numberLabel.snp.right).offset(scale(6))
            make.top.equalTo(firstLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(25))
            make.width.equalTo(scale(114))
        }
        
        //底下横线
        let firstView = UIView()
        firstView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        contentView.addSubview(firstView)

        firstView.snp.makeConstraints { make in
            make.left.equalTo(numberLabel.snp.right).offset(scale(6))
            make.top.equalTo(numberTextField.snp.bottom).offset(5)
            make.height.equalTo(scale(0.5))
            make.width.equalTo(scale(114))
        }
        
        
        
        let addFreightLabel = UILabel()
        addFreightLabel.text = "运费"
        addFreightLabel.textAlignment = .left
        addFreightLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        addFreightLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        contentView.addSubview(addFreightLabel)
        
        addFreightLabel.snp.makeConstraints { make in
            make.left.equalTo(firstView.snp.right).offset(scale(19))
            make.top.equalTo(firstLabel.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(30))
            make.height.equalTo(scale(20))
        }
        
        
        let freightRmbLabel = UILabel()
        freightRmbLabel.text = "¥"
        freightRmbLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        freightRmbLabel.textAlignment = .center
        freightRmbLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        contentView.addSubview(freightRmbLabel)
        
        freightRmbLabel.snp.makeConstraints { make in
            make.left.equalTo(addFreightLabel.snp.right).offset(scale(12))
            make.top.equalTo(firstLabel.snp.bottom).offset(scale(13))
            make.width.equalTo(scale(10))
            make.height.equalTo(scale(22))
        }
        
        let doubleValue = Double(truncating: freightConf?.freight as? NSNumber ?? 0.0)
        if doubleValue < 0.000001{
            freeNumberTextField.text = ""
        }else{
            freeNumberTextField.text = String(format: "%0.2f", doubleValue)
        }
        
        
//        freeNumberTextField.text = String()
        
        
        
        contentView.addSubview(freeNumberTextField)
        freeNumberTextField.snp.makeConstraints { make in
            make.left.equalTo(freightRmbLabel.snp.right).offset(scale(4))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(25))
            make.top.equalTo(firstLabel.snp.bottom).offset(scale(12))
        }
        
        
        
        let freightView = UIView()
        freightView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        contentView.addSubview(freightView)

        freightView.snp.makeConstraints { make in
            make.left.equalTo(addFreightLabel.snp.right).offset(scale(12))
            make.top.equalTo(freeNumberTextField.snp.bottom).offset(5)
            make.height.equalTo(scale(0.5))
            make.right.equalTo(-scale(16))
        }
        
        
        // 续件
        let addFirstLabel = UILabel()
        addFirstLabel.text = "续件"
        addFirstLabel.textAlignment = .left
        addFirstLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
        addFirstLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        contentView.addSubview(addFirstLabel)
        
        addFirstLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(numberLabel.snp.bottom).offset(scale(34))
            make.width.equalTo(scale(30))
            make.height.equalTo(scale(20))
        }
        
        let addnumberLabel = UILabel()
        addnumberLabel.text = "增加(件)"
        addnumberLabel.textAlignment = .left
        addnumberLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        addnumberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        contentView.addSubview(addnumberLabel)
        
        addnumberLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(addFirstLabel.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(61))
            make.height.equalTo(scale(20))
        }
        
        let renewal = Int32(truncating: freightConf?.renewal as? NSNumber ?? 0)
        if renewal <= 0{
            addNumberTextField.text = ""
        }else{
            addNumberTextField.text = String(format: "%d", renewal)
        }
        
        contentView.addSubview(addNumberTextField)
        addNumberTextField.snp.makeConstraints { make in
            make.left.equalTo(addnumberLabel.snp.right).offset(scale(6))
            make.top.equalTo(addFirstLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(25))
            make.width.equalTo(scale(102))
        }
        
        //底下横线
        let addfirstView = UIView()
        addfirstView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        contentView.addSubview(addfirstView)

        addfirstView.snp.makeConstraints { make in
            make.left.equalTo(addnumberLabel.snp.right).offset(scale(6))
            make.top.equalTo(addNumberTextField.snp.bottom).offset(5)
            make.height.equalTo(scale(0.5))
            make.width.equalTo(scale(102))
        }
        
        let addSFreightLabel = UILabel()
        addSFreightLabel.text = "运费增加"
        addSFreightLabel.textAlignment = .left
        addSFreightLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        addSFreightLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        contentView.addSubview(addSFreightLabel)
        
        addSFreightLabel.snp.makeConstraints { make in
            make.left.equalTo(addfirstView.snp.right).offset(scale(19))
            make.top.equalTo(addFirstLabel.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(60))
            make.height.equalTo(scale(20))
        }
        
        
        let addfreightRmbLabel = UILabel()
        addfreightRmbLabel.text = "¥"
        addfreightRmbLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        addfreightRmbLabel.textAlignment = .center
        addfreightRmbLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        contentView.addSubview(addfreightRmbLabel)
        
        addfreightRmbLabel.snp.makeConstraints { make in
            make.left.equalTo(addSFreightLabel.snp.right).offset(scale(12))
            make.top.equalTo(addFirstLabel.snp.bottom).offset(scale(13))
            make.width.equalTo(scale(10))
            make.height.equalTo(scale(22))
        }
        
        
        let renewalFreight = Double(truncating: freightConf?.renewalFreight as? NSNumber ?? 0.0)
        if renewalFreight < 0.000001{
            addFreeNumberTextField.text = ""
        }else{
            addFreeNumberTextField.text = String(format: "%0.2f", renewalFreight)
        }
        
        
        contentView.addSubview(addFreeNumberTextField)
        addFreeNumberTextField.snp.makeConstraints { make in
            make.left.equalTo(addfreightRmbLabel.snp.right).offset(scale(4))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(25))
            make.top.equalTo(addFirstLabel.snp.bottom).offset(scale(12))
        }
        
        let addfreightView = UIView()
        addfreightView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        contentView.addSubview(addfreightView)
        addfreightView.snp.makeConstraints { make in
            make.left.equalTo(addSFreightLabel.snp.right).offset(scale(12))
            make.top.equalTo(addFreeNumberTextField.snp.bottom).offset(5)
            make.height.equalTo(scale(0.5))
            make.right.equalTo(-scale(16))
        }
        
        let appointLabel = UILabel()
        appointLabel.text = "指定条件包邮"
        appointLabel.font = UIFont.systemFont(ofSize: scale(17), weight: .medium)
        appointLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        appointLabel.textAlignment = .left
        view.addSubview(appointLabel)
        appointLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(contentView.snp.bottom).offset(scale(16))
            make.height.equalTo(scale(24))
        }
        
        let packageConditionsView = UIView()
        packageConditionsView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(packageConditionsView)
        
        packageConditionsView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(appointLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(82))
        }
        
        let packageLabel = UILabel()
        packageLabel.text = "包邮条件(件)"
        packageLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        packageLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        packageLabel.textAlignment = .left
        packageConditionsView.addSubview(packageLabel)
        
        packageLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.height.equalTo(scale(20))
            make.width.equalTo(scale(90))
        }
        let parcelConditions = Int32(truncating: freightConf?.parcelConditions as? NSNumber ?? 0)
        if parcelConditions <= 0{
            packageTextField.text = ""
        }else{
            packageTextField.text = String(format: "%d", parcelConditions)
        }
        packageConditionsView.addSubview(packageTextField)
        packageTextField.snp.makeConstraints { make in
            make.left.equalTo(packageLabel.snp.right).offset(scale(6))
            make.right.equalTo(-scale(16))
            make.centerY.equalToSuperview()
            make.height.equalTo(scale(20))
        }
        
        let packageView = UIView()
        packageView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        packageConditionsView.addSubview(packageView)
        packageView.snp.makeConstraints { make in
            make.left.equalTo(packageLabel.snp.right).offset(scale(6))
            make.right.equalTo(-scale(16))
            make.top.equalTo(packageTextField.snp.bottom).offset(scale(8))
            make.height.equalTo(scale(0.5))
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(iPhoneX ? scale(92) : scale(58))
        }
        
        let saveBtn = UIButton()
        saveBtn.setTitle("保存", for: .normal)
        saveBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        saveBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        saveBtn.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        bottomView.addSubview(saveBtn)
        
        saveBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        saveBtn.layer.cornerRadius = scale(4)
        
        
    }
    
    
    @objc func freightConfEditChangeAction(textfield:UITextField){
        if (textfield.text?.count ?? 0) > 0{
            if textfield.tag == 0{
                freightConf?.firstPiece = Int32(textfield.text!)
            }else if textfield.tag == 1{
                freightConf?.freight = Decimal(string: textfield.text!)
            }else if textfield.tag == 2{
                freightConf?.renewal = Int32(textfield.text!)
            }else if textfield.tag == 3{
                freightConf?.renewalFreight = Decimal(string: textfield.text!)
            }else{
                freightConf?.parcelConditions = Int32(textfield.text!)
            }
        }
    }
    
    
    
    //保存
    @objc func saveAction(saveBtn:UIButton){
        
        if (numberTextField.text?.count ?? 0) < 1 || (Int32(numberTextField.text ?? "0") ?? 0) < 1{
            JFPopup.toast(hit: "请添加件数")
            return
        }
        
        if (freeNumberTextField.text?.count ?? 0) < 1 || (Decimal(string: freeNumberTextField.text ?? "0") ?? 0) < 0.000001{
            JFPopup.toast(hit: "请添加运费")
            return
        }
        
        
//        if (addNumberTextField.text?.count ?? 0) < 1 || (Int32(addNumberTextField.text ?? "0") ?? 0) < 1{
//            JFPopup.toast(hit: "请添加增加件数")
//            return
//        }
//
//        if (addFreeNumberTextField.text?.count ?? 0) < 1 || (Decimal(string: addFreeNumberTextField.text ?? "0") ?? 0) < 0.000001{
//            JFPopup.toast(hit: "请添加增加件数运费")
//            return
//        }
//
//
//        if (packageTextField.text?.count ?? 0) < 1{
//            JFPopup.toast(hit: "请添加包邮的条件")
//            return
//        }
        
        
        //这边确定之后要返回上一个页面把这个模型回调上一个页面
        inputBlock!(freightConf!)
        Coordinator.shared?.popViewController(self, true)
        
        
    }

}


extension FreightAllocationViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count == 0{
           return true
        }
        let checkStr = (textField.text as? NSString)?.replacingCharacters(in: range, with: string)
        let regex = "^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$"
        return self.isValid(checkStr: checkStr!, regex: regex)
    }

    func isValid(checkStr:String, regex:String) ->Bool{
        let predicte = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicte.evaluate(with: checkStr)
    }

}

