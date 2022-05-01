//
//  OrderStatusViewController.swift
//  App
//
//  Created by mac on 2022/5/1.
//

import UIKit
import Util


protocol OrderStatusViewControllerDelegate:NSObjectProtocol {
    
    /// 返回的数量
    /// - Parameters:
    ///   - title:内容
    ///   - tag: 位置
    func returnBackNumber(_ title:String,_ tag:Int)
}


class OrderStatusViewController: BaseViewController {

    weak var delegate:OrderStatusViewControllerDelegate?
    
    
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
        //"待支付(0)","待发货(0)","已发货(0)"
        if title?.contains("待支付") == true {
            title = "待支付(99+)"
            delegate?.returnBackNumber(title ?? "", view.tag)
        }else if title?.contains("待发货") == true {
            title = "待发货(99+)"
            delegate?.returnBackNumber(title ?? "", view.tag)
        }else if title?.contains("已发货") == true {
            title = "已发货(99+)"
            delegate?.returnBackNumber(title ?? "", view.tag)
        }
        
    }
    
}
