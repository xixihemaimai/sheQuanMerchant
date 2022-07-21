//
//  AfterSalesDetailViewController.swift
//  App
//
//  Created by mac on 2022/7/14.
//

import UIKit
import Util

class AfterSalesDetailViewController: BaseViewController {

    lazy var newTableView:UITableView = {
        let newTabelView = UITableView(frame: .zero, style: .plain)
        newTabelView.separatorStyle = .none
        if #available(iOS 11.0, *){
            newTabelView.contentInsetAdjustmentBehavior = .never
        }
        if #available(iOS 15.0, *){
            newTabelView.sectionHeaderTopPadding = 0
        }
        return newTabelView
    }()
    
    
    lazy var topView:UIView = {
       let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        return topView
    }()
    
    
    //拒绝退款
    lazy var refuseRefundBtn:UIButton = {
       let refuseRefundBtn = UIButton()
        refuseRefundBtn.setTitle("拒绝退款", for: .normal)
        refuseRefundBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        refuseRefundBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return refuseRefundBtn
    }()
    
    //同意退款
    lazy var agreeRefundBtn:UIButton = {
       let agreeRefundBtn = UIButton()
        agreeRefundBtn.setTitle("同意退款", for: .normal)
        agreeRefundBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        agreeRefundBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return agreeRefundBtn
    }()
    
    //上传凭证
    lazy var uploadVoucherBtn:UIButton = {
        let uploadVoucherBtn = UIButton()
        uploadVoucherBtn.setTitle("上传凭证", for: .normal)
        uploadVoucherBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        uploadVoucherBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
         return uploadVoucherBtn
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(modifyAfterSalesAddress), name: ModifyAfterSalesAddress, object: nil)
        
        
        

        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        title = "售后详情"
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(1))
        }
        
        view.addSubview(newTableView)
        newTableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
        }
        newTableView.delegate = self
        newTableView.dataSource = self
        newTableView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F4F4F4")
        newTableView.register(AfterSalesDetailCell.self, forCellReuseIdentifier: "AfterSalesDetailCell")
        newTableView.register(AfterSalesHistoryCell.self, forCellReuseIdentifier: "AfterSalesHistoryCell")
        newTableView.register(AfterSalesOrderCell.self, forCellReuseIdentifier: "AfterSalesOrderCell")
        newTableView.register(AfterSalesOrderInfoCell.self, forCellReuseIdentifier: "AfterSalesOrderInfoCell")
        newTableView.register(AfterSalesReturnAddressCell.self, forCellReuseIdentifier: "AfterSalesReturnAddressCell")
        newTableView.register(AfterSalesToBePaidCell.self, forCellReuseIdentifier: "AfterSalesToBePaidCell")
        newTableView.register(AfterSalesDeliveryLogisticsCell.self, forCellReuseIdentifier: "AfterSalesDeliveryLogisticsCell")
        
        
        view.addSubview(refuseRefundBtn)
        view.addSubview(agreeRefundBtn)
        view.addSubview(uploadVoucherBtn)
        
        agreeRefundBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(newTableView.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(96))
            make.height.equalTo(scale(36))
        }
        
        agreeRefundBtn.layer.cornerRadius = scale(4)
        agreeRefundBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        agreeRefundBtn.layer.borderWidth = scale(1)
        agreeRefundBtn.isHidden = true
        agreeRefundBtn.addTarget(self, action: #selector(agreeRefundBtnAction), for: .touchUpInside)
        
        
        
        
        refuseRefundBtn.snp.makeConstraints { make in
            make.top.equalTo(newTableView.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(96))
            make.height.equalTo(scale(36))
            make.right.equalTo(agreeRefundBtn.snp.left).offset(-scale(16))
        }
        
        refuseRefundBtn.layer.cornerRadius = scale(4)
        refuseRefundBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        refuseRefundBtn.layer.borderWidth = scale(1)
        refuseRefundBtn.addTarget(self, action: #selector(refuseRefundBtnAction), for: .touchUpInside)
        
        
        uploadVoucherBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(newTableView.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(96))
            make.height.equalTo(scale(36))
        }
        
        uploadVoucherBtn.layer.cornerRadius = scale(4)
        uploadVoucherBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        uploadVoucherBtn.layer.borderWidth = scale(1)
        uploadVoucherBtn.addTarget(self, action: #selector(uploadVoucherAction), for: .touchUpInside)
        
        
    }
    
    @objc func uploadVoucherAction(uploadVoucherBtn:UIButton){
        let negotiationHistoryVc  = NegotiationHistoryViewController()
        Coordinator.shared?.pushViewController(self, negotiationHistoryVc, animated: true)
    }
    
    //同意退款
    @objc func agreeRefundBtnAction(agreeRefundBtn:UIButton){
        self.popup.bottomSheet {
            let agreenRefundView = AgreenRefundView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(492)),viewController: self)
            agreenRefundView.dismissAgreenViweBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            return agreenRefundView
        }
    }
    
    //拒绝退款
    @objc func refuseRefundBtnAction(refuseRefundBtn:UIButton){
        self.popup.bottomSheet {
            let agreenRefundView = AgreenRefundView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(492)),viewController: self)
            agreenRefundView.dismissAgreenViweBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            
            return agreenRefundView
        }
    }
    
    @objc func modifyAfterSalesAddress(noti:Notification){
        let userInfo = noti.userInfo
        let address = userInfo?["address"] as? String
        LXFLog("+==============================\(address)")
        self.popup.bottomSheet {
            let agreenRefundView = AgreenRefundView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(492)),viewController: self)
            agreenRefundView.dismissAgreenViweBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            return agreenRefundView
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension AfterSalesDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AfterSalesDetailCell") as! AfterSalesDetailCell
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AfterSalesHistoryCell") as! AfterSalesHistoryCell
            return cell
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AfterSalesDeliveryLogisticsCell") as! AfterSalesDeliveryLogisticsCell
            return cell
        }else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AfterSalesOrderCell") as! AfterSalesOrderCell
            return cell
        }else if indexPath.row == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AfterSalesOrderInfoCell") as! AfterSalesOrderInfoCell
            return cell
        }else if indexPath.row == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AfterSalesReturnAddressCell") as! AfterSalesReturnAddressCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AfterSalesToBePaidCell") as! AfterSalesToBePaidCell
            return cell
        }
    }
    
}
