//
//  CommodityParametersViewController.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util
import JFPopup
import HXPhotoPicker
import SwiftyJSON

class CommodityParametersViewController: BaseViewController {
    
    
//    var parametersList:[String] = [String]()
    
    
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
    
   // 确认按键
    lazy var sureBtn:UIButton = {
       let sureBtn = UIButton()
        sureBtn.setTitle("确认", for: .normal)
        sureBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF"), for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        sureBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        return sureBtn
    }()
    
    
    
    
    //正品证书 -- 按键
    lazy var isUploadLabel:UILabel = {
       let isUploadLabel = UILabel()
        isUploadLabel.text = "未上传"
        isUploadLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
        isUploadLabel.textAlignment = .left
        isUploadLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return isUploadLabel
    }()
    
    
    
    
    //品牌
    lazy var brandNameLabel:UILabel = {
       let brandNameLabel = UILabel()
        brandNameLabel.text = "请选择"
        brandNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
        brandNameLabel.textAlignment = .left
        brandNameLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return brandNameLabel
    }()

    var paraList:[Spus] = [Spus]()
    
    //0为新发布，1位编辑
    var type:Int = 0
    
    
    //填写的参数确认返回上一个界面
    var sureParmeter:((_ spus:[Spus])->Void)?
    
    
    //生产场地
//    lazy var productionTextView:UITextView = {
//       let productionTextView = UITextView()
//        productionTextView.placeholder = "请输入"
//        productionTextView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
//        productionTextView.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        productionTextView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
//        productionTextView.tintColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
//        return productionTextView
//    }()
//
//    lazy var productionDeleteBtn:UIButton = {
//       let productionDeleteBtn = UIButton()
//        productionDeleteBtn.setBackgroundImage(UIImage(named: "Frame"), for: .normal)
//        return productionDeleteBtn
//    }()

    
    
    
    //风格
//    lazy var styleTextView:UITextView = {
//       let styleTextView = UITextView()
//        styleTextView.placeholder = "请输入"
//        styleTextView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
//        styleTextView.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        styleTextView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
//        styleTextView.tintColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
//        return styleTextView
//    }()
//
//    lazy var styleDeleteBtn:UIButton = {
//       let styleDeleteBtn = UIButton()
//        styleDeleteBtn.setBackgroundImage(UIImage(named: "Frame"), for: .normal)
//        return styleDeleteBtn
//    }()

    
    //材质
//    lazy var materialTextView:UITextView = {
//       let materialTextView = UITextView()
//        materialTextView.placeholder = "请输入"
//        materialTextView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
//        materialTextView.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        materialTextView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
//        materialTextView.tintColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
//        return materialTextView
//    }()
//
//    lazy var materialDeleteBtn:UIButton = {
//       let materialDeleteBtn = UIButton()
//        materialDeleteBtn.setBackgroundImage(UIImage(named: "Frame"), for: .normal)
//        return materialDeleteBtn
//    }()

    
    
    //增加一个UIView
    lazy var bottomView:UIView = {
       let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return bottomView
    }()
    
    
    
//    var _productionView:UIView!
//    var _styleView:UIView!
//    var _materialView:UIView!
    
    var _brandBtn:UIButton!
    
    
     //商品类目ID
    var categoryId:Int32 = 0
     //商品ID
    var productId:Int64 = Int64(0)
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "商品参数"
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(1))
            make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
        }
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(CommodityParameterCell.self, forCellReuseIdentifier: "CommodityParameterCell")
        if paraList.count > 0{
            //这边是已经填写过得
//            LXFLog("+============3===========\(paraList)")
            tableview.reloadData()
        }else{
            //这边是新进来的
            loadOrderSpuInfoList()
        }
        
        
        
        
        //正品证书
//        let certifiedBtn = UIButton()
//        certifiedBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
//        view.addSubview(certifiedBtn)
//
//        certifiedBtn.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(scale(1))
//            make.height.equalTo(scale(50))
//        }
//
//
//        certifiedBtn.addTarget(self, action: #selector(isUploadPitureAction), for: .touchUpInside)
//
//
//        let starLabel = UILabel()
//        starLabel.text = "*"
//        starLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#E82626")
//        starLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
//        certifiedBtn.addSubview(starLabel)
//
//        starLabel.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.centerY.equalToSuperview()
//            make.width.equalTo(scale(8))
//            make.height.equalTo(scale(20))
//        }
//
//
//        let qualityLabel = UILabel()
//        qualityLabel.text = "正品证书"
//        qualityLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
//        qualityLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        certifiedBtn.addSubview(qualityLabel)
//
//        qualityLabel.snp.makeConstraints { make in
//            make.left.equalTo(starLabel.snp.right).offset(scale(1))
//            make.centerY.equalToSuperview()
//            make.width.equalTo(scale(70))
//            make.height.equalTo(scale(22))
//        }
//
//
//        certifiedBtn.addSubview(isUploadLabel)
//        isUploadLabel.snp.makeConstraints { make in
//            //make.left.equalTo(scale(25))
//            make.left.equalTo(qualityLabel.snp.right).offset(scale(25))
//            make.centerY.equalToSuperview()
//            make.right.equalTo(-scale(40))
//            make.height.equalTo(scale(50))
//        }
//
//
//        let rightImage = UIImageView()
//        rightImage.image = UIImage(named: "Frame-right")
//        certifiedBtn.addSubview(rightImage)
//
//        rightImage.snp.makeConstraints { make in
//            make.right.equalTo(-scale(16))
//            make.width.height.equalTo(scale(24))
//            make.centerY.equalToSuperview()
//        }
//
//
//        let certifiedView = UIView()
//        certifiedView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
//        certifiedBtn.addSubview(certifiedView)
//
//        certifiedView.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.right.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.height.equalTo(scale(0.5))
//        }
//
//        //品牌
//
//        let brandBtn = UIButton()
//        brandBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
//        view.addSubview(brandBtn)
//
//        brandBtn.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(certifiedBtn.snp.bottom)
//            make.height.equalTo(scale(50))
//        }
//        _brandBtn = brandBtn
//
//        brandBtn.addTarget(self, action: #selector(choiceBrandAction), for: .touchUpInside)
//
//        let brandStarLabel = UILabel()
//        brandStarLabel.text = "*"
//        brandStarLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#E82626")
//        brandStarLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
//        brandBtn.addSubview(brandStarLabel)
//
//        brandStarLabel.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.centerY.equalToSuperview()
//            make.width.equalTo(scale(8))
//            make.height.equalTo(scale(20))
//        }
//
//        let brandLabel = UILabel()
//        brandLabel.text = "品牌"
//        brandLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
//        brandLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        brandBtn.addSubview(brandLabel)
//        brandLabel.snp.makeConstraints { make in
//            make.left.equalTo(starLabel.snp.right).offset(scale(1))
//            make.centerY.equalToSuperview()
//            make.width.equalTo(scale(70))
//            make.height.equalTo(scale(22))
//        }
//
//
//        brandBtn.addSubview(brandNameLabel)
//        brandNameLabel.snp.makeConstraints { make in
//            make.left.equalTo(brandLabel.snp.right).offset(scale(25))
//            make.centerY.equalToSuperview()
//            make.right.equalTo(-scale(40))
//            make.height.equalTo(scale(50))
//        }
//
//        let brandRightImage = UIImageView()
//        brandRightImage.image = UIImage(named: "Frame-right")
//        brandBtn.addSubview(brandRightImage)
//
//        brandRightImage.snp.makeConstraints { make in
//            make.right.equalTo(-scale(16))
//            make.centerY.equalToSuperview()
//            make.width.height.equalTo(scale(24))
//        }
//
//
//
//        let brandView = UIView()
//        brandView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
//        brandBtn.addSubview(brandView)
//
//        brandView.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.right.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.height.equalTo(scale(0.5))
//        }
        
        
       
        //生产场地 productionTextView
        
//        let productionView = UIView()
//        productionView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
//        view.addSubview(productionView)
//        productionView.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(brandBtn.snp.bottom)
//            make.height.equalTo(scale(50))
//        }
//
//
//        _productionView = productionView
//
//
//
//        let productLabel = UILabel()
//        productLabel.text = "生产场地"
//        productLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
//        productLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        productLabel.textAlignment = .left
//        productionView.addSubview(productLabel)
//
//        productLabel.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.centerY.equalToSuperview()
//            make.height.equalTo(scale(22))
//            make.width.equalTo(scale(70))
//        }
//
//
//        productionView.addSubview(productionTextView)
//
//        productionTextView.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.left.equalTo(productLabel.snp.right).offset(scale(32))
//            make.height.equalTo(scale(30))
//            make.right.equalTo(-scale(40))
//            make.bottom.equalTo(-scale(10))
//        }
//
//
//        productionTextView.delegate = self
//
//
//
//        productionView.addSubview(productionDeleteBtn)
//
//        productionDeleteBtn.snp.makeConstraints { make in
//            make.right.equalTo(-scale(16))
//            make.centerY.equalToSuperview()
//            make.width.height.equalTo(scale(24))
//        }
//
//        productionDeleteBtn.isHidden = true
//
//        productionDeleteBtn.addTarget(self, action: #selector(clearProductTextViewAction), for: .touchUpInside)
//
//        let productDiviver = UIView()
//        productDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
//        productionView.addSubview(productDiviver)
//
//        productDiviver.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.right.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.height.equalTo(scale(0.5))
//        }
//
//        //风格 styleTextView styleDeleteBtn
//        let styleView = UIView()
//        styleView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
//        view.addSubview(styleView)
//        styleView.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(productionView.snp.bottom)
//            make.height.equalTo(scale(50))
//        }
//
//        _styleView = styleView
//
//
//        let styleLabel = UILabel()
//        styleLabel.text = "风格"
//        styleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
//        styleLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        styleLabel.textAlignment = .left
//        styleView.addSubview(styleLabel)
//
//
//        styleLabel.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.centerY.equalToSuperview()
//            make.height.equalTo(scale(22))
//            make.width.equalTo(scale(70))
//        }
//
//
//        styleView.addSubview(styleTextView)
//        styleTextView.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.left.equalTo(styleLabel.snp.right).offset(scale(32))
//            make.height.equalTo(scale(30))
//            make.right.equalTo(-scale(40))
//            make.bottom.equalTo(-scale(10))
//        }
//
//        styleTextView.delegate = self
//
//
//
//
//        styleView.addSubview(styleDeleteBtn)
//        styleDeleteBtn.snp.makeConstraints { make in
//            make.right.equalTo(-scale(16))
//            make.centerY.equalToSuperview()
//            make.width.height.equalTo(scale(24))
//        }
//
//        styleDeleteBtn.isHidden = true
//        styleDeleteBtn.addTarget(self, action: #selector(clearStyleTextViewAction), for: .touchUpInside)
//
//        let styleDiviver = UIView()
//        styleDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
//        styleView.addSubview(styleDiviver)
//
//        styleDiviver.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.right.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.height.equalTo(scale(0.5))
//        }
//
//
////        //材质 materialTextView materialDeleteBtn
//        let materialView = UIView()
//        materialView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
//        view.addSubview(materialView)
//
//
//        _materialView = materialView
//
//
//        materialView.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(styleView.snp.bottom)
//            make.height.equalTo(scale(50))
//        }
//
//
//
//
//        let materialLabel = UILabel()
//        materialLabel.text = "材质"
//        materialLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
//        materialLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        materialLabel.textAlignment = .left
//        materialView.addSubview(materialLabel)
//
//        materialLabel.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.centerY.equalToSuperview()
//            make.height.equalTo(scale(22))
//            make.width.equalTo(scale(70))
//        }
//
//
//
//
//        materialView.addSubview(materialTextView)
//
//        materialTextView.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.left.equalTo(materialLabel.snp.right).offset(scale(32))
//            make.height.equalTo(scale(30))
//            make.right.equalTo(-scale(40))
//            make.bottom.equalTo(-scale(10))
//        }
//
//        materialTextView.delegate = self
//
//        materialView.addSubview(materialDeleteBtn)
//        materialDeleteBtn.snp.makeConstraints { make in
//            make.right.equalTo(-scale(16))
//            make.centerY.equalToSuperview()
//            make.width.height.equalTo(scale(24))
//        }
//
//        materialDeleteBtn.isHidden = true
//
//        materialDeleteBtn.addTarget(self, action: #selector(clearmaterialTextViewAction), for: .touchUpInside)
//
        
        
        
        
        
        
//        view.addSubview(tableview)
//
//        tableview.snp.makeConstraints { make in
//            make.left.top.right.bottom.equalToSuperview()
//        }
//
//        tableview.delegate = self
//        tableview.dataSource = self
//
//        tableview.register(CommodityParametersCell.self, forCellReuseIdentifier: "CommodityParametersCell")
//
//        parametersList = ["正品证书","品牌","参数一","参数二","参数三"]
//
        
        
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(tableview.snp.bottom)
            make.left.right.bottom.equalToSuperview()
//            make.height.equalTo(Height_TabBar)
//            make.height.equalTo(iPhoneX ? scale(92) : scale(58))
        }
        
        
        
        
        bottomView.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        sureBtn.layer.cornerRadius = scale(4)
        sureBtn.addTarget(self, action: #selector(sureAction), for: .touchUpInside)

        
        
        
        
    }
    
    //确认的按键
    @objc func sureAction(sureBtn:UIButton){
        LXFLog("确认")
//        LXFLog("================\(paraList)")
        self.setEditing(true, animated: false)
        //这边要判读是否填写完整
        var isInputComplete:Bool = true
        for spus in paraList {
            if spus.required == true{
                if spus.spuValue == nil{
                    isInputComplete = false
                    break
                }
            }
        }
        
        if isInputComplete == false{
            JFPopup.toast(hit: "你还有些必填的信息没有填写完整")
            return
        }
        
        sureParmeter?(paraList)
        Coordinator.shared?.popViewController(self, true)
    }
    
    
    func loadOrderSpuInfoList(){
        let parameters = ["categoryId":categoryId,"productId":productId] as [String : Any]
        NetWorkResultRequest(OrderApi.getProductSpuList(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<[Spus]>.self, from: data) else{
                return
            }
            self?.paraList.removeAll()
            
            if let _data = model.data{
                self?.paraList = _data
//                for i in 0..<_data.count {
//                    let spus = _data[i] as Spus
//                    if spus.spuValue?.count < 0{
//                        spus.spuValue = ""
//                    }
//                    self?.paraList.append(spus)
//                }
            }
            self?.tableview.reloadData()
        } failureCallback: { error, code in
            code.loginOut()
        }
    }
    
    
    //上传图片
//    @objc func isUploadPitureAction(certifiedBtn:UIButton){
//        manager.type = .photo
//        manager.clearSelectedList()
//        self.popup.actionSheet {
//            [
//                JFPopupAction(with: "从手机相册选择", subTitle: nil, clickActionCallBack: { [weak self] in
//                    self?.hx_presentSelectPhotoController(with: self?.manager, didDone: { allList, photoList, videoList, isOriginal, viewController, manager in
//                        var imageDataArray = [Data]()
//                        photoList?.forEach({ HXPhotoModel in
//                            //对图片进行
//                            guard let image = HXPhotoModel.thumbPhoto else {
//                                return
//                            }
//                                guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }//把图片转换成data
//                                imageDataArray.append(imageData)
//                        })
//                        let Parameters = ["fileType":20]
//                        JFPopupView.popup.loading(hit: "上传图片中....")
//                        NetWorkResultRequest(StoreAppleApi.batchUpload(parameters: Parameters, dataAry: imageDataArray), needShowFailAlert: true) { result, data in
//                            do{
//                                let json = try JSON(data: data)
//                                LXFLog(json)
//                                let array = json["data"]
//                                for i in 0..<array.count{
//                                    let cloudUrl = array[i]["cloudUrl"]
//                                    let data = try JSONEncoder().encode(cloudUrl)
//                                    var url = String(data: data, encoding:String.Encoding.utf8)!.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
//                                    url = url.replacingOccurrences(of: "\"", with: "", options: .literal, range: nil)
//                                    LXFLog(url)
//                                }
//                            }catch{}
//                            self?.isUploadLabel.text = "已上传"
//                            JFPopupView.popup.hideLoading()
//                        } failureCallback: { error,code in
//                            JFPopupView.popup.hideLoading()
//                        }
//
//                    })
//                }),
//                JFPopupAction(with: "拍照", subTitle: nil, clickActionCallBack: {[weak self] in
//                    self?.hx_presentCustomCameraViewController(with: self?.manager) { photoList, viewController in
//                        var imageDataArray = [Data]()
//                        if let photoModel:HXPhotoModel = photoList{
//                            guard let image = photoModel.thumbPhoto else {
//                                return
//                            }
//                                guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }//把图片转换成data
//                                imageDataArray.append(imageData)
//                        }
//                        let Parameters = ["fileType":20]
//                        JFPopupView.popup.loading(hit: "上传图片中....")
//                        NetWorkResultRequest(StoreAppleApi.batchUpload(parameters: Parameters, dataAry: imageDataArray), needShowFailAlert: true) { result, data in
//                            do{
//                                let json = try JSON(data: data)
//                                let array = json["data"]
//                                for i in 0..<array.count{
//                                    let cloudUrl = array[i]["cloudUrl"]
//                                    let data = try JSONEncoder().encode(cloudUrl)
//                                    var url = String(data: data, encoding:String.Encoding.utf8)!.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
//                                    url = url.replacingOccurrences(of: "\"", with: "", options: .literal, range: nil)
//                                    LXFLog(url)
//                                }
//                            }catch{}
//                            self?.isUploadLabel.text = "已上传"
//                            JFPopupView.popup.hideLoading()
//                        } failureCallback: { error,code in
//                            JFPopupView.popup.hideLoading()
//                        }
//
//                    } cancel: { viewController in
//                    }
//                })
//            ]
//        }
//    }
   
    
    
    
    //选择品牌
//    @objc func choiceBrandAction(brandBtn:UIButton){
//
//    }
    
    
    
    //清除生产场地的内容
//    @objc func clearProductTextViewAction(){
//        productionTextView.text = ""
//        productionTextView.resignFirstResponder()
//        productionDeleteBtn.isHidden = true
//        _productionView.snp.remakeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.height.equalTo(scale(50))
//            make.top.equalTo(_brandBtn.snp.bottom)
//        }
//    }
    
    
    //清除风格内容
//    @objc func clearStyleTextViewAction(){
//        styleTextView.text = ""
//        styleTextView.resignFirstResponder()
//        styleDeleteBtn.isHidden = true
//        _styleView.snp.remakeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.height.equalTo(scale(50))
//            make.top.equalTo(_productionView.snp.bottom)
//        }
//    }
    
    
    //清除材质内容
//    @objc func clearmaterialTextViewAction(){
//        materialTextView.text = ""
//        materialTextView.resignFirstResponder()
//        materialDeleteBtn.isHidden = true
//        _materialView.snp.remakeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.height.equalTo(scale(50))
//            make.top.equalTo(_styleView.snp.bottom)
//        }
//    }
    
//    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
//        return false
//    }
    

}



extension CommodityParametersViewController:UITableViewDelegate,UITableViewDataSource{

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paraList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommodityParameterCell") as! CommodityParameterCell
        cell.model = paraList[indexPath.row]
        cell.parameterTextfield.tag = indexPath.row
        cell.parameterTextfield.delegate = self
        let spus = paraList[indexPath.row]
        if spus.spuAttrName == "正品证书"{
            cell.parameterTextfield.placeholder = "未上传"
            cell.parameterTextfield.isEnabled = false
            cell.parameterTextfield.attributedPlaceholder = NSAttributedString.init(string:"未上传", attributes: [
                NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        }else if spus.spuAttrName == "品牌"{
            cell.parameterTextfield.isEnabled = false
            cell.parameterTextfield.placeholder = "请选择"
            cell.parameterTextfield.attributedPlaceholder = NSAttributedString.init(string:"请选择", attributes: [
                NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        }else{
            cell.parameterTextfield.isEnabled = true
            cell.parameterTextfield.placeholder = "请输入"
            cell.parameterTextfield.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
                NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        }
        
//        if indexPath.row == 0{
//            if cell.model?.spuValue == nil{
//                cell.parameterTextfield.placeholder = "未上传"
//                cell.parameterTextfield.isEnabled = false
//                cell.parameterTextfield.attributedPlaceholder = NSAttributedString.init(string:"未上传", attributes: [
//                    NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
//            }
//        }else if indexPath.row == 1{
//            if cell.model?.spuValue == nil{
//                cell.parameterTextfield.isEnabled = false
//                cell.parameterTextfield.placeholder = "请选择"
//                cell.parameterTextfield.attributedPlaceholder = NSAttributedString.init(string:"请选择", attributes: [
//                    NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
//            }
//        }else{
//            if cell.model?.spuValue == nil{
//                cell.parameterTextfield.isEnabled = true
//                cell.parameterTextfield.placeholder = "请输入"
//                cell.parameterTextfield.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
//                    NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
//            }
//        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var spus = paraList[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! CommodityParameterCell
        if spus.spuAttrName == "正品证书"{
            manager.type = .photo
            manager.clearSelectedList()
            self.popup.actionSheet {
                [
                    JFPopupAction(with: "从手机相册选择", subTitle: nil, clickActionCallBack: { [weak self] in
                        self?.hx_presentSelectPhotoController(with: self?.manager, didDone: { allList, photoList, videoList, isOriginal, viewController, manager in
                            LXFLog(photoList?.count)
                            if let photoModel:HXPhotoModel = photoList?.first{
                                
                                photoModel.getAssetURL { url, photoModelMediaSubType, bool, HXPhotoModel in
                                    let nsdata = NSData(contentsOf: url!)
                                    let data:Data = nsdata! as Data
                                //网络请求的部分
                                let Parameters = ["fileType":20]
    //                            let Parameters = [String:Any]()
                                JFPopupView.popup.loading(hit: "上传图片中....")
//                                guard let imageData = photoModel.thumbPhoto?.jpegData(compressionQuality: 0.3) else { return }//把图片转换成data
                                NetWorkResultRequest(StoreAppleApi.uploadFile(parameters: Parameters, imageDate: data), needShowFailAlert: true) { result, data in
                                    do{
                                      let json = try JSON(data: data)
                                      let str = (json["data"]["cloudUrl"].string ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                      LXFLog(str)
                                      spus.spuValue = str
                                      self?.paraList[indexPath.row] = spus
                                    }catch{}
                                    cell.parameterTextfield.text = "已上传"
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
                            LXFLog(photoList)
//                            if let photoModel:HXPhotoModel = photoList{
                            photoList?.getAssetURL { url, photoModelMediaSubType, bool, HXPhotoModel in
                                let nsdata = NSData(contentsOf: url!)
                                let data:Data = nsdata! as Data
                                //对图片进行
                                let Parameters = ["fileType":20]
                                JFPopupView.popup.loading(hit: "上传图片中....")
//                                guard let imageData = photoModel.thumbPhoto?.jpegData(compressionQuality: 0.3) else { return }//把图片转换成data
                                NetWorkResultRequest(StoreAppleApi.uploadFile(parameters: Parameters, imageDate: data), needShowFailAlert: true) { result, data in
                                    do{
                                        let json = try JSON(data: data)
                                        let str = (json["data"]["cloudUrl"].string ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                        LXFLog(str)
                                        spus.spuValue = str
                                        self?.paraList[indexPath.row] = spus
                                    }catch{}
                                    JFPopupView.popup.hideLoading()
                                    cell.parameterTextfield.text = "已上传"
                                } failureCallback: { error,code in
                                    JFPopupView.popup.hideLoading()
                                }
                            }
                        } cancel: { viewController in
                        }
                    })
                ]
            }
        }else if spus.spuAttrName == "品牌"{
            self.popup.bottomSheet {
                let commodityParametersView = CommodityParameterView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(450)),categoryId:categoryId)
                commodityParametersView.cancelBlock = {[weak self] in
                    self?.popup.dismissPopup()
                }
                commodityParametersView.selectBrandNameBlock = {[weak self] brandModel in
//                    cell.parameterTextfield.text = brandName
                    cell.parameterTextfield.text = brandModel.brandName
//                    spus.spuValue = brandName
                    spus.spuValue = String(format: "%d", brandModel.brandId ?? 0)
                    spus.spuText = brandModel.brandName
                    self?.paraList[indexPath.row] = spus
                    self?.popup.dismissPopup()
                }
                return commodityParametersView
            }
        }else{
            spus.spuValue = (cell.parameterTextfield.text ?? "")
            paraList[indexPath.row] = spus
        }
    }
}



extension CommodityParametersViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        var spus = paraList[textField.tag]
        if (spus.spuAttrName != "品牌") || (spus.spuAttrName != "正品证书"){
            spus.spuValue = (textField.text ?? "")
            paraList[textField.tag] = spus
        }
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxNum = 50
        //限制个数
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= maxNum
    }
    
    
    
//    func textViewDidChange(_ textView: UITextView) {
//        if textView == productionTextView{
//            if textView.text.count > 0{
//                productionDeleteBtn.isHidden = false
//            }else{
//                productionDeleteBtn.isHidden = true
//            }
//        }else if textView == styleTextView{
//            if textView.text.count > 0{
//                styleDeleteBtn.isHidden = false
//            }else{
//                styleDeleteBtn.isHidden = true
//            }
//        }else{
//            if textView.text.count > 0{
//                materialDeleteBtn.isHidden = false
//            }else{
//                materialDeleteBtn.isHidden = true
//            }
//        }
//    }
//
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        var frame = textView.frame
//        let height = textView.text.rectHeight(font: UIFont.systemFont(ofSize: scale(16), weight: .regular), size: CGSize(width: SCW - scale(158), height: CGFloat(MAXFLOAT))) + scale(20)
//        frame.size.height = height
//        textView.frame = frame
//        if textView == productionTextView{
//            _productionView.snp.remakeConstraints { make in
//                make.left.right.equalToSuperview()
//                make.height.equalTo(height + scale(20))
//                make.top.equalTo(_brandBtn.snp.bottom)
//            }
//        }else if textView == styleTextView{
//            _styleView.snp.remakeConstraints { make in
//                make.left.right.equalToSuperview()
//                make.height.equalTo(height + scale(20))
//                make.top.equalTo(_productionView.snp.bottom)
//            }
//        }else{
//            _materialView.snp.remakeConstraints { make in
//                make.left.right.equalToSuperview()
//                make.height.equalTo(height + scale(20))
//                make.top.equalTo(_styleView.snp.bottom)
//            }
//        }
//        return true
//    }
}

