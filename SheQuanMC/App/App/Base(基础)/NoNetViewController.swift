//
//  NoNetViewController.swift
//  App
//
//  Created by mac on 2022/6/30.
//

import UIKit
import Util
import Alamofire
import JFPopup

class NoNetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
       
        //图片
        let noNetImage = UIImageView()
        noNetImage.image = UIImage(named: "网络异常")
        view.addSubview(noNetImage)
        
        noNetImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(scale(189))
            make.height.equalTo(scale(175))
            make.top.equalTo(scale(253 - Height_NavBar))
        }
        
        let notNetLabel = UILabel()
        notNetLabel.text = "网络异常，请检查网络连接"
        notNetLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        notNetLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        notNetLabel.textAlignment = .center
        view.addSubview(notNetLabel)
        
        notNetLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(noNetImage.snp.bottom).offset(-scale(22))
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
        }
        
        //重新加载按键
        let reloadBtn = UIButton()
        reloadBtn.setTitle("刷新", for: .normal)
        reloadBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        reloadBtn.setBackgroundImage(UIImage(named: "Rectangle 26"), for: .normal)
        reloadBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        view.addSubview(reloadBtn)
        reloadBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(noNetImage.snp.bottom).offset(scale(38))
            make.height.equalTo(scale(42))
            make.width.equalTo(scale(152))
        }
        reloadBtn.addTarget(self, action: #selector(reloadNetAction), for: .touchUpInside)
    }

    
    
    @objc func reloadNetAction(reloadBtn:UIButton){
        let network = NetworkReachabilityManager()
//        return network?.isReachable ?? true // 无返回就默认网络已连接
        if network?.isReachable == true{
            Coordinator.shared?.popViewController(self, false)
        }else{
            JFPopup.toast(hit: "网络异常，请检查网络连接")
        }
    }
}
