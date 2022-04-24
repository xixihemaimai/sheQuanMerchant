//
//  ShopViewController.swift
//  App
//
//  Created by mac on 2022/4/24.
//

import UIKit
import Util
import SnapKit

public class ShopViewController: BaseViewController {
    
    
   public override func viewDidLoad() {
      super.viewDidLoad()
  
       view.addSubview(tableview)
       tableview.snp.makeConstraints { make in
           make.left.top.right.bottom.equalTo(view)
       }
       tableview.delegate = self
       tableview.dataSource = self
       tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       
           
    }
    
    
    func headerRereshing(){
        print("下拉")
    }
    
    func footerRereshing(){
       print("上拉")
   }
    
    
    
    

    @objc func jump(btn:UIButton){
        let vc = commodityManageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    
}

extension ShopViewController:UITableViewDelegate,UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public  func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "暂无数据"
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18),NSAttributedString.Key.foregroundColor:UIColor.darkGray] as [NSAttributedString.Key : Any]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        return cell
    }
    
    
    
}
