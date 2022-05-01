//
//  AfterSalesStatusViewController.swift
//  App
//
//  Created by mac on 2022/5/1.
//

import UIKit
import Util

protocol AfterSalesStatusViewControllerDelegate:NSObjectProtocol {
    
    /// 返回的数量
    /// - Parameters:
    ///   - title:内容
    ///   - tag: 位置
    func returnBackNumber(_ title:String,_ tag:Int)
}

class AfterSalesStatusViewController: BaseViewController {

    
    weak var delegate:AfterSalesStatusViewControllerDelegate?
    
    lazy var btn:UIButton = {
       let btn = UIButton()
        btn.setTitle("点击", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        btn.addTarget(self, action: #selector(showSS), for: .touchUpInside)
        
    }
    

    @objc func showSS(){
        if title?.contains("待处理") == true{
            title = "待处理(99+)"
            delegate?.returnBackNumber(title ?? "", view.tag)
        }else if title?.contains("待收货") == true{
            title = "待收货(99+)"
            delegate?.returnBackNumber(title ?? "", view.tag)
        }else if title?.contains("平台介入中") == true{
            title = "平台介入中(99+)"
            delegate?.returnBackNumber(title ?? "", view.tag)
        }
    }
}
