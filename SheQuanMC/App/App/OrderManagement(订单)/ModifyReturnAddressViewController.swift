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
    
    var addressList:[RetAddressInfoModel] = [RetAddressInfoModel]()
    
    //进入的方式0为店铺进入，1位订单部分进入
    var jumpType:Int = 0
    
    var choiceRetAddressSuccessBlock:((_ retAddressInfoModel:RetAddressInfoModel)->Void)?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        title = "收货地址"
        
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
        
        reloadReturnAddressList()
    }
    
    override func headerRereshing() {
        reloadReturnAddressList()
    }
    
    func reloadReturnAddressList(){
        NetWorkResultRequest(OrderApi.getRetAddressList, needShowFailAlert: true) {[weak self] result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<[RetAddressInfoModel]>.self, from: data) else { return }
            self?.addressList.removeAll()
            if let _data = model.data{
                self?.addressList = _data
            }
            self?.tableview.mj_header?.endRefreshing()
            self?.tableview.reloadData()
        } failureCallback: {[weak self] error, code in
            code.loginOut()
            self?.tableview.mj_header?.endRefreshing()
        }
    }
    
    
    //添加新地址
    @objc func addNewAddressAction(addAddressBtn:UIButton){
        let addNewAddressVc = ModifyAddressViewController()
        addNewAddressVc.title = "添加新地址"
        Coordinator.shared?.pushViewController(self, addNewAddressVc, animated: true)
        addNewAddressVc.updateAndAddSuccessBlock = {[weak self] in
            self?.reloadReturnAddressList()
        }
    }
    //修改地址
    @objc func modifyAddressAction(modifyAddressBtn:UIButton){
        let retAddressInfoModel = addressList[modifyAddressBtn.tag]
        let parameters = ["retAddressId":retAddressInfoModel.retAddressId as Any] as [String:Any]
        NetWorkResultRequest(OrderApi.getRetAddressInfo(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<RetAddressInfoModel>.self, from: data) else { return }
            if let _data = model.data{
                //这边跳转界面
               let addNewAddressVc = ModifyAddressViewController()
                addNewAddressVc.retAddressInfoModel = _data
               addNewAddressVc.title = "编辑地址"
               Coordinator.shared?.pushViewController(self!, addNewAddressVc, animated: true)
                addNewAddressVc.updateAndAddSuccessBlock = {
                    self?.reloadReturnAddressList()
                }
            }
        } failureCallback: { error, code in
            code.loginOut()
        }
    }
    
    
    //是否为默认
    @objc func isDefaultAction(isDefaultBtn:UIButton){
        //清除其他默认的状态
        let retAddressInfoModel = addressList[isDefaultBtn.tag]
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

                        
                    })
                ])
            ]
        }
    }
    
    
    @objc func deleteAction(deleteBtn:UIButton){
        let retAddressInfoModel = addressList[deleteBtn.tag]
        
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
                    })
                ]),
                .confirmAction([
                    .text("确定"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .tapActionCallback({
                        let parameters = ["retAddressId":retAddressInfoModel.retAddressId as Any] as [String:Any]
                        NetWorkResultRequest(OrderApi.delRetAddressInfo(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
                            self?.reloadReturnAddressList()
                        } failureCallback: { error, code in
                            code.loginOut()
                        }
                    })
                ])
            ]
        }
        
    }
    
   
}

extension ModifyReturnAddressViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell") as! AddressCell
        cell.retAddressInfoModel = addressList[indexPath.row]
        cell.modifyAddressBtn.tag = indexPath.row
        cell.isDefaultBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        cell.isDefaultBtn.addTarget(self, action: #selector(isDefaultAction), for: .touchUpInside)
        cell.deleteBtn.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        cell.modifyAddressBtn.addTarget(self, action: #selector(modifyAddressAction), for: .touchUpInside)
        //是否为默认地址
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // 这边要把退货地址传递回去
        let retAddressInfoModel = addressList[indexPath.row]
        if jumpType == 1{
            choiceRetAddressSuccessBlock?(retAddressInfoModel)
            Coordinator.shared?.popViewController(self, true)
        }
    }
    
}
