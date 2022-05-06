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

class SettingPriceAndStockView: UIView {

    //这边要进行修改这类的动作
    var cancelBlock:(()->Void)?
    
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
    
    
    
    
    //价钱
    lazy var priceTextfield:UITextField = {
       let priceTextfield = UITextField()
        priceTextfield.keyboardType = .numberPad
        priceTextfield.text = "¥"
        priceTextfield.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        priceTextfield.textAlignment = .left
        return priceTextfield
    }()
    
    //库存
    
    lazy var stockTextfield:UITextField = {
       let stockTextfield = UITextField()
        stockTextfield.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        stockTextfield.textAlignment = .left
        stockTextfield.placeholder = "请输入库存数量"
        stockTextfield.attributedPlaceholder = NSAttributedString.init(string:"请输入库存数量", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#999999")])
        return stockTextfield
    }()
    
    
    var viewController:UIViewController?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
     
        let specificationLabel = UILabel()
        specificationLabel.text = "添加规格"
        specificationLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        specificationLabel.font = UIFont.systemFont(ofSize: scale(17), weight: .regular)
        addSubview(specificationLabel)
        
        specificationLabel.snp.makeConstraints { make in
            make.top.equalTo(scale(15))
            make.centerX.equalToSuperview()
            make.width.equalTo(scale(80))
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
        specificationNameLabel.text = "蓝色"
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
        priceLabel.text = "价钱"
        priceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        priceLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        priceLabel.textAlignment = .left
        addSubview(priceLabel)
        
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
            make.top.equalTo(speciNameView.snp.bottom).offset(scale(13))
        }
        
        addSubview(priceTextfield)
        priceTextfield.snp.makeConstraints { make in
            make.left.equalTo(priceLabel.snp.right).offset(scale(37))
            make.height.equalTo(scale(22))
            make.top.equalTo(speciNameView.snp.bottom).offset(scale(13))
            make.right.equalTo(-scale(16))
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
            make.left.equalTo(priceLabel.snp.right).offset(scale(37))
            make.height.equalTo(scale(22))
            make.top.equalTo(diviver.snp.bottom).offset(scale(13))
            make.right.equalTo(-scale(16))
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
        choicePitrueBtn.setBackgroundImage(UIImage(named: "Group 2650"), for: .normal)
        choicePitrueBtn.setImagePostion(type: .imageTop, Space: scale(57))
        addSubview(choicePitrueBtn)
        choicePitrueBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(previewLabel.snp.bottom).offset(scale(12))
            make.width.height.equalTo(scale(82))
        }
        choicePitrueBtn.addTarget(self, action: #selector(uploadPitureAction), for: .touchUpInside)
        
        
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
            make.bottom.equalTo(-scale(34))
        }
        
        sureBtn.layer.cornerRadius = scale(4)
        
    }
    
    //上传图片
    @objc func uploadPitureAction(choicePitrueBtn:UIButton){
        manager.type = .photo
        manager.clearSelectedList()
        self.popup.actionSheet {
                [

                    JFPopupAction(with: "从手机相册选择", subTitle: nil, clickActionCallBack: { [weak self] in
                        self?.currentVC?.hx_presentSelectPhotoController(with: self?.manager, didDone: { allList, photoList, videoList, isOriginal, viewController, manager in
                            photoList?.forEach({ HXPhotoModel in
                                //对图片进行
                                guard let image = HXPhotoModel.thumbPhoto else {
                                    return
                                }
                                choicePitrueBtn.setBackgroundImage(image, for: .normal)
                            })
                        })

                    }),
                    JFPopupAction(with: "拍照", subTitle: nil, clickActionCallBack: {[weak self] in
                        self?.currentVC?.hx_presentCustomCameraViewController(with: self?.manager) { photoList, viewController in
                            LXFLog(photoList)
                            if let photoModel:HXPhotoModel = photoList{
                                //对图片进行
                                guard let image = photoModel.thumbPhoto else {
                                    return
                                }
                                choicePitrueBtn.setBackgroundImage(image, for: .normal)
                            }
                        } cancel: { viewController in
                        }
                    })
                ]
            }
    }
    
    
    //取消
    @objc func cancelAddAction(cancelBtn:UIButton){
        cancelBlock!()
    }
    
    
    //确定
    @objc func sureAction(sureBtn:UIButton){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
