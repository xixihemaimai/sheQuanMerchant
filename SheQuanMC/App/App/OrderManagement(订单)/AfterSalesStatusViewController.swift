//
//  AfterSalesStatusViewController.swift
//  App
//
//  Created by mac on 2022/5/1.
//

import UIKit
import Util

//protocol AfterSalesStatusViewControllerDelegate:NSObjectProtocol {
//
//    /// 返回的数量
//    /// - Parameters:
//    ///   - title:内容
//    ///   - tag: 位置
//    func returnBackNumber(_ title:String,_ tag:Int)
//}

class AfterSalesStatusViewController: BaseViewController {

    
    
    //用来保存订单首页的控制权
    var orderViewVc:OrderViewController?
    
//    weak var delegate:AfterSalesStatusViewControllerDelegate?
    
//    lazy var btn:UIButton = {
//       let btn = UIButton()
//        btn.setTitle("点击", for: .normal)
//        btn.setTitleColor(UIColor.red, for: .normal)
//        return btn
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.addSubview(btn)
//        btn.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.width.height.equalTo(100)
//        }
//        btn.addTarget(self, action: #selector(showSS), for: .touchUpInside)

        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.top.bottom.right.equalToSuperview()
        }
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(AfterSalesCell.self, forCellReuseIdentifier: "AfterSalesCell")
        
//        tableview.mj_header?.beginRefreshing()
        tableview.reloadData()
        
        
    }
    

//    @objc func showSS(){
//        if title?.contains("待处理") == true{
//            title = "待处理(99+)"
//            delegate?.returnBackNumber(title ?? "", view.tag)
//        }else if title?.contains("待收货") == true{
//            title = "待收货(99+)"
//            delegate?.returnBackNumber(title ?? "", view.tag)
//        }else if title?.contains("平台介入中") == true{
//            title = "平台介入中(99+)"
//            delegate?.returnBackNumber(title ?? "", view.tag)
//        }
//    }
    
    
    
    //去处理
    @objc func handleAction(handleBtn:UIButton){
        let afterSalesDetailVc = AfterSalesDetailViewController()
        Coordinator.shared?.pushViewController(self.orderViewVc ?? self, afterSalesDetailVc, animated: true)
    }
    
    
    
}


extension AfterSalesStatusViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AfterSalesCell") as! AfterSalesCell
        cell.handleBtn.tag = indexPath.row
        cell.handleBtn.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let afterSalesDetailVc = AfterSalesDetailViewController()
        Coordinator.shared?.pushViewController(self.orderViewVc ?? self, afterSalesDetailVc, animated: true)
    }
    
    
}
