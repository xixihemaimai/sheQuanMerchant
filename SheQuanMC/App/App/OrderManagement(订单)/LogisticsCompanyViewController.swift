//
//  LogisticsCompanyViewController.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util


class LogisticsCompanyViewController: BaseViewController {
    
    
    //选择物流成功回调
    var selectLogisticsSuccessBlock:((_ logisticsModel:LogisticsModel)->Void)?
    
    
    
    lazy var searchBar:UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "搜索"
        searchBar.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
//        searchBar.delegate = self
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        }
        searchBar.barStyle = .default
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = UIColor.clear
        return searchBar
    }()
    
    
    var logisticsList:[LogisticsModel] = [LogisticsModel]()
    
    
    var commonlyLogisticsList:[LogisticsModel] = [LogisticsModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "选择物流公司"
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(scale(48))
        }
        searchBar.layer.cornerRadius = scale(4)
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.addTarget(self, action: #selector(BeginEdit), for: .editingDidBegin)
        }
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.addTarget(self, action: #selector(EndEdit), for: .editingDidEnd)
        }
        
        if #available(iOS 13.0, *){
            searchBar.searchTextField.addTarget(self, action: #selector(searchContentEdit), for: .editingChanged)
        }
        

        searchBar.setPositionAdjustment(UIOffset(horizontal: SCW/2 - scale(80)/2, vertical: 0), for: .search)
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(LogisticsCompanyCell.self, forCellReuseIdentifier: "LogisticsCompanyCell")
        tableview.register(LogisticsCompanyHeaderView.self, forHeaderFooterViewReuseIdentifier: "LogisticsCompanyHeaderView")
        
        loadLogisticsCompanyList()
    }
    
    
    //获取物流公司
    func loadLogisticsCompanyList(){
        let parameters = ["logisticsName":searchBar.text as Any] as [String:Any]
        NetWorkResultRequest(OrderApi.getLogisticsList(parameters: parameters), needShowFailAlert: true) { result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<[LogisticsModel]>.self, from: data) else { return }
            self.logisticsList.removeAll()
            self.commonlyLogisticsList.removeAll()
            if let _data = model.data{
                for i in 0..<_data.count {
                    let logisticsList = _data[i]
                    self.logisticsList.append(logisticsList)
                    if (logisticsList.usageCount ?? 0) > 0{
                        self.commonlyLogisticsList.append(logisticsList)
                    }
                }
            }
            self.tableview.reloadData()
        } failureCallback: { error, code in
            code.loginOut()
        }
    }
    
    
    @objc func BeginEdit(textfiled:UITextField){
        searchBar.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .search)
    }
    @objc func EndEdit(textfield:UITextField){
        searchBar.setPositionAdjustment(UIOffset(horizontal: SCW/2 - scale(80)/2, vertical: 0), for: .search)
        searchBar.resignFirstResponder()
    }
    @objc func searchContentEdit(textfield:UITextField){
        loadLogisticsCompanyList()
    }
    
}


extension LogisticsCompanyViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return commonlyLogisticsList.count
        }else{
            return logisticsList.count
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
//        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "LogisticsCompanyHeaderView") as! LogisticsCompanyHeaderView
        if section == 0{
            header.titleCompanyLabel.text = "常用物理"
        }else{
            header.titleCompanyLabel.text = "全部物流"
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return scale(42)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogisticsCompanyCell") as! LogisticsCompanyCell
        cell.logisticsModel = logisticsList[indexPath.row]
        if indexPath.row == 0{
            cell.diviver.isHidden = true
        }else{
            cell.diviver.isHidden = false
        }
        return cell
    }
    
    //选中物流公司要进行返回选中的公司
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0{
            let logisticsModel = commonlyLogisticsList[indexPath.row]
            selectLogisticsSuccessBlock?(logisticsModel)
            Coordinator.shared?.popViewController(self, true)
        }else{
            let logisticsModel = logisticsList[indexPath.row]
            selectLogisticsSuccessBlock?(logisticsModel)
            Coordinator.shared?.popViewController(self, true)
        }
    }
}
