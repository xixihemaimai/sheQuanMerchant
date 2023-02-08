//
//  FeedbackMyViewController.swift
//  App
//
//  Created by mac on 2022/7/5.
//

import UIKit
import Util
import HXPhotoPicker
import JFPopup
import SwiftyJSON

class FeedbackMyViewController: BaseViewController {
    

    
    var productPics:[String] = [String]()
    
    
    lazy var manager:HXPhotoManager = {
       let manager = HXPhotoManager()
        manager.configuration.openCamera = true
        manager.configuration.photoMaxNum = 6
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
    
    
    lazy var feedTextView:UITextView = {
       let feedTextView = UITextView()
        feedTextView.placeholder = "请详细描述您所遇到的问题"
        feedTextView.autocorrectionType = .no
        feedTextView.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        feedTextView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
        feedTextView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return feedTextView
    }()
    
    
    lazy var feedBacksView:FeedBackView = {
       let feedBacksView = FeedBackView()
        feedBacksView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return feedBacksView
    }()
    
    
    lazy var midView:UIView = {
       let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F4F4F4")
        return midView
    }()
    
    
    lazy var phoneTextField:UITextField = {
        let phoneTextField = UITextField()
        phoneTextField.clearButtonMode = .whileEditing
        phoneTextField.keyboardType = .phonePad
        phoneTextField.placeholder = "便于我们与你联系（选填）"
        phoneTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        phoneTextField.font = UIFont.systemFont(ofSize: scale(15), weight: .regular)
        phoneTextField.attributedPlaceholder = NSAttributedString.init(string:"便于我们与你联系（选填）", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        phoneTextField.delegate = self
        return phoneTextField
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "意见反馈"
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        let sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        sureBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        view.addSubview(sureBtn)
        
        sureBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        sureBtn.layer.cornerRadius = scale(4)
        
        sureBtn.addTarget(self, action: #selector(sureAction), for: .touchUpInside)
        
        
        
        let questionLabel = UILabel()
        questionLabel.text = "问题/意见"
        questionLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        questionLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        questionLabel.textAlignment = .left
        view.addSubview(questionLabel)
        
        questionLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(14))
            make.height.equalTo(scale(22))
        }
     
        view.addSubview(feedTextView)
        feedTextView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(questionLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(78))
        }
        
        view.addSubview(feedBacksView)
        feedBacksView.itemLength = scale(82)
        feedBacksView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
            make.top.equalTo(feedTextView.snp.bottom).offset(scale(4))
            make.height.equalTo(scale(132))
        }
        
        view.addSubview(midView)
        midView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(feedBacksView.snp.bottom).offset(scale(4))
            make.height.equalTo(scale(9))
        }
        
        
        
        /// 更新高度
        feedBacksView.heightBlock = { [weak self] height in
            self?.feedBacksView.snp.remakeConstraints({ make in
                make.left.equalToSuperview()
                make.width.equalTo(SCW)
                make.top.equalTo(self!.feedTextView.snp.bottom).offset(scale(4))
                make.height.equalTo(scale(height))
            })
            self?.midView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(self!.feedBacksView.snp.bottom).offset(scale(4))
                make.height.equalTo(scale(9))
            }
        }
        
        /// 点击按钮
        feedBacksView.btnPostBlock = { [weak self] in
            self?.uploadImage()
        }
        
        feedBacksView.selectBlock = {[weak self] arrData in
//            self?.commodityModel?.productPics = arrData
            self?.productPics = arrData
        }
        
        /// 添加长按操作
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_ :)))
        gesture.minimumPressDuration = 0.5
        view.addGestureRecognizer(gesture)
                
        /// 添加删除区域
        let vDeleteArea = MomentsDeleteView()
        vDeleteArea.isDelete = false
        view.addSubview(vDeleteArea)
                
        vDeleteArea.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
                
        vDeleteArea.hideView()
        feedBacksView.vDeleteArea = vDeleteArea
    
        
        let phoneView = UIView()
        phoneView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(phoneView)
        phoneView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(midView.snp.bottom)
            make.height.equalTo(scale(48))
        }
        
        
        let phoneLabel = UILabel()
        phoneLabel.text = "手机号"
        phoneLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        phoneLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        phoneLabel.textAlignment = .left
        phoneView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(22))
        }
        
        
        phoneView.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.left.equalTo(phoneLabel.snp.right).offset(scale(32))
            make.height.equalTo(scale(22))
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f4f4f4")
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(phoneView.snp.bottom)
            make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
        }
        
       
        
    }
    
    //确定
    @objc func sureAction(sureBtn:UIButton){
        if feedTextView.text.count < 1{
            JFPopup.toast(hit: "请填写您所遇到的问题")
            return
        }
        
        if phoneTextField.text?.isValidMobile == false{
            JFPopup.toast(hit: "请填写正确的手机号")
            return
        }
        
        
    }
    
    
    /// 添加拖动手势
    @objc private func longPress(_ gesture: UILongPressGestureRecognizer) {
        feedBacksView.longPress(gesture)
    }
    
    
    
    func uploadImage() {
//        vMoments.arrData.append(UIImage(named: "fengjingtu\(getRandom(1, 4))")!)
        if productPics.count > 6 {
            JFPopup.toast(hit: "只能选择6张图片")
        }else{
            manager.type = .photo
            manager.clearSelectedList()
            self.popup.actionSheet {
                [
                    JFPopupAction(with: "从手机相册选择", subTitle: nil, clickActionCallBack: { [weak self] in
                        self?.manager.configuration.photoMaxNum = UInt(6 - (self?.productPics.count ?? 0))
                        self?.hx_presentSelectPhotoController(with: self?.manager, didDone: { allList, photoList, videoList, isOriginal, viewController, manager in
                            var imageDataArray = [Data]()
                            for i in 0..<(photoList?.count ?? 0){
                                guard let model = photoList?[i] else { return }
                                model.getAssetURL{ url, photoModelMediaSubType, bool, photoModel in
                                    let nsdata = NSData(contentsOf: url!)
                                    let data:Data = nsdata! as Data
                                    imageDataArray.append(data)
                                    if imageDataArray.count == photoList?.count{
                                        let Parameters = ["fileType":20]
                                        JFPopupView.popup.loading(hit: "上传图片中....")
                                        NetWorkResultRequest(StoreAppleApi.batchUpload(parameters: Parameters, dataAry: imageDataArray), needShowFailAlert: true) { result, data in
                                            do{
                                                let json = try JSON(data: data)                                                
                                                let array = json["data"]
                                                for i in 0..<array.count{
                                                    let cloudUrl = array[i]["cloudUrl"]
                                                    let data = try JSONEncoder().encode(cloudUrl)
                                                    var url = String(data: data, encoding:String.Encoding.utf8)!.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                                    url = url.replacingOccurrences(of: "\"", with: "", options: .literal, range: nil)
//                                                    LXFLog(url)
                                                    self?.productPics.append(url)
                                                }
                                            }catch{}
                                            if self?.productPics.count ?? 0 > 0{
                                                if self?.productPics.count ?? 7 > 6 {
                                                    let length = (self?.productPics.count ?? 1) - 1
                                                    self?.productPics.removeSubrange(3...length)
                                                    self?.feedBacksView.arrData = self?.productPics ?? [String]()
                                                }else{
                                                    self?.feedBacksView.arrData = self?.productPics ?? [String]()
                                                }
                                            }
                                            JFPopupView.popup.hideLoading()
                                        } failureCallback: { error,code in
                                            JFPopupView.popup.hideLoading()
                                        }
                                    }
                                }
                            }
                        })
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
//                        self?.hx_presentSelectPhotoController(with: self?.manager, didDone: { allList, photoList, videoList, isOriginal, viewController, manager in
//                            var imageDataArray = [Data]()
//                            photoList?.forEach({ HXPhotoModel in
//                                //对图片进行
//                                guard let image = HXPhotoModel.thumbPhoto else {
//                                    return
//                                }
//                                guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }//把图片转换成data
//                                imageDataArray.append(imageData)
//                            })
//
//                            for i in 0..<(photoList?.count ?? 0){
//                                guard let model = photoList?[i] else { return }
//                                model.getAssetURL{ url, photoModelMediaSubType, bool, photoModel in
//                                    let nsdata = NSData(contentsOf: url!)
//                                    let data:Data = nsdata! as Data
//                                    imageDataArray.append(data)
//                                    if imageDataArray.count == photoList?.count{
//                                        let Parameters = ["fileType":20]
//                                        JFPopupView.popup.loading(hit: "上传图片中....")
//                                        NetWorkResultRequest(StoreAppleApi.batchUpload(parameters: Parameters, dataAry: imageDataArray), needShowFailAlert: true) { result, data in
//                                            do{
//                                                let json = try JSON(data: data)
//                                                print("+========23=2=3=2=3=2=======================\(data)")
//                                                print("+========23=2=3=2=3=2=======================\(json)")
//                                                LXFLog(json)
//                                                let array = json["data"]
//                                                for i in 0..<array.count{
//                                                    let cloudUrl = array[i]["cloudUrl"]
//                                                    let data = try JSONEncoder().encode(cloudUrl)
//                                                    var url = String(data: data, encoding:String.Encoding.utf8)!.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
//                                                    url = url.replacingOccurrences(of: "\"", with: "", options: .literal, range: nil)
////                                                    LXFLog(url)
//                                                    self?.productPics.append(url)
//                                                }
//                                            }catch{}
//                                            if self?.productPics.count ?? 0 > 0{
//                                                if self?.productPics.count ?? 7 > 6 {
//                                                    let length = (self?.productPics.count ?? 1) - 1
//                                                    self?.productPics.removeSubrange(6...length)
//                                                    self?.feedBacksView.arrData = self?.productPics ?? [String]()
//                                                }else{
//                                                    self?.feedBacksView.arrData = self?.productPics ?? [String]()
//                                                }
//                                            }
//                                            JFPopupView.popup.hideLoading()
//                                        } failureCallback: { error,code in
//                                            JFPopupView.popup.hideLoading()
//                                        }
//                                    }
//                                }
//                            }
//                        })
                    }),
                    JFPopupAction(with: "拍照", subTitle: nil, clickActionCallBack: {[weak self] in
                        self?.hx_presentCustomCameraViewController(with: self?.manager) { photoList, viewController in
                            var imageDataArray = [Data]()
//                            if let photoModel:HXPhotoModel = photoList{
//                                //对图片进行
//                                guard let image = photoModel.thumbPhoto else {
//                                    return
//                                }
//                                    guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }//把图片转换成data
//                                    imageDataArray.append(imageData)
////                                }
//                            }
                            photoList?.getAssetURL { url, photoModelMediaSubType, bool, HXPhotoModel in
                            let nsdata = NSData(contentsOf: url!)
                            let data:Data = nsdata! as Data
                            imageDataArray.append(data)
                            let Parameters = ["fileType":20]
                            JFPopupView.popup.loading(hit: "上传图片中....")
                            NetWorkResultRequest(StoreAppleApi.batchUpload(parameters: Parameters, dataAry: imageDataArray), needShowFailAlert: true) { result, data in
                                do{
                                    let json = try JSON(data: data)
                                    let array = json["data"]
                                    for i in 0..<array.count{
                                        let cloudUrl = array[i]["cloudUrl"]
                                        let data = try JSONEncoder().encode(cloudUrl)
                                        var url = String(data: data, encoding:String.Encoding.utf8)!.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                        url = url.replacingOccurrences(of: "\"", with: "", options: .literal, range: nil)
                                        LXFLog(url)
                                        self?.productPics.append(url)
                                    }
                                }catch{}
                                if self?.productPics.count ?? 0 > 0{
                                    if self?.productPics.count ?? 7 > 6 {
                                        let length = (self?.productPics.count ?? 1) - 1
                                        self?.productPics.removeSubrange(6...length)
                                        self?.feedBacksView.arrData = self?.productPics ?? [String]()
                                    }else{
                                        self?.feedBacksView.arrData = self?.productPics ?? [String]()
                                    }
                                }
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
    }
}


extension FeedbackMyViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxNum = 6
        if textField == phoneTextField {
                maxNum = 11
        }
//        限制个数
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= maxNum
    }
    
}
