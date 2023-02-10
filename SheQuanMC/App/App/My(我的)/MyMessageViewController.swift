//
//  MyMessageViewController.swift
//  App
//
//  Created by mac on 2022/7/5.
//

import UIKit
import Util

class MyMessageViewController: BaseViewController {
    
    //声音
    lazy var voiceSwitch:UISwitch = {
       let voiceSwitch = UISwitch()
        voiceSwitch.isOn = false
        voiceSwitch.onTintColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return voiceSwitch
    }()
    //振动
    lazy var vibrationSwitch:UISwitch = {
        let vibrationSwitch = UISwitch()
        vibrationSwitch.isOn = false
        vibrationSwitch.onTintColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
         return vibrationSwitch
    }()
    
    //订单通知提醒
    lazy var orderNoticeSwitch:UISwitch = {
        let orderNoticeSwitch = UISwitch()
        orderNoticeSwitch.isOn = false
        orderNoticeSwitch.onTintColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return orderNoticeSwitch
    }()
    
    //店铺通知提醒
    lazy var shopNoticeSwitch:UISwitch = {
        let shopNoticeSwitch = UISwitch()
        shopNoticeSwitch.isOn = false
        shopNoticeSwitch.onTintColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return shopNoticeSwitch
    }()
    
    //系统通知提醒
    lazy var systemNoticeSwitch:UISwitch = {
        let systemNoticeSwitch = UISwitch()
        systemNoticeSwitch.isOn = false
        systemNoticeSwitch.onTintColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return systemNoticeSwitch
    }()
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        
        if title == "消息通知"{
            
           let customerMessageBtn = UIButton()
           customerMessageBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            view.addSubview(customerMessageBtn)
            customerMessageBtn.tag = 0
            customerMessageBtn.addTarget(self, action: #selector(jumpMessageSettingAction), for: .touchUpInside)
            customerMessageBtn.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(scale(0.5))
                make.height.equalTo(scale(48))
            }
           let customerMessageLabel = UILabel()
            customerMessageLabel.text = "客户消息设置"
            customerMessageLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            customerMessageLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
            customerMessageLabel.textAlignment = .left
            customerMessageBtn.addSubview(customerMessageLabel)
            customerMessageLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(scale(16))
                make.width.equalTo(scale(200))
                make.height.equalTo(scale(22))
            }
            
            let customerMessageRight = UIImageView()
            customerMessageRight.image = UIImage(named: "Frame-my-right")
            customerMessageBtn.addSubview(customerMessageRight)
            customerMessageRight.snp.makeConstraints { make in
               make.centerY.equalToSuperview()
               make.right.equalTo(-scale(16))
               make.width.height.equalTo(scale(24))
            }
            //notice
            let noticeMessageBtn = UIButton()
            noticeMessageBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            view.addSubview(noticeMessageBtn)
            noticeMessageBtn.tag = 1
            noticeMessageBtn.addTarget(self, action: #selector(jumpMessageSettingAction), for: .touchUpInside)
            noticeMessageBtn.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(customerMessageBtn.snp.bottom).offset(scale(0.5))
                make.height.equalTo(scale(48))
            }
            let noticeMessageLabel = UILabel()
            noticeMessageLabel.text = "通知消息设置"
            noticeMessageLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            noticeMessageLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
            noticeMessageLabel.textAlignment = .left
            noticeMessageBtn.addSubview(noticeMessageLabel)
            noticeMessageLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(scale(16))
                make.width.equalTo(scale(200))
                make.height.equalTo(scale(22))
            }
             
            let noticeMessageRight = UIImageView()
            noticeMessageRight.image = UIImage(named: "Frame-my-right")
            noticeMessageBtn.addSubview(noticeMessageRight)
            noticeMessageRight.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalTo(-scale(16))
                make.width.height.equalTo(scale(24))
             }
 
        }else if title == "客户消息设置"{
            
            let voiceView = UIView()
            voiceView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            view.addSubview(voiceView)
            
            voiceView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(scale(0.5))
                make.height.equalTo(scale(48))
            }
            
            let voiceLabel = UILabel()
            voiceLabel.text = "声音"
            voiceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            voiceLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
            voiceLabel.textAlignment = .left
            voiceView.addSubview(voiceLabel)
            voiceLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(scale(16))
                make.width.equalTo(scale(80))
                make.height.equalTo(scale(22))
            }
            
            
            voiceView.addSubview(voiceSwitch)
            voiceSwitch.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalTo(-scale(16))
                make.width.equalTo(scale(51))
                make.height.equalTo(scale(30))
            }
            
            
            
            let vibrationView = UIView()
            vibrationView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            view.addSubview(vibrationView)
            
            vibrationView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(voiceView.snp.bottom).offset(scale(0.5))
                make.height.equalTo(scale(48))
            }
            
            let vibrationLabel = UILabel()
            vibrationLabel.text = "振动"
            vibrationLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            vibrationLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
            vibrationLabel.textAlignment = .left
            vibrationView.addSubview(vibrationLabel)
            vibrationLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(scale(16))
                make.width.equalTo(scale(80))
                make.height.equalTo(scale(22))
            }
            
            vibrationView.addSubview(vibrationSwitch)
            vibrationSwitch.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalTo(-scale(16))
                make.width.equalTo(scale(51))
                make.height.equalTo(scale(30))
            }
            
            
            
            
            
        }else if title == "通知消息设置"{
        
            let orderView = UIView()
            orderView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            view.addSubview(orderView)
            
            orderView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(scale(0.5))
                make.height.equalTo(scale(48))
            }
            
            let orderLabel = UILabel()
            orderLabel.text = "订单通知提醒"
            orderLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            orderLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
            orderLabel.textAlignment = .left
            orderView.addSubview(orderLabel)
            orderLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(scale(16))
                make.width.equalTo(scale(200))
                make.height.equalTo(scale(22))
            }
            
            
            orderView.addSubview(orderNoticeSwitch)
            orderNoticeSwitch.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalTo(-scale(16))
                make.width.equalTo(scale(51))
                make.height.equalTo(scale(30))
            }
            
            
            
            let shopView = UIView()
            shopView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            view.addSubview(shopView)
            
            shopView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(orderView.snp.bottom).offset(scale(0.5))
                make.height.equalTo(scale(48))
            }
            
            let shopLabel = UILabel()
            shopLabel.text = "店铺通知提醒"
            shopLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            shopLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
            shopLabel.textAlignment = .left
            shopView.addSubview(shopLabel)
            shopLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(scale(16))
                make.width.equalTo(scale(200))
                make.height.equalTo(scale(22))
            }
            
            
            shopView.addSubview(shopNoticeSwitch)
            shopNoticeSwitch.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalTo(-scale(16))
                make.width.equalTo(scale(51))
                make.height.equalTo(scale(30))
            }
            
            let systemView = UIView()
            systemView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            view.addSubview(systemView)
            
            systemView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(shopView.snp.bottom).offset(scale(0.5))
                make.height.equalTo(scale(48))
            }
            
            let systemLabel = UILabel()
            systemLabel.text = "系统通知提醒"
            systemLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            systemLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
            systemLabel.textAlignment = .left
            systemView.addSubview(systemLabel)
            systemLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(scale(16))
                make.width.equalTo(scale(200))
                make.height.equalTo(scale(22))
            }
            
            
            systemView.addSubview(systemNoticeSwitch)
            systemNoticeSwitch.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalTo(-scale(16))
                make.width.equalTo(scale(51))
                make.height.equalTo(scale(30))
            }
         
        }
    }
    
    
    @objc func jumpMessageSettingAction(btn:UIButton){
        LXFLog("=======================\(btn.tag)")
        let myMessageVc = MyMessageViewController()
        if btn.tag == 0{
            myMessageVc.title = "客户消息设置"
        }else
        {
            myMessageVc.title = "通知消息设置"
        }
        Coordinator.shared?.pushViewController(self, myMessageVc, animated: true)
    }
    
    
    
    
    
}
