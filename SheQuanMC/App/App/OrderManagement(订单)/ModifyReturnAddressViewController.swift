//
//  ModifyReturnAddressViewController.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util
import JFPopup

class ModifyReturnAddressViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        title = "修改退货地址"
        
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
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(AddressCell.self, forCellReuseIdentifier: "AddressCell")
        
        
        let addAdressBtn = UIButton()
        addAdressBtn.setTitle("添加新地址", for: .normal)
        addAdressBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        addAdressBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addAdressBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        addAdressBtn.addTarget(self, action: #selector(addNewAddressAction), for: .touchUpInside)
        view.addSubview(addAdressBtn)
        
        addAdressBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        addAdressBtn.layer.cornerRadius = scale(4)
        
        
        
        
    }
    
    //添加新地址
    @objc func addNewAddressAction(addAddressBtn:UIButton){
        let addNewAddressVc = ModifyAddressViewController()
        addNewAddressVc.title = "添加新地址"
        Coordinator.shared?.pushViewController(self, addNewAddressVc, animated: true)
        
    }
    //修改地址
    @objc func modifyAddressAction(modifyAddressBtn:UIButton){
        let addNewAddressVc = ModifyAddressViewController()
        addNewAddressVc.title = "修改地址"
        Coordinator.shared?.pushViewController(self, addNewAddressVc, animated: true)
    }
    
    
    //是否为默认
    @objc func isDefaultAction(isDefaultBtn:UIButton){
        //清除其他默认的状态
        
        var title:String;
        if isDefaultBtn.isSelected {
            title = "确定要将此模板取消默认吗"
        }else{
            title = "确定要将此模板设置为默认吗"
        }
        
        JFPopup.alert {
            [
                .title(title),
                .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
//                .subTitle("注:取消商品将移至未上架"),
//                .subTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 ")),
                .withoutAnimation(true),
                .cancelAction([
                    .text("取消"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999")),
                    .tapActionCallback({
                        
                        
                        
                    })
                    
                ]),
                .confirmAction([
                    .text("确定"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .tapActionCallback({
//                        JFPopupView.popup.toast(hit: "点击了确定")
                        for i in 0..<3{
                            let cell = self.tableview.cellForRow(at: IndexPath(row: i, section: 0)) as! AddressCell
                            if isDefaultBtn.tag == i{
                            }else{
                                cell.isDefaultBtn.isSelected = false
                            }
                        }
                        isDefaultBtn.isSelected = !isDefaultBtn.isSelected
                    })
                ])
            ]
        }
    }
    
    
    @objc func deleteAction(deleteBtn:UIButton){
        
        JFPopup.alert {
            [
                .title("确定要删除此模板吗？"),
                .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
//                .subTitle("注:取消商品将移至未上架"),
//                .subTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 ")),
                .withoutAnimation(true),
                .cancelAction([
                    .text("取消"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999")),
                    .tapActionCallback({
                        Coordinator.shared?.popViewController(self, true)
                    })
                    
                ]),
                .confirmAction([
                    .text("确定"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .tapActionCallback({
                        JFPopupView.popup.toast(hit: "点击了保存草稿")
                    })
                ])
            ]
        }
        
    }
    
   
}

extension ModifyReturnAddressViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell") as! AddressCell
        cell.modifyAddressBtn.tag = indexPath.row
        
        cell.isDefaultBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        
        cell.isDefaultBtn.addTarget(self, action: #selector(isDefaultAction), for: .touchUpInside)
        cell.deleteBtn.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        
        cell.modifyAddressBtn.addTarget(self, action: #selector(modifyAddressAction), for: .touchUpInside)
        //是否为默认地址
        
        return cell
    }
    
    
   
    
}
