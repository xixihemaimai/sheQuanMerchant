//
//  StoreOccupancyViewController.swift
//  App
//
//  Created by mac on 2022/4/26.
//

import UIKit
import Util
import JFPopup
import HXPhotoPicker

class StoreOccupancyViewController: BaseViewController {
    
    
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
    
    
    
    
    //头像
    lazy var headerImageView:UIImageView = {
       let headerImageView = UIImageView()
        headerImageView.image = UIImage(named: "Group 2738")
//        headerImageView.contentMode = .scaleAspectFill
        return headerImageView
    }()
    
    lazy var uploadLabel:UILabel = {
       let uploadLabel = UILabel()
        uploadLabel.text = "上传头像"
        uploadLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        uploadLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        uploadLabel.textAlignment = .center
        return uploadLabel
    }()
    
    
    //店铺名称
    lazy var shopTextField:UITextField = {
       let shopTextField = UITextField()
        shopTextField.placeholder = "请输入店铺名称,长度不超过20个字"
        shopTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        shopTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        shopTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入店铺名称,长度不超过20个字", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        return shopTextField
    }()
    
    //店铺名称底部横线
    lazy var shopDiviver:UIView = {
       let shopDiviver = UIView()
        shopDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#CBCBCB")
        return shopDiviver
    }()
    
    //选择经营种类
    lazy var choiceManagementBtn:UIButton = {
       let choiceManagementBtn = UIButton()
        choiceManagementBtn.setTitle("请选择经营品类", for: .normal)
        choiceManagementBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#878787"), for: .normal)
        choiceManagementBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        choiceManagementBtn.contentHorizontalAlignment = .left
        return choiceManagementBtn
    }()
    
    //方向图片
    lazy var choiceImageView:UIImageView = {
       let choiceImageView = UIImageView()
        choiceImageView.image = UIImage(named: "Frame-right")
        return choiceImageView
    }()
    
    
    //底部横线
    lazy var choiceDiviver:UIView = {
       let choiceDiviver = UIView()
        choiceDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#CBCBCB")
        return choiceDiviver
    }()
    
    
    
    //错误信息
    lazy var showErrerLabel:UILabel = {
       let showErrerLabel = UILabel()
        showErrerLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F33A2F")
        showErrerLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        showErrerLabel.textAlignment = .left
        return showErrerLabel
    }()
    
    //下一步按键
    lazy var nextBtn:UIButton = {
       let nextBtn = UIButton()
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        nextBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return nextBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        title = "店铺入住"
        //Group 2738
        
        //Frame-right
        view.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scale(28))
            make.height.width.equalTo(scale(78))
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(choicePitureAction))
        headerImageView.isUserInteractionEnabled = true
        headerImageView.addGestureRecognizer(tap)
        
        
//        headerImageView.layer.cornerRadius = headerImageView.width * 0.5
        
        
        view.addSubview(uploadLabel)
        uploadLabel.snp.makeConstraints { make in
            make.top.equalTo(headerImageView.snp.bottom).offset(scale(4))
            make.centerX.equalToSuperview()
            make.height.equalTo(scale(17))
            make.width.equalTo(scale(70))
        }
        
        //店铺名字
        view.addSubview(shopTextField)
        view.addSubview(shopDiviver)
        
        
        shopTextField.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.top.equalTo(uploadLabel.snp.bottom).offset(scale(54))
        }
        
        shopDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.top.equalTo(shopTextField.snp.bottom).offset(scale(8))
            make.height.equalTo(scale(0.5))
        }
        
        
        //经营种类
        view.addSubview(choiceManagementBtn)
        choiceManagementBtn.addSubview(choiceImageView)
        
        choiceManagementBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.top.equalTo(shopDiviver.snp.bottom).offset(scale(24))
            make.height.equalTo(scale(20))
        }
        
        choiceImageView.snp.makeConstraints { make in
            make.right.equalTo(0)
            make.centerY.equalTo(choiceManagementBtn)
            make.width.height.equalTo(scale(24))
        }
        
        view.addSubview(choiceDiviver)
        choiceDiviver.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.top.equalTo(choiceManagementBtn.snp.bottom).offset(scale(8))
            make.height.equalTo(scale(0.5))
        }
        
        
        choiceManagementBtn.addTarget(self, action: #selector(choiceManagerAction), for: .touchUpInside)
        
        //错误提示
        view.addSubview(showErrerLabel)
        showErrerLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.top.equalTo(choiceDiviver.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(20))
        }
        
        
        //下一步
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(30))
            make.right.equalTo(-scale(30))
            make.top.equalTo(showErrerLabel.snp.bottom).offset(scale(40))
            make.height.equalTo(scale(40))
        }
        nextBtn.layer.cornerRadius = scale(4)
        nextBtn.addTarget(self, action: #selector(nextShopAction), for: .touchUpInside)
//
    }
    

    
    //选择相片
    @objc func choicePitureAction(tap:UITapGestureRecognizer){
        manager.type = .photo
        self.popup.actionSheet {
            [
                JFPopupAction(with: "从手机相册选择", subTitle: nil, clickActionCallBack: { [weak self] in
                    self?.hx_presentSelectPhotoController(with: self?.manager, didDone: { allList, photoList, videoList, isOriginal, viewController, manager in
                        LXFLog(photoList?.count)
                        if let photoModel:HXPhotoModel = photoList?.first{
                            //对图片进行
//                            photoModel.thumbPhoto
                            self?.headerImageView.image = photoModel.thumbPhoto?.isRoundCorner(radius:  (self?.headerImageView.width ?? 0) * 0.5, byRoundingCorners: .allCorners, imageSize: self?.headerImageView.size)
                        }
                        
                    })
                }),
                JFPopupAction(with: "拍照", subTitle: nil, clickActionCallBack: {[weak self] in
                    self?.hx_presentCustomCameraViewController(with: self?.manager) { photoList, viewController in
                        LXFLog(photoList)
                        if let photoModel:HXPhotoModel = photoList{
                            //对图片进行
//                            self?.headerImageView.image = photoModel.thumbPhoto
                            self?.headerImageView.image = photoModel.thumbPhoto?.isRoundCorner(radius:  (self?.headerImageView.width ?? 0) * 0.5, byRoundingCorners: .allCorners, imageSize: self?.headerImageView.size)
                        }
                    } cancel: { viewController in
                    }
                })
            ]
        }
    }
    
    
    //选择经营种类
    @objc func choiceManagerAction(choiceManagementBtn:UIButton){
        let businessTypeVc = BusinessTypeViewController()
        Coordinator.shared?.pushViewController(self, businessTypeVc, animated: true)
    }
    
    
    
    //下一步
    @objc func nextShopAction(nextBtn:UIButton){
        //店铺名字
        //shopTextField
//        if shopTextField.text?.containsEmoji() == true{
//            showErrerLabel.text = "店铺名称里面包含表情"
//            return
//        }
//
//        if shopTextField.text?.isValidNickName == false{
//            showErrerLabel.text = "店铺名称不合规,请重新输入"
//            return
//        }
//
//        //经营种类
////        choiceManagementBtn.currentTitle
//        if choiceManagementBtn.currentTitle == "请选择经营种类"{
//            showErrerLabel.text = "请选择经营种类"
//            return
//        }
        
        //网络请求了
        
        let encVc = EnterpriseCertificationViewController()
        Coordinator.shared?.pushViewController(self, encVc, animated: true)
        
    }

}
