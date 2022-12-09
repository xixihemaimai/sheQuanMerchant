//
//  UploadVoucherViewController.swift
//  App
//
//  Created by mac on 2022/7/15.
//

import UIKit
import Util
import HXPhotoPicker
import JFPopup
import SwiftyJSON

class UploadVoucherViewController: BaseViewController {
    
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
    
    
    lazy var modifyTextView:UITextView = {
        let modifyTextView = UITextView()
        modifyTextView.placeholder = "请输入"
        modifyTextView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")
        modifyTextView.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        modifyTextView.textContainer.lineFragmentPadding = scale(16)
        modifyTextView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        modifyTextView.contentInset = UIEdgeInsets.zero
        modifyTextView.delegate = self
        return modifyTextView
    }()
    
    
    lazy var countLabel:UILabel = {
       let countLabel = UILabel()
        countLabel.text = "0/200"
        countLabel.textAlignment = .right
        countLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        countLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return countLabel
    }()
    
    
    lazy var feedBacksView:FeedBackView = {
       let feedBacksView = FeedBackView()
        feedBacksView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return feedBacksView
    }()
    
    
    lazy var bottomView:UIView = {
       let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F4F4F4")
        return bottomView
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "上传凭证"
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        let uploadBtn = UIButton()
        uploadBtn.setTitle("确定上传", for: .normal)
        uploadBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF"), for: .normal)
        uploadBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        uploadBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        view.addSubview(uploadBtn)
        
        uploadBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        uploadBtn.layer.cornerRadius = scale(4)
        
        
        
        let addLeaseMseLabel = UILabel()
        addLeaseMseLabel.text = "添加留言"
        addLeaseMseLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        addLeaseMseLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addLeaseMseLabel.textAlignment = .left
        view.addSubview(addLeaseMseLabel)
        
        addLeaseMseLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(14))
            make.height.equalTo(scale(22))
        }
        
        view.addSubview(modifyTextView)
        modifyTextView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(addLeaseMseLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(148))
        }
        
        view.addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(modifyTextView.snp.bottom)
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
        }
      
        
        
        
        view.addSubview(feedBacksView)
        feedBacksView.itemLength = scale(82)
        feedBacksView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
            make.top.equalTo(countLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(132))
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(feedBacksView.snp.bottom)
            make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
        }
        
        
        /// 更新高度
        feedBacksView.heightBlock = { [weak self] height in
            self?.feedBacksView.snp.remakeConstraints({ make in
                make.left.equalToSuperview()
                make.width.equalTo(SCW)
                make.top.equalTo(self!.countLabel.snp.bottom).offset(scale(12))
                make.height.equalTo(scale(height))
            })
            
            self?.bottomView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(self!.feedBacksView.snp.bottom).offset(scale(4))
                make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
            }
            
        }
        
        
        /// 点击按钮
        feedBacksView.btnPostBlock = { [weak self] in
            self?.uploadImage()
        }
        
        feedBacksView.selectBlock = {[weak self] arrData in
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

        
       
//        uploadBtn.addTarget(self, action: #selector(uploadContentAction), for: .touchUpInside)
    }
    

    /// 添加拖动手势
    @objc private func longPress(_ gesture: UILongPressGestureRecognizer) {
        feedBacksView.longPress(gesture)
    }
    
    
    func uploadImage() {
//        vMoments.arrData.append(UIImage(named: "fengjingtu\(getRandom(1, 4))")!)
        if productPics.count > 3 {
            JFPopup.toast(hit: "只能选择3张图片")
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
                                                LXFLog(json)
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
                                                if self?.productPics.count ?? 4 > 3 {
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
                    }),
                    JFPopupAction(with: "拍照", subTitle: nil, clickActionCallBack: {[weak self] in
                        self?.hx_presentCustomCameraViewController(with: self?.manager) { photoList, viewController in
                            var imageDataArray = [Data]()
                            
                            photoList?.getAssetURL{ url, photoModelMediaSubType, bool, photoModel in
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
                                        if self?.productPics.count ?? 4 > 3 {
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
                        } cancel: { viewController in
                        }
                    })
                ]
            }
        }
    }

}

extension UploadVoucherViewController:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "" && range.length > 0{
            return true
        }
        if textView.text.count > 199{
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        countLabel.text = "\(textView.text.count)" + "/200"
    }
}

