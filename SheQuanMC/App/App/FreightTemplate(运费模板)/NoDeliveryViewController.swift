//
//  NoDeliveryViewController.swift
//  App
//
//  Created by mac on 2022/5/12.
//

import UIKit
import Util
import JFPopup
import RealmSwift
import SwiftUI

class NoDeliveryViewController: BaseViewController {
    
    
//    var addressList:[AddressModel] = [AddressModel]()
    
    var regionList:[[AddressModel]] = [[AddressModel]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "不配送区域"
        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(-scale(92))
        }
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(NoDeliveryCell.self, forCellReuseIdentifier: "NoDeliveryCell")
        
        
        let addRegionBtn = UIButton()
        addRegionBtn.setTitle("添加区域", for: .normal)
        addRegionBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        addRegionBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addRegionBtn.setImage(UIImage(named: "Group 2688"), for: .normal)
        addRegionBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        addRegionBtn.addTarget(self, action: #selector(addRegionNoDeliveryAction), for: .touchUpInside)
        view.addSubview(addRegionBtn)
        
        addRegionBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(-scale(34))
        }
        
        addRegionBtn.layer.cornerRadius = scale(4)
        
    }
    

    
    //添加区域不配送
    @objc func addRegionNoDeliveryAction(addRegionBtn:UIButton){
        LXFLog("添加不配送区域")
        
        self.popup.bottomSheet {
            
            let nodeliveryRegionView = NoDeliveryRegionView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(442)), addressList: [])
            
            nodeliveryRegionView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
                
            }
            nodeliveryRegionView.sureChoiceAddress = {[weak self] list in
//                self?.addressList = list
                //有全选的要对省份进行判断
                //要是没有的话要对区域进行判断
                let addressModel = list[1]
                if addressModel.region_name == "全选"{
                    var isAdd:Bool = true
                    for i in 0..<(self?.regionList.count ?? 0){
                        let array = self?.regionList[i]
                        for j in 0..<(array?.count ?? 0){
                            let addressmodel = array![j] as AddressModel
                            for n in 0..<list.count{
                            let addressmodel1 = list[n]
                            if addressmodel.region_name == addressmodel1.region_name{
                               isAdd = false
                               break
                            }
                          }
                        }
                    }
                    if isAdd{
                        self?.regionList.append(list)
                    }else{
                        JFPopup.toast(hit: "添加的地址有相同的地方")
                    }
                }else{
                    //没有全选的时候
                    var isAdd:Bool = true
                    for i in 0..<(self?.regionList.count ?? 0){
                        if let array = self?.regionList[i]{
                            for j in 1..<array.count{
                                let addressmodel = array[j] as AddressModel
                                for n in 0..<list.count{
                                let addressmodel1 = list[n]
                                if addressmodel.region_name == addressmodel1.region_name{
                                   isAdd = false
                                   break
                                }
                              }
                            }
                        }
                    }
                    if isAdd{
                        self?.regionList.append(list)
                    }else{
                        JFPopup.toast(hit: "添加的地址有相同的地方")
                    }
                }
                self?.tableview.reloadData()
                self?.popup.dismissPopup()
            }
            return nodeliveryRegionView
        }
       
    }
    
    
    //这边设置图片为空
    override func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage()
    }
   
    //并设置文字
    override func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "暂无不配送区域"
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: scale(14), weight: .regular),NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor: "#999999")]
        return NSAttributedString(string: text, attributes: attributes)
    }

    
    //删除不配送地区
    @objc func deleteNoDeliveryAction(cancelBtn:UIButton){
        self.popup.alert {[weak self] in
            [.title("是否删除改区域"),
             .confirmAction([
                .text("确定"),
                .tapActionCallback({
                    JFPopupView.popup.toast(hit: "删除成功")
                    self?.regionList.remove(at: cancelBtn.tag)
                    self?.tableview.reloadData()
                })
             ])
            ]
        }
    }
}

extension NoDeliveryViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.regionList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoDeliveryCell") as! NoDeliveryCell
        
        let array = regionList[indexPath.row]
        let addressmodel = array[1] as AddressModel
        if addressmodel.region_name == "全选"{
            let addressmodel1 = array[0] as AddressModel
//            cell.regionLabel.text = addressmodel1.region_name
            cell.addressText = addressmodel.region_name!
        }else{
            //这边是省份和后续的东西
            var addressText:String = ""
            for i in 0..<array.count{
                let addressmodel = array[i] as AddressModel
                addressText += (addressmodel.region_name)!
            }
//            cell.regionLabel.text = addressText
            cell.addressText = addressText
        }
        
        cell.cancelBtn.tag = indexPath.row
        cell.cancelBtn.addTarget(self, action: #selector(deleteNoDeliveryAction), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.popup.bottomSheet {
            let nodeliveryRegionView = NoDeliveryRegionView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(442)), addressList: self.regionList[indexPath.row])
            nodeliveryRegionView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
                
            }
            nodeliveryRegionView.sureChoiceAddress = {[weak self] list in
//                self?.addressList = list
                //有全选的要对省份进行判断
                //要是没有的话要对区域进行判断
                let addressModel = list[1]
                if addressModel.region_name == "全选"{
                    var isAdd:Bool = true
                    for i in 0..<(self?.regionList.count ?? 0){
                        let array = self?.regionList[i]
                        if i == indexPath.row{
                          continue
                        }
                        for j in 0..<(array?.count ?? 0){
                            let addressmodel = array![j] as AddressModel
                            for n in 0..<list.count{
                            let addressmodel1 = list[n]
                            if addressmodel.region_name == addressmodel1.region_name{
                               isAdd = false
                               break
                            }
                          }
                        }
                    }
                    if isAdd{
//                        self?.regionList.append(list)
                        self?.regionList[indexPath.row] = list
                    }else{
                        JFPopup.toast(hit: "添加的地址有相同的地方")
                    }
                }else{
                    //没有全选的时候
                    var isAdd:Bool = true
                    for i in 0..<(self?.regionList.count ?? 0){
                        if let array = self?.regionList[i]{
                            if i == indexPath.row{
                              continue
                            }
                            for j in 1..<array.count{
                                let addressmodel = array[j] as AddressModel
                                for n in 0..<list.count{
                                let addressmodel1 = list[n]
                                if addressmodel.region_name == addressmodel1.region_name{
                                   isAdd = false
                                   break
                                }
                              }
                            }
                        }
                    }
                    if isAdd{
//                        self?.regionList.append(list)
                        self?.regionList[indexPath.row] = list
                    }else{
                        JFPopup.toast(hit: "添加的地址有相同的地方")
                    }
                }
                self?.tableview.reloadData()
                self?.popup.dismissPopup()
            }
            return nodeliveryRegionView
        }
    }
}
