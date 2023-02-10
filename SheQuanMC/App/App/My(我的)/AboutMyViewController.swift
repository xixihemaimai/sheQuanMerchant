//
//  AboutMyViewController.swift
//  App
//
//  Created by mac on 2022/7/5.
//

import UIKit
import Util

class AboutMyViewController: BaseViewController {

    
    var helpList:[String] = ["检查更新","用户协议","隐私政策"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "关于我们"
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UserHelpCell.self, forCellReuseIdentifier: "UserHelpCell")
        
        setCustomTableViewHeaderView()
        
    }
    
    
    func setCustomTableViewHeaderView(){
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        tableview.tableHeaderView = headerView
        
        headerView.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.equalTo(SCW)
            make.height.equalTo(scale(197))
        }
        
        let headerImage = UIImageView()
        headerImage.image = UIImage(named: "Rectangle 2363")
        headerView.addSubview(headerImage)
        headerImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scale(44))
            make.width.height.equalTo(scale(78))
        }
        
        let headerLabel = UILabel()
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        headerLabel.text = "奢圈商户版" + "V" + (appVersion ?? "1.0.0")
        headerLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        headerLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        headerLabel.textAlignment = .center
        headerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(headerImage.snp.bottom).offset(scale(12))
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
        }
        
        tableview.layoutIfNeeded()
    }
    
}



extension AboutMyViewController:UITableViewDelegate,UITableViewDataSource{
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0{
         
            
        }else if indexPath.row == 1 || indexPath.row == 2{
            let wkWebVc = WKWebViewViewController()
            wkWebVc.title = helpList[indexPath.row]
            Coordinator.shared?.pushViewController(self, wkWebVc, animated: true)
        }
        
    }
    
    
}
