//
//  OrderViewController.swift
//  App
//
//  Created by mac on 2022/5/1.
//

import UIKit
import Util

class OrderViewController: BaseViewController {

    //订单按键
    lazy var orderBtn:UIButton = {
       let orderBtn = UIButton()
        orderBtn.setTitle("订单", for: .normal)
        orderBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"), for: .normal)
        orderBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .selected)
        orderBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(18), weight: .medium)
        orderBtn.isSelected = true
        orderBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F5F6F6")
        return orderBtn
    }()
    
    //售后按键
    lazy var afterSalesBtn:UIButton = {
       let afterSalesBtn = UIButton()
        afterSalesBtn.setTitle("售后", for: .normal)
        afterSalesBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"), for: .normal)
        afterSalesBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .selected)
        afterSalesBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        afterSalesBtn.isSelected = false
        
        return afterSalesBtn
    }()
    
    //这边设置一个uiscrollview
    lazy var contentScrollView:UIScrollView = {
       let contentScrollView = UIScrollView()
        contentScrollView.contentSize = CGSize(width: 2 * SCW, height: 0)
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.isPagingEnabled = true
        contentScrollView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        contentScrollView.bounces = false
        contentScrollView.delegate = self
        return contentScrollView
    }()
    
    //订单的内容
    lazy var orderContentVc:OrderContentViewController = {
       let orderContentVc = OrderContentViewController()
        orderContentVc.orderViewVc = self
        orderContentVc.selectIndex = selectIndex
        return orderContentVc
    }()
    
    //售后的内容
    lazy var afterSalesVc:AfterSalesViewController = {
       let afterSalesVc = AfterSalesViewController()
        afterSalesVc.selectIndex = selectIndex
        afterSalesVc.orderViewVc = self
        return afterSalesVc
    }()
    
    
    //选择是订单还是售后
    var btnAction:Int = 0
    //选择那个分类
    var selectIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //添加导航视图
        let navigationTitleView = UIView()
        navigationTitleView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        navigationItem.titleView = navigationTitleView
//        navigationItem.titleView?.addSubview(navigationTitleView)
        
        navigationTitleView.snp.makeConstraints { make in
            make.center.equalTo(navigationItem.titleView!)
            make.width.equalTo(scale(124))
            make.height.equalTo(scale(32))
        }
        
        navigationTitleView.addSubview(orderBtn)
        navigationTitleView.addSubview(afterSalesBtn)
        
        
        orderBtn.snp.makeConstraints { make in
            make.left.bottom.top.equalToSuperview()
            make.width.equalTo(scale(62))
        }
        afterSalesBtn.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(orderBtn.snp.right)
        }
        orderBtn.layer.cornerRadius = scale(4)
        afterSalesBtn.layer.cornerRadius = scale(4)
        
        view.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        orderBtn.tag = 0
        afterSalesBtn.tag = 1
        orderBtn.addTarget(self, action: #selector(showContentAction), for: .touchUpInside)
        afterSalesBtn.addTarget(self, action: #selector(showContentAction), for: .touchUpInside)
        
        
        contentScrollView.addSubview(orderContentVc.view)
        orderContentVc.view.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.height.equalTo(SCH - Height_NavBar)
            make.width.equalTo(SCW)
        }
        
        contentScrollView.addSubview(afterSalesVc.view)
        afterSalesVc.view.snp.makeConstraints { make in
            make.left.equalTo(orderContentVc.view.snp.right)
            make.top.equalToSuperview()
            make.height.equalTo(SCH - Height_NavBar)
            make.width.equalTo(SCW)
        }
        
        //添加导航栏右边按键
        createRightBarBtnItem(icon: UIImage(named: "Frame-search")!, method: #selector(orderSearchAction))
        
        
        //这边判断是执行那个按键
        
        if btnAction == 0{
            showContentAction(btn: orderBtn)
        }else{
            showContentAction(btn: afterSalesBtn)
        }
        
        //还是要真机测试，往右滑和uiscrollview失效的问题
        let gestureArr = navigationController?.view.gestureRecognizers
        for i in 0..<(gestureArr?.count ?? 0) {
            let gestureRecognizer = gestureArr![i]
            if gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self){
                contentScrollView.panGestureRecognizer.require(toFail: gestureRecognizer)
            }
        }
    }
    
    //搜索
    @objc func orderSearchAction(){
        let orderSearchVc = OrderSearchViewController()
        Coordinator.shared?.pushViewController(self, orderSearchVc, animated: true)
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        contentScrollView.contentSize = CGSize(width: 2 * SCW, height: 0)
    }

    
    @objc func showContentAction(btn:UIButton){
        LXFLog(btn.tag)
        if btn.tag == 0 {
            orderBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F5F6F6")
            orderBtn.isSelected = true
            orderBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(18), weight: .medium)
            afterSalesBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            afterSalesBtn.isSelected = false
            afterSalesBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        }else{
            afterSalesBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F5F6F6")
            afterSalesBtn.isSelected = true
            orderBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            orderBtn.isSelected = false
            afterSalesBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(18), weight: .medium)
            orderBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        }
        contentScrollView.contentOffset = CGPoint(x: btn.tag * Int(SCW), y: 0)
    }
}


extension OrderViewController:UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        LXFLog(scrollView.contentOffset.x)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let radit = scrollView.contentOffset.x / scrollView.width
        scrollView.contentOffset = CGPoint(x: radit * SCW , y: 0)
        LXFLog(radit)
        if Int(radit) == orderBtn.tag{
            orderBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F5F6F6")
            orderBtn.isSelected = true
            orderBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(18), weight: .medium)
            afterSalesBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            afterSalesBtn.isSelected = false
            afterSalesBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        }else{
            afterSalesBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F5F6F6")
            afterSalesBtn.isSelected = true
            orderBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            orderBtn.isSelected = false
            afterSalesBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(18), weight: .medium)
            orderBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        }
    }
}
