//
//  AgreenRefundView.swift
//  App
//
//  Created by mac on 2022/7/15.
//

import UIKit
import Util
import JFPopup

class AgreenRefundView: UIView {
    
    
    lazy var moneyLabel:UILabel = {
       let moneyLabel = UILabel()
        moneyLabel.text = "¥30.00"
        moneyLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        moneyLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        moneyLabel.textAlignment = .right
        return moneyLabel
    }()
    
    
    
    lazy var refeulReasonBtn:UIButton = {
       let refeulReasonBtn = UIButton()
        refeulReasonBtn.setTitle("请选择", for: .normal)
        refeulReasonBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"), for: .normal)
        refeulReasonBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        refeulReasonBtn.setImage(UIImage(named: "Frame-my-right"), for: .normal)
        refeulReasonBtn.setImagePostion(type: .imageRight, Space: scale(14))
        refeulReasonBtn.contentHorizontalAlignment = .right
        return refeulReasonBtn
    }()
    
    
    lazy var refeulTextView:UITextView = {
       let refeulTextView = UITextView()
        refeulTextView.placeholder = "请输入拒绝原因"
        refeulTextView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor: "#BABABA")
        refeulTextView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        refeulTextView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F6F6F6")
        refeulTextView.textContainer.lineFragmentPadding = scale(16)
        refeulTextView.contentInset = UIEdgeInsets.zero
        return refeulTextView
    }()
    
    
    lazy var cancelReulBtn:UIButton = {
       let cancelReulBtn = UIButton()
        cancelReulBtn.setTitle("取消", for: .normal)
        cancelReulBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        cancelReulBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        cancelReulBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return cancelReulBtn
    }()
    
    lazy var refeulBtn:UIButton = {
       let refeulBtn = UIButton()
        refeulBtn.setTitle("拒绝退款", for: .normal)
        refeulBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        refeulBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        refeulBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return refeulBtn
    }()
    
    // 退货地址
    lazy var refeulAddressLabel:UILabel = {
       let refeulAddressLabel = UILabel()
        refeulAddressLabel.text = "退货地址"
        refeulAddressLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        refeulAddressLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        refeulAddressLabel.textAlignment = .left
        return refeulAddressLabel
    }()
    
    //退货地址的分割线
    lazy var refeulDiv:UIView = {
       let refeulDiv = UIView()
        refeulDiv.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4")
        return refeulDiv
    }()
    
    //地址图片
    lazy var addressImage:UIImageView = {
       let addressImage = UIImageView()
        addressImage.image = UIImage(named: "Group 2711")
        return addressImage
    }()
    
    //地址昵称
    lazy var addressNameLabel:UILabel = {
       let addressNameLabel = UILabel()
        addressNameLabel.text = "农大侠"
        addressNameLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addressNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        addressNameLabel.textAlignment = .left
        return addressNameLabel
    }()
    
    //电话号码
    lazy var addressPhoneNumLabel:UILabel = {
        let addressPhoneNumLabel = UILabel()
        addressPhoneNumLabel.text = "13950800000"
        addressPhoneNumLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addressPhoneNumLabel.textAlignment = .left
        addressPhoneNumLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#808080")
        return addressPhoneNumLabel
    }()
    
    //地址
    lazy var addressLabel:UILabel = {
       let addressLabel = UILabel()
        addressLabel.numberOfLines = 0
        addressLabel.text = "福建省 厦门市 思明区 莲前街道岭兜二路75号"
        addressLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        addressLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        addressLabel.textAlignment = .left
        return addressLabel
    }()
    
    //修改按键
    lazy var modifyBtn:UIButton = {
       let modifyBtn = UIButton()
        modifyBtn.setTitle("修改", for: .normal)
        modifyBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        modifyBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return modifyBtn
    }()
    
    var viewController:UIViewController?
    
    
    var dismissAgreenViweBlock:(()->Void)?

    init(frame: CGRect,viewController:UIViewController) {
        super.init(frame: frame)
        self.viewController = viewController
        backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            
        
        let titleLabel = UILabel()
        titleLabel.text = "同意退款"
        titleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        titleLabel.font = UIFont.systemFont(ofSize: scale(17), weight: .regular)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scale(15))
            make.width.equalTo(scale(150))
            make.height.equalTo(scale(24))
        }
        
        
        
        let cancelBtn = UIButton()
        cancelBtn.setBackgroundImage(UIImage(named: "关闭1 1"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelAfterSalesCloseAction), for: .touchUpInside)
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(16))
            make.width.height.equalTo(scale(22))
        }
        
        
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        addSubview(midView)
        
        midView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(scale(15))
            make.height.equalTo(scale(0.5))
        }
        
        
        //售后方式
        let afterSalesModeLabel = UILabel()
        afterSalesModeLabel.text = "售后方式"
        afterSalesModeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        afterSalesModeLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        afterSalesModeLabel.textAlignment = .left
        addSubview(afterSalesModeLabel)
        
        afterSalesModeLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(midView.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
        }
        
        let afterLabel = UILabel()
        afterLabel.text = "仅退款"
        afterLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        afterLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        afterLabel.textAlignment = .right
        addSubview(afterLabel)
        afterLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(midView.snp.bottom).offset(scale(12))
            make.left.equalTo(afterSalesModeLabel.snp.right)
            make.height.equalTo(scale(22))
        }
        
        //退款金额
        let refeulMoneyLabel = UILabel()
        refeulMoneyLabel.text = "退款金额"
        refeulMoneyLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        refeulMoneyLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        refeulMoneyLabel.textAlignment = .left
        addSubview(refeulMoneyLabel)
        
        refeulMoneyLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(afterSalesModeLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
        }
        
        
        
        addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(afterLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(22))
            make.left.equalTo(refeulMoneyLabel.snp.right)
        }
        
        
        addSubview(refeulAddressLabel)
        addSubview(refeulDiv)
        addSubview(addressImage)
        addSubview(addressLabel)
        addSubview(addressNameLabel)
        addSubview(addressPhoneNumLabel)
        addSubview(modifyBtn)
        
        refeulAddressLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(refeulMoneyLabel.snp.bottom).offset(scale(12))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
        }
        
        refeulDiv.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(refeulAddressLabel.snp.bottom).offset(scale(8.5))
            make.height.equalTo(scale(0.5))
        }
        
        addressImage.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(refeulDiv.snp.bottom).offset(scale(12))
            make.width.height.equalTo(scale(16))
        }
        
        addressNameLabel.snp.makeConstraints { make in
            make.left.equalTo(addressImage.snp.right).offset(scale(2))
            make.top.equalTo(refeulDiv.snp.bottom).offset(scale(8.5))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(80))
        }
        
        addressPhoneNumLabel.snp.makeConstraints { make in
            make.left.equalTo(addressNameLabel.snp.right).offset(scale(12))
            make.top.equalTo(refeulDiv.snp.bottom).offset(scale(8.5))
            make.height.equalTo(scale(22))
            make.right.equalTo(-scale(16))
        }
        
        addressLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(34))
            make.right.equalTo(-scale(16))
            make.top.equalTo(addressNameLabel.snp.bottom).offset(scale(8))
            make.height.equalTo(scale(16))
        }
        
        modifyBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(addressLabel.snp.bottom).offset(scale(22))
            make.height.equalTo(scale(26))
            make.width.equalTo(scale(60))
        }
        
        
        modifyBtn.layer.cornerRadius = scale(4)
        modifyBtn.layer.borderWidth = scale(1)
        modifyBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        modifyBtn.addTarget(self, action: #selector(modifyAddressAction), for: .touchUpInside)
        
        
        
        //拒绝原因 --> 这边可以点击的方式
//        let refuseReasonLabel = UILabel()
//        refuseReasonLabel.text = "拒绝原因"
//        refuseReasonLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
//        refuseReasonLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        refuseReasonLabel.textAlignment = .left
//        addSubview(refuseReasonLabel)
//
//        refuseReasonLabel.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.height.equalTo(scale(22))
//            make.top.equalTo(refeulMoneyLabel.snp.bottom).offset(scale(12))
//            make.width.equalTo(scale(70))
//        }
//
//        addSubview(refeulReasonBtn)
//        refeulReasonBtn.snp.makeConstraints { make in
//            make.right.equalTo(-scale(16))
//            make.top.equalTo(moneyLabel.snp.bottom).offset(scale(22))
//            make.left.equalTo(refuseReasonLabel.snp.right)
//            make.height.equalTo(scale(22))
//        }
//
//
//        refeulReasonBtn.addTarget(self, action: #selector(choiceRefeulReasonAction), for: .touchUpInside)
//
//        //拒绝说明
//        let refeulExplainLabel = UILabel()
//        refeulExplainLabel.text = "拒绝说明"
//        refeulExplainLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
//        refeulExplainLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        refeulExplainLabel.textAlignment = .left
//        addSubview(refeulExplainLabel)
//
//        refeulExplainLabel.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.height.equalTo(scale(22))
//            make.top.equalTo(refuseReasonLabel.snp.bottom).offset(scale(12))
//            make.right.equalTo(-scale(16))
//        }
//
//
//        addSubview(refeulTextView)
//        refeulTextView.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.right.equalTo(-scale(16))
//            make.top.equalTo(refeulExplainLabel.snp.bottom).offset(scale(12))
//            make.height.equalTo(scale(142))
//        }
//
//        refeulTextView.layer.cornerRadius = scale(4)
        
        
        //取消按键
        addSubview(cancelReulBtn)
        cancelReulBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
//            make.top.equalTo(refeulTextView.snp.bottom).offset(scale(58))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
            make.width.equalTo(scale(171))
            make.height.equalTo(scale(44))
        }
        
        cancelReulBtn.layer.cornerRadius = scale(4)
        cancelReulBtn.layer.borderWidth = scale(1)
        cancelReulBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
//        cancelBtn.layer.masksToBounds = true
        
        
        
        
        //拒绝退款按键
        addSubview(refeulBtn)
        refeulBtn.snp.makeConstraints { make in
            make.left.equalTo(cancelReulBtn.snp.right).offset(scale(16))
            make.right.equalTo(-scale(16))
//            make.top.equalTo(refeulTextView.snp.bottom).offset(scale(58))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
            make.height.equalTo(scale(44))
        }
        refeulBtn.layer.cornerRadius = scale(4)
        
    }
    
    
    //地址
    @objc func modifyAddressAction(modifyBtn:UIButton){
        let modifyAddressVc = ModifyAddressViewController()
        modifyAddressVc.title = "修改地址"
        modifyAddressVc.submitBtn.setTitle("提交", for: .normal)
        Coordinator.shared?.pushViewController(viewController!, modifyAddressVc, animated: true)
        dismissAgreenViweBlock?()          
    }
    
    @objc func cancelAfterSalesCloseAction(cancelBtn:UIButton){
        dismissAgreenViweBlock?()
    }
    
    
    //选择拒绝原因
    @objc func choiceRefeulReasonAction(refeulReasonBtn:UIButton){
        JFPopupView.popup.bottomSheet { mainContainer in
            let closeOrderReasonView = CloseOrderReasonView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(489)),orderId:0)
            closeOrderReasonView.cancelBlock = {[weak self] in
                mainContainer?.dismissPopupView()
            }
            //成功之后需要做得事情
            closeOrderReasonView.sureCloseSuccessBlock = {[weak self] in
                self?.refeulReasonBtn.setTitle("", for: .normal)
                mainContainer?.dismissPopupView()
            }
            return closeOrderReasonView
        }
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
