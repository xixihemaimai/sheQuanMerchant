//
//  OrderStatusViewController.swift
//  App
//
//  Created by mac on 2022/5/1.
//

import UIKit
import Util
import JFPopup
import SwiftUI


//protocol OrderStatusViewControllerDelegate:NSObjectProtocol {
//
//    /// 返回的数量
//    /// - Parameters:
//    ///   - title:内容
//    ///   - tag: 位置
//    func returnBackNumber(_ title:String,_ tag:Int)
//}


class OrderStatusViewController: BaseViewController {

//    weak var delegate:OrderStatusViewControllerDelegate?
    
    //用来保存订单首页的控制权
    var orderViewVc:OrderViewController?
    
    
    var orderInfoList:[OrederInfoModel] = [OrederInfoModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableview)
        
        tableview.snp.makeConstraints { make in
            make.left.top.bottom.right.equalToSuperview()
        }
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(OrderStatusCell.self, forCellReuseIdentifier: "OrderStatusCell")
//        loadOrderStatus()
        tableview.mj_header?.beginRefreshing()
        
    }

    func loadOrderStatus(){
//        LXFLog("==================\(title)")
        var tag = 0
        if view.tag == 0{
            tag = 0
        }else if view.tag == 1{
            tag = 10
        }else if view.tag == 2{
            tag = 20
        }else if view.tag == 3{
            tag = 21
        }else if view.tag == 4{
            tag = 30
        }else{
            tag = 41
        }
        let parameters = ["lastOrderId":0,"orderStatus":tag] as [String:Any]
        NetWorkResultRequest(OrderApi.getOrderProductList(parameters: parameters), needShowFailAlert: true) { result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<[OrederInfoModel]>.self, from: data) else { return }
            self.orderInfoList.removeAll()
            if let _data = model.data{
                self.orderInfoList = _data
            }
            self.tableview.mj_header?.endRefreshing()
            self.tableview.reloadData()
        } failureCallback: { error, code in
            code.loginOut()
            self.tableview.mj_header?.endRefreshing()
        }
    }
    
    
    override func headerRereshing() {
        LXFLog("下拉")
        loadOrderStatus()
    }
    
    override func footerRereshing() {
        LXFLog("上拉")
        tableview.mj_footer?.endRefreshing()
    }
    
    
    
    
    
//    @objc func showSS(){
//        //"待支付(0)","待发货(0)","已发货(0)"
//        if title?.contains("待支付") == true {
//            title = "待支付(99+)"
//            delegate?.returnBackNumber(title ?? "", view.tag)
//        }else if title?.contains("待发货") == true {
//            title = "待发货(99+)"
//            delegate?.returnBackNumber(title ?? "", view.tag)
//        }else if title?.contains("已发货") == true {
//            title = "已发货(99+)"
//            delegate?.returnBackNumber(title ?? "", view.tag)
//        }
//    }
    
    
    
    //关闭订单按键
    @objc func closeOrderAction(closeOrderBtn:UIButton){
        // 这边要自定义一个UIview
        let orderInfoModel = orderInfoList[closeOrderBtn.tag]
        LXFLog("+==================\(orderInfoModel.orderId)")
        self.popup.bottomSheet {
            let closeOrderReasonView = CloseOrderReasonView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(489)),orderId: orderInfoModel.orderId ?? 0)
            closeOrderReasonView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            //成功之后需要做得事情
            closeOrderReasonView.sureCloseSuccessBlock = {[weak self] in
                self?.loadOrderStatus()
                self?.popup.dismissPopup()
            }
            return closeOrderReasonView
        }
    }
    
   
    
    //改价按键
    @objc func modifyPriceAction(modifyPriceBtn:UIButton){
        //这边也要自定义一个UIview
        let orderInfoModel = orderInfoList[modifyPriceBtn.tag]
        self.popup.bottomSheet {
            let modifyPriceView = ModifyPriceView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(492)),orderId: orderInfoModel.orderId ?? 0)
            modifyPriceView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            modifyPriceView.modifyPriceSuccessBlock = {[weak self] in
                self?.loadOrderStatus()
                self?.popup.dismissPopup()
            }
            return modifyPriceView
        }
    }
    
    
    
    //查看物流
    @objc func checkLogisticsAction(checkLogisticsBtn:UIButton){
        let orderInfoModel = orderInfoList[checkLogisticsBtn.tag]
        let checkLogistVC = CheckLogisticsViewController()
        checkLogistVC.orderInfoModel = orderInfoModel
        Coordinator.shared?.pushViewController(orderViewVc ?? self, checkLogistVC, animated: true)
    }
    
    //修改物流
    @objc func modifyLogisticsAction(modifyLogisticsBtn:UIButton){
        let orderInfoModel = orderInfoList[modifyLogisticsBtn.tag]
        let modifyLogisticsVc  = ModifyLogisticsViewController()
        modifyLogisticsVc.title = "修改物流"
        modifyLogisticsVc.jump = .listJumpType
        modifyLogisticsVc.orderInfoModel = orderInfoModel
        Coordinator.shared?.pushViewController(orderViewVc ?? self, modifyLogisticsVc, animated: true)
        modifyLogisticsVc.jumpSuccessBlockListType = {[weak self] in
            self?.loadOrderStatus()
        }
    }
    
    //去发货
    @objc func toShipAction(toShipBtn:UIButton){
        let orderInfoModel = orderInfoList[toShipBtn.tag]
        let modifyLogisticsVc  = ModifyLogisticsViewController()
        modifyLogisticsVc.title = "订单发货"
        modifyLogisticsVc.jump = .listJumpType
        modifyLogisticsVc.orderInfoModel = orderInfoModel
        Coordinator.shared?.pushViewController(orderViewVc ?? self, modifyLogisticsVc, animated: true)
        modifyLogisticsVc.jumpSuccessBlockListType = {[weak self] in
            self?.loadOrderStatus()
        }
    }
    
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}



extension OrderStatusViewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderInfoList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderStatusCell") as! OrderStatusCell
        let orderInfoModel = orderInfoList[indexPath.row]
        cell.orederInfoModel = orderInfoModel
        //关闭订单按键
        cell.closeOrderBtn.tag = indexPath.row
        cell.closeOrderBtn.addTarget(self, action: #selector(closeOrderAction), for: .touchUpInside)
        //改价按键
        cell.modifyPriceBtn.tag = indexPath.row
        cell.modifyPriceBtn.addTarget(self, action: #selector(modifyPriceAction), for: .touchUpInside)
        //去发货
        cell.toShipBtn.tag = indexPath.row
        cell.toShipBtn.addTarget(self, action: #selector(toShipAction), for: .touchUpInside)
        //修改物流 查看物理
        cell.checkLogisticsBtn.tag = indexPath.row
        cell.checkLogisticsBtn.addTarget(self, action: #selector(checkLogisticsAction), for: .touchUpInside)
        cell.modifyLogisticsBtn.tag = indexPath.row
        cell.modifyLogisticsBtn.addTarget(self, action: #selector(modifyLogisticsAction), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let orderInfoModel = orderInfoList[indexPath.row]
        //这边是看下是直接去跳转在去获取数据还是先获取数据在进行变化
        let parameters = ["orderId":orderInfoModel.orderId as Any] as [String:Any]
        NetWorkResultRequest(OrderApi.getOrderDetailInfo(parameters: parameters), needShowFailAlert: true) { result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<OrederInfoModel>.self, from: data) else { return }
            if let _data = model.data{
                let orderDetailVc = OrderDetailViewController()
                orderDetailVc.orderInfoModel = _data
                Coordinator.shared?.pushViewController(self.orderViewVc ?? self, orderDetailVc, animated: true)
            }
        } failureCallback: { error, code in
            code.loginOut()
        }
//
    }
    
    
    
}
