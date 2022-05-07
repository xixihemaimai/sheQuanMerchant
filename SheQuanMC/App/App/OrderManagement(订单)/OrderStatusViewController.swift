//
//  OrderStatusViewController.swift
//  App
//
//  Created by mac on 2022/5/1.
//

import UIKit
import Util
import JFPopup


protocol OrderStatusViewControllerDelegate:NSObjectProtocol {
    
    /// 返回的数量
    /// - Parameters:
    ///   - title:内容
    ///   - tag: 位置
    func returnBackNumber(_ title:String,_ tag:Int)
}


class OrderStatusViewController: BaseViewController {

    weak var delegate:OrderStatusViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableview)
        
        tableview.snp.makeConstraints { make in
            make.left.top.bottom.right.equalToSuperview()
        }
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(OrderStatusCell.self, forCellReuseIdentifier: "OrderStatusCell")
        
       
        
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
    
    
    
    //关闭订单按键
    @objc func closeOrderAction(closeOrderBtn:UIButton){
        // 这边要自定义一个UIview
        self.popup.bottomSheet {
            let closeOrderReasonView = CloseOrderReasonView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(489)))
            closeOrderReasonView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            return closeOrderReasonView
        }
    }
    
    //改价按键
    @objc func modifyPriceAction(modifyPriceBtn:UIButton){
        //这边也要自定义一个UIview
        self.popup.bottomSheet {
            let modifyPriceView = ModifyPriceView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(492)))
            modifyPriceView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            return modifyPriceView
        }
    }
}



extension OrderStatusViewController:UITableViewDelegate,UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderStatusCell") as! OrderStatusCell
        if view.tag == 0{
            let index = Int(arc4random_uniform(5))
            let array = ["全部","待支付","待发货","已发货","交易成功","交易失败"]
            let string = array[index]
            cell.contentString = string
        }else if view.tag == 1{
            cell.contentString = "待支付"
        }else if view.tag == 2{
            cell.contentString = "待发货"
        }else if view.tag == 3{
            cell.contentString = "已发货"
        }else if view.tag == 4{
            cell.contentString = "交易成功"
        }else{
            cell.contentString = "交易失败"
        }
        
        //关闭订单按键
        cell.closeOrderBtn.tag = indexPath.row
        cell.closeOrderBtn.addTarget(self, action: #selector(closeOrderAction), for: .touchUpInside)
        //改价按键
        cell.modifyPriceBtn.tag = indexPath.row
        cell.modifyPriceBtn.addTarget(self, action: #selector(modifyPriceAction), for: .touchUpInside)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    
}
