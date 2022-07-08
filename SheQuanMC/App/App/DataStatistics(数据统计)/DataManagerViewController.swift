//
//  DataManagerViewController.swift
//  App
//
//  Created by mac on 2022/7/8.
//

import UIKit
import Util

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
        choiceTimeBtn.setImagePostion(type: .imageRight, Space: scale(10))
        return choiceTimeBtn
    }()
    
    
    //支付金额
    lazy var payNumLabel:UILabel = {
       let payNumLabel = UILabel()
        payNumLabel.text = "150.00¥"
        payNumLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        payNumLabel.font = UIFont.systemFont(ofSize: scale(22), weight: .regular)
        payNumLabel.textAlignment = .left
        return payNumLabel
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
            make.right.equalToSuperview()
        }
        
        
        
        let payNumView = UIView()
        payNumView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        payAmountView.addSubview(payNumView)
        payNumView.snp.makeConstraints { make in
            make.left.equalTo(payAmountContentView.snp.right).offset(scale(1))
            make.top.equalTo(scale(1))
            make.right.bottom.equalToSuperview()
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
        
        let noPayNumView = UIView()
        noPayNumView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        noPayAmountView.addSubview(noPayNumView)
        noPayNumView.snp.makeConstraints { make in
            make.left.equalTo(noPayAmountContentView.snp.right).offset(scale(1))
            make.top.equalTo(scale(1))
            make.right.bottom.equalToSuperview()
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
        
        let customerPriceNumView = UIView()
        customerPriceNumView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        customerPriceView.addSubview(customerPriceNumView)
        customerPriceNumView.snp.makeConstraints { make in
            make.left.equalTo(customerPriceContentView.snp.right).offset(scale(1))
            make.top.equalTo(scale(1))
            make.right.bottom.equalToSuperview()
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
        
        let refundAmountNumView = UIView()
        refundAmountNumView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        refundAmountView.addSubview(refundAmountNumView)
        refundAmountNumView.snp.makeConstraints { make in
            make.left.equalTo(refundAmountContentView.snp.right).offset(scale(1))
            make.top.equalTo(scale(1))
            make.right.bottom.equalToSuperview()
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
        }
    }
    
}
