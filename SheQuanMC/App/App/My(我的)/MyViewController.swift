//
//  MyViewController.swift
//  App
//
//  Created by mac on 2022/4/24.
//

import UIKit
import Util

public class MyViewController: BaseViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        
        let logoutBtn = UIButton(title: "退出", titleColor: UIColor.colorWithDyColorChangObject(lightColor: "#333333"), fontSize: 15)
        view.addSubview(logoutBtn)
        
        logoutBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(scale(100))
        }
        
        
        logoutBtn.addTarget(self, action: #selector(logoutBtnAction), for: .touchUpInside)
        
        
    }
    
    
    @objc func logoutBtnAction(logoutBtn:UIButton){
        StoreService.shared.delete()
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = BaseNaviViewController(rootViewController: StartPageViewController())
    }
    
    
}
