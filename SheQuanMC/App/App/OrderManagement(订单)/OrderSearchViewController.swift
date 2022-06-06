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
        searchTextfield.placeholder = "搜索商品名称"
        searchTextfield.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        searchTextfield.attributedPlaceholder = NSAttributedString.init(string:"搜索商品名称", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#B3B3B3")])
        return searchTextfield
    }()
    
    
    
    
    //数组
    var searchProductList:[ProductInfoModel] = [ProductInfoModel]()
    
    
    

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
        searchTextfield.addTarget(self, action: #selector(searchEndAction), for: .editingDidEnd)
        
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
        
//        loadSearchProduct(searchTextfield.text ?? "")
    }
    
    
    
    //搜索完成结束之后
    @objc func searchEndAction(searchTextfield:UITextField){
//        loadSearchProduct(searchTextfield.text ?? "")
    }
    
    //取消按键
    @objc func cancelAction(cancelBtn:UIButton){
        searchTextfield.text = ""
        searchTextfield.resignFirstResponder()
        Coordinator.shared?.popViewController(self, true)
    }
    
    override func headerRereshing() {
        LXFLog("下拉")
//        tableview.mj_header?.endRefreshing()
//        loadSearchProduct(searchTextfield.text ?? "")
    }
    
    override func footerRereshing() {
        LXFLog("上拉")
        tableview.mj_footer?.endRefreshing()
    }
    
    
    
//    func loadSearchProduct(_ keyWords:String){
//        let parameters = ["keyWords":keyWords]
//        NetWorkResultRequest(OrderApi.SearchProduct(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
//            
//            self?.searchProductList.removeAll()
//            guard let model = try? JSONDecoder().decode(GenericResponse<[ProductInfoModel]>.self, from: data) else{
//                return
//            }
//            guard let newData = model.data else{
//                return
//            }
//            self?.searchProductList = newData
//            self?.tableview.reloadData()
//            self?.tableview.mj_header?.endRefreshing()
//        } failureCallback: { error, code in
//            code.loginOut()
//        }
//    }
//    
    
    
    
    
    
    
    //关闭订单按键
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
    
    //改价按键
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
    
    
    
    //查看物流
    @objc func checkLogisticsAction(checkLogisticsBtn:UIButton){
        let checkLogistVC = CheckLogisticsViewController()
        Coordinator.shared?.pushViewController(self, checkLogistVC, animated: true)
    }
    
    //修改物流
    @objc func modifyLogisticsAction(modifyLogisticsBtn:UIButton){
        let modifyLogisticsVc  = ModifyLogisticsViewController()
        modifyLogisticsVc.title = "修改物流"
        Coordinator.shared?.pushViewController(self, modifyLogisticsVc, animated: true)
    }
    
    //去发货
    @objc func toShipAction(toShipBtn:UIButton){
        let modifyLogisticsVc  = ModifyLogisticsViewController()
        modifyLogisticsVc.title = "订单发货"
        Coordinator.shared?.pushViewController(self, modifyLogisticsVc, animated: true)
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
        let productInfoModel = searchProductList[indexPath.row] as ProductInfoModel
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderStatusCell") as! OrderStatusCell
        
        cell.productInfoModel = productInfoModel
        
//        if view.tag == 0{
//            let index = Int(arc4random_uniform(5))
//            let array = ["全部","待支付","待发货","已发货","交易成功","交易失败"]
//            let string = array[index]
//            cell.contentString = string
//        }else if view.tag == 1{
//            cell.contentString = "待支付"
//        }else if view.tag == 2{
//            cell.contentString = "待发货"
//        }else if view.tag == 3{
//            cell.contentString = "已发货"
//        }else if view.tag == 4{
//            cell.contentString = "交易成功"
//        }else{
//            cell.contentString = "交易失败"
//        }
        
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
        let orderDetailVc = OrderDetailViewController()
//        let cell = tableView.cellForRow(at: indexPath) as! OrderStatusCell
        let productInfoModel = searchProductList[indexPath.row] as ProductInfoModel
        
        
        orderDetailVc.status = productInfoModel.statusText
        
        Coordinator.shared?.pushViewController(self, orderDetailVc, animated: true)
    }
    
    
}
