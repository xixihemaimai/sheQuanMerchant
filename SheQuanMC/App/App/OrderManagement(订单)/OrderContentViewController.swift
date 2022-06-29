//
//  OrderContentViewController.swift
//  App
//
//  Created by mac on 2022/5/1.
//

import UIKit
import Util

class OrderContentViewController: BaseViewController {

    //头部UIScrollview
    lazy var titleScrollView:UIScrollView = {
       let titleScrollview = UIScrollView()
        titleScrollview.showsHorizontalScrollIndicator = false
        titleScrollview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        titleScrollview.delegate = self
        return titleScrollview
    }()
    
    //内容uiscrollview
    lazy var contentScrollView:UIScrollView = {
       let contentScrollView = UIScrollView()
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        contentScrollView.delegate = self
        contentScrollView.isPagingEnabled = true
        contentScrollView.bounces = true
        return contentScrollView
    }()
    
    var titleView:UIView!
    
    var perBtn:UIButton?
    
    var btnArray:[UIButton] = [UIButton]()
    //用来保存订单首页的控制权
    var orderViewVc:OrderViewController?
    
    var titleArray:[String] = [String]()
    
    var selectIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(changeOrderCount), name: NSNotification.Name("changeOrderCount"), object: nil)
        
        //创建头部的uiscrollview
        addTitleScrollview()
        //创建内容的UISrollview
        addContentScrollview()
        
        NetWorkResultRequest(OrderApi.getProductOrderCount, needShowFailAlert: true) {[weak self] result, data in
           //这边获取订单数
            guard let model = try? JSONDecoder().decode(GenericResponse<[ProductOrderCountModel]>.self, from: data) else { return }
            self?.titleArray.removeAll()
            if let _data = model.data{
                for i in 0..<_data.count{
                    let productOrderCountModel = _data[i]
                    if i == 0{
                        //全部
                        self?.titleArray.append("全部" + "(" + String(productOrderCountModel.orderCount ?? 0) + ")")
                    }else if i == 1{
                        //待支付
                        self?.titleArray.append("待支付" + "(" + String(productOrderCountModel.orderCount ?? 0) + ")")
                    }else if i == 2{
                        //待发货
                        self?.titleArray.append("待发货" + "(" + String(productOrderCountModel.orderCount ?? 0) + ")")
                    }else if i == 3{
                        //已发货
                        self?.titleArray.append("已发货" + "(" + String(productOrderCountModel.orderCount ?? 0) + ")")
                    }else if i == 4{
                        //交易成功
                        self?.titleArray.append("交易成功" + "(" + String(productOrderCountModel.orderCount ?? 0) + ")")
                    }else{
                        //交易关闭
                        self?.titleArray.append("交易关闭" + "(" + String(productOrderCountModel.orderCount ?? 0) + ")")
                    }
                }
                //创建头部的uiscrollview的标题按键
                self?.addTitleArrayBtn()
                //创建头部uiscrollview的标题按键的下划线
                self?.adddUnlineView()
                //创建内容的添加的子控制
                self?.addChildViewController()
                //创建UIScrollview的代理
                //执行第一个
                let btn = self?.btnArray[self?.selectIndex ?? 0]
                self?.showTitleAction(btn: btn!)
            }
        } failureCallback: { error, code in
            code.loginOut()
        }
    }
    
    
    //创建头部的UIScrollview
    func addTitleScrollview(){
        view.addSubview(titleScrollView)
        titleScrollView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(scale(44))
        }
    }
    
    //创建内容的UIScrollview
    func addContentScrollview(){
        view.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleScrollView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    
    //创建头部的标题按键
    func addTitleArrayBtn(){
//        let titleArray = ["全部","待支付(0)","待发货(0)","已发货(0)","交易成功","交易关闭"]
        let titleWith = scale(90)
        for i in 0..<titleArray.count {
            let btn = UIButton(type: .custom)
            btn.tag = i
            btn.setTitle(titleArray[i], for: .normal)
            btn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#888888"), for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
            btn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .selected)
            btn.addTarget(self, action: #selector(showTitleAction), for: .touchUpInside)
//            btn.frame = CGRect(x: i * titleWith, y: 0, width: titleWith, height: 50)
            titleScrollView.addSubview(btn)
            
            btn.snp.makeConstraints { make in
                make.left.equalTo(CGFloat(i) * titleWith)
                make.top.equalToSuperview()
                make.width.equalTo(titleWith)
                make.height.equalTo(scale(44))
            }
            btnArray.append(btn)
        }
        titleScrollView.contentSize = CGSize(width: CGFloat(titleArray.count) * titleWith, height: 0)
    }
    
    //这边是点击标题的方法
    @objc func showTitleAction(btn:UIButton){
        //这边是要改变下划线的位置，和颜色，字体的变化
//        perBtn.font = UIFont.systemFont(ofSize: 14)
        perBtn?.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        perBtn?.isSelected = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
        btn.isSelected = true
        perBtn = btn
        //让标题按钮居中
        var offsetX = btn.center.x - SCW * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        //计算最大偏移量
        let maxOffsetX = titleScrollView.contentSize.width - SCW
        if offsetX > maxOffsetX{
            offsetX = maxOffsetX
        }
        titleScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        //下滑线的变化
        UIView.animate(withDuration: 0.25) {
            self.titleView?.snp.remakeConstraints({ make in
                make.width.equalTo((btn.titleLabel?.bounds.size.width)!)
                make.centerX.equalTo(btn.snp.centerX)
                make.height.equalTo(scale(2))
                make.bottom.equalTo(btn.snp.bottom).offset(-scale(2))
            })
            self.contentScrollView.contentOffset = CGPoint(x: btn.tag * Int(self.contentScrollView.width), y: 0)
        }
       //添加控制器
        let vc = self.children[btn.tag]
        if (vc.view.superview != nil){
           return
        }
//        vc.view?.frame = contentScrollView.bounds
        vc.view?.frame = CGRect(x: btn.tag * Int(contentScrollView.size.width), y: 0, width: Int(contentScrollView.size.width), height: Int(contentScrollView.size.height))
        contentScrollView.addSubview(vc.view)
    }
    
    
    //添加下划线
    func adddUnlineView(){
        titleView = UIView()
        let btn = btnArray[selectIndex]
        //这边要先获取按键的第一个center.x
        titleView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        titleScrollView.addSubview(titleView!)
        btn.titleLabel?.sizeToFit()
        titleView?.snp.makeConstraints({ make in
            make.width.equalTo((btn.titleLabel?.bounds.size.width)!)
            make.centerX.equalTo(btn.snp.centerX)
            make.height.equalTo(scale(2))
            make.bottom.equalTo(btn.snp.bottom).offset(-scale(2))
        })
    }
    
    
    //添加子控制器
    func addChildViewController(){
        for i in 0..<btnArray.count {
            let vc = OrderStatusViewController()
            vc.orderViewVc = orderViewVc
            let btn = btnArray[i]
            vc.view.tag = btn.tag
            vc.delegate = self
            vc.title = btn.currentTitle
            self.addChild(vc)
//            vc.view?.frame = CGRect(x: i * Int(contentScrollView.size.width), y: 0, width: Int(contentScrollView.size.width), height: Int(contentScrollView.size.height))
//            contentScrollView.addSubview(vc.view)
        }
        let count = self.children.count
        contentScrollView.contentSize = CGSize(width: count * Int(view.bounds.size.width), height: 0)
    }
    
    
    
    //改变订单数
    @objc func changeOrderCount(noti:Notification){
        LXFLog("+=============23========23================================================3=================23=============================")
        NetWorkResultRequest(OrderApi.getProductOrderCount, needShowFailAlert: true) {[weak self] result, data in
           //这边获取订单数
            guard let model = try? JSONDecoder().decode(GenericResponse<[ProductOrderCountModel]>.self, from: data) else { return }
            var titleArray = [String]()
            if let _data = model.data{
                for i in 0..<_data.count{
                    let productOrderCountModel = _data[i]
                    if i == 0{
                        //全部
                        titleArray.append("全部" + "(" + String(productOrderCountModel.orderCount ?? 0) + ")")
                    }else if i == 1{
                        //待支付
                        titleArray.append("待支付" + "(" + String(productOrderCountModel.orderCount ?? 0) + ")")
                    }else if i == 2{
                        //待发货
                        titleArray.append("待发货" + "(" + String(productOrderCountModel.orderCount ?? 0) + ")")
                    }else if i == 3{
                        //已发货
                        titleArray.append("已发货" + "(" + String(productOrderCountModel.orderCount ?? 0) + ")")
                    }else if i == 4{
                        //交易成功
                        titleArray.append("交易成功" + "(" + String(productOrderCountModel.orderCount ?? 0) + ")")
                    }else{
                        //交易关闭
                        titleArray.append("交易关闭" + "(" + String(productOrderCountModel.orderCount ?? 0) + ")")
                    }
                }
                self?.titleArray = titleArray
                self?.btnArray.removeAll()
                for view in self!.titleScrollView.subviews {
                    view.removeFromSuperview()
                }
                for vc in self!.children {
                    vc.removeFromParent()
                }
                for vc in self!.contentScrollView.subviews {
                    vc.removeFromSuperview()
                }
                self?.titleView.removeFromSuperview()
                self?.addTitleArrayBtn()
                self?.adddUnlineView()
                self?.addChildViewController()
                //执行第一个
                let btn = self?.btnArray[self?.selectIndex ?? 0]
                self?.showTitleAction(btn: btn!)
            }
        } failureCallback: { error, code in
            code.loginOut()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension OrderContentViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var ratio = scrollView.contentOffset.x / scrollView.width
        ratio = ratio - CGFloat(perBtn?.tag ?? 0)
        titleView?.centerX = (perBtn?.centerX ?? 0) + ratio * (perBtn?.width ?? 0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let ratio = Int(scrollView.contentOffset.x / scrollView.width)
        selectIndex = ratio
        let btn = btnArray[ratio]
        showTitleAction(btn: btn)
    }
    
}


extension OrderContentViewController:OrderStatusViewControllerDelegate{
    func returnBackNumber(_ titleArray: [String], _ tag: Int) {
        self.titleArray = titleArray
        selectIndex = tag
        btnArray.removeAll()
        for view in titleScrollView.subviews {
            view.removeFromSuperview()
        }
        for vc in children {
            vc.removeFromParent()
        }
        for vc in contentScrollView.subviews {
            vc.removeFromSuperview()
        }
        titleView.removeFromSuperview()
        addTitleArrayBtn()
        adddUnlineView()
        addChildViewController()
        //执行第一个
        let btn = btnArray[selectIndex]
        showTitleAction(btn: btn)
    }
}




