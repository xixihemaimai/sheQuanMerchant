//
//  CommodityManagementViewController.swift
//  App
//
//  Created by mac on 2022/4/28.
//

import UIKit
import Util

class CommodityManagementViewController: BaseViewController {

    lazy var searchBar:UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "搜索商品名称"
        searchBar.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
//        searchBar.delegate = self
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        }
        searchBar.barStyle = .default
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = UIColor.clear
        return searchBar
    }()
    
    
    lazy var titleView:UIView = {
       let titleView = UIView()
        titleView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return titleView
    }()
    
    lazy var contentScrollerView:UIScrollView = {
       let contentScrollerView = UIScrollView()
//        contentScrollerView.backgroundColor = UIColor.red
        contentScrollerView.isPagingEnabled = true
        contentScrollerView.showsHorizontalScrollIndicator = false
        contentScrollerView.bounces = false
        contentScrollerView.delegate = self
        contentScrollerView.panGestureRecognizer.require(toFail: (self.navigationController?.interactivePopGestureRecognizer)!)
       return contentScrollerView
    }()

    
    var titleBtnArray:[UIButton] = [UIButton]()
    
    var preBtn:UIButton?
    
    var lineView:UIView?
    
    
    //底部增加一个发布按键
    lazy var publishBtn:UIButton = {
       let publishBtn = UIButton()
        publishBtn.setTitle("发布商品", for: .normal)
        publishBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF"), for: .normal)
        publishBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        publishBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        return publishBtn
    }()
    
    
    //增加一个UIView
    lazy var bottomView:UIView = {
       let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return bottomView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "商品管理"
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(scale(48))
        }
        searchBar.layer.cornerRadius = scale(4)
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.addTarget(self, action: #selector(BeginEdit), for: .editingDidBegin)
        }
        
        searchBar.setPositionAdjustment(UIOffset(horizontal: SCW/2 - scale(120)/2, vertical: 0), for: .search)
        
        view.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
            make.height.equalTo(scale(44))
        }
        
        
        view.addSubview(contentScrollerView)
        contentScrollerView.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(scale(1))
            make.width.equalTo(SCW)
        }
        
        
        addTitleView()
    
        addSubViewController()
        
        let btn = titleBtnArray[0]
        titleBtnClick(btn: btn)
        
        
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
//            make.height.equalTo(Height_TabBar)
            make.height.equalTo(iPhoneX ? scale(92) : scale(58))
        }
        
        bottomView.addSubview(publishBtn)
        publishBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
//            make.top.equalTo(iPhoneX ? scale(14) : scale(2.5))
            make.bottom.equalTo(iPhoneX ? -scale(14) : -scale(10))
        }
        publishBtn.layer.cornerRadius = scale(4)
        publishBtn.addTarget(self, action: #selector(publishAction), for: .touchUpInside)
        
    }
    
    
    //发布
    @objc func publishAction(publishBtn:UIButton){
        let releaseGoodsVc = ReleaseGoodsViewController()
        releaseGoodsVc.type = 0
        Coordinator.shared?.pushViewController(self, releaseGoodsVc, animated: true)
    }
    
    
    
    @objc func BeginEdit(textfiled:UITextField){
//        searchBar.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .search)
        let commoditySearchVc = CommoditySearchViewController()
        commoditySearchVc.title = preBtn?.currentTitle
        Coordinator.shared?.pushViewController(self, commoditySearchVc, animated: true)
        searchBar.resignFirstResponder()
    }

    //添加标题view
    func addTitleView(){
        addTitleBtn()
        addUnLineView()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentScrollerView.contentSize = CGSize(width:self.children.count * Int(contentScrollerView.width) , height: 0)
    }
    

    //添加多个子控制器
    func addSubViewController(){
        let view1 = CommodityStatusViewController()
        view1.title = "上架中"
        self.addChild(view1)
        let view2 = CommodityStatusViewController()
        self.addChild(view2)
        view2.title = "已售罄"
        let view3 = CommodityStatusViewController()
        self.addChild(view3)
        view3.title = "未上架"
        let view4 = CommodityStatusViewController()
        self.addChild(view4)
        view4.title = "审核中"
        let count = self.children.count
        contentScrollerView.contentSize = CGSize(width:count * Int(contentScrollerView.width) , height: 0)
    }

    //添加标题view里面的按键
    func addTitleBtn(){
        let titles = ["上架中","已售罄","未上架","审核中"]
        let btnW = SCW/4
        let btnH = scale(44)
        for i in 0..<titles.count {
            let titleBtn = UIButton()
            titleView.addSubview(titleBtn)
            titleBtn.snp.makeConstraints { make in
                make.top.equalTo(0)
                make.height.equalTo(btnH)
                make.left.equalTo(CGFloat(i) * btnW)
                make.width.equalTo(btnW)
            }
            titleBtn.tag = i
            titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
            titleBtn.setTitle(titles[i], for: .normal)
            titleBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#888888"), for: .normal)
            titleBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .selected)
            titleBtnArray.append(titleBtn)
            titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
        }
    }

    //添加下划线
    func addUnLineView(){
        let titleBtn = self.titleBtnArray[0]
        lineView = UIView()
        lineView?.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        titleView.addSubview(lineView!)
        lineView?.snp.makeConstraints({ make in
            make.bottom.equalTo(-scale(2))
            make.width.equalTo(scale(30))
            make.centerX.equalTo(titleBtn.snp.centerX)
            make.height.equalTo(scale(2))
        })
    }


    @objc func titleBtnClick(btn:UIButton){
        preBtn?.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        preBtn?.isSelected = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
        btn.isSelected = true
        preBtn = btn
        let tag = btn.tag
        preBtn?.tag = tag
        UIView.animate(withDuration: 0.25) {
            self.lineView?.snp.remakeConstraints({ make in
                make.bottom.equalTo(-scale(2))
                make.width.equalTo(scale(30))
                make.centerX.equalTo(btn.snp.centerX)
                make.height.equalTo(scale(2))
            })
            self.contentScrollerView.contentOffset = CGPoint(x: tag * Int(self.contentScrollerView.width), y: 0)
        }
        let vc = self.children[tag]
        if (vc.view.superview != nil){
            return
        }
        vc.view?.frame = contentScrollerView.bounds
        contentScrollerView.addSubview(vc.view)
    }
}


extension CommodityManagementViewController:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.width
        let titleBtn = titleBtnArray[Int(index)]
        titleBtnClick(btn: titleBtn)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var ratio = scrollView.contentOffset.x / scrollView.width
        ratio = ratio - CGFloat(preBtn?.tag ?? 0)
        lineView?.centerX = (preBtn?.centerX ?? 0) + ratio * (preBtn?.width ?? 0)
    }
}

