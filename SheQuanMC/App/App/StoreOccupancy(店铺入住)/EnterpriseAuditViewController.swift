//
//  EnterpriseAuditViewController.swift
//  App
//
//  Created by mac on 2022/4/27.
//

import UIKit
import Util
import JFPopup

public class EnterpriseAuditViewController: BaseViewController {

    // 这边有俩种状态
    //审核中
    //审核失败
    
    lazy var auditImageView:UIImageView = {
       let auditImageView = UIImageView()
        return auditImageView
    }()
    
    lazy var auditLabel:UILabel = {
       let auditLabel = UILabel()
        auditLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        auditLabel.font = UIFont.systemFont(ofSize: scale(20), weight: .regular)
        auditLabel.textAlignment = .center
        return auditLabel
    }()
    
    
    
    //0为没有的状态 审核中为1 审核失败为2
  public var audit:Int = 0
    
    //失败的原因
    lazy var failView:UIView = {
       let failView = UIView()
        failView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F6F6F6")
        return failView
    }()
    
    
    lazy var failLabel:UILabel = {
       let failLabel = UILabel()
        failLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        failLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return failLabel
    }()
    
    //失败之后修改资料
    lazy var modifyDataBtn:UIButton = {
       let modifyDataBtn = UIButton()
        modifyDataBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        modifyDataBtn.setTitle("修改资料", for: .normal)
        modifyDataBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        modifyDataBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return modifyDataBtn
    }()
    
    
    //禁止某些页面滑动返回上一个页面
//    public override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        UIApplication.shared.isIdleTimerDisabled = true
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
//    }
    
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        self.navigationItem.leftBarButtonItem?.customView?.isHidden = true
        self.navigationItem.leftBarButtonItem?.customView = UIButton(setImage: "返回", setBackgroundImage: "", target: self, action: #selector(exitLoginStatus))
        
        
        view.addSubview(auditImageView)
        auditImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(scale(91))
            make.width.equalTo(scale(189))
            make.height.equalTo(scale(168))
        }
        
        auditImageView.addSubview(auditLabel)
        auditLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(scale(28))
        }
        
        if self.audit == 1 || self.audit == 0{
            auditImageView.image = UIImage(named: "Group 2685")
            auditLabel.text = "审核中..."
//            if self.audit == 1{
//                self.navigationItem.leftBarButtonItem?.customView?.isHidden = true
//                self.navigationItem.leftBarButtonItem?.customView = UIButton(setImage: "返回", setBackgroundImage: "", target: self, action: #selector(exitLoginStatus))
//            }
        }else{
//            self.navigationItem.leftBarButtonItem?.customView?.isHidden = true
//            self.navigationItem.leftBarButtonItem?.customView = UIButton(setImage: "返回", setBackgroundImage: "", target: self, action: #selector(exitLoginStatus))
            auditImageView.image = UIImage(named: "Group 2685")
            auditLabel.text = "审核失败"
//            failLabel.text = "失败原因，失败原因，失败原因"
            if (StoreService.shared.currentUser?.rejectReason.count ?? 0) > 0{
                failLabel.text = StoreService.shared.currentUser?.rejectReason
            }else{
                failLabel.text = "失败原因"
            }
            view.addSubview(failView)
            failView.snp.makeConstraints { make in
                make.left.equalTo(scale(28))
                make.right.equalTo(-scale(28))
                make.top.equalTo(auditImageView.snp.bottom).offset(scale(31))
                make.height.equalTo(0)
            }
            
            
          let heigt = failLabel.text!.rectHeight(font: UIFont.systemFont(ofSize: scale(14), weight: .regular), size: CGSize(width: SCW - scale(100), height: CGFloat(MAXFLOAT)))
            failView.addSubview(failLabel)
            
            failLabel.snp.makeConstraints { make in
                make.left.equalTo(scale(24))
                make.right.equalTo(-scale(28))
                make.top.equalTo(scale(23))
                make.height.equalTo(heigt)
            }
            
            
            failView.snp.remakeConstraints { make in
                make.left.equalTo(scale(28))
                make.right.equalTo(-scale(28))
                make.top.equalTo(auditImageView.snp.bottom).offset(scale(31))
                make.height.equalTo(heigt + scale(43))
            }
            
            
            failView.layer.cornerRadius = scale(4)
            view.addSubview(modifyDataBtn)
            
            
            modifyDataBtn.snp.makeConstraints { make in
                make.left.equalTo(scale(28))
                make.right.equalTo(-scale(28))
                make.top.equalTo(failView.snp.bottom).offset(scale(30))
                make.height.equalTo(scale(40))
            }
            modifyDataBtn.layer.cornerRadius = scale(4)
            
            modifyDataBtn.addTarget(self, action: #selector(modifyDataAction), for: .touchUpInside)
        }
    }
    
    
    //退出登录状态
    @objc func exitLoginStatus(){
        JFPopup.alert {
            [
                .title("确定要退出吗？"),
                .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
//                .subTitle("注:取消商品将移至未上架"),
//                .subTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999")),
                .withoutAnimation(true),
                .cancelAction([
                    .text("取消"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999")),
                    .tapActionCallback({
//                        Coordinator.shared?.popViewController(self, true)
                    })
                ]),
                .confirmAction([
                    .text("确定"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .tapActionCallback({
                        //删除店铺信息
                        StoreService.shared.delete()
                //        Coordinator.shared?.popRootViewController(self)
                        //重新变成登录登记
                        let startPageVc = StartPageViewController()
                        let windwin = UIApplication.shared.keyWindow
                        windwin?.rootViewController = BaseNaviViewController(rootViewController: startPageVc)
                    })
                ])
            ]
        }
    }

    //修改资料
    @objc func modifyDataAction(modifyDataBtn:UIButton){
        let storeOcVc = StoreOccupancyViewController()
        storeOcVc.audit = 1
        Coordinator.shared?.pushViewController(self, storeOcVc, animated: true)
        let mutableArr = NSMutableArray(array:navigationController?.viewControllers ?? [])
        for i in 0..<mutableArr.count {
            let vc = mutableArr[i] as! UIViewController
            if vc.isKind(of: EnterpriseAuditViewController.self){
                mutableArr.removeObject(at: i)
                break
            }
        }
        navigationController?.viewControllers = mutableArr as! [UIViewController]
    }
    
   //禁止某些页面滑动返回上一个页面
//   public override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        UIApplication.shared.isIdleTimerDisabled = false
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
//    }
    
}
