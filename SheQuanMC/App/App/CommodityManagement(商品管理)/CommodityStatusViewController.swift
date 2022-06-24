//
//  CommodityStatusViewController.swift
//  App
//
//  Created by mac on 2022/4/28.
//

import UIKit
import JFPopup
import Util

class CommodityStatusViewController: BaseViewController {

    
    var list:[productListModel] = [productListModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(commodityStatusCell.self, forCellReuseIdentifier: "commodityStatusCell")
        tableview.register(commodityExamineCell.self, forCellReuseIdentifier: "commodityExamineCell")
//        tableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        loadProductList()
    }
    
    
    override func headerRereshing() {
        LXFLog("下拉")
//        tableview.mj_header?.endRefreshing()
        loadProductList()
    }
    
    override func footerRereshing() {
        LXFLog("上拉")
        tableview.mj_footer?.endRefreshing()
    }
    
    
    
    func loadProductList(){
        var productStatus:Int32 = Int32(3)
        if title == "上架中"{
            productStatus = Int32(3)
        }else if title == "审核中"{
            productStatus = Int32(2)
        }else if title == "未上架"{
            productStatus = Int32(1)
        }else if title == "已售罄"{
            productStatus = Int32(4)
        }
        let parmeters = ["keyWord":"","lastSortTime":0,"productStatus":productStatus] as [String:Any]
        NetWorkResultRequest(OrderApi.getProductInfoList(parameters: parmeters), needShowFailAlert: true) { result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<[productListModel]>.self, from: data)else{ return }
            self.list.removeAll()
            guard let data1 = model.data else{return}
            self.list = data1
            LXFLog("====================\(self.list)")
            self.tableview.reloadData()
            self.tableview.mj_header?.endRefreshing()
        } failureCallback: { error, code in
            code.loginOut()
            self.tableview.mj_header?.endRefreshing()
        }
    }
    
    
    
    
    //已售罄---补库存和 未上架---删除
    @objc func stockAction(stockBtn:UIButton){
        let productListModel = self.list[stockBtn.tag]
        if productListModel.productStatus == 1{
            JFPopup.alert {
                [
                    .title("确定要删除这个商品吗?"),
                    .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .withoutAnimation(true),
                    .cancelAction([
                        .text("取消"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"))
                    ]),
                    .confirmAction([
                        .text("删除"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                        .tapActionCallback({
//                            JFPopupView.popup.toast(hit: "点击了删除")
//                            let productListModel = self.list[stockBtn.tag]
                            let parameter = ["productId":productListModel.productId as Any] as [String:Any]
                            NetWorkResultRequest(OrderApi.delProduct(parameters: parameter), needShowFailAlert: true) { result, data in
                                self.list.remove(at: stockBtn.tag)
                                self.tableview.reloadData()
                            } failureCallback: { error, code in
                                code.loginOut()
                            }
                        })
                    ])
                ]
            }
        }else{
//            let productListModel = self.list[stockBtn.tag]
            // 跳转另一个界面
            let replenishVc = ReplenishInventoryViewController()
            replenishVc.productId = Int64(productListModel.productId ?? 0)
            Coordinator.shared?.pushViewController(self, replenishVc, animated: true)
            replenishVc.successBlock = {
                self.loadProductList()
            }
        }
    }
    
    //上架中--下架,已售罄--下架，未上架--上架
    @objc func downAction(downBtn:UIButton){
        let productListModel = self.list[downBtn.tag]
        if productListModel.productStatus == 3 || productListModel.productStatus == 4{
            JFPopup.alert {
                [
                    .title("确定要下架这个商品吗?"),
                    .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .withoutAnimation(true),
                    .cancelAction([
                        .text("取消"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"))
                    ]),
                    .confirmAction([
                        .text("下架"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                        .tapActionCallback({
                            JFPopupView.popup.toast(hit: "点击了下架")
                            
//                            let productListModel = self.list[downBtn.tag]
                            let parameter = ["productId":productListModel.productId as Any] as [String:Any]
                            NetWorkResultRequest(OrderApi.lowerShelf(parameters: parameter), needShowFailAlert: true) { result, data in
                                self.list.remove(at: downBtn.tag)
                                self.tableview.reloadData()
                            } failureCallback: { error, code in
                                code.loginOut()
                            }

                            
                            
                        })
                    ])
                ]
            }
        }else{
            JFPopup.alert {
                [
                    .title("确定要上架这个商品吗?"),
                    .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .withoutAnimation(true),
                    .cancelAction([
                        .text("取消"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"))
                    ]),
                    .confirmAction([
                        .text("上架"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                        .tapActionCallback({
//                            JFPopupView.popup.toast(hit: "点击了上架")
                            
//                            let productListModel = self.list[downBtn.tag]
                            let parameter = ["productId":productListModel.productId as Any] as [String:Any]
                            NetWorkResultRequest(OrderApi.upShelf(parameters: parameter), needShowFailAlert: true) { result, data in
                                self.list.remove(at: downBtn.tag)
                                self.tableview.reloadData()
                            } failureCallback: { error, code in
                                code.loginOut()
                            }
                            
                            
                            
                        })
                    ])
                ]
            }
        }
    }
    //上架中--编辑，已售罄--编辑，未上架---编辑
    @objc func editAction(editBtn:UIButton){
        
        let productListModel = self.list[editBtn.tag]
        let parameter = ["productId":productListModel.productId as Any] as [String:Any]
        NetWorkResultRequest(OrderApi.getProductInfo(parameters: parameter), needShowFailAlert: true) { result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<CommodityModel>.self, from: data) else { return }
            if let data1 = model.data{
                let releaseGoodsVc = ReleaseGoodsViewController()
                releaseGoodsVc.type = 1
                releaseGoodsVc.commodityModel = data1
                Coordinator.shared?.pushViewController(self, releaseGoodsVc, animated: true)
            }
        } failureCallback: { error, code in
            code.loginOut()
        }
        
    }
    
    
    //审核中的删除
    @objc func deleteAction(deleteBtn:UIButton){
        JFPopup.alert {
            [
                .title("确定要删除这个商品吗?"),
                .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                .withoutAnimation(true),
                .cancelAction([
                    .text("取消"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"))
                ]),
                .confirmAction([
                    .text("删除"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .tapActionCallback({
                        
                        let productListModel = self.list[deleteBtn.tag]
                        let parameter = ["productId":productListModel.productId as Any] as [String:Any]
                        NetWorkResultRequest(OrderApi.delProduct(parameters: parameter), needShowFailAlert: true) { result, data in
                            self.list.remove(at: deleteBtn.tag)
                            self.tableview.reloadData()
                        } failureCallback: { error, code in
                            code.loginOut()
                        }
                        
                        
                    })
                ])
            ]
        }
    }
    
    //审核中的编辑
    @objc func examineEditAction(editBtn:UIButton){
        let productListModel = self.list[editBtn.tag]
        let parameter = ["productId":productListModel.productId as Any] as [String:Any]
        NetWorkResultRequest(OrderApi.getProductInfo(parameters: parameter), needShowFailAlert: true) { result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<CommodityModel>.self, from: data) else { return }
            if let data1 = model.data{
                let releaseGoodsVc = ReleaseGoodsViewController()
                releaseGoodsVc.type = 1
                LXFLog("==============\(data1)")
                releaseGoodsVc.commodityModel = data1
                Coordinator.shared?.pushViewController(self, releaseGoodsVc, animated: true)
            }
        } failureCallback: { error, code in
            code.loginOut()
        }
    }
    
    //审核中的取消申请
    @objc func cancelApplyAction(cancelBtn:UIButton){
        JFPopup.alert {
            [
                .title("确定要取消申请吗?"),
                .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                .subTitle("注:取消商品将移至未上架"),
                .subTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999")),
                .withoutAnimation(true),
                .cancelAction([
                    .text("暂不取消"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"))
                ]),
                .confirmAction([
                    .text("取消申请"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .tapActionCallback({
                        JFPopupView.popup.toast(hit: "点击了取消申请")
                       
                        let productListModel = self.list[cancelBtn.tag]
                        let parameter = ["productId":productListModel.productId as Any] as [String:Any]
                        NetWorkResultRequest(OrderApi.cancelApply(parameters: parameter), needShowFailAlert: true) { result, data in
                            //取消申请成功之后的反应
                            self.list.remove(at: cancelBtn.tag)
                            self.tableview.reloadData()
                        } failureCallback: { error, code in
                            code.loginOut()
                        }
                        
                    })
                ])
            ]
        }
    }
    
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    

}

extension CommodityStatusViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productListModel = list[indexPath.row]
        // 1：未上架  2：审核中 3：上架中 4、已售罄
        if productListModel.productStatus == 1 || productListModel.productStatus == 3 || productListModel.productStatus == 4{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "commodityStatusCell") as! commodityStatusCell
            if productListModel.productStatus == 3{
                cell.stockBtn.isHidden = true
            }else if productListModel.productStatus == 4{
                cell.stockBtn.isHidden = false
            }else if productListModel.productStatus == 1{
                cell.stockBtn.setTitle("删除", for: .normal)
                cell.downBtn.setTitle("上架", for: .normal)
            }
//            if (productListModel.stock ?? 0) < 1{
//                cell.stockLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F13232")
//            }else{
//                cell.stockLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
//            }
//            cell.stockLabel.text = "库存余量:" + String(productListModel.stock ?? 0)
            
            cell.model = productListModel
            
            cell.stockBtn.tag = indexPath.row
            cell.downBtn.tag = indexPath.row
            cell.editBtn.tag = indexPath.row
            cell.stockBtn.addTarget(self, action: #selector(stockAction), for: .touchUpInside)
            cell.downBtn.addTarget(self, action: #selector(downAction), for: .touchUpInside)
            cell.editBtn.addTarget(self, action: #selector(editAction), for: .touchUpInside)
            
            
            return cell
        }else{
            let productListModel = list[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "commodityExamineCell") as! commodityExamineCell
            cell.model = productListModel
            cell.deleteBtn.tag = indexPath.row
            cell.editBtn.tag = indexPath.row
            cell.cancelBtn.tag = indexPath.row
            
            cell.deleteBtn.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
            cell.editBtn.addTarget(self, action: #selector(examineEditAction), for: .touchUpInside)
            cell.cancelBtn.addTarget(self, action: #selector(cancelApplyAction), for: .touchUpInside)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let productListModel = self.list[indexPath.row]
//        let parameter = ["productId":productListModel.productId as Any] as [String:Any]
//        NetWorkResultRequest(OrderApi.getProductInfo(parameters: parameter), needShowFailAlert: true) { result, data in
//            guard let model = try? JSONDecoder().decode(GenericResponse<CommodityModel>.self, from: data) else { return }
//            if let data1 = model.data{
//                LXFLog("+============================\(data1)")
//                let releaseGoodsVc = ReleaseGoodsViewController()
//                releaseGoodsVc.type = 1
//                releaseGoodsVc.commodityModel = data1
//                Coordinator.shared?.pushViewController(self, releaseGoodsVc, animated: true)
//            }
//        } failureCallback: { error, code in
//            code.loginOut()
//        }
//    }
    
    
}
