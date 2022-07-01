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
    
    
    lazy var topView:UIView = {
       let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        return topView
    }()
    
    var orderInfoModel:OrederInfoModel?
    
    var orderLogisticsModel:OrderLogisticsModel?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        title = "订单详情"
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
        newTableView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        newTableView.delegate = self
        newTableView.dataSource = self
        newTableView.register(OrderDetailStatusCell.self, forCellReuseIdentifier: "OrderDetailStatusCell")
        newTableView.register(OrderContentCell.self, forCellReuseIdentifier: "OrderContentCell")
        newTableView.register(OrderToBePaidCell.self, forCellReuseIdentifier: "OrderToBePaidCell")
        newTableView.register(OrderDeliveryLogisticsCell.self, forCellReuseIdentifier: "OrderDeliveryLogisticsCell")
        newTableView.register(BuyerAdressCell.self, forCellReuseIdentifier: "BuyerAdressCell")
        
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
                
                
        if orderInfoModel?.orderStatus == 10{
            //待支付
           closeOrderBtn.isHidden = false
           modifyPriceBtn.isHidden = false
           toShipBtn.isHidden = true
           checkLogisticsBtn.isHidden = true
           modifyLogisticsBtn.isHidden = true
        }else if orderInfoModel?.orderStatus == 20{
            //待发货
           closeOrderBtn.isHidden = true
           modifyPriceBtn.isHidden = true
           toShipBtn.isHidden = false
           checkLogisticsBtn.isHidden = true
           modifyLogisticsBtn.isHidden = true
        }else if orderInfoModel?.orderStatus == 21{
           //已发货
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
           newTableView.snp.remakeConstraints { make in
               make.left.right.equalToSuperview()
               make.top.equalTo(topView.snp.bottom)
               make.bottom.equalTo(scale(0))
            }
        }
        //获取订单物流，但是有可能没有
//        reloadOrderLogisticsNetData()
    }
    
    
    
//    func reloadOrderLogisticsNetData(){
//        let parameters = ["orderId":orderInfoModel?.orderId as Any] as [String:Any]
//        NetWorkResultRequest(OrderApi.getOrderLogisticsInfo(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
//            guard let model = try? JSONDecoder().decode(GenericResponse<OrderLogisticsModel>.self, from: data) else { return }
//            if let _data = model.data{
//                self?.orderLogisticsModel = _data
//            }
//            self?.newTableView.reloadData()
//        } failureCallback: { error, code in
//            code.loginOut()
//        }
//    }
    
    
    
    deinit {
        let cell = newTableView.cellForRow(at: IndexPath(row:0, section: 0)) as? OrderDetailStatusCell
        cell?.timer?.invalidate()
        cell?.timer = nil
    }
    
    
   
    
    func reloadCurrentOrderInfo(){
        let parameters = ["orderId":orderInfoModel?.orderId as Any] as [String:Any]
        NetWorkResultRequest(OrderApi.getOrderDetailInfo(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<OrederInfoModel>.self, from: data) else { return }
            if let _data = model.data{
                self?.orderInfoModel = _data
                if self?.orderInfoModel?.orderStatus == 10{
                    //待支付
                    self?.closeOrderBtn.isHidden = false
                    self?.modifyPriceBtn.isHidden = false
                    self?.toShipBtn.isHidden = true
                    self?.checkLogisticsBtn.isHidden = true
                    self?.modifyLogisticsBtn.isHidden = true
                }else if self?.orderInfoModel?.orderStatus == 20{
                    //待发货
                    self?.closeOrderBtn.isHidden = true
                    self?.modifyPriceBtn.isHidden = true
                    self?.toShipBtn.isHidden = false
                    self?.checkLogisticsBtn.isHidden = true
                    self?.modifyLogisticsBtn.isHidden = true
                }else if self?.orderInfoModel?.orderStatus == 21{
                   //已发货
                    self?.closeOrderBtn.isHidden = true
                    self?.modifyPriceBtn.isHidden = true
                    self?.toShipBtn.isHidden = true
                    self?.checkLogisticsBtn.isHidden = false
                    self?.modifyLogisticsBtn.isHidden = false
                }else{
                    self?.closeOrderBtn.isHidden = true
                    self?.modifyPriceBtn.isHidden = true
                    self?.toShipBtn.isHidden = true
                    self?.checkLogisticsBtn.isHidden = true
                    self?.modifyLogisticsBtn.isHidden = true
                    self?.newTableView.snp.remakeConstraints { make in
                       make.left.right.equalToSuperview()
                       make.top.equalTo(self!.topView.snp.bottom)
                       make.bottom.equalToSuperview()
                    }
                }
                self?.newTableView.reloadData()
            }
        } failureCallback: { error, code in
            code.loginOut()
        }
    }
    
    
  
    
    //关闭订单
    @objc func closeOrderAction(closeOrderBtn:UIButton){
        self.popup.bottomSheet {
            let closeOrderReasonView = CloseOrderReasonView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(489)),orderId: orderInfoModel?.orderId ?? 0)
            closeOrderReasonView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            //成功之后需要做得事情
            closeOrderReasonView.sureCloseSuccessBlock = {[weak self] in
                //这边是去重新获取该订单信息
                self?.reloadCurrentOrderInfo()
                
//                self?.reloadOrderLogisticsNetData()
                
                NotificationCenter.default.post(name: NSNotification.Name("changeOrderCount"), object: nil)
                
                self?.popup.dismissPopup()
            }
            return closeOrderReasonView
        }
    }
    
    //修改价格
    @objc func modifyPriceAction(modifyPriceBtn:UIButton){
        self.popup.bottomSheet {
            let modifyPriceView = ModifyPriceView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(492)),orderId: orderInfoModel?.orderId ?? 0)
            modifyPriceView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            
            modifyPriceView.modifyPriceSuccessBlock = {[weak self] in
                //这边是去重新获取该订单信息
                self?.reloadCurrentOrderInfo()
                NotificationCenter.default.post(name: NSNotification.Name("changeOrderCount"), object: nil)
                self?.popup.dismissPopup()
            }
            return modifyPriceView
        }
    }
    
    
    //去发货
    @objc func toShipAction(toshipBtn:UIButton){
        let modifyLogisticsVc  = ModifyLogisticsViewController()
        modifyLogisticsVc.title = "订单发货"
        modifyLogisticsVc.jump = .detailJumpType
        modifyLogisticsVc.orderId = orderInfoModel?.orderId ?? 0
        Coordinator.shared?.pushViewController(self, modifyLogisticsVc, animated: true)
        modifyLogisticsVc.jumpSuccessBlockDetailType = {[weak self] in
            
            self?.reloadCurrentOrderInfo()
            
//            self?.reloadOrderLogisticsNetData()
        }
    }
    
    
    //修改物流
    @objc func modifyLogisticsAction(modifyLogisticsBtn:UIButton){
        let modifyLogisticsVc  = ModifyLogisticsViewController()
        modifyLogisticsVc.title = "修改物流"
        modifyLogisticsVc.jump = .detailJumpType
        modifyLogisticsVc.orderId = orderInfoModel?.orderId ?? 0
        Coordinator.shared?.pushViewController(self, modifyLogisticsVc, animated: true)
        modifyLogisticsVc.jumpSuccessBlockDetailType = {[weak self] in
            
            self?.reloadCurrentOrderInfo()
//            self?.reloadOrderLogisticsNetData()
            
        }
    }
    
    //查看物流
    @objc func checkLogisticsAction(checkLogisticsBtn:UIButton){
        let checkLogistVC = CheckLogisticsViewController()
        checkLogistVC.orderInfoModel = orderInfoModel
        Coordinator.shared?.pushViewController(self, checkLogistVC, animated: true)
    }
    
    
    
    //修改买家地址
    @objc func modifyBuyerAddressAction(modifyBtn:UIButton){
        let modifyAddressVc = ModifyReturnAddressViewController()
        modifyAddressVc.jumpType = 1
        Coordinator.shared?.pushViewController(self, modifyAddressVc, animated: true)
        modifyAddressVc.choiceRetAddressSuccessBlock = {[weak self] retAddressInfoModel in
            //这边要修改地址的地方
            self?.orderLogisticsModel?.retAddress = retAddressInfoModel
            self?.tableview.reloadData()
        }
    }
    
    //进入物流
    @objc func joinCheckLogisticsAction(joinSignBtn:UIButton){
        let checkLogistVC = CheckLogisticsViewController()
        checkLogistVC.orderInfoModel = orderInfoModel
        Coordinator.shared?.pushViewController(self, checkLogistVC, animated: true)
    }
    
    
    //复制
    @objc func copyAddressInfoAction(copyBtn:UIButton){
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = String(format: "%@ %@ %@ %@ %@ %@", orderLogisticsModel?.retAddress?.consignee ?? "",orderLogisticsModel?.retAddress?.mobile ?? "",orderLogisticsModel?.retAddress?.provinceName ?? "",orderLogisticsModel?.retAddress?.cityName ?? "",orderLogisticsModel?.retAddress?.regionName ?? "",orderLogisticsModel?.retAddress?.address ?? "")
        JFPopup.toast(hit: "复制成功")
    }
    

}

extension OrderDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if orderInfoModel?.orderStatus == 10{
            return 3
        }else{
            if orderLogisticsModel?.retAddress == nil{
                return 3
            }else{
                return 4
            }
        }
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
            cell.orderInfoModel = orderInfoModel
            //这边用来判断是否倒计时完成--重新获取下商品详情 待支付  已发货
//            if cell.orderInfoModel?.orderStatus == 10 || cell.orderInfoModel?.orderStatus == 21{
                cell.countdownComplete = {[weak self] in
                    self?.reloadCurrentOrderInfo()
                    
//                    self?.reloadOrderLogisticsNetData()
                }
//            }
            return cell
        }
        if orderInfoModel?.orderStatus == 10{
            //待支付
            if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderContentCell") as! OrderContentCell
                cell.orderInfoModel = orderInfoModel
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderToBePaidCell") as! OrderToBePaidCell
                cell.orderInfoModel = orderInfoModel
                return cell
            }
        }else if orderInfoModel?.orderStatus == 20 {
            //待发货
            //已发货 || orderInfoModel?.orderStatus == 21
            if orderLogisticsModel?.retAddress == nil{
                if indexPath.row == 1{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderContentCell") as! OrderContentCell
                    cell.orderInfoModel = orderInfoModel
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderToBePaidCell") as! OrderToBePaidCell
                    cell.orderInfoModel = orderInfoModel
                    return cell
                }
            }else{
                if indexPath.row == 1{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BuyerAdressCell") as! BuyerAdressCell
                    cell.retAddress = orderLogisticsModel?.retAddress
                    //修改
                    cell.modifyBtn.tag = indexPath.row
                    cell.modifyBtn.addTarget(self, action: #selector(modifyBuyerAddressAction), for: .touchUpInside)
                    //复制
                    cell.copyBtn.tag = indexPath.row
                    cell.copyBtn.addTarget(self, action: #selector(copyAddressInfoAction), for: .touchUpInside)
                    return cell
                    
                }else if indexPath.row == 2{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderContentCell") as! OrderContentCell
                    cell.orderInfoModel = orderInfoModel
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderToBePaidCell") as! OrderToBePaidCell
                    cell.orderInfoModel = orderInfoModel
                    return cell
                }
            }
        }else{
            //交易关闭 交易成功
            if orderLogisticsModel?.retAddress == nil{
                if indexPath.row == 1{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderContentCell") as! OrderContentCell
                    cell.orderInfoModel = orderInfoModel
                    return cell
                }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderToBePaidCell") as! OrderToBePaidCell
                    cell.orderInfoModel = orderInfoModel
                    return cell
                }
            }else{
                if indexPath.row == 1{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDeliveryLogisticsCell") as! OrderDeliveryLogisticsCell
                    cell.orderLogisticsModel = orderLogisticsModel
                    cell.joinSignBtn.tag = indexPath.row
                    cell.joinSignBtn.addTarget(self, action: #selector(joinCheckLogisticsAction), for: .touchUpInside)
                    return cell
                }else if indexPath.row == 2{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderContentCell") as! OrderContentCell
                    cell.orderInfoModel = orderInfoModel
                    return cell
                }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderToBePaidCell") as! OrderToBePaidCell
                    cell.orderInfoModel = orderInfoModel
                    return cell
                }
            }
        }
    }
}
