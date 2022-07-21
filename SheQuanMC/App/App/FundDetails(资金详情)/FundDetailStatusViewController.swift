//
//  FundDetailStatusViewController.swift
//  App
//
//  Created by mac on 2022/7/20.
//

import UIKit
import Util

class FundDetailStatusViewController: BaseViewController {
    
    
    lazy var priceLabel:UILabel = {
      let priceLabel = UILabel()
        priceLabel.text = "-1800.00"
        priceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        priceLabel.font = UIFont.systemFont(ofSize: scale(30), weight: .semibold)
        priceLabel.textAlignment = .center
        return priceLabel
    }()
    
    lazy var statusLabel:UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "发红包"
        statusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        statusLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        statusLabel.textAlignment = .center
        return statusLabel
    }()
    
    
    lazy var styleFirstLabel:UILabel = {
        let styleFirstLabel = UILabel()
        styleFirstLabel.text = "收款人"
        styleFirstLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        styleFirstLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        styleFirstLabel.textAlignment = .left
        return styleFirstLabel
    }()
    
    lazy var styleFirstStatusLabel:UILabel = {
        let styleFirstStatusLabel = UILabel()
        styleFirstStatusLabel.text = "一偶"
        styleFirstStatusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        styleFirstStatusLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        styleFirstStatusLabel.textAlignment = .right
        return styleFirstStatusLabel
    }()
    
    lazy var headerImage:UIImageView = {
       let headerImage = UIImageView()
        headerImage.image = UIImage(named: "Group 2784")
        return headerImage
    }()
    
    
    
    lazy var styleSecondLabel:UILabel = {
        let styleSecondLabel = UILabel()
        styleSecondLabel.text = "付款编码"
        styleSecondLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        styleSecondLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        styleSecondLabel.textAlignment = .left
        return styleSecondLabel
    }()
    
    lazy var styleSecondStatusLabel:UILabel = {
        let styleSecondStatusLabel = UILabel()
        styleSecondStatusLabel.text = "0548009703203009406"
        styleSecondStatusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        styleSecondStatusLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        styleSecondStatusLabel.textAlignment = .right
        return styleSecondStatusLabel
    }()
    
    
    lazy var styleThirdLabel:UILabel = {
        let styleThirdLabel = UILabel()
        styleThirdLabel.text = "创建时间"
        styleThirdLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        styleThirdLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        styleThirdLabel.textAlignment = .left
        return styleThirdLabel
    }()
    
    lazy var styleThirdStatusLabel:UILabel = {
        let styleThirdStatusLabel = UILabel()
        styleThirdStatusLabel.text = "2022-03-01 17:15:15"
        styleThirdStatusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        styleThirdStatusLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        styleThirdStatusLabel.textAlignment = .right
        return styleThirdStatusLabel
    }()
    
    lazy var styleFourLabel:UILabel = {
        let styleFourLabel = UILabel()
        styleFourLabel.text = "付款方式"
        styleFourLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        styleFourLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        styleFourLabel.textAlignment = .left
        return styleFourLabel
    }()
    
    lazy var styleFourStatusLabel:UILabel = {
        let styleFourStatusLabel = UILabel()
        styleFourStatusLabel.text = "账户可用余额"
        styleFourStatusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        styleFourStatusLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        styleFourStatusLabel.textAlignment = .right
        return styleFourStatusLabel
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "详情"
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(28))
            make.height.equalTo(scale(42))
        }
        
        view.addSubview(statusLabel)
        
        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(priceLabel.snp.bottom).offset(scale(8))
            make.height.equalTo(scale(17))
        }
        
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(midView)
        midView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(statusLabel.snp.bottom).offset(scale(31))
            make.height.equalTo(scale(0.5))
        }
    
        
        view.addSubview(styleFirstLabel)
        view.addSubview(styleFirstStatusLabel)
        
        styleFirstLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(midView.snp.bottom).offset(scale(35))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(20))
        }
        
        styleFirstStatusLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(midView.snp.bottom).offset(scale(35))
            make.height.equalTo(scale(20))
            make.width.equalTo(scale(200))
        }
        
        
        view.addSubview(headerImage)
        headerImage.snp.makeConstraints { make in
            make.top.equalTo(midView.snp.bottom).offset(scale(33))
            make.width.height.equalTo(scale(24))
            make.right.equalTo(-scale(52))
        }
        headerImage.layer.cornerRadius = scale(12)
        
        
        
        view.addSubview(styleSecondLabel)
        view.addSubview(styleSecondStatusLabel)
        styleSecondLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(styleFirstLabel.snp.bottom).offset(scale(14))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(20))
        }
        
        styleSecondStatusLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(styleFirstStatusLabel.snp.bottom).offset(scale(14))
            make.height.equalTo(scale(20))
            make.width.equalTo(scale(200))
        }
        
        
        view.addSubview(styleThirdLabel)
        view.addSubview(styleThirdStatusLabel)
        styleThirdLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(styleSecondLabel.snp.bottom).offset(scale(14))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(20))
        }
        
        styleThirdStatusLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(styleSecondStatusLabel.snp.bottom).offset(scale(14))
            make.height.equalTo(scale(20))
            make.width.equalTo(scale(200))
        }
        
        view.addSubview(styleFourLabel)
        view.addSubview(styleFourStatusLabel)
        styleFourLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(styleThirdLabel.snp.bottom).offset(scale(14))
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(20))
        }
        
        styleFourStatusLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(styleThirdStatusLabel.snp.bottom).offset(scale(14))
            make.height.equalTo(scale(20))
            make.width.equalTo(scale(200))
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F4F4F4")
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(styleFourStatusLabel.snp.bottom).offset(scale(28))
        }
        
        
    }
}
