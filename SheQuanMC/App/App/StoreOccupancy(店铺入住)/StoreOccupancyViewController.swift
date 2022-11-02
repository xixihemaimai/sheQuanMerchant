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
import SwiftyJSON
import SDWebImage


open class StoreOccupancyViewController: BaseViewController {
    
    
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
        shopTextField.placeholder = "请输入店铺名称,长度不超过25个字"
        shopTextField.clearButtonMode = .whileEditing
        shopTextField.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        shopTextField.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        shopTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入店铺名称,长度不超过25个字", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
//        shopTextField.addTarget(self, action: #selector(shopNameChangeAction), for: .editingDidEnd)
        shopTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        shopTextField.delegate = self
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
        showErrerLabel.isHidden = true
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
    
    
    
    //0为没有的状态 审核中为1 审核失败为2
   public var audit:Int = 0
    
    //经营种类的ID
    var categoryId:Int32?
    
    
    //这个值市用来判断是否修改过
    var isModify:Bool = false
    
//    public override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        UIApplication.shared.isIdleTimerDisabled = true
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
//    }
    

   public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
       
        title = "店铺入住"
        //Group 2738
       
       self.navigationItem.leftBarButtonItem?.customView?.isHidden = true
       self.navigationItem.leftBarButtonItem?.customView = UIButton(setImage: "返回", setBackgroundImage: "", target: self, action: #selector(exitLoginStatus))
       
        
       navigationController?.interactivePopGestureRecognizer?.delegate = self
       
       
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
        
        headerImageView.layer.cornerRadius = scale(78) * 0.5
        headerImageView.layer.masksToBounds = true
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
       
       
       
       
//       if audit > 0{
           //这边是从本地去拿数据去了
//           头像图片
           //店铺名称
           //经营种类
           //经营种类ID
       if  (StoreService.shared.currentUser?.shopAvatar.count ?? 0) > 0{
           headerImageView.sd_setImage(with: URL(string: StoreService.shared.currentUser?.shopAvatar ?? ""), placeholderImage: UIImage(named: "Group 2738"))
       }else{
           headerImageView.image = UIImage(named: "Group 2738")
       }
       //店铺名称
       shopTextField.text = StoreService.shared.currentUser?.shopName
       //选择经营种类
       if (StoreService.shared.currentUser?.categoryName.count ?? 0) > 0{
           choiceManagementBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
           choiceManagementBtn.setTitle(StoreService.shared.currentUser?.categoryName, for: .normal)
       }else{
           choiceManagementBtn.setTitle("请选择经营品类", for: .normal)
           choiceManagementBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#878787"), for: .normal)
       }
       categoryId = StoreService.shared.categoryId
    }
    

    
    //选择相片
    @objc func choicePitureAction(tap:UITapGestureRecognizer){
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
                                //对图片进行
                                //网络请求的部分
                                let Parameters = ["fileType":20]
                                JFPopupView.popup.loading(hit: "上传图片中....")
//                                guard let imageData = photoModel.thumbPhoto?.jpegData(compressionQuality: 0.3) else { return }//把图片转换成data
                                NetWorkResultRequest(StoreAppleApi.uploadFile(parameters: Parameters, imageDate: data), needShowFailAlert: true) { result, data in
                                    do{
                                        LXFLog(data)
                                        let json = try JSON(data: data)
                                        //去掉\
                                        let str = (json["data"]["cloudUrl"].string ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                        LXFLog(str)
                                        self?.headerImageView.sd_setImage(with: URL(string: str), placeholderImage: UIImage(named: "Group 2738"))
                                        StoreService.shared.updateShopAvatar(str)
                                        
                                    }catch{}
                                    JFPopupView.popup.hideLoading()
                                    self?.isModify = true
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
//                        if let photoModel:HXPhotoModel = photoList{
                        photoList?.getAssetURL { url, photoModelMediaSubType, bool, HXPhotoModel in
                            let nsdata = NSData(contentsOf: url!)
                            let data:Data = nsdata! as Data
                        
                            //网络请求的部分
                            let Parameters = ["fileType":20]
                            JFPopupView.popup.loading(hit: "上传图片中....")
//                            guard let imageData = photoModel.thumbPhoto?.jpegData(compressionQuality: 0.3) else { return }//把图片转换成data
                            NetWorkResultRequest(StoreAppleApi.uploadFile(parameters: Parameters, imageDate: data), needShowFailAlert: true) { result, data in
                                do{
                                    LXFLog(data)
                                    let json = try JSON(data: data)
                                    let str = (json["data"]["cloudUrl"].string ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                      LXFLog(str)
                                    self?.headerImageView.sd_setImage(with: URL(string: str), placeholderImage: UIImage(named: "Group 2738"))
                                    StoreService.shared.updateShopAvatar(str)
                                }catch{}
                                JFPopupView.popup.hideLoading()
                                self?.isModify = true
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
    
    
    //选择经营种类
    @objc func choiceManagerAction(choiceManagementBtn:UIButton){
        let businessTypeVc = BusinessTypeViewController()
        Coordinator.shared?.pushViewController(self, businessTypeVc, animated: true)
        //这边是返回选择是哪个经营种类
        businessTypeVc.sureSelectBusinessType = {[weak self] businessTypeModel in
            choiceManagementBtn.setTitle(businessTypeModel.categoryName, for: .normal)
            //这边要获取这个模型
            self?.categoryId = businessTypeModel.categoryId
            choiceManagementBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
            StoreService.shared.updateCategoryName(businessTypeModel.categoryName ?? "", businessTypeModel.categoryId ?? 0)
            self?.isModify = true
        }
    }
    
    
    
    //输入店铺名字的结束的方法
//    @objc func shopNameChangeAction(textfield:UITextField){
//        LXFLog("修改或取店铺名字的地方")
//        //修改本地库的数据
//        guard let shopName = textfield.text else{return}
//
//    }
    
    
    @objc func textFieldChange(_ titleTF: UITextField) {
        showErrerLabel.isHidden = true
        isModify = true
        if titleTF.markedTextRange != nil {return}
        guard var genString = titleTF.text else{return}
        if genString.count > 25{
           let startIdx = genString.startIndex
           let endIdx = genString.index(genString.startIndex, offsetBy: 26)
           genString = String(genString[startIdx...endIdx])
        }
        titleTF.text = genString
        StoreService.shared.updateShopName(titleTF.text ?? "")
   }
    
    
    
    //下一步
    @objc func nextShopAction(nextBtn:UIButton){
        //店铺名字
        if shopTextField.text?.containsEmoji() == true{
            showErrerLabel.isHidden = false
            showErrerLabel.text = "店铺名称里面包含表情"
            return
        }
//        if shopTextField.text?.isValidNickName == false{
//            showErrerLabel.text = "店铺名称不合规,请重新输入"
//            return
//        }
        //经营种类
        if choiceManagementBtn.currentTitle == "请选择经营种类"{
            showErrerLabel.isHidden = false
            showErrerLabel.text = "请选择经营种类"
            return
        }
        let parameters = ["categoryId":categoryId ?? 0,"shopAvatar":(StoreService.shared.currentUser?.shopAvatar ?? "") as Any,"shopName":(shopTextField.text ?? "") as Any] as [String : Any]
        NetWorkResultRequest(StoreAppleApi.shopAuth(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
            let encVc = EnterpriseCertificationViewController()
            encVc.audit = self!.audit
            Coordinator.shared?.pushViewController(self!, encVc, animated: true)
            self?.showErrerLabel.isHidden = true
//          let mutableArr = NSMutableArray(array: self?.navigationController?.viewControllers ?? [])
//          for i in 0..<mutableArr.count {
//              let vc = mutableArr[i] as! UIViewController
//              if vc.isKind(of: StoreOccupancyViewController.self){
//                 mutableArr.removeObject(at: i)
//                 break
//              }
//           }
//           self?.navigationController?.viewControllers = mutableArr as! [UIViewController]
        } failureCallback: { error,code in
        }
    }
    
    
    //退出登录状态
    @objc func exitLoginStatus(){
        if isModify{
            JFPopup.alert {
                [
                    .title("差一步就能开店了，确定要退出吗？"),
                    .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
    //                .subTitle("注:取消商品将移至未上架"),
    //                .subTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999")),
                    .withoutAnimation(true),
                    .cancelAction([
                        .text("取消"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999")),
                        .tapActionCallback({
                        })
                    ]),
                    .confirmAction([
                        .text("确定"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                        .tapActionCallback({
                            self.isModify = false
                            //删除店铺信息
                            StoreService.shared.delete()
                            //重新变成登录登记
                            let startPageVc = StartPageViewController()
                            let windwin = UIApplication.shared.keyWindow
                            windwin?.rootViewController = BaseNaviViewController(rootViewController: startPageVc)
                        })
                    ])
                ]
            }
        }else{
            Coordinator.shared?.popViewController(self, true)
        }
    }
    
    
    
    
    //禁止某些页面滑动返回上一个页面
//    public override func viewDidDisappear(_ animated: Bool) {
//         super.viewDidDisappear(animated)
//         UIApplication.shared.isIdleTimerDisabled = false
//         self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
//     }
}

extension StoreOccupancyViewController:UITextFieldDelegate{
//    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        var maxNum = 11
//        if textField == shopTextField {
//            maxNum = 25
//        }
//        //限制个数
//        let currentText = textField.text ?? ""
//        guard let stringRange = Range(range, in: currentText) else { return false }
//        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//        return updatedText.count <= maxNum
//    }
//
//
    public func textFieldDidEndEditing(_ textField: UITextField) {
        showErrerLabel.isHidden = true
    }
    
}


extension StoreOccupancyViewController:UIGestureRecognizerDelegate{
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if isModify{
            JFPopupView.popup.alert {
                [
                    .title("差一步就能开店了，确定要退出吗？"),
                    .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .withoutAnimation(true),
                    .cancelAction([
                        .text("取消"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999")),
                        .tapActionCallback({
                        })
                    ]),
                    .confirmAction([
                        .text("确定"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                        .tapActionCallback({
                            self.isModify = false
                            //删除店铺信息
                            StoreService.shared.delete()
                            //重新变成登录登记
                            let startPageVc = StartPageViewController()
                            let windwin = UIApplication.shared.keyWindow
                            windwin?.rootViewController = BaseNaviViewController(rootViewController: startPageVc)
                            
                        })
                    ])
                ]
            }
            return !self.isModify
        }else{
           return true
        }
    }
}
