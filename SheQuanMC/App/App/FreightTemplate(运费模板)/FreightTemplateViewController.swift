//
//  FreightTemplateViewController.swift
//  App
//
//  Created by mac on 2022/5/12.
//

import UIKit
import JFPopup
import Util

class FreightTemplateViewController: BaseViewController {

    
    var list:[FreightListModel] = [FreightListModel]()
    
    var selectFreightId:((_ model:FreightListModel) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "运费模板"
        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
        }
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(FreightTemplateCell.self, forCellReuseIdentifier: "FreightTemplateCell")
        
        
        
        let addTemplateBtn = UIButton()
        addTemplateBtn.setTitle("新建模板", for: .normal)
        addTemplateBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        addTemplateBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addTemplateBtn.setImage(UIImage(named: "Group 2688"), for: .normal)
        addTemplateBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        addTemplateBtn.addTarget(self, action: #selector(addTemplateAction), for: .touchUpInside)
        view.addSubview(addTemplateBtn)
        
        addTemplateBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        addTemplateBtn.layer.cornerRadius = scale(4)
        
        
       loadFreightList()
        
    }
    
    func loadFreightList(){
        NetWorkResultRequest(OrderApi.getFreightInfoList, needShowFailAlert: true) {[weak self] result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<[FreightListModel]>.self, from: data) else { return }
            self?.list.removeAll()
            if let data1 = model.data{
                self?.list = data1
                self?.tableview.reloadData()
            }
            self?.tableview.mj_header?.endRefreshing()
        } failureCallback: {[weak self] error, code in
            code.loginOut()
            self?.tableview.mj_header?.endRefreshing()
        }

//        NetWorkResultRequest(OrderApi.getProductFreightList, needShowFailAlert: true) { result, data in
//            guard let model = try? JSONDecoder().decode(GenericResponse<[FreightListModel]>.self, from: data) else { return }
//            self.list.removeAll()
//            if let data1 = model.data{
//                self.list = data1
//                self.tableview.reloadData()
//            }
//        } failureCallback: { error, code in
//            code.loginOut()
//        }
    }
    
    
    
    override func headerRereshing() {
//        LXFLog("下拉")
        loadFreightList()
    }
    
    
    
    @objc func addTemplateAction(addTemplateBtn:UIButton){
        let templateContentVc = TemplateContentViewController()
        templateContentVc.title = "新建模板"
        templateContentVc.type = 0
        Coordinator.shared?.pushViewController(self, templateContentVc, animated: true)
        templateContentVc.newAndUpdateBlock = {
            self.loadFreightList()
        }
    }
    
    //删除
    @objc func setDeleteAction(deleteBtn:UIButton){
        let model = list[deleteBtn.tag]
        if model.defTemp == false{
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
                            let parameters = ["freightId":model.freightId as Any] as [String:Any]
                            NetWorkResultRequest(OrderApi.delFreightStatus(parameters: parameters), needShowFailAlert: true) { result, data in
                                //成功之后
                                self.loadFreightList()
                            } failureCallback: { error, code in
                                code.loginOut()
                            }
                        })
                    ])
                ]
            }
        }else{
            JFPopup.toast(hit: "默认模板不能删除")
        }
    }
    
    //设置为默认
    @objc func setIsDefaultAction(isDefaultBtn:UIButton){
        let model = list[isDefaultBtn.tag]
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
//                        for i in 0..<3{
//                            let cell = self.tableview.cellForRow(at: IndexPath(row: i, section: 0)) as! FreightTemplateCell
//                            if isDefaultBtn.tag == i{
//                            }else{
//                                cell.isDefaultBtn.isSelected = false
//                            }
//                        }
                        isDefaultBtn.isSelected = !isDefaultBtn.isSelected
                        let parameters = ["defTemp":isDefaultBtn.isSelected,"freightId":model.freightId as Any] as [String:Any]
                        NetWorkResultRequest(OrderApi.defFreightTemplate(parameters: parameters), needShowFailAlert: true) { result, data in
                            //成功之后
                            self.loadFreightList()
                            
                        } failureCallback: { error, code in
                            code.loginOut()
                        }
                    })
                ])
            ]
        }
    }
    
    //编辑
    @objc func setEditAction(editBtn:UIButton){
        
        let model = list[editBtn.tag]
        let parameters = ["freightId":model.freightId as Any] as [String:Any]
        NetWorkResultRequest(OrderApi.getFreightInfo(parameters: parameters), needShowFailAlert: true) { result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<FreightListModel>.self, from: data) else { return }
            let templateContentVc = TemplateContentViewController()
            templateContentVc.title = "修改模板"
            var freightListModel = model.data
            if freightListModel?.freightConf == nil{
                freightListModel?.freightConf = freightConfModel(firstPiece: 0, freight: 0, freightConfId: 0,parcelConditions: 0, renewal: 0, renewalFreight: 0)
            }
            if freightListModel?.noDeliveryRegionIds == nil{
                freightListModel?.noDeliveryRegionIds = [Int32]()
            }
            templateContentVc.type = 1
            templateContentVc.freightListModel = freightListModel
            Coordinator.shared?.pushViewController(self, templateContentVc, animated: true)
            templateContentVc.newAndUpdateBlock = {[weak self] in
                self?.loadFreightList()
            }
        } failureCallback: { error, code in
            code.loginOut()
        }
    }

    
    
//    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
//        return true
//    }

}

extension FreightTemplateViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FreightTemplateCell") as! FreightTemplateCell
        let model = list[indexPath.row]
        cell.model = model
        cell.isDefaultBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        cell.editBtn.tag = indexPath.row
        cell.isDefaultBtn.addTarget(self, action: #selector(setIsDefaultAction), for: .touchUpInside)
        cell.deleteBtn.addTarget(self, action: #selector(setDeleteAction), for: .touchUpInside)
        cell.editBtn.addTarget(self, action: #selector(setEditAction), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vcArray = self.navigationController?.viewControllers
        let vc = self.navigationController?.viewControllers[vcArray!.count - 2]
        if (vc!.isKind(of: ReleaseGoodsViewController.self)){
            let model = list[indexPath.row]
            self.selectFreightId?(model)
            Coordinator.shared?.popViewController(self, true)
        }
    }

    
}
