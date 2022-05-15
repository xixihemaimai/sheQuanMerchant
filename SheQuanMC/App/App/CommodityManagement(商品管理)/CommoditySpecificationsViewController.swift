//
//  CommoditySpecificationsViewController.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util
import JFPopup
import HXPhotoPicker

class CommoditySpecificationsViewController: BaseViewController {
    
    
    
    
    //保存的是规格的数量
    var saveList:[[String]] = [[String]]()
    
    //交集和并集之后的数组
    var unIonSetList:[String] = [String]()
    
    
    
    lazy var newTableView:UITableView = {
        let newTabelView = UITableView(frame: .zero, style: .grouped)
        newTabelView.separatorStyle = .none
        if #available(iOS 11.0, *){
            newTabelView.contentInsetAdjustmentBehavior = .never
        }
        if #available(iOS 15.0, *){
            newTabelView.sectionHeaderTopPadding = 0
        }
        return newTabelView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        saveList = [[String]]()
        
        title = "商品规格"
        view.addSubview(newTableView)
        newTableView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        newTableView.delegate = self
        newTableView.dataSource = self
        
        newTableView.shouldIgnoreScrollingAdjustment = true
        newTableView.shouldRestoreScrollViewContentOffset = true
        
        newTableView.register(CommoditySpecificationsHeaderView.self, forHeaderFooterViewReuseIdentifier: "CommoditySpecificationsHeaderView")
        
        newTableView.register(CommoditySpecificationsFooterView.self, forHeaderFooterViewReuseIdentifier: "CommoditySpecificationsFooterView")
        
        
        newTableView.register(CommoditySpecificationCell.self, forCellReuseIdentifier: "CommoditySpecificationCell")
        
        
        newTableView.register(CommodityPriceAndStockCell.self, forCellReuseIdentifier: "CommodityPriceAndStockCell")
        
        
        newTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: scale(92), right: 0)
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.right.left.bottom.equalToSuperview()
            make.height.equalTo(iPhoneX ? scale(92) : scale(58))
        }
        
        let cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        bottomView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
//            make.top.equalTo(scale(14))
            make.height.equalTo(scale(44))
            make.width.equalTo(scale(120))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        cancelBtn.layer.cornerRadius = scale(4)
        cancelBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        cancelBtn.layer.borderWidth = scale(1)
        
        
        let saveBtn = UIButton()
        saveBtn.setTitle("保存", for: .normal)
        saveBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        saveBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        bottomView.addSubview(saveBtn)
        saveBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
//            make.top.equalTo(scale(14))
            make.left.equalTo(cancelBtn.snp.right).offset(scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(0))
        }
        
        saveBtn.layer.cornerRadius = scale(4)
        
    }
    
    
    //添加规格
    @objc func addSpecificationAction(addSepcificationsBtn:UIButton){
        
        if saveList.count < 2{
            self.popup.bottomSheet {
                
                let addSpecificationsView = AddSpecificationsView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(400)), addSpecificationList: saveList)
                addSpecificationsView.cancelBlock = {[weak self] in
                    self?.popup.dismissPopup()
                }
                addSpecificationsView.sendSureSpecificationList = {[weak self] list in
                    self?.saveList = list
                    self?.newTableView.reloadData()
                    self?.popup.dismissPopup()
                }
                return addSpecificationsView
            }
            
    //            let colorList = [String]()
    ////            colorList.insert(String(1), at: 0)
    //            saveList.append(colorList)
    //            tableview.reloadData()
        }else{
            JFPopup.toast(hit: "只允许添加俩个规格")
        }
    }
    
    
    //添加规格值得value
    @objc func addSpecificationValueAction(addBtn:UIButton){
        var colorList = saveList[addBtn.tag]
//        colorList.insert("", at: 0)
        var isAdd:Bool = true
        for i in 0..<colorList.count {
            let str = colorList[i]
            if str == ""{
                isAdd = false
                break
            }else{
                isAdd = true
            }
        }
        if isAdd{
            if colorList.count < 20{
                colorList.append("")
                saveList[addBtn.tag] = colorList
                newTableView.reloadData()
                guard let cell = newTableView.cellForRow(at: IndexPath(row: addBtn.tag, section: 0)) as? CommoditySpecificationCell else{
                   
                    
                    let cell = newTableView.dequeueReusableCell(withIdentifier: "CommoditySpecificationCell", for: IndexPath(item: addBtn.tag, section: 0)) as! CommoditySpecificationCell
                    var list:[UITextField] = [UITextField]()
                    for i in 0..<cell.specificationView.subviews.count{
                        let view = cell.specificationView.subviews[i]
                        if view.isKind(of: UITextField.self){
                            let view1 = view as! UITextField
                            list.append(view1)
                        }
                    }
                   LXFLog("-----3332---------\(list.count)")
                   let textfield = list.last
                   textfield?.becomeFirstResponder()
                   return
                }
//              Thread.sleep(forTimeInterval: 0.1)
                //延长1秒看下
                var list:[UITextField] = [UITextField]()
                for i in 0..<cell.specificationView.subviews.count{
                    let view = cell.specificationView.subviews[i]
                    if view.isKind(of: UITextField.self){
                        let view1 = view as! UITextField
                        list.append(view1)
                    }
                }
               let textfield = list.last
               textfield?.becomeFirstResponder()
            }else{
                JFPopup.toast(hit: "最多只能添加20条规格值")
            }
        }else{
            JFPopup.toast(hit: "上面添加的数据，没有添加规格值")
        }
    }
    
    
    //添加并集之后的数组进行显示
    func UnionSetArray(){
        //第一个数组  A  B
        //第二个数组  a  b
        //另一个数组 A (a b)  b (a b)
        //这边有俩个数组 获取第一个数组，把第二个数组添加到
        let colorList = saveList[0]
        unIonSetList.removeAll()
        if saveList.count > 1{
            let newColorList = saveList[1]
            for text in colorList{
                for newText in newColorList{
                    unIonSetList.append(text + newText)
                }
            }
            //去除相同的数据，只保留一个
            var listArray = [String]()
            for text in unIonSetList{
                if !listArray.contains(text){
                    listArray.append(text)
                }
            }
            unIonSetList = listArray
        }
    }
    
    
    
    //删除
    @objc func deleteAction(deleteBtn:UIButton){
        saveList.remove(at: deleteBtn.tag)
        unIonSetList.removeAll()
        newTableView.reloadData()
    }
    
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
    
    

    
    
}


extension CommoditySpecificationsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return saveList.count
        }else{
            return unIonSetList.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var isShowSection:Bool = false
        for colorList in saveList {
            if colorList.count > 0 {
                isShowSection = true
                break
            }else{
                isShowSection = false
            }
        }
        return isShowSection ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return UITableView.automaticDimension
        }else{
            //这边的判断要改成是否设置了
            if indexPath.row == 0{
                return scale(60)
            }else{
                return scale(94)
            }
        }
    }
    
    
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommoditySpecificationCell") as! CommoditySpecificationCell
            //这边传递过去去改变图像的高度
            cell.tag = indexPath.row
            cell.delegate = self
            cell.addBtn.tag = indexPath.row
            cell.deleteBtn.tag = indexPath.row
            cell.addBtn.addTarget(self, action: #selector(addSpecificationValueAction), for: .touchUpInside)
            cell.deleteBtn.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
            cell.colorList = saveList[indexPath.row]
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommodityPriceAndStockCell") as! CommodityPriceAndStockCell
            cell.specificationLabel.text = unIonSetList[indexPath.row]
            if indexPath.row == 0{
                cell.diviver.isHidden = true
                cell.midView.isHidden = true
            }else{
                cell.diviver.isHidden = false
                cell.midView.isHidden = false
            }
            return cell
        }
    }
    
    
    
    //组头
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CommoditySpecificationsHeaderView") as! CommoditySpecificationsHeaderView
        if section == 0{
            headerView.contentLabel.text = "设置规格"
        }else{
            headerView.contentLabel.text = "设置价格与库存"
        }
        return headerView
    }
    
    
    //组尾
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0{
            let footView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CommoditySpecificationsFooterView") as! CommoditySpecificationsFooterView
            footView.addSepcificationsBtn.setTitle("添加规格" + "(\(saveList.count)/2)", for: .normal)
            footView.addSepcificationsBtn.addTarget(self, action: #selector(addSpecificationAction), for: .touchUpInside)
            return footView
        }
       return nil
    }
    
    //组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return scale(42)
    }
    
    //组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return scale(64)
        }else{
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            
            self.popup.bottomSheet {
                let settingPriceAndStockView = SettingPriceAndStockView(frame: CGRect(x: 0, y: 0, width: SCW, height: SCH - Height_NavBar))
                settingPriceAndStockView.viewController = self
                settingPriceAndStockView.cancelBlock = {[weak self] in
                    self?.popup.dismissPopup()
                }
                return settingPriceAndStockView
            }
        }
    }
}


extension CommoditySpecificationsViewController:CommoditySpecificationCellDelegate{
    
    //删除规格值
    func deleteSaveListTagAndIndex(tag: Int, index: Int) {
        var colorList = saveList[tag]
        colorList.remove(at: index)
        saveList[tag] = colorList
        //这边是对属性值进行交集
        UnionSetArray()
        newTableView.reloadData()
    }
    
    
    //修改规格值
    func modityTextfieldTagAndIndexAndValue(tag: Int, index: Int, value: String) {
        if value != ""{
            var colorList = saveList[tag]
    //        if !colorList.contains(value){
            colorList[index] = value
            saveList[tag] = colorList
            UnionSetArray()
            newTableView.reloadData()
    //        }else{
    //            JFPopup.toast(hit: "不允许添加相同的规格值")
    //        }
        }
    }
    
    
  
    
}
