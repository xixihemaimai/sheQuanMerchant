//
//  ShopViewController.swift
//  App
//
//  Created by mac on 2022/4/24.
//

import UIKit
import Util
import SnapKit
import SDWebImage
import SwiftyJSON
import JFPopup

class ShopViewController: BaseViewController {
    
    //大背景图片
    lazy var shopBackImageView:UIImageView = {
       let shopBackImageView = UIImageView()
        shopBackImageView.image = UIImage(named: "Mask Group")
        return shopBackImageView
    }()

    //这面添加一个可以点击的UIButton界面包含店铺头像和店铺名称，方向图片
    lazy var shopBtn:UIButton = {
       let shopBtn = UIButton()
        shopBtn.backgroundColor = UIColor.clear
        return shopBtn
    }()
    
    
    //店铺头像
    lazy var shopHeaderImageView:UIImageView = {
       let shopHeaderImageView = UIImageView()
        return shopHeaderImageView
    }()

    //店铺名称
    lazy var shopNameLabel:UILabel = {
       let shopNameLabel = UILabel()
        shopNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        shopNameLabel.font = UIFont.systemFont(ofSize: scale(18), weight: .semibold)
        shopNameLabel.textAlignment = .left
        return shopNameLabel
    }()
    
    //方向图片
    lazy var rightImage:UIImageView = {
       let rightImage = UIImageView()
        rightImage.image = UIImage(named: "Rectangle 28")
        return rightImage
    }()
    
    
    
    //待发货订单
    lazy var shippedLabel:UILabel = {
       let shippedLabel = UILabel()
        shippedLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#1A1A1A")
        shippedLabel.text = "0"
        shippedLabel.textAlignment = .center
        shippedLabel.font = UIFont.systemFont(ofSize: scale(18), weight: .semibold)
        return shippedLabel
    }()
    
    
    //待支付订单
    lazy var paidLabel:UILabel = {
       let paidLabel = UILabel()
        paidLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#1A1A1A")
        paidLabel.textAlignment = .center
        paidLabel.font = UIFont.systemFont(ofSize: scale(18), weight: .semibold)
        paidLabel.text = "0"
        return paidLabel
    }()
    
    //退款/售后Refund
    lazy var refundLabel:UILabel = {
       let refundLabel = UILabel()
        refundLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#1A1A1A")
        refundLabel.textAlignment = .center
        refundLabel.font = UIFont.systemFont(ofSize: scale(18), weight: .semibold)
        refundLabel.text = "0"
        return refundLabel
    }()
    //支付订单数 paymentOrders
    lazy var paymentOrdersLabel:UILabel = {
       let paymentOrdersLabel = UILabel()
        paymentOrdersLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#000000")
        paymentOrdersLabel.textAlignment = .center
        paymentOrdersLabel.font = UIFont.systemFont(ofSize: scale(22), weight: .semibold)
        paymentOrdersLabel.text = "0"
        return paymentOrdersLabel
    }()
    
    //支付金额  paymentAmount
    lazy var paymentAmountLabel:UILabel = {
       let paymentAmountLabel = UILabel()
        paymentAmountLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#000000")
        paymentAmountLabel.textAlignment = .center
        paymentAmountLabel.font = UIFont.systemFont(ofSize: scale(22), weight: .semibold)
        paymentAmountLabel.text = "0"
        return paymentAmountLabel
    }()
    
    //退款订单数 refundOrders
    lazy var refundOrdersLabel:UILabel = {
       let refundOrdersLabel = UILabel()
        refundOrdersLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#000000")
        refundOrdersLabel.textAlignment = .center
        refundOrdersLabel.font = UIFont.systemFont(ofSize: scale(22), weight: .semibold)
        refundOrdersLabel.text = "0"
        return refundOrdersLabel
    }()
    
    //退款金额refundAmount
    lazy var refundAmountLabel:UILabel = {
       let refundAmountLabel = UILabel()
        refundAmountLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F13232")
        refundAmountLabel.textAlignment = .center
        refundAmountLabel.font = UIFont.systemFont(ofSize: scale(22), weight: .semibold)
        refundAmountLabel.text = "¥0"
        return refundAmountLabel
    }()
    
    
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
  
        
        view.addSubview(shopBackImageView)
        shopBackImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(scale(414))
        }
        
        view.addSubview(shopBtn)
        shopBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(48))
            make.height.equalTo(scale(52))
        }
        
        shopBtn.addSubview(shopHeaderImageView)
        shopBtn.addSubview(shopNameLabel)
        shopBtn.addSubview(rightImage)
        shopBtn.addTarget(self, action: #selector(jumpShopDetailAction), for: .touchUpInside)
        
        shopHeaderImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(14))
            make.width.height.equalTo(scale(44))
        }
//        shopHeaderImageView.image = UIImage(named: "Rectangle 2363")
//        shopHeaderImageView.kf.setImage(with: URL(string: StoreService.shared.currentUser?.shopAvatar ?? ""))
//        shopHeaderImageView.kf.setImage(with: URL(string: StoreService.shared.currentUser?.shopAvatar ?? ""), placeholder: UIImage(named: "Group 2784"), options: nil, completionHandler: nil)
        
        
        shopHeaderImageView.sd_setImage(with: URL(string: StoreService.shared.currentUser?.shopAvatar ?? ""), placeholderImage: UIImage(named: "Group 2784"))
        
        shopHeaderImageView.layer.cornerRadius = scale(44) * 0.5
        shopHeaderImageView.layer.masksToBounds = true
//        shopNameLabel.text = "NIKE旗舰店"
        
        
        shopNameLabel.text = StoreService.shared.currentUser?.shopName
        let width = (StoreService.shared.currentUser?.shopName.rectWidth(font: UIFont.systemFont(ofSize: scale(18), weight: .semibold), size: CGSize(width: SCW - scale(86), height: scale(44))) ?? 0) + scale(10)
        
        shopNameLabel.snp.makeConstraints { make in
            make.left.equalTo(shopHeaderImageView.snp.right).offset(scale(6))
            make.centerY.equalToSuperview()
            make.height.equalTo(scale(25))
            make.width.equalTo(width)
        }
        
        rightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(shopNameLabel.snp.right).offset(scale(4))
            make.width.height.equalTo(scale(18))
        }
        
       view.addSubview(tableview)
       tableview.snp.makeConstraints { make in
           make.left.right.bottom.equalTo(view)
           make.top.equalTo(shopBtn.snp.bottom)
       }
        tableview.backgroundColor = UIColor.clear
        tableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Height_NavBar + Height_TabBar, right: 0)
        tableview.mj_header?.beginRefreshing()
        setCustonTableHeaderView()
    }
    
    //自定义头部
    func setCustonTableHeaderView(){
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        tableview.tableHeaderView = headerView
        headerView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.height.equalTo(scale(547))
            make.width.equalTo(SCW)
        }
        
        
        let ordersWidth = (SCW - (scale(16) * 2 + scale(0.5) * 2))/3
        let shippedBtn = UIButton()
        shippedBtn.backgroundColor = UIColor.clear
        headerView.addSubview(shippedBtn)
        shippedBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(19))
            make.height.equalTo(scale(54))
            make.width.equalTo(ordersWidth)
        }
        
        shippedBtn.addTarget(self, action: #selector(shippedAction), for: .touchUpInside)
        
        
        
        
        shippedBtn.addSubview(shippedLabel)
        shippedLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(4))
            make.height.equalTo(scale(25))
        }
        
        
        let shippedNameLabel = UILabel()
        shippedNameLabel.text = "待发货订单"
        shippedNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        shippedNameLabel.textAlignment = .center
        shippedNameLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        shippedBtn.addSubview(shippedNameLabel)
        
        shippedNameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(shippedLabel.snp.bottom).offset(scale(4))
            make.height.equalTo(scale(17))
        }
        
        
        //中间有一个分割线
        let shippedDiviver = UIView()
        shippedDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#D3D3D3")
        headerView.addSubview(shippedDiviver)
        shippedDiviver.snp.makeConstraints { make in
            make.left.equalTo(shippedBtn.snp.right)
            make.top.equalTo(scale(33))
            make.height.equalTo(26)
            make.width.equalTo(0.5)
        }
        
        
        let paidBtn = UIButton()
        shippedBtn.backgroundColor = UIColor.clear
        headerView.addSubview(paidBtn)
        paidBtn.snp.makeConstraints { make in
            make.left.equalTo(shippedDiviver.snp.right)
            make.top.equalTo(scale(19))
            make.height.equalTo(scale(54))
            make.width.equalTo(ordersWidth)
        }
        
        let paidDiviver = UIView()
        paidDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#D3D3D3")
        headerView.addSubview(paidDiviver)
        paidDiviver.snp.makeConstraints { make in
            make.left.equalTo(paidBtn.snp.right)
            make.top.equalTo(scale(33))
            make.height.equalTo(26)
            make.width.equalTo(0.5)
        }
        
        
        paidBtn.addSubview(paidLabel)
        paidLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(4))
            make.height.equalTo(scale(25))
        }
        
        
        let paidNameLabel = UILabel()
        paidNameLabel.text = "待支付订单"
        paidNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        paidNameLabel.textAlignment = .center
        paidNameLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        paidBtn.addSubview(paidNameLabel)
        
        paidNameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(shippedLabel.snp.bottom).offset(scale(4))
            make.height.equalTo(scale(17))
        }
        
        paidBtn.addTarget(self, action: #selector(paidAction), for: .touchUpInside)
        
        
        let refundBtn = UIButton()
        shippedBtn.backgroundColor = UIColor.clear
        headerView.addSubview(refundBtn)
        refundBtn.snp.makeConstraints { make in
            make.left.equalTo(paidDiviver.snp.right)
            make.top.equalTo(scale(19))
            make.height.equalTo(scale(54))
            make.right.equalTo(-scale(16))
        }
        
        
        
        refundBtn.addSubview(refundLabel)
        refundLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(4))
            make.height.equalTo(scale(25))
        }
        
        let refundNameLabel = UILabel()
        refundNameLabel.text = "退款/售后"
        refundNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        refundNameLabel.textAlignment = .center
        refundNameLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        refundBtn.addSubview(refundNameLabel)
        
        refundNameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(shippedLabel.snp.bottom).offset(scale(4))
            make.height.equalTo(scale(17))
        }
        
        
        refundBtn.addTarget(self, action: #selector(refundAction), for: .touchUpInside)
   
        let todayAchievementView = UIView()
        todayAchievementView.backgroundColor = UIColor.clear
        headerView.addSubview(todayAchievementView)
        todayAchievementView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(refundBtn.snp.bottom).offset(scale(20))
            make.height.equalTo(scale(221))
        }
        todayAchievementView.layer.borderWidth = scale(1)
        todayAchievementView.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff").cgColor
        todayAchievementView.layer.cornerRadius = scale(4)
        
        let todayLabel = UILabel()
        todayLabel.text = "今日业绩"
        todayLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#000000")
        todayLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .semibold)
        todayLabel.textAlignment = .left
        todayAchievementView.addSubview(todayLabel)
        todayLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(12))
            make.top.equalTo(scale(12))
            make.right.equalTo(-scale(12))
            make.height.equalTo(scale(22))
        }
        
        let todayDiviver = UIView()
        todayDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#EBEBEB")
        todayAchievementView.addSubview(todayDiviver)
        todayDiviver.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(todayLabel.snp.bottom).offset(scale(13))
            make.height.equalTo(scale(0.5))
        }
        //paymentOrders
        let paymentOrdersBtn = UIButton()
        todayAchievementView.addSubview(paymentOrdersBtn)
        paymentOrdersBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(todayDiviver.snp.bottom)
            make.width.equalTo((SCW - (scale(16) * 2 + scale(0.5) * 2))/2)
            make.height.equalTo(scale(86.5))
        }
        //paymentAmountLabel支付订单数
        let payMentLabel = UILabel()
        payMentLabel.text = "支付订单数"
        payMentLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#888888")
        payMentLabel.textAlignment = .center
        payMentLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        paymentOrdersBtn.addSubview(payMentLabel)
        
        payMentLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(scale(16)))
            make.height.equalTo(scale(17))
        }
        
        paymentOrdersBtn.addSubview(paymentOrdersLabel)
        paymentOrdersLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(payMentLabel.snp.bottom).offset(scale(6))
            make.height.equalTo(scale(31))
        }
        
        //中间分割线
        let payMentDiviver = UIView()
        payMentDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#EBEBEB")
        todayAchievementView.addSubview(payMentDiviver)
        payMentDiviver.snp.makeConstraints { make in
            make.left.equalTo(paymentOrdersBtn.snp.right)
            make.top.equalTo(todayDiviver.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(scale(0.5))
        }
        
        
        //paymentAmount 支付金额
        let paymentAmountBtn = UIButton()
        todayAchievementView.addSubview(paymentAmountBtn)
        paymentAmountBtn.snp.makeConstraints { make in
            make.left.equalTo(payMentDiviver.snp.right)
            make.top.equalTo(todayDiviver.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(scale(86.5))
        }
        
        let paymentALabel = UILabel()
        paymentALabel.text = "支付金额"
        paymentALabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#888888")
        paymentALabel.textAlignment = .center
        paymentALabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        paymentAmountBtn.addSubview(paymentALabel)

        paymentALabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(scale(16)))
            make.height.equalTo(scale(17))
        }
        
        paymentAmountBtn.addSubview(paymentAmountLabel)
        paymentAmountLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(paymentALabel.snp.bottom).offset(scale(6))
            make.height.equalTo(scale(31))
        }
        
        //中间有分割线
        let midDiviver = UIView()
        midDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#EBEBEB")
        todayAchievementView.addSubview(midDiviver)
        midDiviver.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(paymentOrdersBtn.snp.bottom)
            make.height.equalTo(scale(0.5))
        }
        
        //refundOrders 退款订单数 refundOrdersLabel
        let refundOBtn = UIButton()
        todayAchievementView.addSubview(refundOBtn)
        refundOBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(midDiviver.snp.bottom)
            make.right.equalTo(payMentDiviver.snp.left)
            make.height.equalTo(scale(86.5))
        }
        
        let refundOLabel = UILabel()
        refundOLabel.text = "退款订单数"
        refundOLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#888888")
        refundOLabel.textAlignment = .center
        refundOLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        refundOBtn.addSubview(refundOLabel)

        refundOLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(scale(16)))
            make.height.equalTo(scale(17))
        }
        
        refundOBtn.addSubview(refundOrdersLabel)
        refundOrdersLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(refundOLabel.snp.bottom).offset(scale(6))
            make.height.equalTo(scale(31))
        }
        
        //refundAmount 退款金额
        let refundABtn = UIButton()
        todayAchievementView.addSubview(refundABtn)
        refundABtn.snp.makeConstraints { make in
            make.left.equalTo(payMentDiviver.snp.right)
            make.top.equalTo(midDiviver.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(scale(86.5))
        }
        
        
        let refundALabel = UILabel()
        refundALabel.text = "退款金额"
        refundALabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#888888")
        refundALabel.textAlignment = .center
        refundALabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        refundABtn.addSubview(refundALabel)

        refundALabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(scale(16)))
            make.height.equalTo(scale(17))
        }
        
        refundABtn.addSubview(refundAmountLabel)
        refundAmountLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(refundALabel.snp.bottom).offset(scale(6))
            make.height.equalTo(scale(31))
        }
        
        
        let applyView = UIView()
        applyView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        headerView.addSubview(applyView)
        applyView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(todayAchievementView.snp.bottom).offset(13)
            make.height.equalTo(scale(220))
        }
        applyView.layer.cornerRadius = scale(4)
        
        let applyLabel = UILabel()
        applyLabel.text = "常用应用"
        applyLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#000000")
        applyLabel.textAlignment = .left
        applyLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .semibold)
        applyView.addSubview(applyLabel)
        applyLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(12))
            make.right.equalTo(-scale(12))
            make.top.equalTo(scale(12))
            make.height.equalTo(scale(22))
        }
        
        //这边设置下数组图片
        let imageList = ["Group 2749","Group 2750","Group 2751","Group 2752","Group 2753","Group 2754"]
        let nameList = ["商品管理","订单管理","资金详情","数据统计","运费模板","收货地址"]
        // 这边创建九宫格
        for i in 0..<imageList.count{
            let row = i / 4
            let colom = i % 4
            let width = (SCW - (scale(16) * 2))/4
            let height = width
            let btn = UIButton()
            applyView.addSubview(btn)
            btn.snp.makeConstraints { make in
                make.left.equalTo(CGFloat(colom) * width)
                make.top.equalTo(applyLabel.snp.bottom).offset(scale(12) + CGFloat(row) * height)
                make.width.height.equalTo(width)
            }
            
            let imageNameView = UIImageView()
            imageNameView.image = UIImage(named: String(imageList[i]))
            btn.addSubview(imageNameView)
            imageNameView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(scale(8))
                make.width.height.equalTo(scale(40))
            }
            btn.tag = i
            btn.addTarget(self, action: #selector(joinInApplyAction), for: .touchUpInside)
            let nameLabel = UILabel()
            nameLabel.text = nameList[i]
            nameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#000000")
            nameLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
            nameLabel.textAlignment = .center
            btn.addSubview(nameLabel)
            nameLabel.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(imageNameView.snp.bottom).offset(scale(6))
                make.height.equalTo(scale(17))
            }
        }
    
    }
    
    override func headerRereshing() {
        print("下拉")
//        tableview.mj_header?.endRefreshing()
        loadOrderInfo()
    }
    
    
    override func footerRereshing() {
        print("上拉")
        tableview.mj_footer?.endRefreshing()
    }
    
    
    
    
    func loadOrderInfo(){
        
        NetWorkResultRequest(OrderApi.getOrderSalesInfo, needShowFailAlert: true) {[weak self] result, data in
            do{
                let json = try JSON(data: data)
                LXFLog(json)
                self?.shippedLabel.text = String(json["data"]["pendingDeliver"].int32 ?? 0)
                self?.paidLabel.text = String(json["data"]["pendingPayment"].int32 ?? 0)
                self?.refundLabel.text = String(json["data"]["refundAfterSale"].int32 ?? 0)
                self?.paymentOrdersLabel.text = String(json["data"]["orderNum"].int32 ?? 0)
                self?.paymentAmountLabel.text = (json["data"]["paymentAmount"].string ?? "0")
                self?.refundOrdersLabel.text = String(json["data"]["refundOrderNum"].int32 ?? 0)
                self?.refundAmountLabel.text = "¥" + (json["data"]["refundAmount"].string ?? "0")
            }catch{}
            self?.tableview.reloadData()
            self?.tableview.mj_header?.endRefreshing()
            
        } failureCallback: {[weak self] error,code in
            code.loginOut()
            self?.tableview.mj_header?.endRefreshing()
        }
    }
    
    
    
    
    
    
    
    
    //进入店铺详情
    @objc func jumpShopDetailAction(shopBtn:UIButton){
        LXFLog("进入店铺详情")
        let shopDetailVc = ShopDetailViewController()
        Coordinator.shared?.pushViewController(self, shopDetailVc, animated: true)
    }
    
    
    @objc func shippedAction(shippedBtn:UIButton){
        LXFLog("待发货订单")
        let orderVc = OrderViewController()
        orderVc.btnAction = 0
        orderVc.selectIndex = 2
        Coordinator.shared?.pushViewController(self, orderVc, animated: true)
    }
    @objc func paidAction(paidBtn:UIButton){
        LXFLog("待支付订单")
        let orderVc = OrderViewController()
        orderVc.selectIndex = 1
        orderVc.btnAction = 0
        Coordinator.shared?.pushViewController(self, orderVc, animated: true)
    }
    @objc func refundAction(refundBtn:UIButton){
        LXFLog("售后")
        let orderVc = OrderViewController()
        orderVc.btnAction = 1
        orderVc.selectIndex = 1
        Coordinator.shared?.pushViewController(self, orderVc, animated: true)
    }
    
    
    
    //进入应用
    @objc func joinInApplyAction(btn:UIButton){
        if btn.tag == 0 {
            let commodityMVc = CommodityManagementViewController()
            Coordinator.shared?.pushViewController(self, commodityMVc, animated: true)
        } else if btn.tag == 1{
            let orderVc = OrderViewController()
            orderVc.selectIndex = 0
            orderVc.btnAction = 0
            Coordinator.shared?.pushViewController(self, orderVc, animated: true)
        }else if btn.tag == 4{
            let frieghtTemplateVc = FreightTemplateViewController()
            Coordinator.shared?.pushViewController(self, frieghtTemplateVc, animated: true)
        }else if btn.tag == 5{
            let modifyReturnVc = ModifyReturnAddressViewController()
            Coordinator.shared?.pushViewController(self, modifyReturnVc, animated: true)
        }else{
            JFPopup.toast(hit: "本功能暂时还在完善中,请耐心等待")
        }
    }
    
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
}

