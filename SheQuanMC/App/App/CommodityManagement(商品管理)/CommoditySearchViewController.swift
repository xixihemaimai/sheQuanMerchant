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
    lazy var searchTextfield:UITextField = {
       let searchTextfield = UITextField()
        searchTextfield.placeholder = "搜索商品名称"
        searchTextfield.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        searchTextfield.attributedPlaceholder = NSAttributedString.init(string:"搜索商品名称", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#B3B3B3")])
        return searchTextfield
    }()
   
    
    
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
        tableview.register(commodityStatusCell.self, forCellReuseIdentifier: "commodityStatusCell")
        tableview.register(commodityExamineCell.self, forCellReuseIdentifier: "commodityExamineCell")

    }
    
    //搜索完成结束之后
    @objc func searchEndAction(searchTextfield:UITextField){
        
    }
    
    //取消按键
    @objc func cancelAction(cancelBtn:UIButton){
        searchTextfield.text = ""
        searchTextfield.resignFirstResponder()
        Coordinator.shared?.popViewController(self, true)
    }
    
    override func headerRereshing() {
        LXFLog("下拉")
        tableview.mj_header?.endRefreshing()
    }
    
    override func footerRereshing() {
        LXFLog("上拉")
        tableview.mj_footer?.endRefreshing()
    }
    
    
    //已售罄---补库存和 未上架---删除
    @objc func stockAction(stockBtn:UIButton){
        if title == "未上架"{
            JFPopup.alert {
                [
                    .title("确定要删除这个商品吗?"),
                    .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .withoutAnimation(true),
                    .cancelAction([
                        .text("取消"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 "))
                    ]),
                    .confirmAction([
                        .text("删除"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                        .tapActionCallback({
                            JFPopupView.popup.toast(hit: "点击了删除")
                        })
                    ])
                ]
            }
        }else{
            // 跳转另一个界面
            let replenishVc = ReplenishInventoryViewController()
            Coordinator.shared?.pushViewController(self, replenishVc, animated: true)
        }
    }
    
    //上架中--下架,已售罄--下架，未上架--上架
    @objc func downAction(downBtn:UIButton){
        if title == "上架中" || title == "已售罄"{
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
                            JFPopupView.popup.toast(hit: "点击了下架")
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
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 "))
                    ]),
                    .confirmAction([
                        .text("上架"),
                        .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                        .tapActionCallback({
                            JFPopupView.popup.toast(hit: "点击了上架")
                        })
                    ])
                ]
            }
        }
    }
    //上架中--编辑，已售罄--编辑，未上架---编辑
    @objc func editAction(editBtn:UIButton){
        let releaseGoodsVc = ReleaseGoodsViewController()
        //这边要有model传递
        Coordinator.shared?.pushViewController(self, releaseGoodsVc, animated: true)
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
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 "))
                ]),
                .confirmAction([
                    .text("删除"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .tapActionCallback({
                        JFPopupView.popup.toast(hit: "点击了删除")
                    })
                ])
            ]
        }
    }
    
    //审核中的编辑
    @objc func examineEditAction(editBtn:UIButton){
        
        
        
        
    }
    
    //审核中的取消申请
    @objc func cancelApplyAction(cancelBtn:UIButton){
        JFPopup.alert {
            [
                .title("确定要取消申请吗?"),
                .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                .subTitle("注:取消商品将移至未上架"),
                .subTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 ")),
                .withoutAnimation(true),
                .cancelAction([
                    .text("暂不取消"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 "))
                ]),
                .confirmAction([
                    .text("取消申请"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .tapActionCallback({
                        JFPopupView.popup.toast(hit: "点击了取消申请")
                    })
                ])
            ]
        }
    }
    
    
}


extension CommoditySearchViewController:UITableViewDelegate,UITableViewDataSource{
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if title == "上架中" || title == "已售罄" || title == "未上架"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "commodityStatusCell") as! commodityStatusCell
            if title == "上架中"{
                cell.stockBtn.isHidden = true
            }else if title == "已售罄"{
                cell.stockBtn.isHidden = false
            }else if title == "未上架"{
                cell.stockBtn.setTitle("删除", for: .normal)
                cell.downBtn.setTitle("上架", for: .normal)
            }
            //0为没有库存，1为有库存
            let stockNum = arc4random()%2
            if stockNum < 1{
                cell.stockLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F13232")
            }else{
                cell.stockLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
            }
            cell.stockLabel.text = "库存余量:" + String(stockNum)
            
            cell.stockBtn.tag = indexPath.row
            cell.downBtn.tag = indexPath.row
            cell.editBtn.tag = indexPath.row
            
            cell.stockBtn.addTarget(self, action: #selector(stockAction), for: .touchUpInside)
            cell.downBtn.addTarget(self, action: #selector(downAction), for: .touchUpInside)
            cell.editBtn.addTarget(self, action: #selector(editAction), for: .touchUpInside)
            
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "commodityExamineCell") as! commodityExamineCell
            //0为没有审核中，1为有已驳回
            let stockNum = arc4random()%2
            if stockNum < 1{
                cell.deleteBtn.isHidden = true
                cell.editBtn.isHidden = true
                cell.cancelBtn.isHidden = false
                cell.statusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#666666")
                cell.reasonLabel.text = "预计2个工作日内反馈申请结果"
                cell.statusLabel.text = "审核中"
            }else{
                cell.deleteBtn.isHidden = false
                cell.editBtn.isHidden = false
                cell.cancelBtn.isHidden = true
                cell.statusLabel.text = "已驳回"
                cell.statusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F13232")
                cell.reasonLabel.text = "失败原因"
            }
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
