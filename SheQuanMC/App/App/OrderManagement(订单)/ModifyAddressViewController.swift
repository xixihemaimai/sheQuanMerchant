//
//  ModifyAddressViewController.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class ModifyAddressViewController: BaseViewController {

    //原姓名
    lazy var nameTextView:UITextView = {
       let nameTextView = UITextView()
        nameTextView.placeholder = "姓名"
        nameTextView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        nameTextView.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        nameTextView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        nameTextView.textAlignment = .left
        return nameTextView
    }()
    
    
    //联系电话
    lazy var phoneNmberTextView:UITextView = {
       let phoneNmberTextView = UITextView()
        phoneNmberTextView.keyboardType = .phonePad
        phoneNmberTextView.placeholder = "电话号码"
        phoneNmberTextView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        phoneNmberTextView.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        phoneNmberTextView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        phoneNmberTextView.textAlignment = .left
        return phoneNmberTextView
    }()
    
    //地址
    lazy var choiceAddresssBtn:UIButton = {
       let choiceAddresssBtn = UIButton()
        choiceAddresssBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return choiceAddresssBtn
    }()
    
    lazy var addressLabel:UILabel = {
        let addressLabel = UILabel()
//        addressTextView.placeholder = "地址"
//        addressTextView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        addressLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addressLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        addressLabel.textAlignment = .left
       return addressLabel
    }()
    
    
    //详细地址
    lazy var detailAddressTextView:UITextView = {
        let detailAddressTextView = UITextView()
        detailAddressTextView.placeholder = "详细地址"
        detailAddressTextView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        detailAddressTextView.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        detailAddressTextView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        detailAddressTextView.textAlignment = .left
         return detailAddressTextView
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")

        
        let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        
        let originlNameLabel = UILabel()
        originlNameLabel.text = "收件姓名"
        originlNameLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        originlNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        originlNameLabel.textAlignment = .left
        view.addSubview(originlNameLabel)
        
        
        originlNameLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(topView.snp.bottom).offset(scale(16))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
        }
        
        view.addSubview(nameTextView)
        nameTextView.snp.makeConstraints { make in
            make.left.equalTo(originlNameLabel.snp.right).offset(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(36))
            make.top.equalTo(topView.snp.bottom).offset(scale(9))
        }
        
        
        let firstView = UIView()
        firstView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(firstView)
        
        firstView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalToSuperview()
            make.height.equalTo(scale(0.5))
            make.top.equalTo(nameTextView.snp.bottom).offset(scale(16))
        }
        
        
        let contactPhoneNumberLabel = UILabel()
        contactPhoneNumberLabel.text = "联系电话"
        contactPhoneNumberLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        contactPhoneNumberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        contactPhoneNumberLabel.textAlignment = .left
        view.addSubview(contactPhoneNumberLabel)
        
        
        contactPhoneNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(firstView.snp.bottom).offset(scale(16))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
        }
        
        view.addSubview(phoneNmberTextView)
        phoneNmberTextView.snp.makeConstraints { make in
            make.left.equalTo(contactPhoneNumberLabel.snp.right).offset(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(36))
            make.top.equalTo(firstView.snp.bottom).offset(scale(7))
        }
        
        
        
        let secondView = UIView()
        secondView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(secondView)
        
        secondView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalToSuperview()
            make.height.equalTo(scale(0.5))
            make.top.equalTo(phoneNmberTextView.snp.bottom).offset(scale(16))
        }
        
        
        view.addSubview(choiceAddresssBtn)
        choiceAddresssBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(secondView.snp.bottom)
            make.height.equalTo(scale(54))
        }
        
        choiceAddresssBtn.addTarget(self, action: #selector(locationAction), for: .touchUpInside)
        
        
        
        let creditCodeLabel = UILabel()
        creditCodeLabel.text = "所在地区"
        creditCodeLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        creditCodeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        creditCodeLabel.textAlignment = .left
        choiceAddresssBtn.addSubview(creditCodeLabel)
        
        creditCodeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
        }
        
        choiceAddresssBtn.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(creditCodeLabel.snp.right).offset(scale(16))
            make.height.equalTo(scale(36))
            make.right.equalTo(-scale(50))
        }
        
        
        let rightImage = UIImageView()
        rightImage.image = UIImage(named: "Frame-right")
        choiceAddresssBtn.addSubview(rightImage)
        
        rightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
        }
        
        
        
        
        let thirdView = UIView()
        thirdView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(thirdView)
        
        thirdView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalToSuperview()
            make.height.equalTo(scale(0.5))
            make.top.equalTo(choiceAddresssBtn.snp.bottom)
        }
        
        
        
        
        let detailAddressLabel = UILabel()
        detailAddressLabel.text = "详细地址"
        detailAddressLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        detailAddressLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        detailAddressLabel.textAlignment = .left
        view.addSubview(detailAddressLabel)
        
        
        detailAddressLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.height.equalTo(scale(22))
            make.top.equalTo(thirdView.snp.bottom).offset(scale(16))
            make.width.equalTo(scale(70))
        }
        
        
        view.addSubview(detailAddressTextView)
        detailAddressTextView.snp.makeConstraints { make in
            make.left.equalTo(detailAddressLabel.snp.right).offset(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(thirdView.snp.bottom).offset(scale(9))
            make.height.equalTo(scale(70))
        }
        
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(detailAddressTextView.snp.bottom)
            make.bottom.equalTo(-scale(92))
        }
        
        
        
        
        //提交
        let submitBtn = UIButton()
        submitBtn.setTitle("提交", for: .normal)
        submitBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        submitBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        view.addSubview(submitBtn)
        
        submitBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(-scale(44))
        }
        
        submitBtn.layer.cornerRadius = scale(4)
    }

    
    
    //所在地区
    @objc func locationAction(choiceAddresssBtn:UIButton){
        LXFLog("---------------------")
        let pickerView = BHJPickerView.init(self, .address)
        pickerView.pickerViewShow()
    }
}

extension ModifyAddressViewController:PickerDelegate{
    
    func selectedDate(_ pickerView: BHJPickerView, _ dateStr: Date) {
        
    }
    
    func selectedGender(_ pickerView: BHJPickerView, _ genderStr: String) {
        
    }
    
    func selectedAddress(_ pickerView: BHJPickerView, _ procince: AddressModel, _ city: AddressModel, _ area: AddressModel) {
        let messge = procince.region_name! + city.region_name! + area.region_name!
        addressLabel.text = messge
    }
}
