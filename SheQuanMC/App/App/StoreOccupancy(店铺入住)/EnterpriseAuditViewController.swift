//
//  EnterpriseAuditViewController.swift
//  App
//
//  Created by mac on 2022/4/27.
//

import UIKit
import Util

class EnterpriseAuditViewController: BaseViewController {

    // 这边有俩种状态
    //审核中
    //审核失败
    
    lazy var auditImageView:UIImageView = {
       let auditImageView = UIImageView()
        return auditImageView
    }()
    
    lazy var auditLabel:UILabel = {
       let auditLabel = UILabel()
        auditLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        auditLabel.font = UIFont.systemFont(ofSize: scale(20), weight: .regular)
        auditLabel.textAlignment = .center
        return auditLabel
    }()
    
    
    
    //审核中为1 审核失败为2
    var audit:Int = 1
    
    //失败的原因
    lazy var failView:UIView = {
       let failView = UIView()
        failView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F6F6F6")
        return failView
    }()
    
    
    lazy var failLabel:UILabel = {
       let failLabel = UILabel()
        failLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        failLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return failLabel
    }()
    
    //失败之后修改资料
    lazy var modifyDataBtn:UIButton = {
       let modifyDataBtn = UIButton()
        modifyDataBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        modifyDataBtn.setTitle("修改资料", for: .normal)
        modifyDataBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        modifyDataBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return modifyDataBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        view.addSubview(auditImageView)
        auditImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(scale(91))
            make.width.equalTo(scale(189))
            make.height.equalTo(scale(168))
        }
        
        auditImageView.addSubview(auditLabel)
        auditLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(scale(28))
        }
        
        if self.audit == 1{
            auditImageView.image = UIImage(named: "Group 2685")
            auditLabel.text = "审核中"
        }else{
            auditImageView.image = UIImage(named: "Group 2685")
            auditLabel.text = "审核失败"
            
            failLabel.text = "失败原因，失败原因，失败原因"
           
            
            view.addSubview(failView)
            
            failView.snp.makeConstraints { make in
                make.left.equalTo(scale(28))
                make.right.equalTo(-scale(28))
                make.top.equalTo(auditImageView.snp.bottom).offset(scale(31))
                make.height.equalTo(0)
            }
            
            
          let heigt = failLabel.text!.rectHeight(font: UIFont.systemFont(ofSize: scale(14), weight: .regular), size: CGSize(width: SCW - scale(100), height: CGFloat(MAXFLOAT)))
            failView.addSubview(failLabel)
            
            failLabel.snp.makeConstraints { make in
                make.left.equalTo(scale(24))
                make.right.equalTo(-scale(28))
                make.top.equalTo(scale(23))
                make.height.equalTo(heigt)
            }
            
            
            failView.snp.remakeConstraints { make in
                make.left.equalTo(scale(28))
                make.right.equalTo(-scale(28))
                make.top.equalTo(auditImageView.snp.bottom).offset(scale(31))
                make.height.equalTo(heigt + scale(43))
            }
            
            
            failView.layer.cornerRadius = scale(4)
            view.addSubview(modifyDataBtn)
            
            
            modifyDataBtn.snp.makeConstraints { make in
                make.left.equalTo(scale(28))
                make.right.equalTo(-scale(28))
                make.top.equalTo(failView.snp.bottom).offset(scale(30))
                make.height.equalTo(scale(40))
            }
            modifyDataBtn.layer.cornerRadius = scale(4)
            
            modifyDataBtn.addTarget(self, action: #selector(modifyDataAction), for: .touchUpInside)
        }
    }
    
    
    //修改资料
    @objc func modifyDataAction(modifyDataBtn:UIButton){
        let storeOcVc = StoreOccupancyViewController()
        Coordinator.shared?.pushViewController(self, storeOcVc, animated: true)
    }
    
}
