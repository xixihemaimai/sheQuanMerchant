//
//  CheckLogisticsViewController.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class CheckLogisticsViewController: BaseViewController {

    var orderInfoModel:OrederInfoModel?
    
    var viewLogisticsModel:ViewLogisticsModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        
        title = "查看物流"
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(scale(1))
        }
        
    
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(CheckLogisticsNumberCell.self, forCellReuseIdentifier: "CheckLogisticsNumberCell")
        tableview.register(CheckLogisticsProgressCell.self, forCellReuseIdentifier: "CheckLogisticsProgressCell")
        
        loadChechViewLogisticsList()
        
    }
    
    
    
    override func headerRereshing() {
        loadChechViewLogisticsList()
    }
    
    
    
    func loadChechViewLogisticsList(){
        let parameters = ["orderId":orderInfoModel?.orderId as Any] as [String:Any]
        NetWorkResultRequest(OrderApi.viewLogistics(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<ViewLogisticsModel>.self, from: data) else { return }
            if let _data = model.data{
                self?.viewLogisticsModel = _data
                self?.viewLogisticsModel?.tracks?.reverse()
            }
            self?.tableview.reloadData()
            self?.tableview.mj_header?.endRefreshing()
        } failureCallback: {[weak self] error, code in
            code.loginOut()
            self?.tableview.mj_header?.endRefreshing()
        }
    }
}




extension CheckLogisticsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return viewLogisticsModel?.tracks?.count ?? 0
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckLogisticsNumberCell") as! CheckLogisticsNumberCell
            cell.viewLogisticsModel = viewLogisticsModel
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckLogisticsProgressCell") as! CheckLogisticsProgressCell
            cell.viewLogisticsListModel = viewLogisticsModel?.tracks?[indexPath.row]
            if indexPath.row == 0 {
                cell.topView.isHidden = true
                cell.midView.snp.remakeConstraints { make in
                    make.left.equalTo(scale(18))
                    make.top.equalTo(cell.topView.snp.bottom)
                    make.width.height.equalTo(scale(12))
                }
                cell.midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
                cell.midView.layer.cornerRadius = scale(6)
            }else{
                cell.topView.isHidden = false
                cell.midView.snp.remakeConstraints { make in
                    make.left.equalTo(scale(19.5))
                    make.top.equalTo(cell.topView.snp.bottom)
                    make.width.height.equalTo(scale(8))
                }
                cell.midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4")
                cell.midView.layer.cornerRadius = scale(4)
            }
            
            if (indexPath.row + 1) == viewLogisticsModel?.tracks?.count{
                cell.bottomView.isHidden = true
            }else{
                cell.bottomView.isHidden = false
            }
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
