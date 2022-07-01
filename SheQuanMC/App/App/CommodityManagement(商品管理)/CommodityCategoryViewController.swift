//
//  CommodityCategoryViewController.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util

class CommodityCategoryViewController: BaseViewController {
    
    lazy var searchBar:UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "搜索"
        searchBar.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        }
        searchBar.barStyle = .default
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = UIColor.clear
        return searchBar
    }()
    
    
    var categoryList:[BussinessSecondTypeModel] = [BussinessSecondTypeModel]()
    
    var selectCategoryId:Int32 = 0
    
    //用来判断是选择了那个商品类目
    var choiceGoodsTypeTitle:((_ model:BussinessSecondTypeModel)->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "选择商品类目"
        createRightBarBtnItem(title: "确认", method: #selector(sureAction), titleColor: UIColor.colorWithDyColorChangObject(lightColor: "#333333"))
        //搜索框
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(scale(48))
        }
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.addTarget(self, action: #selector(BeginEdit), for: .editingDidBegin)
        }
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.addTarget(self, action: #selector(EndEdit), for: .editingDidEnd)
        }
        
        if #available(iOS 13.0, *){
            searchBar.searchTextField.addTarget(self, action: #selector(editChangedAction), for: .editingChanged)
        }
        
        
        searchBar.setPositionAdjustment(UIOffset(horizontal: SCW/2 - scale(80)/2, vertical: 0), for: .search)
        view.addSubview(tableview)
        
        tableview.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalToSuperview()
        }
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(CommodityCategoryCell.self, forCellReuseIdentifier: "CommodityCategoryCell")
        
        getProductCategoryList()
        
    }
    
    
    
    override func headerRereshing() {
        getProductCategoryList()
    }
    
    
    
    func getProductCategoryList(){
        let parameters = ["categoryId":StoreService.shared.categoryId,"categoryName":(searchBar.text ?? "")] as [String:Any]
        NetWorkResultRequest(OrderApi.getProductCategoryList(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
            self?.categoryList.removeAll()
            guard let models = try? JSONDecoder().decode(GenericResponse<[BussinessSecondTypeModel]>.self, from: data) else{
                return
            }
            self?.categoryList = models.data!
            self?.tableview.reloadData()
            self?.tableview.mj_header?.endRefreshing()
        } failureCallback: {[weak self] error, code in
            code.loginOut()
            self?.tableview.mj_header?.endRefreshing()
        }
    }
    
    
    
    
    
    //确认
    @objc func sureAction(btn:UIButton){
        for i in 0..<categoryList.count {
            if let cell = tableview.cellForRow(at: IndexPath(row: i, section: 0)) as? CommodityCategoryCell{
                if cell.choiceBtn.isSelected{
                     //选中的二级类目类型
//                    self.choiceGoodsTypeTitle!("随便谢谢")
                    let model = self.categoryList[i]
                    self.choiceGoodsTypeTitle!(model)
                    break
                }
            }
        }
        Coordinator.shared?.popViewController(self, true)
    }
    
    //搜索开始
    @objc func BeginEdit(textfiled:UITextField){
        searchBar.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .search)
    }
    //搜索结束
    @objc func EndEdit(textfield:UITextField){
        searchBar.setPositionAdjustment(UIOffset(horizontal: SCW/2 - scale(80)/2, vertical: 0), for: .search)
        searchBar.resignFirstResponder()
    }
    
    //搜索变化中
    @objc func editChangedAction(textfield:UITextField){
        getProductCategoryList()
    }
    
    

    
    //选择第二级商品类目
//    @objc func choiceSecondCategoryAction(choiceBtn:UIButton){
//        //这边要对所有的类目进行青春
//        categoryList.forEach { index in
//           let cell = tableview.cellForRow(at: IndexPath(row: index, section: 0)) as! CommodityCategoryCell
//            cell.choiceBtn.isSelected = false
//        }
////        choiceBtn.isSelected = !choiceBtn.isSelected
//        if choiceTag["tag"] == choiceBtn.tag{
//            choiceTag["tag"] = 1000000000000
//        }else{
//            choiceTag["tag"] = choiceBtn.tag
//        }
//        tableview.reloadData()
//    }
    
}



extension CommodityCategoryViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommodityCategoryCell")
        as! CommodityCategoryCell
        cell.model = categoryList[indexPath.row]
        if cell.model?.categoryId == selectCategoryId{
            cell.choiceBtn.isSelected = true
        }else{
            cell.choiceBtn.isSelected = false
        }
        cell.choiceBtn.tag = indexPath.row
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell1 = tableView.cellForRow(at: indexPath) as! CommodityCategoryCell
        for i in 0..<categoryList.count {
            let cell = tableview.cellForRow(at: IndexPath(row: i, section: 0)) as! CommodityCategoryCell
            if i == indexPath.row{
            }else{
                cell.choiceBtn.isSelected = false
            }
        }
//        categoryList.forEach { index in
//           let cell = tableview.cellForRow(at: IndexPath(row: index, section: 0)) as! CommodityCategoryCell
//            if index == indexPath.row{
//
//            }else{
//                cell.choiceBtn.isSelected = false
//            }
//        }
        cell1.choiceBtn.isSelected = !cell1.choiceBtn.isSelected
    }
    
    
    
}
