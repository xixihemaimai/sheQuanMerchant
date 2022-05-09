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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建头部的uiscrollview
        addTitleScrollview()
        //创建内容的UISrollview
        addContentScrollview()
        //创建头部的uiscrollview的标题按键
        addTitleArrayBtn()
        //创建头部uiscrollview的标题按键的下划线
        adddUnlineView()
        //创建内容的添加的子控制
        addChildViewController()
        //创建UIScrollview的代理
        //执行第一个
        let btn = btnArray[0]
        showTitleAction(btn: btn)
        
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
        let titleArray = ["全部","待支付(0)","待发货(0)","已发货(0)","交易成功","交易关闭"]
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
        vc.view?.frame = contentScrollView.bounds
        contentScrollView.addSubview(vc.view)
    }
    
    
    //添加下划线
    func adddUnlineView(){
        titleView = UIView()
        let btn = btnArray[0]
        //这边要先获取按键的第一个center.x
//        titleView.width = (btn.titleLabel?.bounds.size.width)!
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
            vc.view.tag = i
            self.addChild(vc)
            vc.delegate = self
            vc.title = btn.currentTitle
        }
        let count = self.children.count
        contentScrollView.contentSize = CGSize(width: count * Int(view.bounds.size.width), height: 0)
    }
}

extension OrderContentViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let ratio = Int(scrollView.contentOffset.x / scrollView.width)
//        let btn = btnArray[ratio]
//        titleView.centerX = btn.centerX
        
        
        //这边是对渐变的处理
        
        //获取到左边的按钮和右边的按钮
        //计算出这俩个按钮的缩放比例
        
        //首先获取左边的标题按钮
//        let leftIndex = Int(scrollView.contentOffset.x / scrollView.width)
//        let rightIndex = leftIndex + 1
//        let leftBtn = btnArray[leftIndex]
//        var rightBtn = UIButton()
//        if rightIndex < btnArray.count{
//            rightBtn = btnArray[rightIndex]
//        }
//        var rightRatio = Int(scrollView.contentOffset.x / scrollView.width)
//        rightRatio -= leftIndex
        
//        let leftRatio = 1 - rightRatio
        
//        leftBtn.transform = CGAffineTransform(scaleX:  1 + 0.3 * CGFloat(leftRatio), y: 1 + 0.3 * CGFloat(leftRatio))
//        rightBtn.transform = CGAffineTransform(scaleX: 1 + 0.3 * CGFloat(rightRatio), y: 1 + 0.3 * CGFloat(rightRatio))

        /*
         文字颜色的渐变
         颜色的三通道 r g b:红色通道，绿色通道，蓝色通道(24真彩色)
         每个颜色通道8位二进制来标题 -> 十进制(0-255)256种
         在oc中的取值(0~1)
         常见颜色表示
         r g b
         0 0 0 （黑色）
         1 1 1 （白色）
         1 0 0  (红色)
         0 1 0 （绿色）
         0 0 1 （蓝色）
         */
//        leftBtn.setTitleColor(UIColor.init(CGFloat(leftRatio), 0, 0), for: .normal)
//        rightBtn.setTitleColor(UIColor.init(CGFloat(rightRatio), 0, 0), for: .normal)
        
        var ratio = scrollView.contentOffset.x / scrollView.width
        ratio = ratio - CGFloat(perBtn?.tag ?? 0)
        titleView?.centerX = (perBtn?.centerX ?? 0) + ratio * (perBtn?.width ?? 0)
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let ratio = Int(scrollView.contentOffset.x / scrollView.width)
        LXFLog("-----323232---------\(ratio)")
        let btn = btnArray[ratio]
        showTitleAction(btn: btn)
    }
    
}


extension OrderContentViewController:OrderStatusViewControllerDelegate{
    func returnBackNumber(_ title: String, _ tag: Int) {
        LXFLog("===============")
        let btn = btnArray[tag]
        //这边要变成那个状态的数量和下划线的宽度
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.sizeToFit()
        titleView.snp.remakeConstraints { make in
            make.width.equalTo((btn.titleLabel?.bounds.size.width)!)
            make.centerX.equalTo(btn.snp.centerX)
            make.height.equalTo(scale(2))
            make.bottom.equalTo(btn.snp.bottom).offset(-scale(2))
        }
    }
}




