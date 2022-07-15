//
//  NegotiationHistoryViewController.swift
//  App
//
//  Created by mac on 2022/7/15.
//

import UIKit
import Util

class NegotiationHistoryViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "协商历史"
        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
        }
        
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F4F4F4")
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(NegotiationHistoryCell.self, forCellReuseIdentifier: "NegotiationHistoryCell")
        
        
        
        let uploadBtn = UIButton()
        uploadBtn.setTitle("上传凭证", for: .normal)
        uploadBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF"), for: .normal)
        uploadBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        uploadBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        view.addSubview(uploadBtn)
        
        uploadBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        uploadBtn.layer.cornerRadius = scale(4)
    
        uploadBtn.addTarget(self, action: #selector(uploadContentAction), for: .touchUpInside)
        
    }
    
    //上传凭证
    @objc func uploadContentAction(uploadBtn:UIButton){
        //Upload voucher
        let uploadVoucherVc = UploadVoucherViewController()
        Coordinator.shared?.pushViewController(self, uploadVoucherVc, animated: true)
    }
    

}

extension NegotiationHistoryViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NegotiationHistoryCell") as! NegotiationHistoryCell
        return cell
    }
    
}
