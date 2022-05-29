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

extension CommodityStatusViewController:UITableViewDelegate,UITableViewDataSource{
    
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
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let releaseGoodsVc = ReleaseGoodsViewController()
        releaseGoodsVc.type = 1
        Coordinator.shared?.pushViewController(self, releaseGoodsVc, animated: true)

        
    }
    
    
}
