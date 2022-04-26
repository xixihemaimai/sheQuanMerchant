//
//  BusinessTypeViewController.swift
//  App
//
//  Created by mac on 2022/4/26.
//

import UIKit
import Util

class BusinessTypeViewController: BaseViewController {

    
    lazy var searchBar:UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "搜索"
        return searchBar
    }()
    
    //用来保存展开还是关闭的数组
    var openList:[Bool] = [Bool]()
    //用来保存是选中了经营种类
    var choiceDict:[String:Int] = [:]
    
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
        
        view.addSubview(self.tableview)
        self.tableview.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(BusinessTypeCell.self, forCellReuseIdentifier: "BusinessTypeCell")
        self.tableview.register(BusinessTypeHeaderView.self, forHeaderFooterViewReuseIdentifier: "BusinessTypeHeaderView")
        
        
        //获取数据
        
        
        openList = [
           false,
           false,
           false,
           false
        ]
        
    }
    
    //下拉
    override func headerRereshing() {
        tableview.mj_header?.endRefreshing()
    }
    
    //上拉
    override func footerRereshing() {
        tableview.mj_footer?.endRefreshing()
    }
    
    
    
    
    //确认
    @objc func sureChoiceAction(){
        for i in 0..<openList.count {
            if let headerView = tableview.headerView(forSection: i) as? BusinessTypeHeaderView{
                if headerView.choiceBtn.isSelected{
                    //选中的经营种类
                }
            }
        }
    }
    
}


extension BusinessTypeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isOpen = openList[section]
        if isOpen{
            return 4
        }else{
          return 0
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return openList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTypeCell") as! BusinessTypeCell
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
        headerView.openTwoType(section: section, isOpen: isOpen)
        
        if section == choiceDict["tag"]{
            headerView.choiceBtn.isSelected = true
        }
        return headerView
    }
    
    
    //展开和关闭
    @objc func shopOpenBtnAction(showOpenBtn:UIButton){
        showOpenBtn.isSelected = !showOpenBtn.isSelected
        openList[showOpenBtn.tag] = showOpenBtn.isSelected
        tableview.reloadSections(IndexSet(integer:showOpenBtn.tag), with: .none)
    }
    
    
    //选择经营种类
    @objc func choiceBussinessAction(choiceBtn:UIButton){
        //这边先所有的
        for i in 0..<openList.count {
            if let headerView = tableview.headerView(forSection: i) as? BusinessTypeHeaderView{
                headerView.choiceBtn.isSelected = false
            }
        }
        
        
        
        
//        if let headerView = tableview.headerView(forSection: choiceBtn.tag) as? BusinessTypeHeaderView {
//            headerView.choiceBtn.isSelected = true
            //这边保存
            choiceDict["tag"] = choiceBtn.tag
//            tableview.reloadSections(IndexSet(integer:choiceBtn.tag), with: .none)
        tableview.reloadData()
//        }
    }
    
    
    
//    emptyDataSetShouldDisplay
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
    
}
