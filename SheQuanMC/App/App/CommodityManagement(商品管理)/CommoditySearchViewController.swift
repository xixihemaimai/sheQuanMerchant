//
//  CommoditySearchViewController.swift
//  App
//
//  Created by mac on 2022/4/28.
//

import UIKit
import Util
import JFPopup

class CommoditySearchViewController: BaseViewController {
    //传递过来的状态
    var status:Int = 0
    
    var header:Bool = true
    lazy var searchTextfield:UITextField = {
       let searchTextfield = UITextField()
        searchTextfield.placeholder = "搜索商品名称"
        searchTextfield.clearButtonMode = .whileEditing
        searchTextfield.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        searchTextfield.attributedPlaceholder = NSAttributedString.init(string:"搜索商品名称", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#B3B3B3")])
        searchTextfield.addTarget(self, action: #selector(searchChangeAction), for: .editingChanged)
        return searchTextfield
    }()
    
    //数组
//    var searchProductList:[ProductInfoModel] = [ProductInfoModel]()
    
    
    var list:[productListModel] = [productListModel]()
   
    
    
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
        tableview.register(commodityStatusCell.self, forCellReuseIdentifier: "commodityStatusCell")
        tableview.register(commodityExamineCell.self, forCellReuseIdentifier: "commodityExamineCell")
        
        loadProductList()

    }
    
    
    
    func loadProductList(){
        if header == true{
            list.removeAll()
        }
        var lastSortTime:Int64 = 0
        if list.count > 0{
            let productListModel = list.last
            lastSortTime = productListModel?.sortTime ?? 0
        }
        let parmeters = ["keyWord":searchTextfield.text as Any,"lastSortTime":lastSortTime,"productStatus":Int32(0)] as [String:Any]
        NetWorkResultRequest(OrderApi.getProductInfoList(parameters: parmeters), needShowFailAlert: true) {[weak self] result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<[productListModel]>.self, from: data)else{ return }
            guard let data1 = model.data else{return}
            if self?.header == true{
                self?.list.removeAll()
                self?.list = data1
                self?.tableview.reloadData()
                self?.tableview.mj_header?.endRefreshing()
            }else{
                self?.list += data1
                self?.tableview.reloadData()
                self?.tableview.mj_footer?.endRefreshing()   
            }
        } failureCallback: {[weak self] error, code in
            code.loginOut()
            self?.tableview.mj_footer?.endRefreshing()
            self?.tableview.mj_header?.endRefreshing()
        }
    }
    
    
    //取消按键
    @objc func cancelAction(cancelBtn:UIButton){
        searchTextfield.text = ""
        searchTextfield.resignFirstResponder()
        Coordinator.shared?.popViewController(self, true)
    }
    
    override func headerRereshing() {
        header = true
        loadProductList()

    }
    
    override func footerRereshing() {
        header = false
        loadProductList()
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
    
    
    @objc func searchChangeAction(searchTextfield:UITextField){
        header = true
        loadProductList()
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
//                            let productListModel = self.list[stockBtn.tag]
                            let parameter = ["productId":productListModel.productId as Any] as [String:Any]
                            NetWorkResultRequest(OrderApi.delProduct(parameters: parameter), needShowFailAlert: true) { result, data in
//                                self.list.remove(at: stockBtn.tag)
//                                self.tableview.reloadData()
                                self.header = true
                                self.loadProductList()
                            } failureCallback: { error, code in
                                code.loginOut()
                            }
                            
                            
                        })
                    ])
                ]
            }
        }else{
            // 跳转另一个界面
            let replenishVc = ReplenishInventoryViewController()
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
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 "))
                    ]),
                    .confirmAction([
                        .text("下架"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                        .tapActionCallback({
//                            let productListModel = self.list[downBtn.tag]
                            let parameter = ["productId":productListModel.productId as Any] as [String:Any]
                            NetWorkResultRequest(OrderApi.lowerShelf(parameters: parameter), needShowFailAlert: true) { result, data in
//                                self.list.remove(at: downBtn.tag)
//                                self.tableview.reloadData()
                                self.header = true
                                self.loadProductList()
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
//                            let productListModel = self.list[downBtn.tag]
                            let parameter = ["productId":productListModel.productId as Any] as [String:Any]
                            NetWorkResultRequest(OrderApi.upShelf(parameters: parameter), needShowFailAlert: true) { result, data in
//                                self.list.remove(at: downBtn.tag)
//                                self.tableview.reloadData()
                                self.header = true
                                self.loadProductList()
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
//                LXFLog("==============\(data1)")
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
//                            self.list.remove(at: deleteBtn.tag)
//                            self.tableview.reloadData()
                            self.header = true
                            self.loadProductList()
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
                        let productListModel = self.list[cancelBtn.tag]
                        let parameter = ["productId":productListModel.productId as Any] as [String:Any]
                        NetWorkResultRequest(OrderApi.cancelApply(parameters: parameter), needShowFailAlert: true) { result, data in
                            //取消申请成功之后的反应
//                            self.list.remove(at: cancelBtn.tag)
//                            self.tableview.reloadData()
                            self.header = true
                            self.loadProductList()
                        } failureCallback: { error, code in
                            code.loginOut()
                        }
                    })
                ])
            ]
        }
    }
    
    
}


extension CommoditySearchViewController:UITableViewDelegate,UITableViewDataSource{
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return list.count
    }
    
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productListModel = list[indexPath.row]
      
//        if title == "上架中" || title == "已售罄" || title == "未上架"{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "commodityStatusCell") as! commodityStatusCell
//            if title == "上架中"{
//                cell.stockBtn.isHidden = true
//            }else if title == "已售罄"{
//                cell.stockBtn.isHidden = false
//            }else if title == "未上架"{
//                cell.stockBtn.setTitle("删除", for: .normal)
//                cell.downBtn.setTitle("上架", for: .normal)
//            }

      //（1：待审核、2：审核通过、3：审核失败）
      //第二个是显示用到 auditStatusText  判断状态是第一个 auditStatus

      
      if productListModel.productStatus == 1 || productListModel.productStatus == 3 || productListModel.productStatus == 4{
          //// 1：未上架  2：审核中 3：上架中 4、已售罄
          let cell = tableView.dequeueReusableCell(withIdentifier: "commodityStatusCell") as! commodityStatusCell
          if productListModel.productStatus == 3{
              cell.stockBtn.isHidden = true
          }else if productListModel.productStatus == 4{
              cell.stockBtn.isHidden = false
          }else if productListModel.productStatus == 1{
              cell.stockBtn.setTitle("删除", for: .normal)
              cell.downBtn.setTitle("上架", for: .normal)
          }
            //这里有一个问题----这个是要和后台进行交流下
//            if title == "上架中"{
//                cell.stockBtn.isHidden = true
//            }else if title == "已售罄"{
//                cell.stockBtn.isHidden = false
//            }else if title == "未上架"{
//                cell.stockBtn.setTitle("删除", for: .normal)
//                cell.downBtn.setTitle("上架", for: .normal)
//            }
            //0为没有库存，1为有库存
            cell.model = productListModel
            cell.stockBtn.tag = indexPath.row
            cell.downBtn.tag = indexPath.row
            cell.editBtn.tag = indexPath.row
            cell.stockBtn.addTarget(self, action: #selector(stockAction), for: .touchUpInside)
            cell.downBtn.addTarget(self, action: #selector(downAction), for: .touchUpInside)
            cell.editBtn.addTarget(self, action: #selector(editAction), for: .touchUpInside)
            return cell
        }else{
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
    
    
    
}
