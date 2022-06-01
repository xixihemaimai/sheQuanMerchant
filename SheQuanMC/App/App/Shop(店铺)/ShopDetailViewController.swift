//
//  ShopDetailViewController.swift
//  App
//
//  Created by mac on 2022/4/28.
//

import UIKit
import Util
import SDWebImage

class ShopDetailViewController: BaseViewController {

    
    var shopeDetailList:[[[String:String]]] = [[[:]]]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "店铺信息"
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(ShopDetailCell.self, forCellReuseIdentifier: "ShopDetailCell")
        tableview.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "ShopDetailHeaderView")
        
        tableview.register(ShopDetailCardCell.self, forCellReuseIdentifier: "ShopDetailCardCell")
        tableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        reloadData()
    }
    
    func reloadData(){
        shopeDetailList.removeAll()
        for i in 0...3 {
            var rowList = [[String:String]]()
            if i == 0{
                var dict = [String:String]()
                dict["titleNameLabel"] = "店铺名称"
                dict["detailLabel"] = StoreService.shared.currentUser?.shopName
                rowList.append(dict)
            }else if i == 1{
                for j in 0...1{
                    var dict = [String:String]()
                    if j == 0{
                        dict["titleNameLabel"] = "手机号"
                        dict["detailLabel"] = StoreService.shared.currentUser?.mobile
                    }else{
                        dict["titleNameLabel"] = "开通时间"
                        dict["detailLabel"] = StoreService.shared.currentUser?.regTime
                    }
                    rowList.append(dict)
                }
            }else if i == 2{
                for j in 0...3{
                    var dict = [String:String]()
                    if j == 0{
                        dict["titleNameLabel"] = "企业名称"
                        LXFLog(StoreService.shared.currentUser?.entName)
                        dict["detailLabel"] = StoreService.shared.currentUser?.entName
                    }else if j == 1{
                        dict["titleNameLabel"] = "地址"
                        dict["detailLabel"] = StoreService.shared.currentUser?.entAddress
                    }else if j == 2{
                        dict["titleNameLabel"] = "法人姓名"
                        dict["detailLabel"] = StoreService.shared.currentUser?.legalName
                    }else{
                        dict["titleNameLabel"] = "信用代码"
                        dict["detailLabel"] = StoreService.shared.currentUser?.creditCode
                    }
                    rowList.append(dict)
                }
            }else{
                var dict = [String:String]()
                dict["idCardFort"] = StoreService.shared.currentUser?.frontPic
                dict["idCardBack"] = StoreService.shared.currentUser?.reversePic
                dict["bussIn"] = StoreService.shared.currentUser?.licencePic
                rowList.append(dict)
            }
            shopeDetailList.append(rowList)
        }
        tableview.reloadData()
    }
    
}




extension ShopDetailViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = shopeDetailList[section]
        return list.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return shopeDetailList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? scale(1) : scale(8)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopDetailCardCell") as! ShopDetailCardCell
            let list = shopeDetailList[indexPath.section]
            let dict = list[indexPath.row]
//            cell.cardFrotImageView.image = UIImage(named: dict["idCardFort"]!)
//            cell.cardBackImageView.image = UIImage(named: dict["idCardBack"]!)
//            cell.bussImageView.image = UIImage(named: dict["bussIn"]!)
            
//            cell.cardFrotImageView.kf.setImage(with: URL(string: dict["idCardFort"] ?? ""))
            
            cell.cardFrotImageView.sd_setImage(with: URL(string: dict["idCardFort"] ?? ""))
            cell.cardBackImageView.sd_setImage(with: URL(string: dict["idCardBack"] ?? ""))
//            cell.cardBackImageView.kf.setImage(with: URL(string: dict["idCardBack"] ?? ""))
//            cell.bussImageView.kf.setImage(with: URL(string: dict["bussIn"] ?? ""))
            cell.bussImageView.sd_setImage(with: URL(string: dict["bussIn"] ?? ""))
            
            
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShopDetailCell") as! ShopDetailCell
            if indexPath.row == 0{
                cell.diviver.isHidden = true
            }
            let list = shopeDetailList[indexPath.section]
            let dict = list[indexPath.row]
            cell.titleNameLabel.text = dict["titleNameLabel"]
            cell.detailLabel.text = dict["detailLabel"]
            return cell
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3{
//             return scale(378)
            return UITableView.automaticDimension
        }else{
            return UITableView.automaticDimension <= scale(48) ? scale(48) : UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ShopDetailHeaderView")!
        headerView.contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        return headerView
    }
    
    
    
    
}
