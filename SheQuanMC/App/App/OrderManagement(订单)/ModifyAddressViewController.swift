//
//  ModifyAddressViewController.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util
import JFPopup
import SwiftyJSON

class ModifyAddressViewController: BaseViewController {

    
    
    
    
    //原姓名
    lazy var nameTextView:UITextView = {
       let nameTextView = UITextView()
        nameTextView.placeholder = "请输入"
        nameTextView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        nameTextView.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        nameTextView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        nameTextView.delegate = self
        nameTextView.textAlignment = .left
        return nameTextView
    }()
    
    
    //删除原姓名的按键
    lazy var deleteNameBtn:UIButton = {
       let deleteNameBtn = UIButton()
        deleteNameBtn.setBackgroundImage(UIImage(named: "Frame"), for: .normal)
        deleteNameBtn.isHidden = true
        deleteNameBtn.addTarget(self, action: #selector(deleteNameAction), for: .touchUpInside)
        return deleteNameBtn
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
        phoneNmberTextView.delegate = self
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
        addressLabel.text = "请选择"
        addressLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
//        addressTextView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        addressLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
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
        detailAddressTextView.delegate = self
        return detailAddressTextView
    }()
    
    
    lazy var deleteAddressBtn:UIButton = {
       let deleteAddressBtn = UIButton()
        deleteAddressBtn.setBackgroundImage(UIImage(named: "Frame"), for: .normal)
        deleteAddressBtn.isHidden = true
        deleteAddressBtn.addTarget(self, action: #selector(deleteAddressAction), for: .touchUpInside)
        return deleteAddressBtn
    }()
    
    
    
    lazy var isDefaultSwitch:UISwitch = {
       let isDefaultSwitch = UISwitch()
        isDefaultSwitch.isOn = false
        isDefaultSwitch.onTintColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        isDefaultSwitch.addTarget(self, action: #selector(isDefaultSwitchAction), for: .touchUpInside)
        return isDefaultSwitch
    }()
    
    
    //省份数组
    var provinceList:[RegionInfoModel] = [RegionInfoModel]()
    
    var addressList:[RegionInfoModel] = [RegionInfoModel]()
    
    var retAddressInfoModel:RetAddressInfoModel?
    
    
    var updateAndAddSuccessBlock:(()->Void)?
    
    
    
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
        originlNameLabel.text = "收件人"
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
            make.right.equalTo(-scale(40))
            make.height.equalTo(scale(36))
            make.top.equalTo(topView.snp.bottom).offset(scale(9))
        }
        
        
        view.addSubview(deleteNameBtn)
        deleteNameBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(topView.snp.bottom).offset(scale(15))
            make.width.height.equalTo(scale(24))
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
            make.right.equalTo(-scale(40))
            make.top.equalTo(thirdView.snp.bottom).offset(scale(9))
            make.height.equalTo(scale(70))
        }
        
        
        
        view.addSubview(deleteAddressBtn)
        deleteAddressBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(thirdView.snp.bottom).offset(scale(15))
            make.width.height.equalTo(scale(24))
        }
        
        
        
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        view.addSubview(midView)
        
        midView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(detailAddressTextView.snp.bottom)
            make.height.equalTo(scale(8))
        }
        
        
        let isdelutLabel = UILabel()
        isdelutLabel.text = "设为默认地址"
        isdelutLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        isdelutLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        isdelutLabel.textAlignment = .left
        view.addSubview(isdelutLabel)
        
        isdelutLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(midView.snp.bottom).offset(scale(16))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(120))
        }
        
        
        
        view.addSubview(isDefaultSwitch)
        isDefaultSwitch.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.width.equalTo(scale(51))
            make.height.equalTo(scale(30))
            make.top.equalTo(midView.snp.bottom).offset(scale(12))
        }
        
        
        
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(isDefaultSwitch.snp.bottom).offset(scale(12))
            make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
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
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        submitBtn.layer.cornerRadius = scale(4)
        submitBtn.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        
        
        if title == "添加新地址"{
            retAddressInfoModel = RetAddressInfoModel(address: detailAddressTextView.text, cityId: 0, cityName: "", consignee: nameTextView.text, isDef: isDefaultSwitch.isOn, mobile: phoneNmberTextView.text, provinceId: 0, provinceName: "", regionId: 0, regionName: "", retAddressId: 0, zipCode: "")
        }else{
            
            nameTextView.text = retAddressInfoModel?.consignee
            if nameTextView.text.count > 0 {
                deleteNameBtn.isHidden = false
            }else{
                deleteNameBtn.isHidden = true
            }
            
            
            phoneNmberTextView.text = retAddressInfoModel?.mobile
            
            addressLabel.text = String(format: "%@%@%@", retAddressInfoModel?.provinceName ?? "",retAddressInfoModel?.cityName ?? "",retAddressInfoModel?.regionName ?? "")
            addressLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            
            detailAddressTextView.text = retAddressInfoModel?.address
            
            if detailAddressTextView.text.count > 0 {
                deleteAddressBtn.isHidden = false
            }else{
                deleteAddressBtn.isHidden = true
            }
            
            
            isDefaultSwitch.isOn = retAddressInfoModel?.isDef == true ? true : false
            
        }
        

        let parameters = ["freightVerId":0 as Any,"level":2,"regionId":0,"subHierarchy":2] as [String:Any]
        NetWorkResultRequest(OrderApi.getFreightRegionList(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<[RegionInfoModel]>.self, from: data) else { return }
            self?.provinceList.removeAll()
            if let _data = model.data{
                self?.provinceList = _data
            }
        } failureCallback: { error, code in
            code.loginOut()
        }
        
        
    }

    
    //删除收件人
    @objc func deleteNameAction(deleteNameBtn:UIButton){
        nameTextView.text = ""
        deleteNameBtn.isHidden = true
        
        retAddressInfoModel?.consignee = nameTextView.text
    }
    
    //删除详细地址
    @objc func deleteAddressAction(deleteAddressBtn:UIButton){
        detailAddressTextView.text = ""
        deleteAddressBtn.isHidden = true
        
        retAddressInfoModel?.address = detailAddressTextView.text
    }
    
    //修改是否默认
    @objc func isDefaultSwitchAction(isDefaultSwitch:UISwitch){
        isDefaultSwitch.isOn = isDefaultSwitch.isOn
        retAddressInfoModel?.isDef = isDefaultSwitch.isOn
    }
    
    //提交
    @objc func submitAction(submitBtn:UIButton){
        let parameters = ["address":retAddressInfoModel?.address as Any,"cityId":retAddressInfoModel?.cityId as Any,"consignee":retAddressInfoModel?.consignee as Any,"isDef":retAddressInfoModel?.isDef as Any,"mobile":retAddressInfoModel?.mobile as Any,"provinceId":retAddressInfoModel?.provinceId as Any,"regionId":retAddressInfoModel?.regionId as Any,"retAddressId":retAddressInfoModel?.retAddressId as Any,"zipCode":retAddressInfoModel?.zipCode as Any] as [String:Any]
        NetWorkResultRequest(OrderApi.updateRetAddress(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
            //成功之后
            self?.updateAndAddSuccessBlock?()
            Coordinator.shared?.popViewController(self!, true)
        } failureCallback: { error, code in
            code.loginOut()
        }
    }
    
    
    
    //所在地区
    @objc func locationAction(choiceAddresssBtn:UIButton){
        LXFLog("---------------------")
          //let pickerView = BHJPickerView.init(self, .address)
          //pickerView.pickerViewShow()
          //var str = "福建省(龙岩市、厦门市、漳州市)"
          //str = str.replacingOccurrences(of: "(", with: "", options: .literal, range: nil)
          //str = str.replacingOccurrences(of: "、", with: "", options: .literal, range: nil)
          //str = str.replacingOccurrences(of: ")", with: "", options: .literal, range: nil)
          //LXFLog(str)
          //let parser = MMLocationParser.init(loation: str)
          //LXFLog(parser.location)
          //LXFLog(parser.province)
          //LXFLog(parser.city)
          //LXFLog(parser.area)
          //LXFLog(parser.town)
          //LXFLog(parser.street)
          //LXFLog(parser.name)
          //LXFLog(parser.results)
          //parser.results
          //有三个就是0位省 1为城市 2为区县
          //有俩个就是0位省 1为城市
          //if parser.results.count > 2{
          // //省  市  区
          //}else{
          // //省  市
          //}
        if (addressLabel.text?.count ?? 0) > 0{
            
            self.addressList.removeAll()
            if (retAddressInfoModel?.provinceName?.count ?? 0) > 0{
               //省
                let regionInfoModel = RegionInfoModel(initials: "", lat: 0, level: 2, lng: 0, regionId: retAddressInfoModel?.provinceId, regionName: retAddressInfoModel?.provinceName, checked: false, childNodes: [RegionInfoModel]())
               self.addressList.append(regionInfoModel)
            }
            
            if (retAddressInfoModel?.cityName?.count ?? 0) > 0{
                //城市
                let regionInfoModel = RegionInfoModel(initials: "", lat: 0, level: 3, lng: 0, regionId: retAddressInfoModel?.cityId, regionName: retAddressInfoModel?.cityName, checked: false, childNodes: [RegionInfoModel]())
                self.addressList.append(regionInfoModel)
            }
            
            if (retAddressInfoModel?.regionName?.count ?? 0) > 0{
                //地区
                let regionInfoModel = RegionInfoModel(initials: "", lat: 0, level: 4, lng: 0, regionId: retAddressInfoModel?.regionId, regionName: retAddressInfoModel?.regionName, checked: false, childNodes: [RegionInfoModel]())
                self.addressList.append(regionInfoModel)
            }
            //self.addressList 为有值得情况
            //这边要进行设置
            //要先判断addressList有几个才进行设置值
            //省份已经有了
            //城市可以通过这个省份的regid获取
        }else{
            //self.addressList 为新建
            self.addressList = [RegionInfoModel]()
        }
        self.popup.bottomSheet {
            let regionView = RegionView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(442)), addressList: self.addressList,dataArray: self.provinceList)
            regionView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            regionView.sureChoiceAddress = {[weak self] list in
                self?.addressList = list
                var addressText:String = ""
                self?.addressList.forEach({ addressModel in
                    addressText += (addressModel.regionName ?? "")
                })
                self?.addressLabel.text = addressText
                //添加数组
                for i in 0..<(self?.addressList.count ?? 0){
                    let regionInfoModel = self?.addressList[i]
                    if i == 0{
                        self?.retAddressInfoModel?.provinceId = regionInfoModel?.regionId
                        self?.retAddressInfoModel?.provinceName = regionInfoModel?.regionName
                    }else if i == 1{
                        self?.retAddressInfoModel?.cityId = regionInfoModel?.regionId
                        self?.retAddressInfoModel?.cityName = regionInfoModel?.regionName
                    }else{
                        self?.retAddressInfoModel?.regionId = regionInfoModel?.regionId
                        self?.retAddressInfoModel?.regionName = regionInfoModel?.regionName
                    }
                }
                self?.addressLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
                self?.popup.dismissPopup()
            }
            return regionView
        }
    }
}



//extension ModifyAddressViewController:PickerDelegate{
//
//    func selectedDate(_ pickerView: BHJPickerView, _ dateStr: Date) {
//
//    }
//
//    func selectedGender(_ pickerView: BHJPickerView, _ genderStr: String) {
//
//    }
//
//    func selectedAddress(_ pickerView: BHJPickerView, _ procince: AddressModel, _ city: AddressModel, _ area: AddressModel) {
//        let messge = procince.region_name! + city.region_name! + area.region_name!
//        addressLabel.text = messge
//    }
//}


extension ModifyAddressViewController:UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == nameTextView{
            
            retAddressInfoModel?.consignee = textView.text
            
            if textView.text.count > 0 {
                deleteNameBtn.isHidden = false
            }else{
                deleteNameBtn.isHidden = true
            }
        }else if textView == phoneNmberTextView{
           
            retAddressInfoModel?.mobile = textView.text
             
        }else{
            
            retAddressInfoModel?.address = textView.text
            
            
            if textView.text.count > 0 {
                deleteAddressBtn.isHidden = false
            }else{
                deleteAddressBtn.isHidden = true
            }
        }
    }
    
    
}
