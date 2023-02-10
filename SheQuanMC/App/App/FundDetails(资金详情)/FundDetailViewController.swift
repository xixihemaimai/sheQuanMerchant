//
//  FundDetailViewController.swift
//  App
//
//  Created by mac on 2022/7/20.
//

import UIKit
import Util


class FundDetailViewController: BaseViewController {
    
    
    lazy var shopBackImageView:UIImageView = {
       let shopBackImageView = UIImageView()
        shopBackImageView.image = UIImage(named: "Mask Group")
        return shopBackImageView
    }()
    
    //账户可用余额(元)
    lazy var accountMoneyLabel:UILabel = {
       let accountMoneyLabel = UILabel()
        accountMoneyLabel.text = "25741.15"
        accountMoneyLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        accountMoneyLabel.font = UIFont.systemFont(ofSize: scale(46), weight: .semibold)
        accountMoneyLabel.textAlignment = .center
        return accountMoneyLabel
    }()
    
    //未入账余额
    lazy var noInMoneyLabel:UILabel = {
        let noInMoneyLabel = UILabel()
        noInMoneyLabel.text = "300.00"
        noInMoneyLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        noInMoneyLabel.font = UIFont.systemFont(ofSize: scale(24), weight: .semibold)
        noInMoneyLabel.textAlignment = .center
        return noInMoneyLabel
    }()
    
    
    //店铺保证金
    lazy var shopMoneyLabel:UILabel = {
        let shopMoneyLabel = UILabel()
        shopMoneyLabel.text = "300.00"
        shopMoneyLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        shopMoneyLabel.font = UIFont.systemFont(ofSize: scale(24), weight: .semibold)
        shopMoneyLabel.textAlignment = .center
        return shopMoneyLabel
    }()
    
    
    fileprivate let list:[String] = ["充值","提现","资金流水","银行卡","保证金"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        

        
//        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        
        
        view.addSubview(shopBackImageView)
        shopBackImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(scale(414))
        }
        
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named: "返回"), for: .normal)
        backBtn.backgroundColor = UIColor.clear
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(iPhoneX ? scale(60) : scale(32))
            make.width.height.equalTo(scale(24))
        }
        
        backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "资金详情"
        titleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: scale(18), weight: .medium)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iPhoneX ? scale(60) : scale(32))
            make.height.equalTo(scale(25))
            make.width.equalTo(scale(200))
        }
        
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(Height_NavBar)
        }
        tableview.backgroundColor = UIColor.clear
        tableview.register(FundCell.self, forCellReuseIdentifier: "FundCell")
        tableview.delegate = self
        tableview.dataSource = self
        setTableViewCustonHeaderView()
    }
    
    @objc func backAction(backBtn:UIButton){
        Coordinator.shared?.popViewController(self, true)
    }
    
    
    func setTableViewCustonHeaderView(){
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        tableview.tableHeaderView = headerView
        headerView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.height.equalTo(scale(273))
            make.width.equalTo(SCW)
        }
        
        let accountView = UIView()
        accountView.backgroundColor = UIColor.clear
        headerView.addSubview(accountView)
        accountView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(12))
            make.height.equalTo(scale(245))
        }
        
        accountView.layer.cornerRadius = scale(4)
        accountView.layer.borderWidth = scale(1)
        accountView.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF").cgColor
        
        
        let accountLabel = UILabel()
        accountLabel.text = "账户可用余额(元)"
        accountLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        accountLabel.textAlignment = .center
        accountLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        accountView.addSubview(accountLabel)
        accountLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(46))
            make.height.equalTo(scale(20))
        }
        
        
        
        accountView.addSubview(accountMoneyLabel)
        accountMoneyLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(accountLabel.snp.bottom).offset(scale(14))
            make.height.equalTo(scale(64))
        }
        
        
        let noInLabel = UILabel()
        noInLabel.text = "未入账金额"
        noInLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#808080")
        noInLabel.textAlignment = .center
        noInLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        accountView.addSubview(noInLabel)
        noInLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(accountMoneyLabel.snp.bottom).offset(scale(26))
            make.width.equalTo(SCW/2 - scale(32))
            make.height.equalTo(scale(17))
        }
        
        accountView.addSubview(noInMoneyLabel)
        noInMoneyLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.bottom.equalToSuperview()
            make.top.equalTo(noInLabel.snp.bottom).offset(scale(2))
            make.width.equalTo(SCW/2 - scale(32))
        }
        
        let shopLabel = UILabel()
        shopLabel.text = "店铺保证金"
        shopLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#808080")
        shopLabel.textAlignment = .center
        shopLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        accountView.addSubview(shopLabel)
        shopLabel.snp.makeConstraints { make in
            make.left.equalTo(noInLabel.snp.right)
            make.top.equalTo(accountMoneyLabel.snp.bottom).offset(scale(26))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(17))
        }
        accountView.addSubview(shopMoneyLabel)
        shopMoneyLabel.snp.makeConstraints { make in
            make.left.equalTo(noInMoneyLabel.snp.right)
            make.bottom.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.top.equalTo(shopLabel.snp.bottom).offset(scale(2))
        }
        
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E1E1E1")
        accountView.addSubview(midView)
        
        midView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-scale(29))
            make.height.equalTo(scale(44))
            make.width.equalTo(scale(0.5))
        }
        headerView.layoutIfNeeded()
    }
    

    
}

extension FundDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FundCell") as! FundCell
        cell.fundLabel.text = list[indexPath.row]
        if indexPath.row == 0{
            //部分倒角
            cell.titleView.frame = CGRect(x: scale(16), y: 0, width: SCW - scale(32), height: scale(58))
            cell.titleView.addCorner(conrners: [.topLeft,.topRight], radius: scale(4))
        }else if indexPath.row == list.count - 1{
            cell.midView.isHidden = true
            //也需要倒角
            cell.titleView.frame = CGRect(x: scale(16), y: 0, width: SCW - scale(32), height: scale(58))
            cell.titleView.addCorner(conrners: [.bottomLeft,.bottomRight], radius: scale(4))
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0{
            let rechargeAndWthdrawalVc = RechargeAndiWthdrawalViewController()
            rechargeAndWthdrawalVc.funtionStyle = .funtionStyle_Recharge
            Coordinator.shared?.pushViewController(self, rechargeAndWthdrawalVc, animated: true)
        }else if indexPath.row == 1{
            let rechargeAndWthdrawalVc = RechargeAndiWthdrawalViewController()
            rechargeAndWthdrawalVc.funtionStyle = .FuntionStyle_Wthdrawal
            Coordinator.shared?.pushViewController(self, rechargeAndWthdrawalVc, animated: true)
        }else if indexPath.row == 2{
            let capitalFlowVc = CapitalFlowViewController()
            Coordinator.shared?.pushViewController(self, capitalFlowVc, animated: true)
        }else if indexPath.row == 3{
            let bankListVc = BankListViewController()
            Coordinator.shared?.pushViewController(self, bankListVc, animated: true)
        }
    }
    
}
