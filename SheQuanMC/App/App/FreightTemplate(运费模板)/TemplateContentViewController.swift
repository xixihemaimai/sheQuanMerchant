//
//  TemplateContentViewController.swift
//  App
//
//  Created by mac on 2022/5/12.
//

import UIKit
import Util
import JFPopup

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
        templateNameTextFiled.addTarget(self, action: #selector(templateNameEditChangeAction), for: .editingChanged)
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
    
    
    //完成
    lazy var completeBtn:UIButton = {
       let completeBtn = UIButton()
        completeBtn.setTitle("完成", for: .normal)
        completeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        completeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        completeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        completeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        completeBtn.isEnabled = false
        return completeBtn
    }()
    
    
    
    
    //模型的数据
    var freightListModel:FreightListModel?
    //用来判断是0位新建，1为编辑
    var type:Int = 0
    
    var _pieceLabel:UILabel!
    
    
    //新建/更新成功之后进行的回调
    var newAndUpdateBlock:(()->Void)?
    
    
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
        _pieceLabel = pieceLabel
        
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
        
        view.addSubview(completeBtn)
        completeBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        completeBtn.layer.cornerRadius = scale(4)
        completeBtn.addTarget(self, action: #selector(completeAction), for: .touchUpInside)
        
        
        
        //这边要区分是修改还是新建
        if type == 0{
            
            freightListModel = FreightListModel(chargeType: Int32(1), chargeTypeText: "按件计费", defTemp: false, freightConf: freightConfModel(firstPiece: 0, freight: 0, freightConfId: 0,parcelConditions: 0, renewal: 0, renewalFreight: 0), freightId: Int64(0), freightType: Int32(1), freightTypeText: "包邮", freightVerId: Int32(0), noDeliveryRegionIds: [Int32](), templateName: "")
            //包邮的按键
            freeBtn.isSelected = true
            //自定义的按键
            customFreightBtn.isSelected = false
            //计费方式
            typeView.isHidden = true
            //运费配置
            freightConfigureBtn.isHidden = true
            //按件计费
            _pieceLabel.text = freightListModel?.chargeTypeText
            
            
            bottomView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(noDisBtn.snp.bottom)
                make.bottom.equalTo(-scale(92))
            }
            
            
            
            
        }else{
            
            //这边要看是包邮，还是自定义
            templateNameTextFiled.text = freightListModel?.templateName
            //按件计费
            _pieceLabel.text = freightListModel?.chargeTypeText
            
            //freightType运费类型
            if freightListModel?.freightType == Int32(1){
                //包邮
                freeBtn.isSelected = true
                customFreightBtn.isSelected = false
                
                //计费方式
                typeView.isHidden = true
                //运费配置
                freightConfigureBtn.isHidden = true
                
                bottomView.snp.remakeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.top.equalTo(noDisBtn.snp.bottom)
                    make.bottom.equalTo(-scale(92))
                }
                
            }else{
                //自定义
                freeBtn.isSelected = false
                customFreightBtn.isSelected = true
                //计费方式
                typeView.isHidden = false
                //运费配置
                freightConfigureBtn.isHidden = false
                
                bottomView.snp.remakeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.top.equalTo(freightConfigureBtn.snp.bottom)
                    make.bottom.equalTo(-scale(92))
                }
            }
            //noSettingLabeL 暂未设置
            if (freightListModel?.noDeliveryRegionIds?.count ?? 0 ) < 1{
                noSettingLabeL.text = "暂未设置"
                noSettingLabeL.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
            }else{
                noSettingLabeL.text = "已设置"
                noSettingLabeL.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            }
            
            //freightConfigureLabel 未配置
            if freightListModel?.freightConf?.firstPiece == 0 && freightListModel?.freightConf?.freight == 0 && freightListModel?.freightConf?.parcelConditions == 0 && freightListModel?.freightConf?.renewal == 0 && freightListModel?.freightConf?.renewalFreight == 0{
                freightConfigureLabel.text = "未配置"
                freightConfigureLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
            }else{
                freightConfigureLabel.text = "已配置"
                freightConfigureLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            }
            
            if (templateNameTextFiled.text?.count ?? 0) < 1{
                completeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
                completeBtn.isEnabled = false
            }else{
                completeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
                completeBtn.isEnabled = true
            }
        }
    }
    
    
    //完成
    @objc func completeAction(completeBtn:UIButton){
        
        if (templateNameTextFiled.text?.count ?? 0) < 1{
            JFPopup.toast(hit: "请填写模板名称")
            return
        }
        
        //这边是进行新建/更新运费模板
//        freightListModel
//
          /**
           {
             "chargeType": 0,
             "freightConf": {
               "firstPiece": 0,
               "freight": 0,
               "freightConfId": 0,
               "parcelConditions": 0,
               "renewal": 0,
               "renewalFreight": 0
             },
             "freightId": 0,
             "freightType": 0,
             "freightVerId": 0,
             "noDeliveryAreaIds": [
               0
             ],
             "templateName": "string"
           }
           */

        //运费配置
        let freightConfDict = ["firstPiece":freightListModel?.freightConf?.firstPiece as Any,"freight":freightListModel?.freightConf?.freight as Any,"freightConfId":freightListModel?.freightConf?.freightConfId as Any,"parcelConditions":freightListModel?.freightConf?.parcelConditions as Any,"renewal":freightListModel?.freightConf?.renewal as Any,"renewalFreight":freightListModel?.freightConf?.renewalFreight as Any] as [String:Any]
        let jsonstring = getJSONStringFromData(obj: freightConfDict, isEscape: true)
        
//        LXFLog("===============\(jsonstring)")
        //不配送区域
//        freightListModel?.noDeliveryAreaIds?.append(2)
//        freightListModel?.noDeliveryAreaIds?.append(3)
//        freightListModel?.noDeliveryAreaIds?.append(4)
        var resultstr = "["
        for i in 0..<(freightListModel?.noDeliveryRegionIds?.count ?? 0){
            guard let value = freightListModel?.noDeliveryRegionIds?[i] else{
                return
            }
//            let values = Int32(truncating: value as? NSNumber ?? 0)
            if i == 0{
                resultstr += String(format: "%d",value)
            }else{
                resultstr += ","  + String(format: "%d",value)
            }
        }
        resultstr += "]"
//        LXFLog("=====================\(resultstr)")
        let parameters = ["chargeType":freightListModel?.chargeType as Any,"freightConf":jsonstring,"freightId":freightListModel?.freightId as Any,"freightType":freightListModel?.freightType as Any,"freightVerId":freightListModel?.freightVerId as Any,"noDeliveryRegionIds":(resultstr.count > 0 ? resultstr : [Int32]()),"templateName":freightListModel?.templateName as Any] as [String:Any]
        NetWorkResultRequest(OrderApi.freightTemplate(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
            //成功之后要返回上一个界面进行刷新
            self?.newAndUpdateBlock?()
            Coordinator.shared?.popViewController(self!, true)
        } failureCallback: { error, code in
            code.loginOut()
        }
    }
    
    //不配送区域
    @objc func noDisAction(noDisBtn:UIButton){
        let noDeliveryVc = NoDeliveryViewController()
//        noDeliveryVc.noDeliveryAreaIds = freightListModel?.noDeliveryAreaIds ?? [Int32]()
        noDeliveryVc.freightListModel = freightListModel
        Coordinator.shared?.pushViewController(self, noDeliveryVc, animated: true)
        //这边是一个数组
        noDeliveryVc.noDeliveryCompleteBlock = {[weak self] freightListModel in
            self?.freightListModel = freightListModel
            if (self?.freightListModel?.noDeliveryRegionIds?.count ?? 0) > 0{
                self?.noSettingLabeL.text = "已设置"
                self?.noSettingLabeL.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            }else{
                self?.noSettingLabeL.text = "暂未设置"
                self?.noSettingLabeL.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
            }
        }
    }
    
    //运费配置
    @objc func freightConfigureAction(freightConfigureBtn:UIButton){
        let freightAllocationVc = FreightAllocationViewController()
        freightAllocationVc.freightConf = freightListModel?.freightConf
        Coordinator.shared?.pushViewController(self, freightAllocationVc, animated: true)
        freightAllocationVc.inputBlock = {[weak self] freightConf in
            self?.freightListModel?.freightConf = freightConf
            //是否配置
            self?.freightConfigureLabel.text = "已配置"
            self?.freightConfigureLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        }
    }
    
    //包邮
    @objc func choiceFreeAction(freeBtn:UIButton){
        freeBtn.isSelected = !freeBtn.isSelected
        
        if freeBtn.isSelected{
            customFreightBtn.isSelected = false
            typeView.isHidden = true
            freightConfigureBtn.isHidden = true
            bottomView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(noDisBtn.snp.bottom)
                make.bottom.equalTo(-scale(92))
            }
            freightListModel?.freightType = Int32(1)
            freightListModel?.freightTypeText = "包邮"
            
            
        }else{
            customFreightBtn.isSelected = true
            freightListModel?.freightType = Int32(2)
            freightListModel?.freightTypeText = "自定义"

            typeView.isHidden = false
            freightConfigureBtn.isHidden = false
            bottomView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(freightConfigureBtn.snp.bottom)
                make.bottom.equalTo(-scale(92))
            }
        }
    }
    
    
    //自定义运费
    @objc func choiceCustomAction(customFreightBtn:UIButton){
        customFreightBtn.isSelected = !customFreightBtn.isSelected
        if customFreightBtn.isSelected{
            freeBtn.isSelected = false
            typeView.isHidden = false
            freightConfigureBtn.isHidden = false
            bottomView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(freightConfigureBtn.snp.bottom)
                make.bottom.equalTo(-scale(92))
            }
            freightListModel?.freightType = Int32(2)
            freightListModel?.freightTypeText = "自定义"
            
        }else{
            freeBtn.isSelected = true
            freightListModel?.freightType = Int32(1)
            freightListModel?.freightTypeText = "包邮"
            typeView.isHidden = true
            freightConfigureBtn.isHidden = true
            bottomView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(noDisBtn.snp.bottom)
                make.bottom.equalTo(-scale(92))
            }
        }
    }
    
    @objc func templateNameEditChangeAction(templateNameTextFiled:UITextField){
        if (templateNameTextFiled.text?.count ?? 0) > 0{
            freightListModel?.templateName = templateNameTextFiled.text
            completeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
            completeBtn.isEnabled = true
        }else{
            freightListModel?.templateName = ""
            completeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
            completeBtn.isEnabled = false
        }
    }
    
}
