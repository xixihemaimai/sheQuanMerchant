//
//  FundRWSuccessViewController.swift
//  App
//
//  Created by mac on 2022/7/20.
//

import UIKit
import Util

class FundRWSuccessViewController: BaseViewController {
    
    
    lazy var funtionLabel:UILabel = {
       let funtionLabel = UILabel()
        funtionLabel.text = "充值成功"
        funtionLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        funtionLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        funtionLabel.textAlignment = .center
        return funtionLabel
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = viewControllerWhiteColor
        
        
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
        
        
        let goOnRechargeBtn = UIButton()
        goOnRechargeBtn.setTitle("继续充值", for: .normal)
        goOnRechargeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        goOnRechargeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        goOnRechargeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(goOnRechargeBtn)
        
        goOnRechargeBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(45))
            make.top.equalTo(funtionLabel.snp.bottom).offset(scale(40))
            make.height.equalTo(scale(42))
            make.width.equalTo(scale(128))
        }
        
        goOnRechargeBtn.layer.cornerRadius = scale(4)
        goOnRechargeBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        goOnRechargeBtn.layer.borderWidth = scale(1)
        
        goOnRechargeBtn.addTarget(self, action: #selector(goOnRechargeAction), for: .touchUpInside)
        
        
        
        let checkDetailBtn = UIButton()
        checkDetailBtn.setTitle("查看详情", for: .normal)
        checkDetailBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        checkDetailBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        checkDetailBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        view.addSubview(checkDetailBtn)
        checkDetailBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(45))
            make.top.equalTo(funtionLabel.snp.bottom).offset(scale(40))
            make.height.equalTo(scale(42))
            make.width.equalTo(scale(128))
        }
        checkDetailBtn.layer.cornerRadius = scale(4)
        checkDetailBtn.addTarget(self, action: #selector(checkDetailAction), for: .touchUpInside)
    }
    
    
    //继续充值
    @objc func goOnRechargeAction(goOnRechargeBtn:UIButton){
        let rechargeAndWthdrawalVc = RechargeAndiWthdrawalViewController()
        rechargeAndWthdrawalVc.funtionStyle = .funtionStyle_Recharge
        Coordinator.shared?.pushViewController(self, rechargeAndWthdrawalVc, animated: true)
        let mutableArr1 = NSMutableArray(array: navigationController?.viewControllers ?? [])
        for i in 0..<mutableArr1.count {
            let vc = mutableArr1[i] as! UIViewController
            if vc.isKind(of: FundRWSuccessViewController.self){
                mutableArr1.removeObject(at: i)
                break
            }
        }
        navigationController?.viewControllers = mutableArr1 as! [UIViewController]
    }
    
    //查看详情
    @objc func checkDetailAction(checkDetailBtn:UIButton){
        let fundDetailStatusVc = FundDetailStatusViewController()
        Coordinator.shared?.pushViewController(self, fundDetailStatusVc, animated: true)
    }
   
}
