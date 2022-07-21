//
//  OrderSearchViewController.swift
//  App
//
//  Created by mac on 2022/5/11.
//

import UIKit
import Util

class OrderSearchViewController: BaseViewController {
    
    
    
    //传递过来的状态
    var status:Int = 0
    lazy var searchTextfield:UITextField = {
       let searchTextfield = UITextField()
        searchTextfield.placeholder = "请输入用户名/商品名称/商品编码"
        searchTextfield.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        searchTextfield.attributedPlaceholder = NSAttributedString.init(string:"请输入用户名/商品名称/商品编码", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#B3B3B3")])
        searchTextfield.addTarget(self, action: #selector(searchingContentAction), for: .editingChanged)
        searchTextfield.addTarget(self, action: #selector(searchContentEndAction), for: .editingDidEnd)
        return searchTextfield
    }()
    
    //数组
    var searchProductList:[OrederInfoModel] = [OrederInfoModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        let searchView = UIView()
        searchView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(iPhoneX ? scale(52) : scale(28))
            make.right.equalTo(-scale(64))
            make.height.equalTo(scale(32))
        }
        searchView.layer.cornerRadius = scale(4)
        
        let searchImageView = UIImageView()
        searchImageView.image = UIImage(named: "Rectangle 2062")
        searchView.addSubview(searchImageView)
        
        searchImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(scale(16))
            make.left.equalTo(scale(16))
        }
        
        
        searchView.addSubview(searchTextfield)
        searchTextfield.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(searchImageView.snp.right).offset(scale(4))
            make.height.equalTo(scale(17))
            make.right.equalToSuperview()
        }
//        searchTextfield.addTarget(self, action: #selector(searchEndAction), for: .editingDidEnd)
        
        //取消
        let cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 "), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        view.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.left.equalTo(searchView.snp.right)
            make.right.equalToSuperview()
            make.centerY.equalTo(searchView)
            make.height.equalTo(scale(32))
        }
        cancelBtn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        
        let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(diviver)
        diviver.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchView.snp.bottom).offset(scale(8))
            make.height.equalTo(scale(0.5))
        }
        
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(diviver.snp.bottom)
        }
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(OrderStatusCell.self, forCellReuseIdentifier: "OrderStatusCell")
        //loadSearchProduct(searchTextfield.text ?? "")
        loadOrderStatus()
    }
    
    
    
    //搜索中
    @objc func searchingContentAction(searchTextfield:UITextField){
        loadOrderStatus()
    }
    
    //搜索结束
    @objc func searchContentEndAction(searchTextfield:UITextField){
        LXFLog("===============\(String(describing: searchTextfield.text))")
        loadOrderStatus()
    }
    
    
    
    //取消按键
    @objc func cancelAction(cancelBtn:UIButton){
        searchTextfield.text = ""
        searchTextfield.resignFirstResponder()
        Coordinator.shared?.popViewController(self, true)
    }
    
    
    
    
    override func headerRereshing() {
        loadOrderStatus()
    }
    
//    override func footerRereshing() {
//        tableview.mj_footer?.endRefreshing()
//    }
    
    func loadOrderStatus(){
        let parameters = ["keyWords":searchTextfield.text as Any] as [String:Any]
        NetWorkResultRequest(OrderApi.geSearchProductList(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<[OrederInfoModel]>.self, from: data) else { return }
            self?.searchProductList.removeAll()
            if let _data = model.data{
                self?.searchProductList = _data
            }
            self?.tableview.reloadData()
            self?.tableview.mj_header?.endRefreshing()
//            self?.tableview.mj_footer?.endRefreshing()
        } failureCallback: {[weak self] error, code in
            code.loginOut()
            self?.tableview.mj_header?.endRefreshing()
//            self?.tableview.mj_footer?.endRefreshing()
        }
    }
    
    //关闭订单按键
    @objc func closeOrderAction(closeOrderBtn:UIButton){
        let orderInfoModel = searchProductList[closeOrderBtn.tag]
        // 这边要自定义一个UIview
        self.popup.bottomSheet {
            let closeOrderReasonView = CloseOrderReasonView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(489)), orderId: orderInfoModel.orderId ?? 0)
            closeOrderReasonView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            closeOrderReasonView.sureCloseSuccessBlock = {[weak self] in
                self?.loadOrderStatus()
                
              NotificationCenter.default.post(name: ChangeOrderCount, object: nil)
                
                self?.popup.dismissPopup()
            }
            return closeOrderReasonView
        }
    }
    
    //改价按键
    @objc func modifyPriceAction(modifyPriceBtn:UIButton){
        //这边也要自定义一个UIview
        let orderInfoModel = searchProductList[modifyPriceBtn.tag]
        self.popup.bottomSheet {
            let modifyPriceView = ModifyPriceView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(492)), orderId: orderInfoModel.orderId ?? 0)
            modifyPriceView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            modifyPriceView.modifyPriceSuccessBlock = { [weak self] in
                self?.loadOrderStatus()
                NotificationCenter.default.post(name: ChangeOrderCount, object: nil)
                self?.popup.dismissPopup()
            }
            return modifyPriceView
        }
    }
    
    //查看物流
    @objc func checkLogisticsAction(checkLogisticsBtn:UIButton){
        let orderInfoModel = searchProductList[checkLogisticsBtn.tag]
        let checkLogistVC = CheckLogisticsViewController()
        checkLogistVC.orderInfoModel = orderInfoModel
        Coordinator.shared?.pushViewController(self, checkLogistVC, animated: true)
    }
    
    //修改物流
    @objc func modifyLogisticsAction(modifyLogisticsBtn:UIButton){
        let orderInfoModel = searchProductList[modifyLogisticsBtn.tag]
        let modifyLogisticsVc  = ModifyLogisticsViewController()
        modifyLogisticsVc.title = "修改物流"
        modifyLogisticsVc.jump = .listJumpType
        modifyLogisticsVc.orderId = orderInfoModel.orderId ?? 0
        Coordinator.shared?.pushViewController(self, modifyLogisticsVc, animated: true)
//        modifyLogisticsVc.jumpSuccessBlockListType = {[weak self] in
//            self?.loadOrderStatus()
//        }
    }
    
    //去发货
    @objc func toShipAction(toShipBtn:UIButton){
        let orderInfoModel = searchProductList[toShipBtn.tag]
        let modifyLogisticsVc  = ModifyLogisticsViewController()
        modifyLogisticsVc.title = "订单发货"
        modifyLogisticsVc.jump = .listJumpType
        modifyLogisticsVc.orderId = orderInfoModel.orderId ?? 0
        Coordinator.shared?.pushViewController(self, modifyLogisticsVc, animated: true)
        modifyLogisticsVc.jumpSuccessBlockListType = {[weak self] in
            self?.loadOrderStatus()
        }
    }
}

extension OrderSearchViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchProductList.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderStatusCell") as! OrderStatusCell
        let orederInfoModel = searchProductList[indexPath.row]
        cell.model = orederInfoModel
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let orderInfoModel = searchProductList[indexPath.row]
        //这边是看下是直接去跳转在去获取数据还是先获取数据在进行变化
        let parameters = ["orderId":orderInfoModel.orderId as Any] as [String:Any]
        NetWorkResultRequest(OrderApi.getOrderDetailInfo(parameters: parameters), needShowFailAlert: true) { result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<OrederInfoModel>.self, from: data) else { return }
            if let _data = model.data{
                let orderDetailVc = OrderDetailViewController()
                orderDetailVc.orderInfoModel = _data
                Coordinator.shared?.pushViewController(self, orderDetailVc, animated: true)
            }
        } failureCallback: { error, code in
            code.loginOut()
        }
    }
}
