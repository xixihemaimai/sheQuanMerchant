//
//  DataManagerViewController.swift
//  App
//
//  Created by mac on 2022/7/8.
//

import UIKit
import Util
import SwiftUI

class DataManagerViewController: BaseViewController {
    //实时按键
    lazy var currentTimeBtn:UIButton = {
       let currentTimeBtn = UIButton()
        currentTimeBtn.setTitle("实时", for: .normal)
        currentTimeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        currentTimeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .selected)
        currentTimeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        currentTimeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        currentTimeBtn.isSelected = true
        currentTimeBtn.tag = 0
        currentTimeBtn.addTarget(self, action: #selector(showCurrentStatusTimeDataAction), for: .touchUpInside)
        return currentTimeBtn
    }()
    
    //实时图
    lazy var currentView:UIView = {
       let currentView = UIView()
        currentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        return currentView
    }()
    
    //日报
    lazy var dayTimeBtn:UIButton = {
       let dayTimeBtn = UIButton()
        dayTimeBtn.setTitle("日报", for: .normal)
        dayTimeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        dayTimeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .selected)
        dayTimeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        dayTimeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        dayTimeBtn.isSelected = false
        dayTimeBtn.tag = 1
        dayTimeBtn.addTarget(self, action: #selector(showCurrentStatusTimeDataAction), for: .touchUpInside)
        return dayTimeBtn
    }()
    
    //日报图
    lazy var dayView:UIView = {
       let dayView = UIView()
        dayView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4")
        return dayView
    }()
    
    
    //月报
    lazy var monthTimeBtn:UIButton = {
       let monthTimeBtn = UIButton()
        monthTimeBtn.setTitle("月报", for: .normal)
        monthTimeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        monthTimeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .selected)
        monthTimeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        monthTimeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        monthTimeBtn.isSelected = false
        monthTimeBtn.tag = 2
        monthTimeBtn.addTarget(self, action: #selector(showCurrentStatusTimeDataAction), for: .touchUpInside)
        return monthTimeBtn
    }()
    //月报图
    lazy var monthView:UIView = {
       let monthView = UIView()
        monthView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4")
        return monthView
    }()
    
    
    //选择时间
    lazy var choiceTimeBtn:UIButton = {
        let choiceTimeBtn = UIButton()
        //当前时间
        choiceTimeBtn.setTitle("2022年03月03日", for: .normal)
        choiceTimeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        choiceTimeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        choiceTimeBtn.setImage(UIImage(named: "Group 2736"), for: .normal)
        choiceTimeBtn.setImagePostion(type: .imageRight, Space: scale(4))
        choiceTimeBtn.contentHorizontalAlignment = .right
        choiceTimeBtn.addTarget(self, action: #selector(choiceDataTypeAction), for: .touchUpInside)
        choiceTimeBtn.isHidden = true
        return choiceTimeBtn
    }()
    
    
    //支付金额
    lazy var payNumLabel:UILabel = {
       let payNumLabel = UILabel()
        payNumLabel.text = "150.00"
        payNumLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        payNumLabel.font = UIFont.systemFont(ofSize: scale(22), weight: .regular)
        payNumLabel.textAlignment = .left
        return payNumLabel
    }()
    
    //支付订单数
    lazy var payOrderNumberLabel:UILabel = {
        let payOrderNumberLabel = UILabel()
        payOrderNumberLabel.text = "12"
        payOrderNumberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        payOrderNumberLabel.font = UIFont.systemFont(ofSize: scale(22), weight: .regular)
        payOrderNumberLabel.textAlignment = .left
        return payOrderNumberLabel
    }()
    
    
    //下单未付款金额
    lazy var noPayLabel:UILabel = {
        let noPayLabel = UILabel()
        noPayLabel.text = "150.00"
        noPayLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        noPayLabel.font = UIFont.systemFont(ofSize: scale(22), weight: .regular)
        noPayLabel.textAlignment = .left
        return noPayLabel
    }()
    
    
     //下单未付款单数
    lazy var noPayNumLabel:UILabel = {
        let noPayNumLabel = UILabel()
        noPayNumLabel.text = "12"
        noPayNumLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        noPayNumLabel.font = UIFont.systemFont(ofSize: scale(22), weight: .regular)
        noPayNumLabel.textAlignment = .left
        return noPayNumLabel
    }()
    
    
    //客单价
    lazy var ticketsLabel:UILabel = {
        let ticketsLabel = UILabel()
        ticketsLabel.text = "150.00"
        ticketsLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        ticketsLabel.font = UIFont.systemFont(ofSize: scale(22), weight: .regular)
        ticketsLabel.textAlignment = .left
        return ticketsLabel
    }()
    
    
    //店铺访问数
    lazy var ticketsNumLabel:UILabel = {
        let ticketsNumLabel = UILabel()
        ticketsNumLabel.text = "12"
        ticketsNumLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        ticketsNumLabel.font = UIFont.systemFont(ofSize: scale(22), weight: .regular)
        ticketsNumLabel.textAlignment = .left
        return ticketsNumLabel
    }()
    
    //退款金额
    lazy var refundAmountLabel:UILabel = {
       let refundAmountLabel = UILabel()
        refundAmountLabel.text = "150.00"
        refundAmountLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        refundAmountLabel.font = UIFont.systemFont(ofSize: scale(22), weight: .regular)
        refundAmountLabel.textAlignment = .left
        return refundAmountLabel
    }()
    
    //退款单数
    lazy var refundNumLabel:UILabel = {
        let refundNumLabel = UILabel()
        refundNumLabel.text = "12"
        refundNumLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        refundNumLabel.font = UIFont.systemFont(ofSize: scale(22), weight: .regular)
        refundNumLabel.textAlignment = .left
        return refundNumLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "数据统计"
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F4F4F4")
        
        //这边是view
        let contentView = UIView()
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(8))
            make.bottom.equalTo(-scale(270))
        }
        
        //数据统计标题
        let dataLabel = UILabel()
        dataLabel.text = "数据统计"
        dataLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        dataLabel.font = UIFont.systemFont(ofSize: scale(15), weight: .semibold)
        dataLabel.textAlignment = .left
        contentView.addSubview(dataLabel)
        dataLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(12))
            make.height.equalTo(scale(21))
            make.width.equalTo(scale(100))
        }
        
        contentView.addSubview(choiceTimeBtn)
        choiceTimeBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(12))
            make.height.equalTo(scale(25))
            make.width.equalTo(scale(150))
        }
        
        
        currentView.frame = CGRect(x: SCW/2 - scale(76)/2 - scale(76) + scale(1), y: scale(52), width: scale(76), height: scale(32))
        contentView.addSubview(currentView)
        currentView.addCorner(conrners: [.topLeft,.bottomLeft], radius: scale(4))
        currentTimeBtn.frame = CGRect(x: scale(1), y: scale(1), width: scale(74), height: scale(30))
        currentView.addSubview(currentTimeBtn)
        currentTimeBtn.addCorner(conrners: [.topLeft,.bottomLeft], radius: scale(4))

        
        
        contentView.addSubview(dayView)
        dayView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scale(52))
            make.width.equalTo(scale(76))
            make.height.equalTo(scale(32))
        }
        
        dayView.addSubview(dayTimeBtn)
        dayTimeBtn.snp.makeConstraints { make in
            make.top.equalTo(scale(1))
            make.bottom.equalTo(-scale(1))
            make.left.equalTo(scale(1))
            make.right.equalTo(-scale(1))
        }
        
        monthView.frame = CGRect(x: SCW/2 + scale(76)/2 - scale(1), y: scale(52), width: scale(76), height: scale(32))
        contentView.addSubview(monthView)
        monthView.addCorner(conrners: [.topRight,.bottomRight], radius: scale(4))
        monthTimeBtn.frame = CGRect(x: scale(1), y: scale(1), width: scale(74), height: scale(30))
        monthView.addSubview(monthTimeBtn)
        monthTimeBtn.addCorner(conrners: [.topRight,.bottomRight], radius: scale(4))
        
        
        
        choiceTimeBtn.setTitle(Date().getString(format: "yyyy年MM月dd日"), for: .normal)
        
        let payAmountView = UIView()
        payAmountView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        contentView.addSubview(payAmountView)
        
        payAmountView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(91))
            make.height.equalTo(scale(93))
        }
            
        let payAmountContentView = UIView()
        payAmountContentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        payAmountView.addSubview(payAmountContentView)
        payAmountContentView.snp.makeConstraints { make in
            make.left.equalTo(scale(1))
            make.top.equalTo(scale(1))
            make.bottom.equalToSuperview()
            make.width.equalTo(SCW/2 - scale(1))
        }
        
        
        let payLabel = UILabel()
        payLabel.text = "支付金额"
        payLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#818181")
        payLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        payLabel.textAlignment  = .left
        payAmountContentView.addSubview(payLabel)
        payLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(19))
            make.height.equalTo(scale(18))
            make.right.equalToSuperview()
        }
        
        
        payAmountContentView.addSubview(payNumLabel)
        payNumLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(payLabel.snp.bottom).offset(scale(6))
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(70))
        }
        
        
        let payLastView = UILabel()
        payLastView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        payLastView.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        payLastView.textAlignment  = .left
        payLastView.text = "¥"
        payAmountContentView.addSubview(payLastView)
        payLastView.snp.makeConstraints { make in
            make.left.equalTo(payNumLabel.snp.right)
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(20))
            make.height.equalTo(scale(20))
        }
        
        
        let payNumView = UIView()
        payNumView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        payAmountView.addSubview(payNumView)
        payNumView.snp.makeConstraints { make in
            make.left.equalTo(payAmountContentView.snp.right).offset(scale(1))
            make.top.equalTo(scale(1))
            make.right.bottom.equalToSuperview()
        }
        
        
        let payOrderLabel = UILabel()
        payOrderLabel.text = "支付订单数"
        payOrderLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#818181")
        payOrderLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        payOrderLabel.textAlignment  = .left
        payNumView.addSubview(payOrderLabel)
        payOrderLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(19))
            make.height.equalTo(scale(18))
            make.right.equalToSuperview()
        }
        
     
        payNumView.addSubview(payOrderNumberLabel)
        payOrderNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(payOrderLabel.snp.bottom).offset(scale(6))
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(30))
        }
        
        let payNumLastView = UILabel()
        payNumLastView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        payNumLastView.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        payNumLastView.textAlignment  = .left
        payNumLastView.text = "单"
        payNumView.addSubview(payNumLastView)
        payNumLastView.snp.makeConstraints { make in
            make.left.equalTo(payOrderNumberLabel.snp.right)
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(20))
            make.height.equalTo(scale(20))
        }
        
        
        
        
        
        let noPayAmountView = UIView()
        noPayAmountView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        contentView.addSubview(noPayAmountView)
        noPayAmountView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(payAmountView.snp.bottom)
            make.height.equalTo(scale(93))
        }
        
        let noPayAmountContentView = UIView()
        noPayAmountContentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        noPayAmountView.addSubview(noPayAmountContentView)
        noPayAmountContentView.snp.makeConstraints { make in
            make.left.equalTo(scale(1))
            make.top.equalTo(scale(1))
            make.bottom.equalToSuperview()
            make.width.equalTo(SCW/2 - scale(1))
        }
        
        
        
        let noPayPriceLabel = UILabel()
        noPayPriceLabel.text = "下单未付款金额"
        noPayPriceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#818181")
        noPayPriceLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        noPayPriceLabel.textAlignment  = .left
        noPayAmountContentView.addSubview(noPayPriceLabel)
        noPayPriceLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(19))
            make.height.equalTo(scale(18))
            make.right.equalToSuperview()
        }
        
        
        noPayAmountContentView.addSubview(noPayLabel)
        noPayLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(noPayPriceLabel.snp.bottom).offset(scale(6))
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(70))
        }
        
        
        
        let noPaylastView = UILabel()
        noPaylastView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        noPaylastView.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        noPaylastView.textAlignment  = .left
        noPaylastView.text = "¥"
        noPayAmountContentView.addSubview(noPaylastView)
        noPaylastView.snp.makeConstraints { make in
            make.left.equalTo(noPayLabel.snp.right)
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(20))
            make.height.equalTo(scale(20))
        }
        
        
        
        
        
        
        let noPayNumView = UIView()
        noPayNumView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        noPayAmountView.addSubview(noPayNumView)
        noPayNumView.snp.makeConstraints { make in
            make.left.equalTo(noPayAmountContentView.snp.right).offset(scale(1))
            make.top.equalTo(scale(1))
            make.right.bottom.equalToSuperview()
        }
        
        
        let noPayNumPriceLabel = UILabel()
        noPayNumPriceLabel.text = "下单未付款单数"
        noPayNumPriceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#818181")
        noPayNumPriceLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        noPayNumPriceLabel.textAlignment  = .left
        noPayNumView.addSubview(noPayNumPriceLabel)
        noPayNumPriceLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(19))
            make.height.equalTo(scale(18))
            make.right.equalToSuperview()
        }
        
        noPayNumView.addSubview(noPayNumLabel)
        noPayNumLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(noPayNumPriceLabel.snp.bottom).offset(scale(6))
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(30))
        }
        
        let noPaylastNumView = UILabel()
        noPaylastNumView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        noPaylastNumView.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        noPaylastNumView.textAlignment  = .left
        noPaylastNumView.text = "单"
        noPayNumView.addSubview(noPaylastNumView)
        noPaylastNumView.snp.makeConstraints { make in
            make.left.equalTo(noPayNumLabel.snp.right)
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(20))
            make.height.equalTo(scale(20))
        }
        
        
        
        
        let customerPriceView = UIView()
        customerPriceView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        contentView.addSubview(customerPriceView)
        customerPriceView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(noPayAmountView.snp.bottom)
            make.height.equalTo(scale(93))
        }
        
        
        
        let customerPriceContentView = UIView()
        customerPriceContentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        customerPriceView.addSubview(customerPriceContentView)
        customerPriceContentView.snp.makeConstraints { make in
            make.left.equalTo(scale(1))
            make.top.equalTo(scale(1))
            make.bottom.equalToSuperview()
            make.width.equalTo(SCW/2 - scale(1))
        }
        
        
        let ticketsCustomerLabel = UILabel()
        ticketsCustomerLabel.text = "客单价"
        ticketsCustomerLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#818181")
        ticketsCustomerLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        ticketsCustomerLabel.textAlignment  = .left
        customerPriceContentView.addSubview(ticketsCustomerLabel)
        ticketsCustomerLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(19))
            make.height.equalTo(scale(18))
            make.right.equalToSuperview()
        }
        
        customerPriceContentView.addSubview(ticketsLabel)
        ticketsLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(ticketsCustomerLabel.snp.bottom).offset(scale(6))
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(70))
        }
        
        
        let ticketslastView = UILabel()
        ticketslastView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        ticketslastView.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        ticketslastView.textAlignment  = .left
        ticketslastView.text = "¥"
        customerPriceContentView.addSubview(ticketslastView)
        ticketslastView.snp.makeConstraints { make in
            make.left.equalTo(ticketsLabel.snp.right)
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(20))
            make.height.equalTo(scale(20))
        }
        
        
        let customerPriceNumView = UIView()
        customerPriceNumView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        customerPriceView.addSubview(customerPriceNumView)
        customerPriceNumView.snp.makeConstraints { make in
            make.left.equalTo(customerPriceContentView.snp.right).offset(scale(1))
            make.top.equalTo(scale(1))
            make.right.bottom.equalToSuperview()
        }
        

        
        let ticketsCustomerNumLabel = UILabel()
        ticketsCustomerNumLabel.text = "店铺访问人数"
        ticketsCustomerNumLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#818181")
        ticketsCustomerNumLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        ticketsCustomerNumLabel.textAlignment  = .left
        customerPriceNumView.addSubview(ticketsCustomerNumLabel)
        ticketsCustomerNumLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(19))
            make.height.equalTo(scale(18))
            make.right.equalToSuperview()
        }
        
        customerPriceNumView.addSubview(ticketsNumLabel)
        ticketsNumLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(ticketsCustomerNumLabel.snp.bottom).offset(scale(6))
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(30))
        }
        
        
        let ticketslastNumView = UILabel()
        ticketslastNumView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        ticketslastNumView.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        ticketslastNumView.textAlignment  = .left
        ticketslastNumView.text = "人"
        customerPriceNumView.addSubview(ticketslastNumView)
        ticketslastNumView.snp.makeConstraints { make in
            make.left.equalTo(ticketsNumLabel.snp.right)
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(20))
            make.height.equalTo(scale(20))
        }
        
        
        
        
        let refundAmountView = UIView()
        refundAmountView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        contentView.addSubview(refundAmountView)
        refundAmountView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(customerPriceView.snp.bottom)
            make.height.equalTo(scale(93))
        }
        
        
        let refundAmountContentView = UIView()
        refundAmountContentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        refundAmountView.addSubview(refundAmountContentView)
        refundAmountContentView.snp.makeConstraints { make in
            make.left.equalTo(scale(1))
            make.top.equalTo(scale(1))
            make.bottom.equalToSuperview()
            make.width.equalTo(SCW/2 - scale(1))
        }
        
 
        let refundAmountContentLabel = UILabel()
        refundAmountContentLabel.text = "退款金额"
        refundAmountContentLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#818181")
        refundAmountContentLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        refundAmountContentLabel.textAlignment  = .left
        refundAmountContentView.addSubview(refundAmountContentLabel)
        refundAmountContentLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(19))
            make.height.equalTo(scale(18))
            make.right.equalToSuperview()
        }
        
        refundAmountContentView.addSubview(refundAmountLabel)
        refundAmountLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(refundAmountContentLabel.snp.bottom).offset(scale(6))
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(70))
        }
        
        
        let refundAmountlastView = UILabel()
        refundAmountlastView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        refundAmountlastView.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        refundAmountlastView.textAlignment  = .left
        refundAmountlastView.text = "¥"
        refundAmountContentView.addSubview(refundAmountlastView)
        refundAmountlastView.snp.makeConstraints { make in
            make.left.equalTo(refundAmountLabel.snp.right)
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(20))
            make.height.equalTo(scale(20))
        }
        
        let refundAmountNumView = UIView()
        refundAmountNumView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        refundAmountView.addSubview(refundAmountNumView)
        refundAmountNumView.snp.makeConstraints { make in
            make.left.equalTo(refundAmountContentView.snp.right).offset(scale(1))
            make.top.equalTo(scale(1))
            make.width.bottom.equalToSuperview()
        }
        
        let refundAmountContentNumLabel = UILabel()
        refundAmountContentNumLabel.text = "退款单数"
        refundAmountContentNumLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#818181")
        refundAmountContentNumLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        refundAmountContentNumLabel.textAlignment  = .left
        refundAmountNumView.addSubview(refundAmountContentNumLabel)
        refundAmountContentNumLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(19))
            make.height.equalTo(scale(18))
            make.right.equalToSuperview()
        }
        
        refundAmountNumView.addSubview(refundNumLabel)
        refundNumLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(refundAmountContentNumLabel.snp.bottom).offset(scale(6))
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(30))
        }
        
        
        let refundAmountlastNumView = UILabel()
        refundAmountlastNumView.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        refundAmountlastNumView.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        refundAmountlastNumView.textAlignment  = .left
        refundAmountlastNumView.text = "单"
        refundAmountNumView.addSubview(refundAmountlastNumView)
        refundAmountlastNumView.snp.makeConstraints { make in
            make.left.equalTo(ticketsNumLabel.snp.right)
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(20))
            make.height.equalTo(scale(20))
        }
        
    }
    
    
    
    @objc func showCurrentStatusTimeDataAction(btn:UIButton){
        
        if btn.tag == 0{
            currentTimeBtn.isSelected = true
            monthTimeBtn.isSelected = false
            dayTimeBtn.isSelected = false
            currentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
            dayView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#c4c4c4")
            monthView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#c4c4c4")
            
            currentTimeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
            dayTimeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            monthTimeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            
            choiceTimeBtn.isHidden = true
            
            
        }else if btn.tag == 1{
            
            currentTimeBtn.isSelected = false
            monthTimeBtn.isSelected = false
            dayTimeBtn.isSelected = true
            currentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#c4c4c4")
            dayView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
            monthView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#c4c4c4")
            
            
            currentTimeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            dayTimeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
            monthTimeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            
            choiceTimeBtn.isHidden = false
            
            
            choiceTimeBtn.setTitle(Date().getString(format: "yyyy年MM月dd日"), for: .normal)
            choiceTimeBtn.setImagePostion(type: .imageRight, Space: scale(6))
            
        }else if  btn.tag == 2{
            
            currentTimeBtn.isSelected = false
            monthTimeBtn.isSelected = true
            dayTimeBtn.isSelected = false
            currentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#c4c4c4")
            dayView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#c4c4c4")
            monthView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
            
            currentTimeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            dayTimeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            monthTimeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
            
            choiceTimeBtn.isHidden = false
            choiceTimeBtn.setTitle(Date().getString(format: "yyyy年MM月"), for: .normal)
            choiceTimeBtn.setImagePostion(type: .imageRight, Space: scale(4))
        }
    }
    
    
    
    @objc func choiceDataTypeAction(choiceTimeBtn:UIButton){
        //字符串转date
        //当前的时间的年-2得到最小时间年份
        let year = Int(Date().getString(format: "yyyy"))! - 2
        let newYear = String(year)
        let datePicker = YBDatePicker(currentDate: Date(), minLimitDate: Date.getDate(dateStr: newYear + "-01-01", format: monthTimeBtn.isSelected == true ? "yyyy-MM" : "yyyy-MM-dd"), maxLimitDate: Date(), datePickerType: monthTimeBtn.isSelected == true ? .YM : .YMD) {[weak self] date in
            LXFLog("=---------------------------\(date)")
            if self?.monthTimeBtn.isSelected == true{
                self?.choiceTimeBtn.setTitle(date.getString(format: "yyyy年MM月"), for: .normal)
            }else
            {
                self?.choiceTimeBtn.setTitle(date.getString(format: "yyyy年MM月dd日"), for: .normal)
            }
        }
        datePicker.show()
    }
}
