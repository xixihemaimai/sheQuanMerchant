//
//  OrderDetailViewController.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class OrderDetailViewController: BaseViewController {
    
    
    
    
    //待支付
    //关闭订单按键
    lazy var closeOrderBtn:UIButton = {
       let closeOrderBtn = UIButton()
        closeOrderBtn.setTitle("关闭订单", for: .normal)
        closeOrderBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        closeOrderBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return closeOrderBtn
    }()
    
    
    //改价按键
    lazy var modifyPriceBtn:UIButton = {
       let modifyPriceBtn = UIButton()
        modifyPriceBtn.setTitle("改价", for: .normal)
        modifyPriceBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        modifyPriceBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return modifyPriceBtn
    }()
    
    
    
    //-----------待发货
    //去发货按键
    lazy var toShipBtn:UIButton = {
       let toShipBtn = UIButton()
        toShipBtn.setTitle("去发货", for: .normal)
        toShipBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        toShipBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return toShipBtn
    }()
    
    
    //-----------已发货
    //修改物流按键
    lazy var modifyLogisticsBtn:UIButton = {
       let modifyLogisticsBtn = UIButton()
        modifyLogisticsBtn.setTitle("修改物流", for: .normal)
        modifyLogisticsBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        modifyLogisticsBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return modifyLogisticsBtn
    }()
    
    
    //查看物流按键
    lazy var checkLogisticsBtn:UIButton = {
       let checkLogisticsBtn = UIButton()
        checkLogisticsBtn.setTitle("查看物流", for: .normal)
        checkLogisticsBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        checkLogisticsBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return checkLogisticsBtn
    }()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        title = "订单详情"
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(-scale(92))
        }
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(OrderDetailStatusCell.self, forCellReuseIdentifier: "OrderDetailStatusCell")
        tableview.register(OrderContentCell.self, forCellReuseIdentifier: "OrderContentCell")
        tableview.register(OrderToBePaidCell.self, forCellReuseIdentifier: "OrderToBePaidCell")
        
        
        tableview.register(OrderDeliveryLogisticsCell.self, forCellReuseIdentifier: "OrderDeliveryLogisticsCell")
        
        
        //待支付
        view.addSubview(modifyPriceBtn)
        modifyPriceBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.bottom.equalTo(-scale(44))
            make.height.equalTo(scale(36))
            make.width.equalTo(scale(64))
        }
        
        modifyPriceBtn.layer.cornerRadius = scale(4)
        modifyPriceBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        modifyPriceBtn.layer.borderWidth = scale(1)
        
        view.addSubview(closeOrderBtn)
        closeOrderBtn.snp.makeConstraints { make in
            make.bottom.equalTo(-scale(44))
            make.height.equalTo(scale(36))
            make.width.equalTo(scale(80))
            make.right.equalTo(modifyPriceBtn.snp.left).offset(-scale(12))
        }
        
        
        closeOrderBtn.layer.cornerRadius = scale(4)
        closeOrderBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        closeOrderBtn.layer.borderWidth = scale(1)
        
        
        //待发货
        view.addSubview(toShipBtn)
        toShipBtn.snp.makeConstraints { make in
            make.bottom.equalTo(-scale(44))
            make.height.equalTo(scale(36))
            make.width.equalTo(scale(74))
            make.right.equalTo(-scale(12))
        }
        
        toShipBtn.layer.cornerRadius = scale(4)
        toShipBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        toShipBtn.layer.borderWidth = scale(1)
        
        
        
        //已发货
        view.addSubview(modifyLogisticsBtn)
        view.addSubview(checkLogisticsBtn)
        checkLogisticsBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(36))
            make.width.equalTo(scale(88))
            make.bottom.equalTo(-scale(44))
        }
        
        checkLogisticsBtn.layer.cornerRadius = scale(4)
        checkLogisticsBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        checkLogisticsBtn.layer.borderWidth = scale(1)
        
        
        
        modifyLogisticsBtn.snp.makeConstraints { make in
            make.bottom.equalTo(-scale(44))
            make.height.equalTo(scale(36))
            make.width.equalTo(scale(88))
            make.right.equalTo(checkLogisticsBtn.snp.left).offset(-scale(12))
        }
        
        modifyLogisticsBtn.layer.cornerRadius = scale(4)
        modifyLogisticsBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        modifyLogisticsBtn.layer.borderWidth = scale(1)
        
        
        
    }
    
    deinit {
        let cell = tableview.cellForRow(at: IndexPath(row:0, section: 0)) as! OrderDetailStatusCell
        cell.timer?.invalidate()
        cell.timer = nil
    }
    

}

extension OrderDetailViewController:UITableViewDelegate,UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailStatusCell") as! OrderDetailStatusCell
            return cell
        }
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderContentCell") as! OrderContentCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderToBePaidCell") as! OrderToBePaidCell
            return cell
        }
    }
}
