//
//  BankListViewController.swift
//  App
//
//  Created by mac on 2022/7/20.
//

import UIKit
import Util

class BankListViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "银行卡"
        
//        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
    
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
        }
        
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(BankListCell.self, forCellReuseIdentifier: "BankListCell")
        
        
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF")
        view.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(iPhoneX ? scale(92) : scale(58))
        }
        
        let addBankBtn = UIButton()
        addBankBtn.setTitle("添加银行卡", for: .normal)
        addBankBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        addBankBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addBankBtn.setImage(UIImage(named: "Group 2688"), for: .normal)
        addBankBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        addBankBtn.addTarget(self, action: #selector(addBankAction), for: .touchUpInside)
        bottomView.addSubview(addBankBtn)
        
        addBankBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        addBankBtn.layer.cornerRadius = scale(4)
        
        
        
    }
    
    
    //添加银行卡
    @objc func addBankAction(addBankBtn:UIButton){
        let addBankVc = AddBankViewController()
        Coordinator.shared?.pushViewController(self, addBankVc, animated: true)
    }
    
    
    
    

    //这边设置图片为空
    override func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage()
    }
   
    //并设置文字
    override func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "暂无银行卡"
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: scale(14), weight: .regular),NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor: "#999999")]
        return NSAttributedString(string: text, attributes: attributes)
    }


}

extension BankListViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankListCell") as! BankListCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let bankDetailVc = BankDetailViewController()
        Coordinator.shared?.pushViewController(self, bankDetailVc, animated: true)
    }

    
}
