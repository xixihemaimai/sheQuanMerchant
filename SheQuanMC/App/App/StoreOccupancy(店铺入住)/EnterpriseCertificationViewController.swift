//
//  EnterpriseCertificationViewController.swift
//  App
//
//  Created by mac on 2022/4/27.
//

import UIKit
import Util
import JFPopup
import HXPhotoPicker
import SwiftyJSON

import SDWebImage

class EnterpriseCertificationViewController: BaseViewController {

    
    //这边对图片管理进行懒加载
    lazy var manager:HXPhotoManager = {
        let manager = HXPhotoManager()
        manager.configuration.openCamera = true
        manager.configuration.photoMaxNum = 1
        //是否可以单选模式下选择图片跳转到编辑界面
        manager.configuration.singleJumpEdit = true
        //是否可以裁剪
        manager.configuration.movableCropBox = true
        //是否可以移动裁剪编辑大小
        manager.configuration.movableCropBoxEditSize = true
        //是否可以保存到媒体库
        manager.configuration.saveSystemAblum = true
        manager.configuration.hideOriginalBtn = false
        return manager
    }()
    
    //企业名称 enterpriseName
    
    lazy var scorllview:UIScrollView = {
       let scorllview = UIScrollView()
//        scorllview.showsHorizontalScrollIndicator = false
//        scorllview.showsVerticalScrollIndicator = false
       return scorllview
    }()
    

    lazy var epNameLabel:UILabel = {
       let epNameLabel = UILabel()
        epNameLabel.textAlignment = .left
        epNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        epNameLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        epNameLabel.text = "企业名称"
        return epNameLabel
    }()
    
    lazy var epNameTextField:UITextField = {
         let epNameTextField = UITextField()
        epNameTextField.placeholder = "请输入企业名称"
        epNameTextField.clearButtonMode = .whileEditing
        epNameTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入企业名称", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        epNameTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        epNameTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        epNameTextField.tag = 0
        epNameTextField.addTarget(self, action: #selector(entInfoAction), for: .editingDidEnd)
        return epNameTextField
    }()
    
    lazy var epNameDiviver:UIView = {
       let epNameDiviver = UIView()
        epNameDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return epNameDiviver
    }()
    
    
    
    //企业地址 enterpriseAddress
    
    lazy var epdLabel:UILabel = {
       let epdLabel = UILabel()
        epdLabel.textAlignment = .left
        epdLabel.isUserInteractionEnabled = true
        epdLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        epdLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        epdLabel.text = "企业地址"
        return epdLabel
    }()
    
    lazy var epdTextField:UITextField = {
         let epdTextField = UITextField()
        epdTextField.placeholder = "请输入企业地址"
        epdTextField.clearButtonMode = .whileEditing
        epdTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入企业地址", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        epdTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        epdTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        epdTextField.tag = 1
        epdTextField.addTarget(self, action: #selector(entInfoAction), for: .editingDidEnd)
        return epdTextField
    }()
    
    lazy var epdDiviver:UIView = {
       let epdDiviver = UIView()
        epdDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return epdDiviver
    }()
    
    //信用代码 credit
    
    lazy var creditLabel:UILabel = {
       let creditLabel = UILabel()
        creditLabel.textAlignment = .left
        creditLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        creditLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        creditLabel.text = "信用代码"
        return creditLabel
    }()
    
    lazy var creditTextField:UITextField = {
         let creditTextField = UITextField()
        creditTextField.placeholder = "请输入信用代码/注册号"
        creditTextField.clearButtonMode = .whileEditing
        creditTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入信用代码/注册号", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        creditTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        creditTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        creditTextField.tag = 2
        creditTextField.addTarget(self, action: #selector(entInfoAction), for: .editingDidEnd)
        return creditTextField
    }()
    
    lazy var creditDiviver:UIView = {
       let creditDiviver = UIView()
        creditDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return creditDiviver
    }()
    
    
    //法人姓名 legalName
    
    
    lazy var legalNameLabel:UILabel = {
       let legalNameLabel = UILabel()
        legalNameLabel.textAlignment = .left
        legalNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        legalNameLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        legalNameLabel.text = "法人姓名"
        return legalNameLabel
    }()
    
    lazy var legalNameTextField:UITextField = {
         let legalNameTextField = UITextField()
        legalNameTextField.placeholder = "请输入法人姓名"
        legalNameTextField.clearButtonMode = .whileEditing
        legalNameTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入法人姓名", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        legalNameTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        legalNameTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        legalNameTextField.tag = 3
        legalNameTextField.addTarget(self, action: #selector(entInfoAction), for: .editingDidEnd)
        return legalNameTextField
    }()
    
    lazy var legalNameDiviver:UIView = {
       let legalNameDiviver = UIView()
        legalNameDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return legalNameDiviver
    }()
    
    
    //身份证号 idCard
    
    lazy var idCardLabel:UILabel = {
       let idCardLabel = UILabel()
        idCardLabel.textAlignment = .left
        idCardLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        idCardLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        idCardLabel.text = "身份证号"
        return idCardLabel
    }()
    
    lazy var idCardTextField:UITextField = {
         let idCardTextField = UITextField()
        idCardTextField.placeholder = "请输入法人身份证号"
        idCardTextField.clearButtonMode = .whileEditing
        idCardTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入法人身份证号", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        idCardTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        idCardTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        idCardTextField.tag = 4
        idCardTextField.addTarget(self, action: #selector(entInfoAction), for: .editingDidEnd)
        return idCardTextField
    }()
    
//    lazy var idCardDiviver:UIView = {
//       let idCardDiviver = UIView()
//        idCardDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
//        return idCardDiviver
//    }()
    
    
    //法人证件信息 legalInformation
    
    lazy var leInLabel:UILabel = {
      let leInLabel = UILabel()
        leInLabel.text = "    法人证件信息"
        leInLabel.textAlignment = .left
        leInLabel.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        leInLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#818181")
        leInLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return leInLabel
    }()
    
    
    lazy var leInView:UIView = {
        let leInView = UIView()
        leInView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return leInView
    }()
    
    //正面
    lazy var cardFrontBtn:UIButton = {
       let cardFrontBtn = UIButton()
        cardFrontBtn.setBackgroundImage(UIImage(named: "Group 2743"), for: .normal)
        return cardFrontBtn
    }()
    
    
    lazy var cardFrontLabel:UILabel = {
        let cardFrontLabel = UILabel()
        cardFrontLabel.text = "身份证正面"
        cardFrontLabel.textAlignment = .center
        cardFrontLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        cardFrontLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        return cardFrontLabel
    }()
    
    lazy var cardFrontDeleteBtn:UIButton = {
       let cardFrontDeleteBtn = UIButton()
        cardFrontDeleteBtn.setBackgroundImage(UIImage(named: "Group 2746"), for: .normal)
        cardFrontDeleteBtn.isHidden = true
        return cardFrontDeleteBtn
    }()
    
    
    //反面
    lazy var cardBackBtn:UIButton = {
       let cardBackBtn = UIButton()
        cardBackBtn.setBackgroundImage(UIImage(named: "Group 2744"), for: .normal)
        return cardBackBtn
    }()

    
    lazy var cardBackLabel:UILabel = {
        let cardBackLabel = UILabel()
        cardBackLabel.text = "身份证反面"
        cardBackLabel.textAlignment = .center
        cardBackLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        cardBackLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        return cardBackLabel
    }()
    
    lazy var cardBackDeleteBtn:UIButton = {
       let cardBackDeleteBtn = UIButton()
        cardBackDeleteBtn.setBackgroundImage(UIImage(named: "Group 2746"), for: .normal)
        cardBackDeleteBtn.isHidden = true
        return cardBackDeleteBtn
    }()
    
    
    //营业执照信息 businessInformation
    lazy var bussInLabel:UILabel = {
      let bussInLabel = UILabel()
        bussInLabel.text = "    营业执照信息"
        bussInLabel.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        bussInLabel.textAlignment = .left
        bussInLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#818181")
        bussInLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return bussInLabel
    }()
    
    
    lazy var bussInView:UIView = {
        let bussInView = UIView()
        bussInView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return bussInView
    }()
    
    lazy var bussInBtn:UIButton = {
       let bussInBtn = UIButton()
        bussInBtn.setBackgroundImage(UIImage(named: "Group 2745"), for: .normal)
        bussInBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        bussInBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"), for: .normal)
        return bussInBtn
    }()
    
    
    lazy var bussInDeleteBtn:UIButton = {
       let bussInDeleteBtn = UIButton()
        bussInDeleteBtn.setBackgroundImage(UIImage(named: "Group 2746"), for: .normal)
        bussInDeleteBtn.isHidden = true
        return bussInDeleteBtn
    }()
    
    
    
    lazy var sureBtn:UIButton = {
       let sureBtn = UIButton()
        sureBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return sureBtn
    }()
    
    
    //0为没有的状态 审核中为1 审核失败为2
    var audit:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        title = "企业认证"
        view.addSubview(scorllview)
        scorllview.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }

        //企业名称
        scorllview.addSubview(epNameLabel)
        scorllview.addSubview(epNameTextField)
        scorllview.addSubview(epNameDiviver)
        
        
        epNameLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(16))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(22))
        }
//
        epNameTextField.snp.makeConstraints { make in
            make.top.equalTo(scale(12))
            make.left.equalTo(epNameLabel.snp.right).offset(scale(16))
            make.width.equalTo(SCW - (scale(16) * 2) - scale(85))
            make.height.equalTo(scale(30))
        }

        
        epNameDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(epNameTextField.snp.bottom).offset(scale(12))
            make.width.equalTo(SCW - scale(16))
            make.height.equalTo(scale(0.5))
        }
     
        //企业地址
        scorllview.addSubview(epdLabel)
        scorllview.addSubview(epdTextField)
        scorllview.addSubview(epdDiviver)

        epdLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(epNameDiviver.snp.bottom).offset(scale(16))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(22))
        }

        epdTextField.snp.makeConstraints { make in
            make.top.equalTo(epNameDiviver.snp.bottom).offset(scale(12))
            make.left.equalTo(epdLabel.snp.right).offset(scale(16))
            make.width.equalTo(SCW - (scale(16) * 2) - scale(85))
            make.height.equalTo(scale(30))
        }

        epdDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.width.equalTo(SCW - scale(16))
            make.top.equalTo(epdTextField.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(0.5))
        }

        //信用代码
        scorllview.addSubview(creditLabel)
        scorllview.addSubview(creditTextField)
        scorllview.addSubview(creditDiviver)


        creditLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(epdDiviver.snp.bottom).offset(scale(16))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(22))
        }

        creditTextField.snp.makeConstraints { make in
            make.top.equalTo(epdDiviver.snp.bottom).offset(scale(12))
            make.left.equalTo(creditLabel.snp.right).offset(scale(16))
            make.width.equalTo(SCW - (scale(16) * 2) - scale(85))
            make.height.equalTo(scale(30))
        }

        creditDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.width.equalTo(SCW - scale(16))
            make.top.equalTo(creditTextField.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(0.5))
        }

        //法人姓名
        scorllview.addSubview(legalNameLabel)
        scorllview.addSubview(legalNameTextField)
        scorllview.addSubview(legalNameDiviver)


        legalNameLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(creditDiviver.snp.bottom).offset(scale(16))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(22))
        }

        legalNameTextField.snp.makeConstraints { make in
            make.top.equalTo(creditDiviver.snp.bottom).offset(scale(12))
            make.left.equalTo(legalNameLabel.snp.right).offset(scale(16))
            make.width.equalTo(SCW - (scale(16) * 2) - scale(85))
            make.height.equalTo(scale(30))
        }

        legalNameDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.width.equalTo(SCW - scale(16))
            make.top.equalTo(legalNameTextField.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(0.5))
        }


        //身份证号
        scorllview.addSubview(idCardLabel)
        scorllview.addSubview(idCardTextField)

        idCardLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(legalNameDiviver.snp.bottom).offset(scale(16))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(22))
        }

        idCardTextField.snp.makeConstraints { make in
            make.top.equalTo(legalNameDiviver.snp.bottom).offset(scale(12))
            make.left.equalTo(idCardLabel.snp.right).offset(scale(16))
            make.width.equalTo(SCW - (scale(16) * 2) - scale(85))
            make.height.equalTo(scale(30))
        }
        
//        view.addSubview(idCardDiviver)
        
        //法人证件信息
        scorllview.addSubview(leInLabel)
        
        
        leInLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
            make.top.equalTo(idCardTextField.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(44))
        }
        
        scorllview.addSubview(leInView)
        
        
        leInView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
            make.top.equalTo(leInLabel.snp.bottom)
            make.height.equalTo(scale(163))
        }
        
        //正面
        leInView.addSubview(cardFrontBtn)
        leInView.addSubview(cardFrontLabel)
        cardFrontBtn.addSubview(cardFrontDeleteBtn)
        
        
        cardFrontBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(16))
            make.width.equalTo((SCW - (scale(16) * 2) - scale(12))/2)
            make.height.equalTo(scale(106))
        }
        cardFrontBtn.addTarget(self, action: #selector(relodIdCardFrontAction), for: .touchUpInside)
        cardFrontBtn.layer.cornerRadius = scale(4)
        cardFrontBtn.layer.masksToBounds = true
        cardFrontBtn.tag = 0
        cardFrontLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(cardFrontBtn.snp.bottom).offset(8)
            make.width.equalTo((SCW - (scale(16) * 2) - scale(12))/2)
            make.height.equalTo(scale(17))
        }
        
        
        cardFrontDeleteBtn.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.height.equalTo(scale(22))
        }
        
        cardFrontDeleteBtn.addTarget(self, action: #selector(deleteCardFrontAction), for: .touchUpInside)
        
        //反面
        leInView.addSubview(cardBackBtn)
        leInView.addSubview(cardBackLabel)
        cardBackBtn.addSubview(cardBackDeleteBtn)
        
        cardBackBtn.snp.makeConstraints { make in
            make.left.equalTo(cardFrontBtn.snp.right).offset(scale(12))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(106))
            make.top.equalTo(scale(16))
        }
        cardBackBtn.addTarget(self, action: #selector(relodIdCardBackAction), for: .touchUpInside)
        cardBackBtn.layer.cornerRadius = scale(4)
        cardBackBtn.layer.masksToBounds = true
        cardBackBtn.tag = 1
        cardBackLabel.snp.makeConstraints { make in
            make.left.equalTo(cardFrontLabel.snp.right).offset(scale(12))
            make.top.equalTo(cardBackBtn.snp.bottom).offset(8)
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(17))
        }
        
        
        cardBackDeleteBtn.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.height.equalTo(scale(22))
        }
        cardBackDeleteBtn.addTarget(self, action: #selector(deleteCardBackAction), for: .touchUpInside)
        
        //营业执照信息
        scorllview.addSubview(bussInLabel)
        scorllview.addSubview(bussInView)
        
        bussInView.addSubview(bussInBtn)
        bussInBtn.addSubview(bussInDeleteBtn)
        
        
        bussInLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
            make.top.equalTo(leInView.snp.bottom)
            make.height.equalTo(scale(44))
        }
        
        bussInView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
            make.top.equalTo(bussInLabel.snp.bottom)
            make.height.equalTo(scale(134))
        }
        
        bussInBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.height.equalTo(scale(106))
        }
        
        bussInBtn.addTarget(self, action: #selector(bussinAction), for: .touchUpInside)
        bussInBtn.layer.cornerRadius = scale(4)
        bussInBtn.layer.masksToBounds = true
        bussInBtn.tag = 2
        bussInDeleteBtn.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.height.equalTo(scale(22))
        }
        
        bussInDeleteBtn.addTarget(self, action: #selector(deleteBussInAction), for: .touchUpInside)
        scorllview.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.width.equalTo(SCW - (scale(16) * 2))
            make.top.equalTo(bussInView.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(40))
        }
        sureBtn.layer.cornerRadius = scale(4)
        sureBtn.addTarget(self, action: #selector(sureEnterCerAction), for: .touchUpInside)
//        if audit > 0{
            //获取本地数据
            
            //企业名称
            epNameTextField.text = StoreService.shared.currentUser?.entName
            //企业地址
            epdTextField.text = StoreService.shared.currentUser?.entAddress
            //信用代码
            creditTextField.text = StoreService.shared.currentUser?.creditCode
            //法人姓名
            legalNameTextField.text = StoreService.shared.currentUser?.legalName
            //身份证号
            idCardTextField.text = StoreService.shared.currentUser?.certNo
            
        if (StoreService.shared.currentUser?.frontPic.count ?? 0) > 0{
            //身份证正面
             //cardFrontBtn.kf.setBackgroundImage(with: URL(string: StoreService.shared.currentUser?.frontPic ?? ""), for: .normal)
            cardFrontBtn.sd_setBackgroundImage(with: URL(string: StoreService.shared.currentUser?.frontPic ?? ""), for: .normal, placeholderImage: UIImage(named: "Group 2743"))
            cardFrontDeleteBtn.isHidden = false
        }else
        {
            cardFrontDeleteBtn.isHidden = true
        }
        if (StoreService.shared.currentUser?.reversePic.count ?? 0) > 0{
            //身份证反面
            //cardBackBtn.kf.setBackgroundImage(with: URL(string: StoreService.shared.currentUser?.reversePic ?? ""), for: .normal)
            //cardFrontBtn.kf.setBackgroundImage(with: URL(string: StoreService.shared.currentUser?.reversePic ?? ""), for: .normal, placeholder: UIImage(named: "Group 2744"), options: nil, progressBlock: nil, completionHandler: nil)
            cardBackBtn.sd_setBackgroundImage(with: URL(string: StoreService.shared.currentUser?.reversePic ?? ""), for: .normal, placeholderImage: UIImage(named: "Group 2744"))
            cardBackDeleteBtn.isHidden = false
        }else{
            cardBackDeleteBtn.isHidden = true
        }
        
        if (StoreService.shared.currentUser?.licencePic.count ?? 0) > 0{
            //营业执照
            //bussInBtn.kf.setBackgroundImage(with:  URL(string: StoreService.shared.currentUser?.licencePic ?? ""), for: .normal)
            //cardFrontBtn.kf.setBackgroundImage(with: URL(string: StoreService.shared.currentUser?.licencePic ?? ""), for: .normal, placeholder: UIImage(named: "Group 2745"), options: nil, progressBlock: nil, completionHandler: nil)
            bussInBtn.sd_setBackgroundImage(with: URL(string: StoreService.shared.currentUser?.licencePic ?? ""), for: .normal, placeholderImage: UIImage(named: "Group 2745"))
            bussInDeleteBtn.isHidden = false
        }else{
            bussInDeleteBtn.isHidden = true
        }
    }
    
    
    
    //输入相关企业信息
    @objc func entInfoAction(textfield:UITextField){
        if textfield.tag == 0 {
            guard let entName = textfield.text else {
                return
            }
            StoreService.shared.updateEntName(entName)
        }else if textfield.tag == 1{
            guard let entAddress = textfield.text else {
                return
            }
            StoreService.shared.updateEntAddress(entAddress)
        }else if textfield.tag == 2{
            guard let creditCode = textfield.text else {
                return
            }
            StoreService.shared.updateCreditCode(creditCode)
        }else if textfield.tag == 3{
            guard let legalName = textfield.text else {
                return
            }
            StoreService.shared.updateLegalName(legalName)
        }else{
            guard let certNo = textfield.text else {
                return
            }
            StoreService.shared.updateCertNo(certNo)
        }
    }
    
    
    
    //获取身份证的正面
    @objc func relodIdCardFrontAction(cardFrontBtn:UIButton){
        reloadPhotoManager(sender: cardFrontBtn)
    }
    
    //获取身份证的反面
    @objc func relodIdCardBackAction(cardBackBtn:UIButton){
        reloadPhotoManager(sender: cardBackBtn)
    }
    
    //获取营业执照
    @objc func bussinAction(bussinBtn:UIButton){
        reloadPhotoManager(sender: bussinBtn)
    }
    
    
    //获取营业执照，身份证正面和身份证背面
    func reloadPhotoManager(sender:UIButton){
        self.manager.clearSelectedList()
        self.popup.actionSheet {
            [
                JFPopupAction(with: "从手机相册选择", subTitle: nil, clickActionCallBack: { [weak self] in
                    self?.hx_presentSelectPhotoController(with: self?.manager, didDone: { allList, photoList, videoList, isOriginal, viewController, manager in
                        if let photoModel:HXPhotoModel = photoList?.first{
                            
                            photoModel.getAssetURL { url, photoModelMediaSubType, bool, HXPhotoModel in
                                let nsdata = NSData(contentsOf: url!)
                                let data:Data = nsdata! as Data
                            
                            //对图片进行
                            let Parameters = ["fileType":20]
                            JFPopupView.popup.loading(hit: "上传图片中....")
//                            guard let imageData = photoModel.thumbPhoto?.jpegData(compressionQuality: 0.3) else { return }//把图片转换成data
                            NetWorkResultRequest(StoreAppleApi.uploadFile(parameters: Parameters, imageDate: data), needShowFailAlert: true) { result, data in
                                do{
                                    LXFLog(data)
                                    let json = try JSON(data: data)
                                    LXFLog(json["data"]["cloudUrl"])
                                    if sender.tag == 0{
                                        let str = (json["data"]["cloudUrl"].string ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                        sender.sd_setBackgroundImage(with: URL(string: str), for: .normal, placeholderImage: UIImage(named: "Group 2743"))
                                        //身份证正面
                                        StoreService.shared.updateFrontPic(str)
                                        
                                    }else if sender.tag == 1{
                                        
                                        let str = (json["data"]["cloudUrl"].string ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                        sender.sd_setBackgroundImage(with: URL(string: str), for: .normal, placeholderImage: UIImage(named: "Group 2744"))
                                        //身份证方面
                                        StoreService.shared.updateReversePic(str)
                                    }else{
                                        let str = (json["data"]["cloudUrl"].string ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                        sender.sd_setBackgroundImage(with: URL(string: str), for: .normal, placeholderImage: UIImage(named: "Group 2745"))
                                        StoreService.shared.updateLicencePic(str)
                                    }
                                    //这边要判断删除是否显示
                                    if sender.tag == 0{
                                        self?.cardFrontDeleteBtn.isHidden = false
                                    }else if sender.tag == 1{
                                        self?.cardBackDeleteBtn.isHidden = false
                                    }else{
                                        self?.bussInDeleteBtn.isHidden = false
                                    }
                                }catch{}
                                
                                JFPopupView.popup.hideLoading()
                                
                            } failureCallback: { error,code in
                                JFPopupView.popup.hideLoading()
                            }
                            }
                        }
                    })
                }),
                JFPopupAction(with: "拍照", subTitle: nil, clickActionCallBack: {[weak self] in
                    self?.hx_presentCustomCameraViewController(with: self?.manager) { photoList, viewController in
//                        if let photoModel:HXPhotoModel = photoList{
                        photoList?.getAssetURL { url, photoModelMediaSubType, bool, HXPhotoModel in
                            let nsdata = NSData(contentsOf: url!)
                            let data:Data = nsdata! as Data
                            //对图片进行
                            let Parameters = ["fileType":20]
                            JFPopupView.popup.loading(hit: "上传图片中....")
//                            guard let imageData = photoModel.thumbPhoto?.jpegData(compressionQuality: 0.3) else { return }//把图片转换成data
                            NetWorkResultRequest(StoreAppleApi.uploadFile(parameters: Parameters, imageDate: data), needShowFailAlert: true) { result, data in
                                do{
                                    LXFLog(data)
                                    let json = try JSON(data: data)
                                    if sender.tag == 0{
                                        //身份证正面
                                        let str = (json["data"]["cloudUrl"].string ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                        sender.sd_setBackgroundImage(with: URL(string: str), for: .normal, placeholderImage: UIImage(named: "Group 2743"))
                                        StoreService.shared.updateFrontPic(str)
                                    }else if sender.tag == 1{
                                        let str = (json["data"]["cloudUrl"].string ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                        sender.sd_setBackgroundImage(with: URL(string: str), for: .normal, placeholderImage: UIImage(named: "Group 2744"))
                                        //身份证方面
                                        StoreService.shared.updateReversePic(str)
                                    }else{
                                        let str = (json["data"]["cloudUrl"].string ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                        sender.sd_setBackgroundImage(with: URL(string: str), for: .normal, placeholderImage: UIImage(named: "Group 2745"))
                                        StoreService.shared.updateLicencePic(str)
                                    }
                                    //这边要判断删除是否显示
                                    if sender.tag == 0{
                                        self?.cardFrontDeleteBtn.isHidden = false
                                    }else if sender.tag == 1{
                                        self?.cardBackDeleteBtn.isHidden = false
                                    }else{
                                        self?.bussInDeleteBtn.isHidden = false
                                    }
                                }catch{}
                                JFPopupView.popup.hideLoading()
                            } failureCallback: { error,code in
                                JFPopupView.popup.hideLoading()
                            }
                        }
                    } cancel: { viewController in
                    }
                })
            ]
        }
    }
    
    
    //删除身份证正面
    @objc func deleteCardFrontAction(cardFrontDeleteBtn:UIButton){
        cardFrontDeleteBtn.isHidden = true
        cardFrontBtn.setBackgroundImage(UIImage(named: "Group 2743"), for: .normal)
        StoreService.shared.updateFrontPic("")
    }
    
    //删除身份证反面
    @objc func deleteCardBackAction(cardBackDeleteBtn:UIButton){
        cardBackDeleteBtn.isHidden = true
        cardBackBtn.setBackgroundImage(UIImage(named: "Group 2744"), for: .normal)
        StoreService.shared.updateReversePic("")
    }
    
    //删除营业执照
    @objc func deleteBussInAction(bussInDeleteBtn:UIButton){
        bussInBtn.setBackgroundImage(UIImage(named: "Group 2745"), for: .normal)
        bussInDeleteBtn.isHidden = true
        StoreService.shared.updateLicencePic("")
    }
    
    
    //确定
    @objc func sureEnterCerAction(sureBtn:UIButton){
        LXFLog("确定")
        //判断哪些没有写
        if (epNameTextField.text?.count ?? 0) < 1{
            JFPopup.toast(hit: "企业名称错误")
            return
        }
        if (epdTextField.text?.count ?? 0) < 1{
            JFPopup.toast(hit: "企业地址错误")
            return
        }
        if (creditTextField.text?.count ?? 0) < 1{
            JFPopup.toast(hit: "信用代码错误")
            return
        }
        if (legalNameTextField.text?.count ?? 0) < 1{
            JFPopup.toast(hit: "法人姓名错误")
            return
        }
        if !(idCardTextField.text?.isValidIDCardNumber ?? true){
            JFPopup.toast(hit: "身份证号错误")
            return
        }

        if cardFrontBtn.currentImage == UIImage(named: "Group 2743"){
            JFPopup.toast(hit: "身份证正面图片错误")
            return
        }
        if cardBackBtn.currentImage == UIImage(named: "Group 2744"){
            JFPopup.toast(hit: "身份证反面图片错误")
            return
        }
        if bussInBtn.currentImage == UIImage(named: "Group 2745"){
            JFPopup.toast(hit: "营业执照图片错误")
            return
        }
        //企业认证
        let parameters = ["entName":(epNameTextField.text ?? ""),"entAddress":(epdTextField.text ?? ""),"creditCode":(creditTextField.text ?? ""),"legalName":(legalNameTextField.text ?? ""),"certNo":(idCardTextField.text ?? ""),"frontPic":(StoreService.shared.currentUser?.frontPic ?? ""),"reversePic":(StoreService.shared.currentUser?.reversePic ?? ""),"licencePic":(StoreService.shared.currentUser?.licencePic ?? "")] as [String:String]
        NetWorkResultRequest(StoreAppleApi.entCert(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
            let enterpriseAuditVc = EnterpriseAuditViewController()
            enterpriseAuditVc.audit = self!.audit
            Coordinator.shared?.pushViewController(self!, enterpriseAuditVc, animated: true)
//            JFPopup.toast(hit: "企业认证成功", icon: .success)

            
            let mutableArr1 = NSMutableArray(array: self?.navigationController?.viewControllers ?? [])
                for i in 0..<mutableArr1.count {
                let vc = mutableArr1[i] as! UIViewController
                if vc.isKind(of: StoreOccupancyViewController.self){
                    mutableArr1.removeObject(at: i)
                    break
                }
            }
            self?.navigationController?.viewControllers = mutableArr1 as! [UIViewController]
            
            
            
//            let mutableArr = NSMutableArray(array: self?.navigationController?.viewControllers ?? [])
            for i in 0..<mutableArr1.count {
                let vc = mutableArr1[i] as! UIViewController
                if vc.isKind(of: EnterpriseCertificationViewController.self){
                    mutableArr1.removeObject(at: i)
                    break
                }
            }
            self?.navigationController?.viewControllers = mutableArr1 as! [UIViewController]
            
          
            
        } failureCallback: { error,code in
        }
    }
    
    //解决uiscrollview不能滑动的问题
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scorllview.contentSize = CGSize(width:0, height: sureBtn.bottom + scale(20))
    }
}
