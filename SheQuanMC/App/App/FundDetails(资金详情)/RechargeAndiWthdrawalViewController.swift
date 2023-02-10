//
//  RechargeAndiWthdrawalViewController.swift
//  App
//
//  Created by mac on 2022/7/20.
//

import UIKit
import Util
import JFPopup

enum FundFuntionStyle{
    case funtionStyle_Recharge
    case FuntionStyle_Wthdrawal
}



class RechargeAndiWthdrawalViewController: BaseViewController {

    var funtionStyle:FundFuntionStyle?
    
    
    
    lazy var choiceBankBtn:UIButton = {
       let choiceBankBtn = UIButton()
        return choiceBankBtn
    }()
    
    
    lazy var bankImage:UIImageView = {
       let bankImage = UIImageView()
        bankImage.image = UIImage(named: "银行卡_面 1")
        return bankImage
    }()
    
    lazy var bankLabel:UILabel = {
       let bankLabel = UILabel()
        bankLabel.text = "暂无可用于充值银行卡"
        bankLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        bankLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        bankLabel.textAlignment = .right
        return bankLabel
    }()
    
    lazy var rightImage:UIImageView = {
        let rightImage = UIImageView()
        rightImage.image = UIImage(named: "Frame-goods")
        return rightImage
    }()
    
    lazy var moneyTextField:UITextField = {
       let moneyTextField = UITextField()
        moneyTextField.clearButtonMode = .whileEditing
        moneyTextField.keyboardType = .decimalPad
        return moneyTextField
    }()
    
    lazy var rechargeBtn:UIButton = {
        let rechargeBtn = UIButton()
        rechargeBtn.setTitle("充值", for: .normal)
        rechargeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        rechargeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF"), for: .normal)
        rechargeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return rechargeBtn
    }()
    
    
    lazy var errorLabel:UILabel = {
       let errorLabel = UILabel()
        errorLabel.text = "输入金额超过可用余额"
        errorLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F13232")
        errorLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        errorLabel.textAlignment = .left
        return errorLabel
    }()
    
    lazy var infoLabel:UILabel = {
        let infoLabel = UILabel()
        infoLabel.text = "当前可用余额为12.28"
        infoLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F13232")
        infoLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        infoLabel.textAlignment = .left
        return infoLabel
    }()
    
    lazy var withdrawalBtn:UIButton = {
       let withdrawalBtn = UIButton()
        withdrawalBtn.setTitle("全部提现", for: .normal)
        withdrawalBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#4E8DEA"), for: .normal)
        withdrawalBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        withdrawalBtn.contentHorizontalAlignment = .left
        return withdrawalBtn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF")
        
        if funtionStyle == .funtionStyle_Recharge{
            title = "充值"
        }else{
            title = "提现"
        }
        
        
        let topView = UIView()
        topView.backgroundColor = viewControllerWhiteColor
        view.addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        
        view.addSubview(choiceBankBtn)
        choiceBankBtn.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(scale(52))
        }
        
        choiceBankBtn.addSubview(bankImage)
        choiceBankBtn.addSubview(bankLabel)
        choiceBankBtn.addSubview(rightImage)
        
        bankImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.width.height.equalTo(scale(24))
        }
        
        
        rightImage.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.centerY.equalToSuperview()
            make.width.height.equalTo(scale(24))
        }
        
        bankLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(rightImage.snp.left)
            make.left.equalTo(bankImage.snp.right)
            make.height.equalTo(scale(22))
        }
        
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(midView)
        
        midView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(scale(0.5))
            make.top.equalTo(choiceBankBtn.snp.bottom)
        }
        
        let moneyLabel = UILabel()
        moneyLabel.text = "充值金额(元)"
        moneyLabel.textAlignment = .left
        moneyLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        moneyLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        view.addSubview(moneyLabel)
        
        moneyLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(midView.snp.bottom).offset(scale(17))
            make.height.equalTo(scale(20))
        }
        
        let moneyDetailLabel = UILabel()
        moneyDetailLabel.text = "¥"
        moneyDetailLabel.textAlignment = .left
        moneyDetailLabel.font = UIFont.systemFont(ofSize: scale(32), weight: .semibold)
        moneyDetailLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        view.addSubview(moneyDetailLabel)
        
        moneyDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(20))
            make.height.equalTo(scale(45))
            make.top.equalTo(moneyLabel.snp.bottom).offset(scale(16))
        }
        
        
        view.addSubview(moneyTextField)
        moneyTextField.snp.makeConstraints { make in
            make.left.equalTo(moneyDetailLabel.snp.right).offset(scale(5))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(45))
            make.top.equalTo(moneyLabel.snp.bottom).offset(scale(16))
        }
        
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(moneyTextField.snp.bottom).offset(scale(4))
        }
        
        
        
        view.addSubview(errorLabel)
        view.addSubview(infoLabel)
        view.addSubview(withdrawalBtn)
        
        
        errorLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(bottomView.snp.bottom).offset(scale(8))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(17))
        }
        
        infoLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(bottomView.snp.bottom).offset(scale(8))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(17))
        }
        
        withdrawalBtn.snp.makeConstraints { make in
            make.left.equalTo(infoLabel.snp.right)
            make.top.equalTo(bottomView.snp.bottom).offset(scale(8))
            make.width.equalTo(scale(50))
            make.height.equalTo(scale(17))
        }
        
        
        
        view.addSubview(rechargeBtn)
        rechargeBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.top.equalTo(bottomView.snp.bottom).offset(scale(44))
        }
        
        
        rechargeBtn.layer.cornerRadius = scale(4)
        
        rechargeBtn.addTarget(self, action: #selector(rechargeAndWithDrawalAction), for: .touchUpInside)
        
        /**

         JFPopupView.popup.alert {[
         //1.银行卡可用余额不足，请核实后再试
         
                    .subTitle(""),
                    .showCancel(false),
                    .confirmAction([
                        .text("确定"),
                        .tapActionCallback({
                        })
                    ])
                ]}
         
         
         JFPopupView.popup.alert {[
         //验证码错误
                    .subTitle(""),
                    .showCancel(false),
                    .confirmAction([
                        .text("重新输入"),
                        .tapActionCallback({
                        })
                    ])
                ]}
         
         */
        
        JFPopupView.popup.alert {[
                    .title("为了保障您的资金安全,清先完成实名认证"),
                    .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .cancelAction(
                        [.text("稍后"),
                         .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999")),
                         .tapActionCallback({
                         })
                        ]
                    ),
                    .confirmAction([
                        .text("去认证"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                        .tapActionCallback({
                        })
                    ])
                ]}
        
        
        
        
    }
    
    //提现和充值
    @objc func rechargeAndWithDrawalAction(rechargeBtn:UIButton){
        
//        self.popup.dialog{
//
        //这个界面是密码
//            let view = PasswordCodeView(frame: CGRect(x: scale(45), y: SCH/2 - scale(281)/2, width: SCW - scale(90), height: scale(281)))
//            view.backgroundColor = UIColor.white
//            view.layer.cornerRadius = scale(4)
//            return view
            
            //这个界面验证码
//            let view = InputCodeView(frame: CGRect(x: scale(45), y: SCH/2 - scale(224)/2, width: SCW - scale(90), height: scale(224)))
//            view.backgroundColor = UIColor.white
//            view.layer.cornerRadius = scale(4)
//            return view
//        }
        
        
        let fundRWSuccessVc = FundRWSuccessViewController()
        Coordinator.shared?.pushViewController(self, fundRWSuccessVc, animated: true)
        
        //充值成功获取提现成功，要把当前的充值和提现页面进行销毁
        let mutableArr1 = NSMutableArray(array: navigationController?.viewControllers ?? [])
        for i in 0..<mutableArr1.count {
            let vc = mutableArr1[i] as! UIViewController
            if vc.isKind(of: RechargeAndiWthdrawalViewController.self){
                mutableArr1.removeObject(at: i)
                break
            }
        }
        navigationController?.viewControllers = mutableArr1 as! [UIViewController]
           
    }

}
