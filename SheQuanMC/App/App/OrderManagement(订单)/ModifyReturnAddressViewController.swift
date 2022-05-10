//
//  ModifyReturnAddressViewController.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class ModifyReturnAddressViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        title = "修改退货地址"
        
        let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        view.addSubview(topView)

        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(1))
        }
         
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(-scale(92))
        }
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(AddressCell.self, forCellReuseIdentifier: "AddressCell")
        
        
        let addAdressBtn = UIButton()
        addAdressBtn.setTitle("添加新地址", for: .normal)
        addAdressBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        addAdressBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addAdressBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        addAdressBtn.addTarget(self, action: #selector(addNewAddressAction), for: .touchUpInside)
        view.addSubview(addAdressBtn)
        
        addAdressBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(-scale(44))
        }
        
        addAdressBtn.layer.cornerRadius = scale(4)
        
        
        
        
    }
    
    //添加新地址
    @objc func addNewAddressAction(addAddressBtn:UIButton){
        let addNewAddressVc = ModifyAddressViewController()
        addNewAddressVc.title = "添加新地址"
        Coordinator.shared?.pushViewController(self, addNewAddressVc, animated: true)
        
    }
    //修改地址
    @objc func modifyAddressAction(modifyAddressBtn:UIButton){
        let addNewAddressVc = ModifyAddressViewController()
        addNewAddressVc.title = "修改地址"
        Coordinator.shared?.pushViewController(self, addNewAddressVc, animated: true)
    }
    
   
}

extension ModifyReturnAddressViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell") as! AddressCell
        cell.modifyAddressBtn.tag = indexPath.row
        cell.modifyAddressBtn.addTarget(self, action: #selector(modifyAddressAction), for: .touchUpInside)
        //是否为默认地址
        
        return cell
    }
    
    
   
    
}
