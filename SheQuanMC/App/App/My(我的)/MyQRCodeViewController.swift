//
//  MyQRCodeViewController.swift
//  App
//
//  Created by mac on 2022/7/5.
//

import UIKit
import Util

class MyQRCodeViewController: BaseViewController {
    //背景
    lazy var shopBackImageView:UIImageView = {
       let shopBackImageView = UIImageView()
        shopBackImageView.image = UIImage(named: "Mask Group")
        return shopBackImageView
    }()
    //返回
    lazy var backBtn:UIButton = {
//        let backBtn = UIButton(BackgroundImage: "返回", title: "", titleColor: UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), target: self, action: #selector(backPartentAction))
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named: "返回"), for: .normal)
        backBtn.addTarget(self, action: #selector(backPartentAction), for: .touchUpInside)
        return backBtn
    }()

    //qrcode背景
    
    //头像
    lazy var headerImage:UIImageView = {
       let headerImage = UIImageView()
        headerImage.image = UIImage(named: "Group 2784")
        return headerImage
    }()
    
    //昵称
    lazy var nickNameLabel:UILabel = {
        let nickNameLabel = UILabel()
        nickNameLabel.text = "NIKAI旗舰店"
        nickNameLabel.font = UIFont.systemFont(ofSize: scale(18), weight: .semibold)
        nickNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#1A1A1A")
        nickNameLabel.textAlignment = .center
        return nickNameLabel
    }()
    
    //主营类目
    lazy var businessLabel:UILabel = {
       let businessLabel = UILabel()
        businessLabel.text = "主营类目"
        businessLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        businessLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        businessLabel.textAlignment = .center
        return businessLabel
    }()
    //二维码
    lazy var qrCodeImage:UIImageView = {
       let qrCodeImage = UIImageView()
        qrCodeImage.image = UIImage(named: "Group 2784")
        return qrCodeImage
    }()
    
    //保存按键
    lazy var saveQRCodeBtn:UIButton = {
       let saveQRCodeBtn = UIButton()
        saveQRCodeBtn.setTitle("保存二维码", for: .normal)
        saveQRCodeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        saveQRCodeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        saveQRCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        saveQRCodeBtn.setImage(UIImage(named: "Group 2909"), for: .normal)
        return saveQRCodeBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(shopBackImageView)
        shopBackImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(scale(414))
        }
        
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(scale(42)))
            make.width.height.equalTo(scale(40))
        }
        
        let backView = UIView()
        backView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(scale(202))
        }
        
        headerImage.sd_setImage(with: URL(string: StoreService.shared.currentUser?.shopAvatar ?? ""), placeholderImage: UIImage(named: "Group 2784"))
        view.addSubview(headerImage)
        headerImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scale(158))
            make.width.height.equalTo(scale(88))
        }
        headerImage.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff").cgColor
        headerImage.layer.borderWidth = scale(2)
        headerImage.layer.cornerRadius = scale(44)
        headerImage.layer.masksToBounds = true
        
        
        view.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(25))
            make.top.equalTo(headerImage.snp.bottom).offset(scale(16))
        }
        
        view.addSubview(businessLabel)
        businessLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(20))
            make.top.equalTo(nickNameLabel.snp.bottom).offset(scale(8))
        }
        
        view.addSubview(qrCodeImage)
        qrCodeImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(businessLabel.snp.bottom).offset(scale(24))
            make.width.height.equalTo(scale(232))
        }
        
        view.addSubview(saveQRCodeBtn)
        saveQRCodeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(qrCodeImage.snp.bottom).offset(scale(30))
            make.width.equalTo(scale(152))
            make.height.equalTo(scale(42))
        }
        saveQRCodeBtn.layer.cornerRadius = scale(4)
    }
    
    @objc func backPartentAction(backBtn:UIButton){
        Coordinator.shared?.popViewController(self, true)
    }
    
    

   

}
