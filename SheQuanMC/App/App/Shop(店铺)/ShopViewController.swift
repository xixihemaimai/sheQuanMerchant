//
//  ShopViewController.swift
//  App
//
//  Created by mac on 2022/4/24.
//

import UIKit
import Util
import SnapKit

class ShopViewController: BaseViewController {
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
  
       view.addSubview(tableview)
       tableview.snp.makeConstraints { make in
           make.left.top.right.bottom.equalTo(view)
       }
       tableview.delegate = self
       tableview.dataSource = self
       tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

           
    }
    
    
    override func headerRereshing() {
        print("下拉")
        
        tableview.mj_header?.endRefreshing()
    }
    
    
    override func footerRereshing() {
        print("上拉")
        tableview.mj_footer?.endRefreshing()
    }
    

    @objc func jump(btn:UIButton){
        let vc = commodityManageViewController()
        navigationController?.pushViewController(vc, animated: true)
//        Coordinator.shared?.pushViewController(vc, animated: true)
    }

    
}

extension ShopViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "暂无数据"
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18),NSAttributedString.Key.foregroundColor:UIColor.darkGray] as [NSAttributedString.Key : Any]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = commodityManageViewController()
//        navigationController?.pushViewController(vc, animated: true)
        Coordinator.shared?.pushViewController(self, vc, animated: true)
        
//        Coordinator.shared?.pushViewController(vc, animated: true)
    }
    
    
}
