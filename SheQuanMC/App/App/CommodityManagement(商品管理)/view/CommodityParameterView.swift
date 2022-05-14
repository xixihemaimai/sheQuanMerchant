//
//  CommodityParameterView.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util


class CommodityParameterView: UIView {

    
    //输入uitextview
    
    //这边要进行修改这类的动作
    var cancelBlock:(()->Void)?
    
    
    //完成按键
    lazy var sureBtn:UIButton = {
       let sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF"), for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        sureBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        return sureBtn
    }()
    
    
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
    
    
    lazy var tableview:UITableView = {
        let tableview = UITableView(frame: .zero, style: .plain)
        tableview.separatorStyle = .none
        tableview.estimatedSectionFooterHeight = 0
        tableview.estimatedSectionHeaderHeight = 0
        if #available(iOS 11.0, *){
            tableview.contentInsetAdjustmentBehavior = .never
        }
        if #available(iOS 15.0, *){
            tableview.sectionHeaderTopPadding = 0
        }
        return tableview
    }()
    
    
    var reasonList:[String] = [String]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        let brandLabel = UILabel()
        brandLabel.text = "品牌"
        brandLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        brandLabel.textAlignment = .center
        brandLabel.font = UIFont.systemFont(ofSize: scale(17), weight: .regular)
        addSubview(brandLabel)
        brandLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scale(15))
            make.width.equalTo(scale(60))
            make.height.equalTo(scale(24))
        }
        reasonList = ["Nike","阿迪达斯","斐乐","安德玛","安踏"]
        
        //取消
        let cancelBtn = UIButton()
        cancelBtn.setBackgroundImage(UIImage(named: "关闭1 1"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelAddAction), for: .touchUpInside)
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(16))
            make.width.height.equalTo(scale(22))
        }
        
        //搜索框
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom).offset(scale(2))
            make.left.right.equalToSuperview()
            make.height.equalTo(scale(48))
        }
        searchBar.layer.cornerRadius = scale(4)
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.addTarget(self, action: #selector(BeginEdit), for: .editingDidBegin)
        }
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.addTarget(self, action: #selector(EndEdit), for: .editingDidEnd)
        }
        searchBar.setPositionAdjustment(UIOffset(horizontal: SCW/2 - scale(80)/2, vertical: 0), for: .search)
        
        
        
        
        addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(-scale(92))
        }
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(CloseOrderReasonCell.self, forCellReuseIdentifier: "CloseOrderReasonCell")
        
        
        
        //看下需不需要添加下拉和上拉
        
        
        addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(tableview.snp.bottom).offset(scale(14))
            make.height.equalTo(scale(44))
        }
        
        sureBtn.layer.cornerRadius = scale(4)
        
    }
    
    
    //取消
    @objc func cancelAddAction(cancelBtn:UIButton){
        cancelBlock!()
    }
    
    
    @objc func BeginEdit(textfiled:UITextField){
        searchBar.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .search)
    }
    @objc func EndEdit(textfield:UITextField){
        searchBar.setPositionAdjustment(UIOffset(horizontal: SCW/2 - scale(80)/2, vertical: 0), for: .search)
        searchBar.resignFirstResponder()
    }
    
    
    //选择关闭订单原因
//    @objc func choiceCloseReasoonAction(choiceBtn:UIButton){
//        for i in 0..<reasonList.count{
//            let cell = tableview.cellForRow(at: IndexPath(row: i, section: 0)) as! CloseOrderReasonCell
//            if choiceBtn.tag == i{
//            }else{
//                cell.choiceBtn.isSelected = false
//            }
//        }
//        choiceBtn.isSelected = !choiceBtn.isSelected
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension CommodityParameterView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reasonList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CloseOrderReasonCell") as! CloseOrderReasonCell
        cell.reasonLabel.text = reasonList[indexPath.row]
        cell.choiceBtn.tag = indexPath.row
//        cell.choiceBtn.addTarget(self, action: #selector(choiceCloseReasoonAction), for: .touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let cell1 = tableView.cellForRow(at: indexPath) as! CloseOrderReasonCell
//        reasonList.forEach { index in
//           let cell = tableview.cellForRow(at: IndexPath(row: index, section: 0)) as! CloseOrderReasonCell
//            if index == indexPath.row{
//
//            }else{
//                cell.choiceBtn.isSelected = false
//            }
//        }
        for (index, _) in reasonList.enumerated(){
            let cell = tableview.cellForRow(at: IndexPath(row: index, section: 0)) as! CloseOrderReasonCell
            if index == indexPath.row{
            }else{
               cell.choiceBtn.isSelected = false
            }
        }
        cell1.choiceBtn.isSelected = !cell1.choiceBtn.isSelected
    }
    
    
}
