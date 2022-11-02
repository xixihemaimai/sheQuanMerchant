//
//  SettingPriceAndStockView.swift
//  App
//
//  Created by mac on 2022/5/6.
//

import UIKit
import Util
import JFPopup
import HXPhotoPicker
import SwiftyJSON
import SDWebImage

class SettingPriceAndStockView: UIView {

    //这边要进行修改这类的动作
    var cancelBlock:(()->Void)?
    
    //这边是设置了值得返回的block
    var settingBlock:((_ Skus:Skus)->Void)?
    
    
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
    
    
    //模型类型
    var skus:Skus?
    //预览图
    var preview:String = ""
    
    //价钱
    lazy var priceTextfield:UITextField = {
       let priceTextfield = UITextField()
        priceTextfield.keyboardType = .decimalPad
        priceTextfield.clearButtonMode = .whileEditing
        priceTextfield.text = "¥"
        priceTextfield.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        priceTextfield.textAlignment = .left
        priceTextfield.delegate = self
        priceTextfield.placeholder = "请输入价格"
        priceTextfield.attributedPlaceholder = NSAttributedString.init(string:"请输入价格", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#999999")])
        return priceTextfield
    }()
    
    //库存
    lazy var stockTextfield:UITextField = {
       let stockTextfield = UITextField()
        stockTextfield.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        stockTextfield.textAlignment = .left
        stockTextfield.clearButtonMode = .whileEditing
        stockTextfield.keyboardType = .numberPad
        stockTextfield.placeholder = "请输入库存数量"
        stockTextfield.attributedPlaceholder = NSAttributedString.init(string:"请输入库存数量", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#999999")])
        return stockTextfield
    }()
    
    
//    var viewController:UIViewController?
    
    
    init(frame: CGRect,skus:Skus) {
        super.init(frame: frame)
        self.skus = skus
//        self.viewController = viewController
        
        backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
     
        let specificationLabel = UILabel()
        specificationLabel.text = "设置价格与库存"
        specificationLabel.textAlignment = .center
        specificationLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        specificationLabel.font = UIFont.systemFont(ofSize: scale(17), weight: .regular)
        addSubview(specificationLabel)
        
        specificationLabel.snp.makeConstraints { make in
            make.top.equalTo(scale(15))
            make.centerX.equalToSuperview()
            make.width.equalTo(scale(150))
            make.height.equalTo(scale(24))
        }
        
        let cancelBtn = UIButton()
        cancelBtn.setBackgroundImage(UIImage(named: "关闭1 1"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelAddAction), for: .touchUpInside)
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(16))
            make.width.height.equalTo(scale(22))
        }
        
        let speciNameView = UIView()
        speciNameView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        addSubview(speciNameView)
        speciNameView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(specificationLabel.snp.bottom).offset(scale(15))
            make.height.equalTo(scale(48))
        }
        
        
        //规格
        let specificationNameLabel = UILabel()
//        let array = unIonSetList[indexPath.row]
//        var temp = [Specs]()
//        for skus in arraySkus{
//            temp.append(skus.specs!.first!)
//        }
//        var value:String = ""
//        for i in 0..<temp.count{
//            let specs = temp[i] as Specs
//            value += specs.specValue ?? ""
//        }
        
//        let skus = unIonSetList[indexPath.row]
//            var temp = [Specs]()
//            for skus in array{
//                temp.append(skus.specs!.first!)
//            }
        var value:String = ""
        for i in 0..<(skus.specs?.count ?? 0){
            let specs = skus.specs?[i] as? Specs
//                value += sp.specValue ?? ""
            
            if i == 0 {
                value += specs?.specValue ?? ""
            }else{
                value += "  |  " + (specs?.specValue ?? "")
            }
        }
//        if ((skus.price ?? 0.0) > 0) && ((skus.stock ?? 0) > 0){
//            isSet = true
//        }
        
//        for i in 0..<(skus.specs?.count ?? 0){
//            let specs = skus.specs?[i] as? Specs
//            value += "" + (specs?.specValue ?? "")
//        }
        specificationNameLabel.text = value
        specificationNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        specificationNameLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        specificationNameLabel.textAlignment = .left
        speciNameView.addSubview(specificationNameLabel)
        specificationNameLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.centerY.equalToSuperview()
            make.height.equalTo(scale(22))
        }
        //价钱
        let priceLabel = UILabel()
        priceLabel.text = "价钱            ¥"
        priceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        priceLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        priceLabel.textAlignment = .left
        addSubview(priceLabel)
        
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(107))
            make.top.equalTo(speciNameView.snp.bottom).offset(scale(13))
        }
        
        addSubview(priceTextfield)
        priceTextfield.snp.makeConstraints { make in
            make.left.equalTo(priceLabel.snp.right).offset(scale(0))
            make.height.equalTo(scale(22))
            make.top.equalTo(speciNameView.snp.bottom).offset(scale(13))
            make.right.equalTo(-scale(16))
        }
        
        let doubleValue = Double(truncating: skus.price as? NSNumber ?? 0.0)
        if doubleValue < 0.000001{
            priceTextfield.text = ""
        }else{
            priceTextfield.text = String(format: "%0.3f", doubleValue)
        }
       
        
        let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        addSubview(diviver)
        
        diviver.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom).offset(scale(13))
            make.height.equalTo(scale(0.5))
        }
        
        
        //库存
        let stockeLabel = UILabel()
        stockeLabel.text = "库存"
        stockeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        stockeLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        stockeLabel.textAlignment = .left
        addSubview(stockeLabel)
        
        stockeLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
            make.top.equalTo(diviver.snp.bottom).offset(scale(13))
        }
        
        addSubview(stockTextfield)
        stockTextfield.snp.makeConstraints { make in
            make.left.equalTo(stockeLabel.snp.right).offset(scale(37))
            make.height.equalTo(scale(22))
            make.top.equalTo(diviver.snp.bottom).offset(scale(13))
            make.right.equalTo(-scale(16))
        }
        
//        let doubleValue = Double(truncating: skus.price as? NSNumber ?? 0.0)
        let int32Value = Int32(truncating: skus.stock as? NSNumber ?? 0)
        if int32Value < 1{
            stockTextfield.text = ""
        }else{
            stockTextfield.text = String(format: "%d", int32Value)
        }
        
        
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        addSubview(midView)
        
        midView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(stockeLabel.snp.bottom).offset(scale(13))
            make.height.equalTo(scale(0.5))
        }
        
        
        //预览图（选填）
        let previewLabel = UILabel()
        previewLabel.text = "预览图"
        previewLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        previewLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        previewLabel.textAlignment = .left
        addSubview(previewLabel)
        
        previewLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(midView.snp.bottom).offset(scale(13))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(50))
        }
        
        let fillingLabel = UILabel()
        fillingLabel.text = "(选填)"
        fillingLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#BDBDBD")
        fillingLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        fillingLabel.textAlignment = .left
        addSubview(fillingLabel)
        
        fillingLabel.snp.makeConstraints { make in
            make.left.equalTo(previewLabel.snp.right)
            make.top.equalTo(midView.snp.bottom).offset(scale(13))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(50))
        }
        
        
        //选择图片
        let choicePitrueBtn = UIButton()
        choicePitrueBtn.setTitle("上传图片", for: .normal)
        choicePitrueBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#BDBDBD"), for: .normal)
        choicePitrueBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
//        choicePitrueBtn.setBackgroundImage(UIImage(named: "Group 2650"), for: .normal)
        choicePitrueBtn.setImagePostion(type: .imageTop, Space: scale(57))
        addSubview(choicePitrueBtn)
        choicePitrueBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(previewLabel.snp.bottom).offset(scale(12))
            make.width.height.equalTo(scale(82))
        }
        choicePitrueBtn.addTarget(self, action: #selector(uploadPitureAction), for: .touchUpInside)
        
        if let skupics = skus.skuPics?.last {
            choicePitrueBtn.sd_setBackgroundImage(with: URL(string: skupics), for: .normal, placeholderImage: UIImage(named: "Group 2650"))
            preview = skupics
            choicePitrueBtn.setTitle("", for: .normal)
        }else{
            choicePitrueBtn.setBackgroundImage(UIImage(named: "Group 2650"), for: .normal)
            preview = ""
        }
        
        let sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        sureBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        sureBtn.addTarget(self, action: #selector(sureAction), for: .touchUpInside)
        addSubview(sureBtn)

        sureBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        sureBtn.layer.cornerRadius = scale(4)
        
    }
    
    //上传图片
    @objc func uploadPitureAction(choicePitrueBtn:UIButton){
        self.endEditing(true)
        manager.type = .photo
        manager.clearSelectedList()
        
        JFPopupView.popup.actionSheet {
            [
                            JFPopupAction(with: "从手机相册选择", subTitle: nil, clickActionCallBack: { [weak self] in
                                self?.currentVC?.hx_presentSelectPhotoController(with: self?.manager, didDone: { allList, photoList, videoList, isOriginal, viewController, manager in
                                    LXFLog(photoList?.count)
                                    if let photoModel:HXPhotoModel = photoList?.first{
                                        photoModel.getAssetURL { url, photoModelMediaSubType, bool, HXPhotoModel in
                                            let nsdata = NSData(contentsOf: url!)
                                            let data:Data = nsdata! as Data
                                            
                                            //对图片进
                                            //网络请求的部分
                                            let Parameters = ["fileType":20]
                                            JFPopupView.popup.loading(hit: "上传图片中....")
//                                            guard let imageData = photoModel.thumbPhoto?.jpegData(compressionQuality: 0.3) else { return }//把图片转换成data
                                            NetWorkResultRequest(StoreAppleApi.uploadFile(parameters: Parameters, imageDate: data), needShowFailAlert: true) { result, data in
                                                do{
                                                    let json = try JSON(data: data)
                                                    //去掉\
                                                  let str = (json["data"]["cloudUrl"].string ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                                    LXFLog(str)
                                                    choicePitrueBtn.sd_setBackgroundImage(with: URL(string: str), for: .normal, placeholderImage: UIImage(named: "Group 2650"))
                                                    choicePitrueBtn.setTitle("", for: .normal)
                                                    self?.preview = str
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
                                self?.currentVC?.hx_presentCustomCameraViewController(with: self?.manager) { photoList, viewController in
                                    LXFLog(photoList)
                                    
                                    photoList?.getAssetURL { url, photoModelMediaSubType, bool, HXPhotoModel in
                                        let nsdata = NSData(contentsOf: url!)
                                        let data:Data = nsdata! as Data
                                        
                                        //网络请求的部分
                                        let Parameters = ["fileType":20]
                                        JFPopupView.popup.loading(hit: "上传图片中....")
//                                        guard let imageData = photoModel.thumbPhoto?.jpegData(compressionQuality: 0.3) else { return }//把图片转换成data
                                        NetWorkResultRequest(StoreAppleApi.uploadFile(parameters: Parameters, imageDate: data), needShowFailAlert: true) { result, data in
                                            do{
                                                let json = try JSON(data: data)
                                                let str = (json["data"]["cloudUrl"].string ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                                  LXFLog(str)
                                                choicePitrueBtn.sd_setBackgroundImage(with: URL(string: str), for: .normal, placeholderImage: UIImage(named: "Group 2650"))
                                                choicePitrueBtn.setTitle("", for: .normal)
                                                self?.preview = str
                                            }catch{}
                                            JFPopupView.popup.hideLoading()
                                        } failureCallback: { error,code in
                                            JFPopupView.popup.hideLoading()
                                        }
                                        
                                    }
//                                    if let photoModel:HXPhotoModel = photoList{
                                        
                                        
                                        
                                        
//                                    }
                                } cancel: { viewController in
                                }
                            })
                        ]
        }

        
        
        
//
//        self.popup.actionSheet {
//
//        }
    }
    
    
    //取消
    @objc func cancelAddAction(cancelBtn:UIButton){
        cancelBlock!()
    }
    
    
    //确定
    @objc func sureAction(sureBtn:UIButton){
        
        //
        if (priceTextfield.text?.count ?? 0) < 1{
            JFPopup.toast(hit: "请填写价钱")
            return
        }
        
        if (stockTextfield.text?.count ?? 0) < 1{
            JFPopup.toast(hit: "请填写库存")
            return
        }
        
        if Decimal(string: priceTextfield.text!) ?? 0.0 > 0 && Int32(stockTextfield.text!) ?? 0 >= 0{
    //        for i in 0..<(arraySkus?.count ?? 0) {
    //            var skus = arraySkus![i]
                //价钱
                skus?.price = Decimal(string: priceTextfield.text!)
                //库存
                skus?.stock = Int32(stockTextfield.text!)
                //预览图
                skus?.skuPics?.append(preview)
    //            arraySkus![i] = skus
    //        }
    //        settingBlock!()
            settingBlock!(skus!)
            //这边还需要返回进行刷新
        }else{
            JFPopup.toast(hit: "请设置大于0的值")
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SettingPriceAndStockView:UITextFieldDelegate{
    
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
