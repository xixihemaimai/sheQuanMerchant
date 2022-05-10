//
//  ModifyLogisticsViewController.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class ModifyLogisticsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-scale(92))
            make.top.equalTo(topView.snp.bottom)
        }
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        tableview.register(OrderModifyLogisticsCell.self, forCellReuseIdentifier: "OrderModifyLogisticsCell")
        tableview.register(ReturnGoodsAddressCell.self, forCellReuseIdentifier: "ReturnGoodsAddressCell")
        tableview.register(LogisticsInformationCell.self, forCellReuseIdentifier: "LogisticsInformationCell")
        
        
        let suerModifyBtn = UIButton()
        suerModifyBtn.setTitle("确认修改", for: .normal)
        suerModifyBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        suerModifyBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        suerModifyBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        view.addSubview(suerModifyBtn)
        
        suerModifyBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(-scale(44))
        }
        
        suerModifyBtn.layer.cornerRadius = scale(4)
    }
    
    //goodsDetailLabel 选择物流
    @objc func choiceLogisticsAction(goodsDetailBtn:UIButton){
        let logisticsCompanyVc = LogisticsCompanyViewController()
        Coordinator.shared?.pushViewController(self, logisticsCompanyVc, animated: true)
        
        // 这边要返回选择的物流公司
        
    }
    
    
    //修改退货地址
    @objc func modifyReturnAddressAction(modifyBtn:UIButton){
        let returnAddressVc = ModifyReturnAddressViewController()
        Coordinator.shared?.pushViewController(self, returnAddressVc, animated: true)
    }
    
}


extension ModifyLogisticsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderModifyLogisticsCell") as! OrderModifyLogisticsCell
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogisticsInformationCell") as! LogisticsInformationCell
            
            cell.goodsDetailBtn.addTarget(self, action: #selector(choiceLogisticsAction), for: .touchUpInside)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnGoodsAddressCell") as! ReturnGoodsAddressCell
            
            cell.modifyBtn.addTarget(self, action: #selector(modifyReturnAddressAction), for: .touchUpInside)
            
            return cell
        }
    }
}

