//
//  OrderDetailViewController.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util
import JFPopup

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
    
    
    
    
    var status:String?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        title = "订单详情"
        
        
        let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        view.addSubview(topView)

        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(1))
        }
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
        }
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        
        
        tableview.delegate = self
        tableview.dataSource = self
        
        
         
        tableview.register(OrderDetailStatusCell.self, forCellReuseIdentifier: "OrderDetailStatusCell")
        tableview.register(OrderContentCell.self, forCellReuseIdentifier: "OrderContentCell")
        tableview.register(OrderToBePaidCell.self, forCellReuseIdentifier: "OrderToBePaidCell")
        
        // 待支付 OrderDetailStatusCell OrderContentCell OrderToBePaidCell 底下按键为 关闭订单 改价
        //待发货 OrderDetailStatusCell BuyerAdressCell OrderContentCell    底下按键为 去发货
        //已发货 OrderDetailStatusCell OrderDeliveryLogisticsCell OrderContentCell  底下按键为 修改物流 查看物流
        //交易成功 OrderDetailStatusCell OrderDeliveryLogisticsCell OrderContentCell 底下为空
        //交易失败 OrderDetailStatusCell OrderDeliveryLogisticsCell OrderContentCell 底下为空
        
        tableview.register(OrderDeliveryLogisticsCell.self, forCellReuseIdentifier: "OrderDeliveryLogisticsCell")
        
        tableview.register(BuyerAdressCell.self, forCellReuseIdentifier: "BuyerAdressCell")
        
        //待支付
        view.addSubview(modifyPriceBtn)
        modifyPriceBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
            make.height.equalTo(scale(36))
            make.width.equalTo(scale(64))
        }
        
        modifyPriceBtn.layer.cornerRadius = scale(4)
        modifyPriceBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        modifyPriceBtn.layer.borderWidth = scale(1)
        
        
        modifyPriceBtn.addTarget(self, action: #selector(modifyPriceAction), for: .touchUpInside)
        
        
        view.addSubview(closeOrderBtn)
        closeOrderBtn.snp.makeConstraints { make in
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
            make.height.equalTo(scale(36))
            make.width.equalTo(scale(80))
            make.right.equalTo(modifyPriceBtn.snp.left).offset(-scale(12))
        }
        
        closeOrderBtn.addTarget(self, action: #selector(closeOrderAction), for: .touchUpInside)
        
        closeOrderBtn.layer.cornerRadius = scale(4)
        closeOrderBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        closeOrderBtn.layer.borderWidth = scale(1)
        
        
        //待发货
        view.addSubview(toShipBtn)
        toShipBtn.snp.makeConstraints { make in
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
            make.height.equalTo(scale(36))
            make.width.equalTo(scale(74))
            make.right.equalTo(-scale(12))
        }
        
        toShipBtn.layer.cornerRadius = scale(4)
        toShipBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        toShipBtn.layer.borderWidth = scale(1)
        
        
        toShipBtn.addTarget(self, action: #selector(toShipAction), for: .touchUpInside)
        
        //已发货
        view.addSubview(modifyLogisticsBtn)
        view.addSubview(checkLogisticsBtn)
        checkLogisticsBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(36))
            make.width.equalTo(scale(88))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        checkLogisticsBtn.layer.cornerRadius = scale(4)
        checkLogisticsBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        checkLogisticsBtn.layer.borderWidth = scale(1)
        checkLogisticsBtn.addTarget(self, action: #selector(checkLogisticsAction), for: .touchUpInside)
        
        
        modifyLogisticsBtn.snp.makeConstraints { make in
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
            make.height.equalTo(scale(36))
            make.width.equalTo(scale(88))
            make.right.equalTo(checkLogisticsBtn.snp.left).offset(-scale(12))
        }
        
        modifyLogisticsBtn.layer.cornerRadius = scale(4)
        modifyLogisticsBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        modifyLogisticsBtn.layer.borderWidth = scale(1)
        
        modifyLogisticsBtn.addTarget(self, action: #selector(modifyLogisticsAction), for: .touchUpInside)
                
                
                
                    
                if status == "待支付"{
                    
                    
                    closeOrderBtn.isHidden = false
                    modifyPriceBtn.isHidden = false
                    toShipBtn.isHidden = true
                    
                    checkLogisticsBtn.isHidden = true
                    modifyLogisticsBtn.isHidden = true
                    
                    
                    
                }else if status == "待发货"{
                    
                    closeOrderBtn.isHidden = true
                    modifyPriceBtn.isHidden = true
                    toShipBtn.isHidden = false
                    
                    checkLogisticsBtn.isHidden = true
                    modifyLogisticsBtn.isHidden = true
                    
                    
                    
                }else if status == "已发货"{
                    
                    closeOrderBtn.isHidden = true
                    modifyPriceBtn.isHidden = true
                    toShipBtn.isHidden = true
                    
                    checkLogisticsBtn.isHidden = false
                    modifyLogisticsBtn.isHidden = false
                    
                    
                }else{
                    closeOrderBtn.isHidden = true
                    modifyPriceBtn.isHidden = true
                    toShipBtn.isHidden = true
                    
                    checkLogisticsBtn.isHidden = true
                    modifyLogisticsBtn.isHidden = true
                    
                    tableview.snp.remakeConstraints { make in
                        make.left.right.equalToSuperview()
                        make.top.equalTo(topView.snp.bottom)
                        make.bottom.equalTo(scale(0))
                    }
                }
        
        
    }
    
    deinit {
        let cell = tableview.cellForRow(at: IndexPath(row:0, section: 0)) as! OrderDetailStatusCell
        cell.timer?.invalidate()
        cell.timer = nil
    }
    
    
    //修改价格
    @objc func modifyPriceAction(modifyPriceBtn:UIButton){
        //这边也要自定义一个UIview
        self.popup.bottomSheet {
            let modifyPriceView = ModifyPriceView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(492)))
            modifyPriceView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            return modifyPriceView
        }
    }
    
    //关闭订单
    @objc func closeOrderAction(closeOrderBtn:UIButton){
        // 这边要自定义一个UIview
        self.popup.bottomSheet {
            let closeOrderReasonView = CloseOrderReasonView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(489)))
            closeOrderReasonView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            return closeOrderReasonView
        }
    }
    
    //去发货
    @objc func toShipAction(toshipBtn:UIButton){
        let modifyLogisticsVc  = ModifyLogisticsViewController()
        modifyLogisticsVc.title = "订单发货"
        Coordinator.shared?.pushViewController(self, modifyLogisticsVc, animated: true)
    }
    
    
    //修改物流
    @objc func checkLogisticsAction(checkLogisticsBtn:UIButton){
        let modifyLogisticsVc  = ModifyLogisticsViewController()
        modifyLogisticsVc.title = "修改物流"
        Coordinator.shared?.pushViewController(self, modifyLogisticsVc, animated: true)
    }
    
    
    //查看物流
    @objc func modifyLogisticsAction(modifyLogisticsBtn:UIButton){
        let checkLogistVC = CheckLogisticsViewController()
        Coordinator.shared?.pushViewController(self, checkLogistVC, animated: true)
    }
    
    
    
    //修改买家地址
    @objc func modifyBuyerAddressAction(modifyBtn:UIButton){
        let modifyAddressVc = ModifyReturnAddressViewController()
        Coordinator.shared?.pushViewController(self, modifyAddressVc, animated: true)
    }
    
    //进入物流
    @objc func joinCheckLogisticsAction(joinSignBtn:UIButton){
        let checkLogistVC = CheckLogisticsViewController()
        Coordinator.shared?.pushViewController(self, checkLogistVC, animated: true)
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
        if status == "待支付"{
            if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderContentCell") as! OrderContentCell
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderToBePaidCell") as! OrderToBePaidCell
                return cell
            }
            
        }else if status == "待发货"{
            if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "BuyerAdressCell") as! BuyerAdressCell
                cell.modifyBtn.tag = indexPath.row
                cell.modifyBtn.addTarget(self, action: #selector(modifyBuyerAddressAction), for: .touchUpInside)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderContentCell") as! OrderContentCell
                return cell
            }
        }else{
            if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDeliveryLogisticsCell") as! OrderDeliveryLogisticsCell
                cell.joinSignBtn.tag = indexPath.row
                cell.joinSignBtn.addTarget(self, action: #selector(joinCheckLogisticsAction), for: .touchUpInside)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderContentCell") as! OrderContentCell
                return cell
            }
        }
    }
}
