//
//  MyViewController.swift
//  App
//
//  Created by mac on 2022/4/24.
//

import UIKit
import Util
import SDWebImage
import JFPopup

public class MyViewController: BaseViewController {
    
    
    lazy var shopBackImageView:UIImageView = {
       let shopBackImageView = UIImageView()
        shopBackImageView.image = UIImage(named: "Mask Group")
        return shopBackImageView
    }()

    //店铺图片
    lazy var headerImage:UIImageView = {
       let headerImage = UIImageView()
        headerImage.contentMode = .scaleAspectFill
        return headerImage
    }()
    
    //店铺名称
    lazy var shopName:UILabel = {
       let shopName = UILabel()
        shopName.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#1A1A1A")
        shopName.font = UIFont.systemFont(ofSize: scale(18), weight: .semibold)
        shopName.text = StoreService.shared.currentUser?.shopName
        shopName.textAlignment = .left
        return shopName
    }()
    
    
    var myImageList = ["safe","message","help","idea","about",""]
    var myTitleList = ["账户与安全","消息通知","用户帮助","意见反馈","关于我们",""]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        view.addSubview(shopBackImageView)
        shopBackImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(scale(474))
        }
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = UIColor.clear
        tableview.register(MyCell.self, forCellReuseIdentifier: "MyCell")
        tableview.register(MyLoginOutCell.self, forCellReuseIdentifier: "MyLoginOutCell")
        myCustomTableViewHeaderView()
    }
    
    func myCustomTableViewHeaderView(){
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        tableview.tableHeaderView = headerView
        headerView.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.equalTo(SCW)
            make.height.equalTo(scale(164))
        }
        
        let headerBtn = UIButton()
        headerBtn.backgroundColor = UIColor.clear
        headerBtn.addTarget(self, action: #selector(jumpShopInfomationAction), for: .touchUpInside)
        headerView.addSubview(headerBtn)
        headerBtn.snp.makeConstraints { make in
            make.top.equalTo(scale(69))
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(64))
        }
        
        //店铺图片
        headerBtn.addSubview(headerImage)
        headerImage.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(scale(64))
        }
        headerImage.sd_setImage(with: URL(string: StoreService.shared.currentUser?.shopAvatar ?? ""), placeholderImage: UIImage(named: "Group 2784"))
        headerImage.layer.cornerRadius = 64 * 0.5
        headerImage.layer.borderWidth = scale(2)
        headerImage.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff").cgColor
        headerImage.layer.masksToBounds = true
        headerBtn.addSubview(shopName)
        
        
//        var width = StoreService.shared.currentUser?.shopName.singleLineSize(font: UIFont.systemFont(ofSize: scale(18), weight: .semibold)).width
//        width! += scale(10)
        
        shopName.snp.makeConstraints { make in
            make.left.equalTo(headerImage.snp.right).offset(scale(12))
            make.top.equalTo(scale(8))
//            make.width.equalTo(width!)
            make.height.equalTo(scale(25))
        }
        
        
        //方向图片
        let rightImage = UIImageView()
        rightImage.image = UIImage(named: "Frame-my-right")
        headerBtn.addSubview(rightImage)
        rightImage.snp.makeConstraints { make in
            make.left.equalTo(shopName.snp.right).offset(scale(4))
//            make.top.equalTo(scale(8))
            make.centerY.equalTo(shopName)
            make.width.height.equalTo(scale(20))
        }
        
        //店铺ID
        let shopId = UILabel()
        shopId.text = "店铺ID: 12345678910"
        shopId.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#838383")
        shopId.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        shopId.textAlignment = .left
        headerBtn.addSubview(shopId)
        shopId.snp.makeConstraints { make in
            make.left.equalTo(headerImage.snp.right).offset(scale(12))
            make.top.equalTo(shopName.snp.bottom).offset(scale(6))
            make.right.equalToSuperview()
            make.height.equalTo(scale(17))
        }
        
        tableview.layoutIfNeeded()
    }
    
    
    @objc func jumpShopInfomationAction(headerBtn:UIButton){
        let shopInformationVc = ShopInformationViewController()
        Coordinator.shared?.pushViewController(self, shopInformationVc, animated: true)
        shopInformationVc.modifyShopAvterFuntion = {[weak self] type in
            if type == 1{
                self?.headerImage.sd_setImage(with: URL(string: StoreService.shared.currentUser?.shopAvatar ?? ""), placeholderImage: UIImage(named: "Group 2784"))
            }else{
                //店铺名称
                var width = StoreService.shared.currentUser?.shopName.singleLineSize(font: UIFont.systemFont(ofSize: scale(18), weight: .semibold)).width
                width! += scale(10)
                self?.shopName.text = StoreService.shared.currentUser?.shopName
                self?.shopName.snp.remakeConstraints { make in
                    make.left.equalTo((self?.headerImage.snp.right)!).offset(scale(12))
                    make.top.equalTo(scale(8))
                    make.width.equalTo(width!)
                    make.height.equalTo(scale(25))
                }
            }
        }
    }
    
    
    @objc func loginOutBtnAction(loginOutBtn:UIButton){
        JFPopup.alert {
            [
                .title("确定要退出吗？"),
                .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                .withoutAnimation(true),
                .cancelAction([
                    .text("取消"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"))
                ]),
                .confirmAction([
                    .text("确定"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .tapActionCallback({
                        StoreService.shared.delete()
                        let window = UIApplication.shared.keyWindow
                        window?.rootViewController = BaseNaviViewController(rootViewController: StartPageViewController())
                    })
                ])
            ]
        }
    }
    
}


extension MyViewController:UITableViewDelegate,UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myImageList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row <= 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! MyCell
            cell.backgroundColor = UIColor.clear
            cell.myImage.image = UIImage(named: myImageList[indexPath.row])
            cell.myLabel.text = myTitleList[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyLoginOutCell") as! MyLoginOutCell
            cell.loginOutBtn.addTarget(self, action: #selector(loginOutBtnAction), for: .touchUpInside)
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0{
            let accountAndSafeVc = AccountAndSafeViewController()
            Coordinator.shared?.pushViewController(self, accountAndSafeVc, animated: true)
        }else if indexPath.row == 1{
            let myMessageVc = MyMessageViewController()
            myMessageVc.title = "消息通知"
            Coordinator.shared?.pushViewController(self, myMessageVc, animated: true)
        }else if indexPath.row == 2{
            let userHelpVc = UserHelpViewController()
            Coordinator.shared?.pushViewController(self, userHelpVc, animated: true)
        }else if indexPath.row == 3{
            let feedBackVc = FeedbackMyViewController()
            Coordinator.shared?.pushViewController(self, feedBackVc, animated: true)
        }
        else if indexPath.row == 4{
            //关于我们
            let aboutMyVc = AboutMyViewController()
            Coordinator.shared?.pushViewController(self, aboutMyVc, animated: true)
        }
    }
    
}
