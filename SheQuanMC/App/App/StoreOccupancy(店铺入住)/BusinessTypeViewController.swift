//
//  BusinessTypeViewController.swift
//  App
//
//  Created by mac on 2022/4/26.
//

import UIKit
import Util
import SwiftyJSON
import HandyJSON
import JFPopup


class BusinessTypeViewController: BaseViewController {

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
    
    //用来保存展开还是关闭的数组
    var openList:[Bool] = [Bool]()
    //用来保存是选中了经营种类
//    var choiceDict:[String:Int] = [:]
    
    //用来保存有一级数组
    var firstArray:[BusinessTypeModel] = [BusinessTypeModel]()
    //用来确认完成返回的内容
    var sureSelectBusinessType:((_ businessTypeModel:BusinessTypeModel) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "经营种类"
        createRightBarBtnItem(title: "确认", method: #selector(sureChoiceAction),titleColor: UIColor.colorWithDyColorChangObject(lightColor: "#333333"))
        
        //这边要先添加一个搜索框
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
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.addTarget(self, action: #selector(editChange), for: .editingChanged)
        }
        
        searchBar.setPositionAdjustment(UIOffset(horizontal: SCW/2 - scale(80)/2, vertical: 0), for: .search)
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(BusinessTypeCell.self, forCellReuseIdentifier: "BusinessTypeCell")
        tableview.register(BusinessTypeHeaderView.self, forHeaderFooterViewReuseIdentifier: "BusinessTypeHeaderView")
        
        
        //获取数据
//        openList = [
//           false,
//           false,
//           false,
//           false
//        ]
        reload(categoryName: searchBar.text ?? "")
        
    }
    
    //下拉
    override func headerRereshing() {
        reload(categoryName: searchBar.text ?? "")
//        tableview.mj_header?.endRefreshing()
    }
    
    //上拉
//    override func footerRereshing() {
//        tableview.mj_footer?.endRefreshing()
//    }
    
    
    func reload(categoryName:String){
//        {
//          "categoryName": "string"
//        }
        //模型BusinessTypeModel
        let parameters = ["categoryName":categoryName]
        NetWorkResultRequest(StoreAppleApi.getCategoryInfoList(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
//            do{
                self?.firstArray.removeAll()
//                let json = try JSON(data: data)
//                guard let models = JSONDeserializer<BusinessTypeModel>.deserializeModelArrayFrom(json: json["data"].description) else{
//                  return
//                }
//                for i in 0..<models.count{
//                    guard let model = JSONDeserializer<BussinessSecondTypeModel>.deserializeModelArrayFrom(json: json["data"][i]["subCategorys"].description) else{
//                        return
//                    }
//                    let businessTypeModel = models[i]
////                    LXFLog("---------\(model)")
//                    businessTypeModel!.subCategorys! = model as! [BussinessSecondTypeModel]
//                    LXFLog(businessTypeModel?.subCategorys)
//                    self?.firstArray.append(businessTypeModel!)
//                }
//                let jsonString = String(data: data, encoding: .utf8)
                guard let models = try? JSONDecoder().decode(GenericResponse<[BusinessTypeModel]>.self, from: data) else{
                    return
                }
                self?.firstArray = models.data!
            
//                LXFLog(models)
//            }catch{}
            self?.openList.removeAll()
            for _ in 0..<(self?.firstArray.count ?? 0){
                self?.openList.append(false)
            }
            self?.tableview.reloadData()
            
            self?.tableview.mj_header?.endRefreshing()
            
        } failureCallback: {[weak self] error,code in
            code.loginOut()
            self?.tableview.mj_header?.endRefreshing()
        }
    }
    
    
    
    
    
    
    //确认
    @objc func sureChoiceAction(){
        var isSure:Bool = false
        var selectIndex:Int = 0
        for i in 0..<openList.count {
            if let headerView = tableview.headerView(forSection: i) as? BusinessTypeHeaderView{
                if headerView.choiceBtn.isSelected{
                    //选中的经营种类
                    isSure = true
                    selectIndex = i
                    break
                }
            }
        }
        
        
        if isSure{
            let businessTypeModel = self.firstArray[selectIndex]
            sureSelectBusinessType!(businessTypeModel)
            //返回
            Coordinator.shared?.popViewController(self, true)
        }else{
            JFPopup.toast(hit: "请选择经营种类")
        }
    }
    
    
    @objc func BeginEdit(textfiled:UITextField){
        searchBar.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .search)
    }
    @objc func EndEdit(textfield:UITextField){
        searchBar.setPositionAdjustment(UIOffset(horizontal: SCW/2 - scale(80)/2, vertical: 0), for: .search)
        searchBar.resignFirstResponder()
    }
    
    @objc func editChange(textfield:UITextField){
        reload(categoryName: textfield.text ?? "")
    }
    
}


extension BusinessTypeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isOpen = self.openList[section]
        if isOpen{
             let buinessTypemodel = self.firstArray[section]
             return buinessTypemodel.subCategorys?.count ?? 0
        }else{
            return 0
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return openList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTypeCell") as! BusinessTypeCell
//        if indexPath.row == 0{
//            cell.diviver.isHidden = true
//        }
        let buinessTypemodel = self.firstArray[indexPath.section]
        if let buinessSecondTyoeModel = buinessTypemodel.subCategorys?[indexPath.row] as? BussinessSecondTypeModel{
            cell.productLabel.text = buinessSecondTyoeModel.categoryName
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return scale(54)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "BusinessTypeHeaderView") as! BusinessTypeHeaderView
        let isOpen = openList[section]
        //还有就是展开的变化
        headerView.showOpenBtn.tag = section
        headerView.choiceBtn.tag = section
        headerView.showOpenBtn.addTarget(self, action: #selector(shopOpenBtnAction), for: .touchUpInside)
        headerView.choiceBtn.addTarget(self, action: #selector(choiceBussinessAction), for: .touchUpInside)
        let buinessTypemodel = firstArray[section]
        headerView.openTwoType(section: section, isOpen: isOpen, businessName: buinessTypemodel.categoryName ?? "")
        
//        if section == choiceDict["tag"]{
//            headerView.choiceBtn.isSelected = true
//        }
        
        return headerView
    }
    
    
    //展开和关闭
    @objc func shopOpenBtnAction(showOpenBtn:UIButton){
        showOpenBtn.isSelected = !showOpenBtn.isSelected
        openList[showOpenBtn.tag] = showOpenBtn.isSelected
        tableview.reloadSections(IndexSet(integer: showOpenBtn.tag), with: .none)
    }
    
    
    //选择经营种类
    @objc func choiceBussinessAction(choiceBtn:UIButton){
        let headerView = tableview.headerView(forSection: choiceBtn.tag) as! BusinessTypeHeaderView
        //这边先所有的
        for i in 0..<openList.count {
            if let headerView = tableview.headerView(forSection: i) as? BusinessTypeHeaderView{
                if choiceBtn.tag == i {
                    
                }else{
                    headerView.choiceBtn.isSelected = false
                }
            }
        }
        headerView.choiceBtn.isSelected = !headerView.choiceBtn.isSelected
//        if let headerView = tableview.headerView(forSection: choiceBtn.tag) as? BusinessTypeHeaderView {
//            headerView.choiceBtn.isSelected = true
            //这边保存
//        if choiceDict["tag"] == choiceBtn.tag{
//            choiceDict["tag"] = 1000000000000
//        }else{
//            choiceDict["tag"] = choiceBtn.tag
//        }
//            tableview.reloadSections(IndexSet(integer:choiceBtn.tag), with: .none)
//        tableview.reloadData()
//        }
    }
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
    
}




//extension BusinessTypeViewController:UISearchBarDelegate{
//    //当searchBar结束编辑时调用
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//
//    }
//
//}
