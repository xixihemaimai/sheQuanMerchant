//
//  CompleteAddBankViewController.swift
//  App
//
//  Created by mac on 2022/7/20.
//

import UIKit
import Util

class CompleteAddBankViewController: BaseViewController {
    
    lazy var funtionLabel:UILabel = {
       let funtionLabel = UILabel()
        funtionLabel.text = "添加成功"
        funtionLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        funtionLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        funtionLabel.textAlignment = .center
        return funtionLabel
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        let successImage = UIImageView()
        successImage.image = UIImage(named: "成功 1")
        view.addSubview(successImage)
        
        successImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scale(20))
            make.width.height.equalTo(scale(52))
        }
        
        view.addSubview(funtionLabel)
        funtionLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(successImage.snp.bottom).offset(scale(16))
            make.height.equalTo(scale(22))
        }
        
        
        let finishBtn = UIButton()
        finishBtn.setTitle("完成", for: .normal)
        finishBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        finishBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        finishBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        view.addSubview(finishBtn)
        
        finishBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(funtionLabel.snp.bottom).offset(scale(40))
            make.height.equalTo(scale(42))
            make.width.equalTo(scale(128))
        }
        
    }
    

    
}
