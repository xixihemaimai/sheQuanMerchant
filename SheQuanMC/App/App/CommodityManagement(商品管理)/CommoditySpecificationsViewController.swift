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
import SwiftUI

class CommoditySpecificationsViewController: BaseViewController {
    
    /**
     [
     商品规格
     ProductSpecInfo{
     description:
     商品规格
     specAttrId    integer($int32)
     规格属性Id
     specId    string
     规格Id
     specValue    string
     规格属性值
     }]
     */
    
    
    //商品规格和价格和库存
    var commoditySpecifications:((_ SpecList:[Specs],_ PriceInVentory:[Skus]) ->Void)?
    
    
    
    var categoryId:Int32 = 0
    
    
    
    
    //这个用来判断是否添加俩个（不管后台传多少个，增删改查都没有关系）
    var addCoutList:[String] = [String]()
    
    //保存的是规格的数量(Specs 模型)
    var saveList:[SpecGroups] = [SpecGroups]()
    
    //保存规格值得数组
    var saveValueList:[[Specs]] = [[Specs]]()
 
    
    //交集和并集之后的数组
    var unIonSetList:[Skus] = [Skus]()
    
    
    var combinationArray:[[Skus]] = [[Skus]]()
    
    
    
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

//        saveList = [String]()
        
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
        cancelBtn.addTarget(self, action: #selector(cancelManagerAction), for: .touchUpInside)
        
        
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
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        saveBtn.layer.cornerRadius = scale(4)
        
        saveBtn.addTarget(self, action: #selector(saveManagerAction), for: .touchUpInside)
        
    }
    
    
    //取消
    @objc func cancelManagerAction(cancelBtn:UIButton){
        Coordinator.shared?.popViewController(self, true)
    }
    
    //保存
    @objc func saveManagerAction(saveBtn:UIButton){
        
        
        //这边要对商品规格进行重组 saveValueList里面有俩个数组
        let specsArray = arrayForConsolidationThe(array: saveValueList)
        //还需要对价格和库存进行重组 unIonSetList
//        let skusArray = arrayForConsolidationValueThe(array: unIonSetList)
        
        
        LXFLog("-------------------\(specsArray)")
        
        LXFLog("==================\(unIonSetList)")
        
        
        //这边要进行判断没有填写完整的提醒，成功填写完整还需要返回上一个界面，把所需的数据传递过去
        
        
        var isComplete:Bool = true
        for skus in unIonSetList {
            if ((skus.price ?? 0.0) < 0) && ((skus.stock ?? 0) < 0){
                isComplete = false
                break
            }
        }
        if isComplete{
            //这版要把填写的数据传递回去上一个界面
            commoditySpecifications!(specsArray,unIonSetList)
            Coordinator.shared?.popViewController(self, true)
            
        }else{
            JFPopup.toast(hit: "请填写完整价钱和库存等数据")
        }
    }
    
    
    //添加规格
    @objc func addSpecificationAction(addSepcificationsBtn:UIButton){
        
        if addCoutList.count < 2{
            self.popup.bottomSheet {
                
                let addSpecificationsView = AddSpecificationsView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(400)), addSpecificationList: addCoutList,categoryId: categoryId)
                addSpecificationsView.cancelBlock = {[weak self] in
                    self?.popup.dismissPopup()
                }
                

                
                addSpecificationsView.sendSureSpecificationList = {[weak self] list in
                    for i in 0..<list.count {
                        let specGroups = list[i]
                //                      let specGroups = SpecGroups(specGroupId: <#T##Int64?#>, specGroupName: <#T##String?#>, specs: <#T##[String]?#>)
                            self?.saveList.append(specGroups)
                            self?.addCoutList.append(specGroups.specGroupName ?? "")
                            let colorList = [Specs]()
                            self?.saveValueList.append(colorList)
                        }
                    self?.newTableView.reloadData()
                    self?.popup.dismissPopup()
                }
                
//                addSpecificationsView.sendSureSpecificationList = {[weak self] list in
//                    for i in 0..<list.count {
//                        let specGroups = list[i]
////                      let specGroups = SpecGroups(specGroupId: <#T##Int64?#>, specGroupName: <#T##String?#>, specs: <#T##[String]?#>)
//
//                        self?.saveList.append(specGroups)
//                        self?.addCoutList.append(specGroups)
//
//                        let colorList = [Specs]()
//                        self?.saveValueList.append(colorList)
//                    }
//                    self?.newTableView.reloadData()
//                    self?.popup.dismissPopup()
//                }
                return addSpecificationsView
            }
             
    //       let colorList = [String]()
    //       colorList.insert(String(1), at: 0)
    //       saveList.append(colorList)
    //       tableview.reloadData()
        }else{
            JFPopup.toast(hit: "只允许添加俩个规格")
        }
    }
    
    
    //添加规格值得value
    @objc func addSpecificationValueAction(addBtn:UIButton){
        let specGroups = saveList[addBtn.tag]
        var colorList = saveValueList[addBtn.tag]
        var isAdd:Bool = true
        for i in 0..<colorList.count {
            let specs = colorList[i]
            if specs.specValue == ""{
                isAdd = false
                break
            }else{
                isAdd = true
            }
        }
        if isAdd{
            if colorList.count < 20{
//                colorList.append("")
                let specs = Specs(specGroupId: specGroups.specGroupId,specValue: "")
                colorList.append(specs)
                saveValueList[addBtn.tag] = colorList
                newTableView.reloadData()
                guard let cell = newTableView.cellForRow(at: IndexPath(row: addBtn.tag, section: 0)) as? CommoditySpecificationCell else{
//                    let cell = newTableView.dequeueReusableCell(withIdentifier: "CommoditySpecificationCell", for: IndexPath(item: addBtn.tag, section: 0)) as! CommoditySpecificationCell
//                    var list:[UITextField] = [UITextField]()
//                    for i in 0..<cell.specificationView.subviews.count{
//                        let view = cell.specificationView.subviews[i]
//                        if view.isKind(of: UITextField.self){
//                            let view1 = view as! UITextField
//                            list.append(view1)
//                        }
//                    }
//                   LXFLog("-----3332---------\(list.count)")
//                   let textfield = list.last
//                   textfield?.becomeFirstResponder()
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
    func UnionSetArray(tag: Int, index: Int){
        let temArray = unIonSetList
         unIonSetList.removeAll()
        //这边要判断是否第二个数组有值，没有值就显示第一个规格的值
        var valueInt:Int = 0
        for colorList in saveValueList {
            if colorList.count > 0{
                valueInt += 1
            }
        }
        if valueInt > 1{
            getCombination(kid: 0, inputArray: saveValueList, addArray: [Skus]())
            unIonSetList = arrayForConsolidationValueThe(array: combinationArray)
            combinationArray.removeAll()
            
            for i in 0..<temArray.count {
                var value = ""
                let skus = temArray[i]
                for i in 0..<(skus.specs?.count ?? 0){
                    let specs = skus.specs?[i] as? Specs
                    value += specs?.specValue ?? ""
                }
                for j in 0..<unIonSetList.count {
                    var skus1 = unIonSetList[j]
                    var value1 = ""
                    for i in 0..<(skus1.specs?.count ?? 0){
                        let specs1 = skus1.specs?[i] as? Specs
                        value1 += specs1?.specValue ?? ""
                    }
                    if value == value1{
                        skus1 = skus
                        unIonSetList[j] = skus1
                        break
                    }
                }
            }
        }else{
            
            for i in 0..<saveValueList.count{
                let colorList = saveValueList[i]
                for specs in colorList{
                    let skus = Skus( price: 0,skuCode: "", skuId: 0, skuPics: [String](), specs: [specs], stock: 0)
                    unIonSetList.append(skus)
                }
            }
            for skus in temArray {
                var value = ""
                for i in 0..<(skus.specs?.count ?? 0){
                    let specs = skus.specs?[i] as? Specs
                    value += specs?.specValue ?? ""
                }
                for i in 0..<unIonSetList.count{
                   var skus1 = unIonSetList[i]
                    var value1 = ""
                    for i in 0..<(skus1.specs?.count ?? 0){
                        let specs1 = skus1.specs?[i] as? Specs
                        value1 += specs1?.specValue ?? ""
                    }
                    if value == value1{
                       skus1 = skus
                       unIonSetList[i] = skus1
                       break
                    }
                }
            }
        }
    }
    
    
    
    func getCombination(kid: Int,
                           inputArray: [[Specs]],
                           addArray: [Skus]) {
        
           if kid < inputArray.count {
               let dataArr = inputArray[kid]
               if dataArr.count == 0 {
                   return
               }
               for i in 0 ..< dataArr.count {
                   var newArr = addArray
                   let specs = dataArr[i]
                   let skus = Skus(price: 0,skuCode: "", skuId: 0, skuPics: [String](), specs: [specs], stock: 0)
                   newArr.append(skus)
                   getCombination(kid: kid + 1, inputArray: inputArray, addArray: newArr)
               }
           } else {
               var dataArr = [Skus]()
               for i in 0 ..< addArray.count {
                   dataArr.append(addArray[i])
               }
               combinationArray.append(dataArr)
           }
    }
    
    
    
    
//    func getCombination(kid: Int,
//                           inputArray: [[String]],
//                           addArray: [String]) {
//
//           if kid < inputArray.count {
//               let dataArr = inputArray[kid]
//               if dataArr.count == 0 {
//                   return
//               }
//               for i in 0 ..< dataArr.count {
//                   var newArr = addArray
//                   newArr.append(dataArr[i])
//                   getCombination(kid: kid + 1, inputArray: inputArray, addArray: newArr)
//               }
//           } else {
//               var dataArr = [String]()
//               for i in 0 ..< addArray.count {
//                   dataArr.append(addArray[i])
//               }
//               combinationArray.append(dataArr)
//               LXFLog("---------------\(combinationArray)")
//           }
//        LXFLog("---------------\(combinationArray.count)")
//    }
    
    //删除规格专用的newtableview第二组的数据的变化
//    func UnionSetArrayDelete(){
//        var temArray = unIonSetList
//        unIonSetList.removeAll()
//        var valueInt:Int = 0
//        for colorList in saveValueList {
//            if colorList.count > 0{
//               valueInt += 1
//            }
//        }
//        if valueInt > 1{
//                getCombination(kid: 0, inputArray: saveValueList, addArray: [Skus]())
//                unIonSetList = arrayForConsolidationValueThe(array: combinationArray)
//                combinationArray.removeAll()
//        }else{
//            for i in 0..<saveValueList.count{
//                let colorList = saveValueList[i]
//                for specs in colorList{
////                    var array = [Skus]()
//                    let skus = Skus(price: 0, restrictedQty: 0, skuCode: "", skuId: "", skuPics: [String](), specs: [specs], stock: 0)
////                    array.append(skus)
//                    unIonSetList.append(skus)
//                }
//            }
//
//            for skus in temArray {
//                let spec = skus.specs?.first
//                for i in 0..<unIonSetList.count{
//                   var skus1 = unIonSetList[i]
//                    let spec1 = skus1.specs?.first
//                    if spec?.specValue == spec1?.specValue{
//                       skus1 = skus
//                        unIonSetList[i] = skus1
//                       break
//                    }
//                }
//            }
//        }
//    }
    
    
    
    //删除
    @objc func deleteAction(deleteBtn:UIButton){
        saveList.remove(at: deleteBtn.tag)
        addCoutList.remove(at: deleteBtn.tag)
        saveValueList.remove(at: deleteBtn.tag)
//        unIonSetList.removeAll()
        
        UnionSetArray(tag: deleteBtn.tag, index: 0)
        
        
        
        newTableView.reloadData()
    }
    
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
    
    //这里要写一个方法对数组进行便利，对相同的规格进行添加到一个数组中
    //对数据进行整理->对相同的数组里面相同的进行整理
    func arrayConvenienceIsTheSameArray(array:[Specs]) -> [[Specs]]{
        var array1 = array
        var tempArray = [[Specs]]()
        for i in 0..<array1.count {
           let specs = array1[i]
            var temp = [Specs]()
            temp.append(specs)
            for var j in 1..<array.count{
                let specs1 = array[j]
                if specs.specGroupId == specs1.specGroupId{
                    temp.append(specs1)
                    array1.remove(at: j)
                    j -= 1
                }
            }
            tempArray.append(temp)
        }
        return tempArray
    }

    //这里要把俩个规格数组里面的规格值进行整合到一起的方法
    func arrayForConsolidationThe(array:[[Specs]]) -> [Specs]{
        var tempArray = [Specs]()
        let array1 = array
        for i in 0..<array1.count{
           let temp = array1[i]
            for j in 0..<temp.count{
               let specs = temp[j]
                tempArray.append(specs)
            }
        }
        return tempArray
    }
    
    
    
    
    func arrayForConsolidationValueThe(array:[[Skus]]) -> [Skus]{
        var tempArray = [Skus]()
        let array1 = array
        for i in 0..<array1.count{
            var skus = Skus(price: 0,skuCode: "", skuId: 0, skuPics: [String](), specs: [Specs](), stock: 0)
           let temp = array1[i]
            for j in 0..<temp.count{
               let skus1 = temp[j]
                for i in 0..<(skus1.specs?.count ?? 0)  {
                    let spec = skus1.specs![i]
                    skus.specs?.append(spec)
                }
                skus.price = skus1.price
                skus.skuCode = skus1.skuCode
                skus.skuId = skus1.skuId
                skus.skuPics = skus1.skuPics
                skus.stock = skus1.stock
            }
            tempArray.append(skus)
        }
        return tempArray
    }
    
    
    
//    func arrayUnionListIsTheSameArray(array:[Skus]) -> [[Skus]]{
//        var array1 = array
//        var tempArray = [[Skus]]()
//        for i in 0..<array1.count {
//           let skus = array1[i]
//            var value = ""
//            for i in 0..<(skus.specs?.count ?? 0){
//                let specs = skus.specs?[i] as? Specs
//                value += specs?.specValue ?? ""
//            }
//            var temp = [Skus]()
//            temp.append(skus)
//            for var j in 1..<array.count{
//                let skus1 = array[j]
//                var value1 = ""
//                for i in 0..<(skus.specs?.count ?? 0){
//                    let specs = skus.specs?[i] as? Specs
//                    value1 += specs?.specValue ?? ""
//                }
//                if value == value1{
//                    temp.append(skus1)
//                    array1.remove(at: j)
//                    j -= 1
//                }
//            }
//            tempArray.append(temp)
//        }
//        return tempArray
//    }
//
//
//
//    func arrayUnionListChageArray(array:[[Skus]]) -> [Skus]{
//        var tempArray = [Skus]()
//        let array1 = array
//        for i in 0..<array1.count{
//           var skus = Skus(price: 0, restrictedQty: 0, skuCode: "", skuId: "", skuPics: [String](), specs: [Specs](), stock: 0)
//           let temp = array1[i]
//           let skus1 = temp.first
//           skus.specs = skus1?.specs
//           skus.price = skus1?.price
//           skus.restrictedQty = skus1?.restrictedQty
//           skus.skuCode = skus1?.skuCode
//           skus.skuId = skus1?.skuId
//           skus.skuPics = skus1?.skuPics
//           skus.stock = skus1?.stock
//           tempArray.append(skus)
//        }
//        return tempArray
//    }
//
    
    
    
    
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
        for specGroups in saveList {
            if (specGroups.specs?.count ?? 0) > 0 {
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
            let skus = unIonSetList[indexPath.row]
//            var temp = [Specs]()
//            for skus in array{
//                temp.append(skus.specs!.first!)
//            }
            var value:String = ""
            var isSet:Bool = false
            for i in 0..<(skus.specs?.count ?? 0){
                let specs = skus.specs?[i] as? Specs
//                value += sp.specValue ?? ""
                value += specs?.specValue ?? ""
            }
            if ((skus.price ?? 0.0) > 0) && ((skus.stock ?? 0) > 0){
                isSet = true
            }
            if isSet{
                return scale(94)
            }else{
                return scale(60)
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
//            cell.specificationLabel.text = saveList[indexPath.row]
            let specGroups = saveList[indexPath.row]
            cell.specificationLabel.text = specGroups.specGroupName
            
//            if saveValueList.count > 0{
            cell.colorList = saveValueList[indexPath.row]
//            }
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommodityPriceAndStockCell") as! CommodityPriceAndStockCell
//            let array = unIonSetList[indexPath.row]
//            var temp = [Specs]()
//            for skus in array{
//                temp.append(skus.specs!.first!)
//            }
//            var value:String = ""
//            for i in 0..<temp.count{
//                let specs = temp[i] as Specs
//                value += specs.specValue ?? ""
//            }
//            var isSet:Bool = false
//            for skus in array{
//                if ((skus.price ?? 0.0) > 0) && ((skus.stock ?? 0) > 0){
//                    isSet = true
//                    break
//                }
//            }
            
            let skus = unIonSetList[indexPath.row]
//            var temp = [Specs]()
//            for skus in array{
//                temp.append(skus.specs!.first!)
//            }
            var value:String = ""
            var isSet:Bool = false
            for i in 0..<(skus.specs?.count ?? 0){
                let specs = skus.specs?[i] as? Specs
//                value += sp.specValue ?? ""
                value += specs?.specValue ?? ""
            }
            if ((skus.price ?? 0.0) > 0) && ((skus.stock ?? 0) > 0){
                isSet = true
            }
            
            cell.specificationLabel.text = value
            if isSet{
                cell.diviver.isHidden = false
                cell.midView.isHidden = false
//                let skus = array.first
                let doubleValue = Double(truncating: skus.price as? NSNumber ?? 0.0)
                let price = String(format: "%0.3f", doubleValue)
                let int32Value = Int32(truncating: skus.stock as? NSNumber ?? 0)
                let stock = String(format: "%d", int32Value)
                cell.priceLabel.text = "价格:¥" + price
                cell.stockLabel.text = "库存:" + stock
                //颜色
                cell.isSettingLabel.text = "已设置"
                cell.isSettingLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            }else{
                cell.diviver.isHidden = true
                cell.midView.isHidden = true
                cell.isSettingLabel.text = "未设置"
                cell.isSettingLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F13232")
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
            var skus = unIonSetList[indexPath.row]
            self.popup.bottomSheet {
//                let settingPriceAndStockView = SettingPriceAndStockView(frame: CGRect(x: 0, y: 0, width: SCW, height: SCH - Height_NavBar),Skus)
                let settingPriceAndStockView = SettingPriceAndStockView(frame: CGRect(x: 0, y: 0, width: SCW, height: SCH - Height_NavBar), skus: skus)
                settingPriceAndStockView.viewController = self
                settingPriceAndStockView.cancelBlock = {[weak self] in
                    self?.popup.dismissPopup()
//                    self?.newTableView.reloadData()
                }
                
                //这里要传回添加完成之后的值
                settingPriceAndStockView.settingBlock = {[weak self] list in
                    skus = list
                    self?.unIonSetList[indexPath.row] = skus
                    self?.popup.dismissPopup()
                    self?.newTableView.reloadData()
                }
                return settingPriceAndStockView
            }
        }
    }
}


extension CommoditySpecificationsViewController:CommoditySpecificationCellDelegate{
    
    //删除规格值
    func deleteSaveListTagAndIndex(tag: Int, index: Int) {
        var colorList = saveValueList[tag]
        let spec = colorList[index]
        colorList.remove(at: index)
        
        saveValueList[tag] = colorList
        
        var specGroups = saveList[tag]
        for i in 0..<(specGroups.specs?.count ?? 0){
            let str = specGroups.specs?[i]
            if str == spec.specValue{
               specGroups.specs?.remove(at: i)
               break
            }
        }
        saveList[tag] = specGroups
        
        LXFLog("=========================\(saveValueList)")
        LXFLog("=========================\(saveList)")
        
        UnionSetArray(tag: tag, index: index)
        newTableView.reloadData()
    }
    
    
    //修改规格值
    func modityTextfieldTagAndIndexAndValue(tag: Int, index: Int, value: String) {
        if value != ""{
            var colorList = saveValueList[tag]
            var specs = colorList[index]
            specs.specValue = value
            colorList[index] = specs
            
           saveValueList[tag] = colorList
           var specGroups = saveList[tag]
           specGroups.specs?.append(value)
           saveList[tag] = specGroups
            
            LXFLog("=========================\(saveValueList)")
           LXFLog("=========================\(saveList)")
            
           UnionSetArray(tag: tag, index: index)
           newTableView.reloadData()
    
        }
    }
    
    
  
    
}
