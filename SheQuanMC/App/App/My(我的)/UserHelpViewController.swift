//
//  UserHelpViewController.swift
//  App
//
//  Created by mac on 2022/7/5.
//

import UIKit

class UserHelpViewController: BaseViewController {

    var helpList:[String] = ["如何发布新商品","如何下架商品","如何添加退货地址","如何修改/删除运费模版"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "用户帮助"
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UserHelpCell.self, forCellReuseIdentifier: "UserHelpCell")
        
        
        
    }
    


}

extension UserHelpViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpList.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserHelpCell") as! UserHelpCell
        cell.helpTitleLabel.text = helpList[indexPath.row]
        return cell
    }

    
    
    
}
