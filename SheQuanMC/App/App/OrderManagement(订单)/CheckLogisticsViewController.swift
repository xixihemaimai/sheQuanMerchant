//
//  CheckLogisticsViewController.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class CheckLogisticsViewController: BaseViewController {

    
    
    
    
    
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
        
    }
    

}




extension CheckLogisticsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 10
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckLogisticsNumberCell") as! CheckLogisticsNumberCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckLogisticsProgressCell") as! CheckLogisticsProgressCell
            if indexPath.row == 0 {
                cell.topView.isHidden = true
                cell.first = "1"
            }else{
                cell.topView.isHidden = false
            }
            
            if indexPath.row == 9{
                cell.bottomView.isHidden = true
            }else
            {
                cell.bottomView.isHidden = false
            }
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
