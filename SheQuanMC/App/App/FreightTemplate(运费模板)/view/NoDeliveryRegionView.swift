//
//  NoDeliveryRegionView.swift
//  App
//
//  Created by mac on 2022/5/13.
//

import UIKit
import JFPopup
import Util
import SwiftyJSON

class NoDeliveryRegionView: UIView {
    
    
 


    //这边添加标题视图
    lazy var titleView:UIView = {
       let titleView = UIView()
        titleView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
       return titleView
    }()
    
    
    
    //这边添加标题和底部按键的横线
    lazy var lineView:UIView = {
       let lineView = UIView()
        return lineView
    }()
    
    
    lazy var tableview:NoDeliveryTableView = {
        let tableview = NoDeliveryTableView(frame: .zero, style: .plain)
        return tableview
    }()
    
    
    
//    lazy var contentScrollView:UIScrollView = {
//       let contentScrollView = UIScrollView()
//        contentScrollView.showsHorizontalScrollIndicator = false
//        contentScrollView.bounces = false
//        return contentScrollView
//    }()
    
    //中间值的按键和底部横线
    var preBtn:UIButton?
    
    
    
    
    
    
    //标题数组
    var titleArray:[RegionInfoModel] = [RegionInfoModel]()
    
    var titleBtnArray:[UIButton] = [UIButton]()
    //省份数组
    var dataArray:[RegionInfoModel] = [RegionInfoModel]()
    //城市数组
    var cityArray:[RegionInfoModel] = [RegionInfoModel]()
    //取消的闭包
    var cancelBlock:(()->Void)?
    //确定的闭包
    var sureChoiceAddress:((_ addreList:[RegionInfoModel]) ->Void)?
    
    
    //添加不配送区域的数组
    var addNewNoAreaList:[RegionInfoModel] = [RegionInfoModel]()
    //点击不配送区域的cell的模型
    var regionInfoModel:RegionInfoModel?
    //跳转的方式 0为添加区域按键 1位cell点击的动作
    var jumpType:Int = 0
    
    
    init(frame: CGRect,regionInfoModel:RegionInfoModel,addNewNoAreaList:[RegionInfoModel],dataArray:[RegionInfoModel],jumpType:Int) {
        super.init(frame: frame)
        
//        self.titleArray = addressList
        
        self.addNewNoAreaList = addNewNoAreaList
        
        self.regionInfoModel = regionInfoModel
        
        self.jumpType = jumpType
        
        var regionInfoModel = RegionInfoModel(initials: "0", lat: 0, level: 2, lng: 0, regionId: 0, regionName: "请选择", checked: false,childNodes: [RegionInfoModel]())
        titleArray.append(regionInfoModel)
        
        
        
        self.dataArray = dataArray
        backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        let titleLabel = UILabel()
        titleLabel.text = "请选择"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        titleLabel.font = UIFont.systemFont(ofSize: scale(17), weight: .regular)
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(16)
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(24))
        }
        
        let cancelBtn = UIButton()
        cancelBtn.tag = 0
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(17), weight: .regular)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(15))
            make.width.equalTo(scale(70))
            make.height.equalTo(scale(24))
        }
        
        let sureBtn:UIButton = UIButton.init(type: .custom)
        sureBtn.tag = 1
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"), for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(17), weight: .regular)
        sureBtn.addTarget(self, action: #selector(sureBtnClicked), for: .touchUpInside)
        addSubview(sureBtn)
        
        sureBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(15))
            make.width.equalTo(scale(70))
            make.height.equalTo(scale(24))
        }
        
        
       let diviver = UIView()
       diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
       addSubview(diviver)
        diviver.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
            make.height.equalTo(scale(0.5))
            make.top.equalTo(titleLabel.snp.bottom).offset(scale(14))
        }
        
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(diviver.snp.bottom)
            make.height.equalTo(scale(44))
        }
        
//        addSubview(contentScrollView)
//        contentScrollView.snp.makeConstraints { make in
//            make.left.bottom.equalToSuperview()
//            make.top.equalTo(titleView.snp.bottom)
//            make.width.equalTo(SCW)
//        }
        
        addSubview(tableview)
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        tableview.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
        }
        
        if jumpType == 0{
            //点击了添加不配送区域的按键的动作
            addTitleView()
            addSubviewContentView()
//            let count = (titleArray.count > 2 ? 1 : titleArray.count - 1)
            let btn = titleBtnArray[titleArray.count - 1]
//            changBtnTitle(titleBtn: btn)
            titleBtnClick(titleBtn: btn)
            LXFLog("+===============================\(titleArray.count)")
            
        }else{
            //点击了不配送区域cell的动作
//            regionInfoModel.regionName = noDeliveryRegionListModel.province
            regionInfoModel.checked = true
            regionInfoModel.regionName = self.regionInfoModel?.regionName
            titleArray[0] = regionInfoModel
//          let provinceM = self.dataArray[index]
//            self.cityArray = provinceM.childNodes!
            
            var regionInfoModel1 = RegionInfoModel(initials: "0", lat: 0, level: 3, lng: 0, regionId: 0, regionName: "请选择", checked: false,childNodes: [RegionInfoModel]())
            self.cityArray.removeAll()
            for i in 0..<self.dataArray.count{
                let provinceM = self.dataArray[i]
                if self.regionInfoModel?.regionId == provinceM.regionId{
                    if (provinceM.childNodes?.count ?? 0) > 0{
                        self.cityArray = (provinceM.childNodes ?? [regionInfoModel])
                    }
                }
            }
            
            if self.regionInfoModel?.checked == true{
                //全选
                //这边要先判断是否是全选的状态要是全选的话，就是添加一个该省的全选的状态的网络请求
                if (self.regionInfoModel?.childNodes?.count ?? 0) > 0{
                    for n in 0..<self.cityArray.count {
                        var regionInfoModel2 = self.cityArray[n]
                        regionInfoModel2.checked = true
                        self.cityArray[n] = regionInfoModel2
                    }
                    
                    let regionInfoModel5 = RegionInfoModel(initials: "0", lat: 0, level: 3, lng: 0, regionId: 0, regionName: "全选", checked:true,childNodes: [RegionInfoModel]())
                    self.cityArray.insert(regionInfoModel5, at: 0)
                    
                    regionInfoModel1.regionName = "全选"
                    regionInfoModel1.checked = true
                    titleArray.append(regionInfoModel1)
                    
                    //这边是已经有选择了城市了
//                    let parameters = ["level":3,"regionId":350000 as Any] as [String:Any]
//                    NetWorkResultRequest(OrderApi.getFreightRegionList(parameters: parameters), needShowFailAlert: true) { result, data in
//                        guard let model = try? JSONDecoder().decode(GenericResponse<[RegionInfoModel]>.self, from: data) else { return }
//                        self.cityArray.removeAll()
//                        if let _data = model.data{
//                            self.cityArray = _data
//                        }
//                        for i in 0..<self.cityArray.count {
//                            var noDevliveryRegionMoel4 = self.cityArray[i]
//                            noDevliveryRegionMoel4.checked = true
//                            self.cityArray[i] = noDevliveryRegionMoel4
//                        }
//                        let regionInfoModel5 = RegionInfoModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "全选", checked: true,childNodes: [RegionInfoModel]())
//                        self.cityArray.insert(regionInfoModel5, at: 0)
//                        self.addTitleView()
//                        self.addSubviewContentView()
//                        let btn = self.titleBtnArray[self.titleArray.count - 1]
//                        self.titleBtnClick(titleBtn: btn)
//                    } failureCallback: { error, code in
//                        code.loginOut()
//                    }
                }else{
                    //针对于没有城市的地方，比如台湾省
                    let regionInfoModel5 = RegionInfoModel(initials: "0", lat: 0, level: 3, lng: 0, regionId: 0, regionName: "全选", checked:true,childNodes: [RegionInfoModel]())
                    self.cityArray.insert(regionInfoModel5, at: 0)
                    
                    regionInfoModel1.regionName = "全选"
                    regionInfoModel1.checked = true
                    titleArray.append(regionInfoModel1)
                }
            }else{
                //没有全选
                
//                let regionInfoModel5 = RegionInfoModel(initials: "0", lat: 0, level: 3, lng: 0, regionId: 0, regionName: "请选择", checked: false,childNodes: [RegionInfoModel]())
                regionInfoModel1.checked = true
                
                
                for j in 0..<(self.regionInfoModel?.childNodes?.count ?? 0) {
                    let regionInfoModel3 = self.regionInfoModel?.childNodes?[j]
                    for n in 0..<self.cityArray.count {
                        let regionInfoModel2 = self.cityArray[n]
                        if regionInfoModel3?.regionId == regionInfoModel2.regionId{
                            self.cityArray[n] = regionInfoModel3!
                        }
                    }
                }
                
                let regionInfoModel6 = RegionInfoModel(initials: "0", lat: 0, level: 3, lng: 0, regionId: 0, regionName: "全选", checked:false,childNodes: [RegionInfoModel]())
                self.cityArray.insert(regionInfoModel6, at: 0)
                
                for i in 0..<self.cityArray.count {
                    let regionInfoModel = self.cityArray[i]
                    if regionInfoModel.checked == true{
                        regionInfoModel1.regionName = regionInfoModel.regionName
                        break
                    }
                }
                titleArray.append(regionInfoModel1)
               
                
                
//                let parameters = ["level":3,"regionId":350000 as Any] as [String:Any]
//                NetWorkResultRequest(OrderApi.getFreightRegionList(parameters: parameters), needShowFailAlert: true) { result, data in
//                    guard let model = try? JSONDecoder().decode(GenericResponse<[RegionInfoModel]>.self, from: data) else { return }
//                    self.cityArray.removeAll()
//                    if let _data = model.data{
//                        self.cityArray = _data
//                    }
//                    let regionInfoModel5 = RegionInfoModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "全选", checked: false,childNodes: [RegionInfoModel]())
//                    self.cityArray.insert(regionInfoModel5, at: 0)
//                    for i in 0..<(regionInfoModel.childNodes?.count ?? 0){
////                        let regionInfoModel6 = self.titleArray[i]
////                        let city = self.noDeliveryRegionListModel?.citys?[i]
//                        let regionInfoModel2 = regionInfoModel.childNodes?[i]
//                        for j in 0..<self.cityArray.count {
//                            var regionInfoModel = self.cityArray[j]
//                            if regionInfoModel.regionName == regionInfoModel2?.regionName{
////                                regionInfoModel.checked = true
////                                regionInfoModel.regionName = city
//                                self.cityArray[j] = regionInfoModel2!
//                            }
//                        }
//                    }
//
//                } failureCallback: { error, code in
//                    code.loginOut()
//                }
            }
            self.addTitleView()
            self.addSubviewContentView()
//                    let count = (self.titleArray.count > 2 ? 1 : self.titleArray.count - 1)
            let btn = self.titleBtnArray[self.titleArray.count - 1]
//                    self.changBtnTitle(titleBtn: btn)
            self.titleBtnClick(titleBtn: btn)
        }
       
//        if self.titleArray.count < 1{
        
//        addTitleView()
//        addSubviewContentView()
////            let count = (titleArray.count > 2 ? 1 : titleArray.count - 1)
//        let btn = titleBtnArray[titleArray.count - 1]
////            changBtnTitle(titleBtn: btn)
//        titleBtnClick(titleBtn: btn)
//        }
//        else{
//            var noDeliveryRegionModel = titleArray[0] as NoDeliveryRegionModel
//                    //这个是要选中状态
//                    noDeliveryRegionModel.isChoice = true
//                    let noDeliveryRegionModel2 = titleArray[1] as NoDeliveryRegionModel
//                    if noDeliveryRegionModel2.regionName == "全选"{
//                        let parameters = ["level":3,"regionId":noDeliveryRegionModel.regionId as Any] as [String:Any]
//                        NetWorkResultRequest(OrderApi.getRegionInfoList(parameters: parameters), needShowFailAlert: true) { result, data in
//                            guard let model = try? JSONDecoder().decode(GenericResponse<[NoDeliveryRegionModel]>.self, from: data) else { return }
//                            self.cityArray.removeAll()
//                            if let _data = model.data{
//                                self.cityArray = _data
//                            }
//                            for i  in 0..<self.cityArray.count {
//                                var noDevliveryRegionMoel4 = self.cityArray[i]
//                                noDevliveryRegionMoel4.isChoice = true
//                                self.cityArray[i] = noDevliveryRegionMoel4
//                            }
//                            let noDeliveryRegionModel5 = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "全选", isChoice: true)
//                            self.cityArray.insert(noDeliveryRegionModel5, at: 0)
//                            self.addTitleView()
//                            self.addSubviewContentView()
//                            let count = (self.titleArray.count > 2 ? 1 : self.titleArray.count - 1)
//                            let btn = self.titleBtnArray[count]
//                            self.changBtnTitle(titleBtn: btn)
//                        } failureCallback: { error, code in
//                            code.loginOut()
//                        }
//                    }else{
//                        let parameters = ["level":3,"regionId":noDeliveryRegionModel.regionId as Any] as [String:Any]
//                        NetWorkResultRequest(OrderApi.getRegionInfoList(parameters: parameters), needShowFailAlert: true) { result, data in
//                            guard let model = try? JSONDecoder().decode(GenericResponse<[NoDeliveryRegionModel]>.self, from: data) else { return }
//                            self.cityArray.removeAll()
//                            if let _data = model.data{
//                                self.cityArray = _data
//                            }
//                            let noDeliveryRegionModel5 = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "全选", isChoice: false)
//                            self.cityArray.insert(noDeliveryRegionModel5, at: 0)
//                            for i in 0..<self.titleArray.count{
//                                let noDeliveryRegionModel6 = self.titleArray[i]
//                                for j in 0..<self.cityArray.count {
//                                    let noDeliveryRegionModel7 = self.cityArray[j]
//                                    if noDeliveryRegionModel7.regionName == noDeliveryRegionModel6.regionName{
//                                        self.cityArray[j] = noDeliveryRegionModel6
//                                    }
//                                }
//                            }
//                            self.addTitleView()
//                            self.addSubviewContentView()
//                            let count = (self.titleArray.count > 2 ? 1 : self.titleArray.count - 1)
//                            let btn = self.titleBtnArray[count]
//                            self.changBtnTitle(titleBtn: btn)
//                        } failureCallback: { error, code in
//                            code.loginOut()
//                        }
//                    }
//        }
    }
    
    
    func addTitleView(){
        addTitleBtnAndUnline()
        addUnLineView()
    }
    
    
    func addTitleBtnAndUnline(){
        for view in titleView.subviews {
           view.removeFromSuperview()
        }
        let btnH = scale(44)
        titleBtnArray.removeAll()
        let btnW = scale(120)
        for i in 0..<titleArray.count{
            let noDeliveryRegionModel = titleArray[i]
            let titleBtn = UIButton()
            titleView.addSubview(titleBtn)
            titleBtn.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.height.equalTo(btnH)
                make.left.equalTo(CGFloat(i) * btnW)
                make.width.equalTo(btnW)
            }
            titleBtn.tag = i
            titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
            titleBtn.setTitle(noDeliveryRegionModel.regionName, for: .normal)
            titleBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"), for: .normal)
            titleBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .selected)
            titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
            titleBtnArray.append(titleBtn)
        }
    }
    
    func addUnLineView(){
//        let count = (titleArray.count > 2 ? 1 : titleArray.count - 1)
        let titleBtn = titleBtnArray[titleArray.count - 1]
        lineView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        titleView.addSubview(lineView)
        titleBtn.titleLabel?.sizeToFit()
        lineView.snp.makeConstraints({ make in
            make.bottom.equalTo(-scale(5))
            make.width.equalTo((titleBtn.titleLabel?.bounds.size.width)!)
            make.centerX.equalTo(titleBtn.snp.centerX)
            make.height.equalTo(scale(2))
        })
    }
    
    //选中的按键
    @objc func titleBtnClick(titleBtn:UIButton){
        preBtn?.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
        preBtn?.isSelected = false
        titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
        titleBtn.isSelected = true
        titleBtn.titleLabel?.sizeToFit()
        preBtn = titleBtn
        let tag = titleBtn.tag
        preBtn?.tag = tag
        //下滑线变化
        UIView.animate(withDuration: 0.25) {
            self.lineView.snp.remakeConstraints({ make in
                make.bottom.equalTo(-scale(5))
                make.width.equalTo((titleBtn.titleLabel?.bounds.size.width)!)
                make.centerX.equalTo(titleBtn.snp.centerX)
                make.height.equalTo(scale(2))
            })
        }
        if titleBtn.tag == 0{
//            contentScrollView.subviews.forEach { view in
//                if view.isKind(of: UITableView.self){
//                    let tableview = view as! NoDeliveryTableView
//                    titleArray.removeAll()
                   if titleArray.count > 1{
                      titleArray.removeLast()
                      var regionInfoModel = titleArray[0]
                       regionInfoModel.regionName = "请选择"
                      titleArray[0] = regionInfoModel
                      addTitleView()
                    }
            
//                    for var addressmodel in self.dataArray {
//                        addressmodel.isChoice = false
//                    }
                    //let noDeliveryRegionModel = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "请选择", isChoice: false)
                    //titleArray.append(noDeliveryRegionModel)
                    tableview.titleStringArray = self.dataArray
                    tableview.titleArray = titleArray
                    tableview.reloadData()
//                    self.addTitleView()
//                    for view in titleView.subviews {
//                        if view.isKind(of: UIButton.self){
//                            let btn = view as! UIButton
//                            btn.isSelected = true
//                        }
//                    }
//                }
//            }
        }
    }
    
//    func changBtnTitle(titleBtn:UIButton){
//        preBtn?.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
//        preBtn?.isSelected = false
//        titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
//        titleBtn.isSelected = true
//        titleBtn.titleLabel?.sizeToFit()
//        preBtn = titleBtn
//        let tag = titleBtn.tag
//        preBtn?.tag = tag
//        //下滑线变化
//        UIView.animate(withDuration: 0.25) {
//            self.lineView.snp.remakeConstraints({ make in
//                make.bottom.equalTo(-scale(5))
//                make.width.equalTo((titleBtn.titleLabel?.bounds.size.width)!)
//                make.centerX.equalTo(titleBtn.snp.centerX)
//                make.height.equalTo(scale(2))
//            })
//        }
//    }
    
    func addSubviewContentView(){
        if titleArray.count == 1{
            tableview.titleStringArray = self.dataArray
        }else{
            tableview.titleStringArray = self.cityArray
        }
        tableview.titleArray = self.titleArray
        tableview.reloadData()
        tableview.backSelectType = {regionInfoModel,index,tableview in
            if self.titleArray.count == 1{
                let provinceM = self.dataArray[index]
                self.titleArray[0] = regionInfoModel
                if (provinceM.childNodes?.count ?? 0) > 0{
                    self.cityArray = (provinceM.childNodes ?? [regionInfoModel])
                }
                var regionInfoModel1 = RegionInfoModel(initials: "0", lat: 0, level: 3, lng: 0, regionId: 0, regionName: "请选择", checked: false,childNodes: [RegionInfoModel]())
                self.titleArray.append(regionInfoModel1)
                
                //添加省份
                self.regionInfoModel = provinceM
                self.regionInfoModel?.checked = false
                //然后情况该情况的选择的省份
                self.regionInfoModel?.childNodes?.removeAll()
                
                for i in 0..<self.addNewNoAreaList.count{
                    let regionInfoModel2 = self.addNewNoAreaList[i]
                    for n in 0..<(regionInfoModel2.childNodes?.count ?? 0){
                        let regionInfoModel3 = regionInfoModel2.childNodes?[n]
                        for j in 0..<self.cityArray.count {
                            var regionInfoModel = self.cityArray[j]
                            if regionInfoModel.regionId == regionInfoModel3?.regionId{
                                regionInfoModel.checked = true
                                regionInfoModel.regionName = regionInfoModel3?.regionName
                                self.cityArray[j] = regionInfoModel
                            }
                        }
                    }
                }
                //用来判断是否是全选的状态
                var regionInfoModel2 = RegionInfoModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "全选", checked: false,childNodes: [RegionInfoModel]())
                var isAllChoice = true
                for i in 0..<self.cityArray.count {
                    let regionInfoModel = self.cityArray[i]
                    if regionInfoModel.checked == false{
                        isAllChoice = false
                        break
                    }
                }
                if isAllChoice{
                    if self.cityArray.count > 0{
                        regionInfoModel2.checked = true
                        self.regionInfoModel?.checked = true
                        regionInfoModel1.regionName = "全选"
                        self.titleArray[1] = regionInfoModel1
                    }else{
                        regionInfoModel1.regionName = "请选择"
                        regionInfoModel2.checked = false
                        self.regionInfoModel?.checked = false
                        self.titleArray[1] = regionInfoModel1
                    }
                }
                else{
                    regionInfoModel2.checked = false
                    self.regionInfoModel?.checked = false
                    for i in 0..<self.cityArray.count {
                        let regionInfoModel = self.cityArray[i]
                        if regionInfoModel.checked == true{
                            regionInfoModel1.regionName = regionInfoModel.regionName
                            break
                        }
                    }
                }
               
//                   self.noDeliveryRegionListModel?.province = regionInfoModel.regionName
                //然后添加cityArray选中的城市
                for i in 0..<self.cityArray.count {
                    let regionInfoModel = self.cityArray[i]
                    if regionInfoModel.checked == true{
                        self.regionInfoModel?.childNodes?.append(regionInfoModel)
                    }
                }
                
                self.cityArray.insert(regionInfoModel2, at: 0)
                
//                 let parameters = ["level":3,"regionId":provinceM.regionId as Any] as [String:Any]
//                 NetWorkResultRequest(OrderApi.getFreightRegionList(parameters: parameters), needShowFailAlert: true) { result, data in
//                     guard let model = try? JSONDecoder().decode(GenericResponse<[RegionInfoModel]>.self, from: data) else { return }
//                     self.cityArray.removeAll()
//                     if let _data = model.data{
//                         self.cityArray = _data
//                     }
//
//                     for i in 0..<self.addNewNoAreaList.count{
//                         let regionInfoModel2 = self.addNewNoAreaList[i]
//                         for n in 0..<(regionInfoModel2.childNodes?.count ?? 0){
//                             let regionInfoModel3 = regionInfoModel2.childNodes?[n]
//                             for j in 0..<self.cityArray.count {
//                                 var regionInfoModel = self.cityArray[j]
//                                 if regionInfoModel.regionName == regionInfoModel3?.regionName{
//                                     regionInfoModel.checked = true
//                                     regionInfoModel.regionName = regionInfoModel3?.regionName
//                                     self.cityArray[j] = regionInfoModel
//                                 }
//                             }
//                         }
//                     }
//
//                     //用来判断是否是全选的状态
//                     var regionInfoModel2 = RegionInfoModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "全选", checked: false,childNodes: [RegionInfoModel]())
//                     var isAllChoice = true
//                     for i in 0..<self.cityArray.count {
//                         let regionInfoModel = self.cityArray[i]
//                         if regionInfoModel.checked == false{
//                             isAllChoice = false
//                             break
//                         }
//                     }
//                     if isAllChoice{
//                         regionInfoModel2.checked = true
//                     }
//                     else{
//                         regionInfoModel2.checked = false
//                     }
//                     self.cityArray.insert(regionInfoModel2, at: 0)
////                   self.noDeliveryRegionListModel?.province = regionInfoModel.regionName
//                     //然后添加cityArray选中的城市
//                     for i in 0..<self.cityArray.count {
//                         let regionInfoModel = self.cityArray[i]
//                         if regionInfoModel.checked == true{
////                             self.noDeliveryRegionListModel?.citys?.append(<#T##Element#>)
//                         }
//                     }
////                     self.noDeliveryRegionListModel?.citys.app
//                     //这里的城市数组要和其他的地方的数组做对比
//                     if self.jumpType == 0{
//                          //为点击添加不配送区域按键的动作
//                     }else{
//                         //点击不配送区域cell的动作
//                         //self._noDeliveryRegionListModel?.citys
//                     }
//                } failureCallback: { error, code in
//                     code.loginOut()
//                }
            }else{
                
                //首先是什么省的，省里面有没有该城市，没有就添加到该省，有就取消，获取移除
                
                
               

                //对数组进行处理
//                var isOnly:Bool = true
//                for i in 0..<self.titleArray.count{
//                    let regionInfoModel1 = self.titleArray[i]
//                    if regionInfoModel.regionName == regionInfoModel1.regionName{
//                        self.titleArray[i] = regionInfoModel
//                        isOnly = false
//                        break
//                    }
//                }
//                if isOnly{
//                    self.titleArray.append(regionInfoModel)
//                }
                
                
                //这边要要做得判断是这个模型里面有没有值
                var isOnly:Bool = true
                for i in 0..<(self.regionInfoModel?.childNodes?.count ?? 0){
                    let regionInfoModel1 = self.regionInfoModel?.childNodes![i]
                    if regionInfoModel1?.regionId == regionInfoModel.regionId{
                        self.regionInfoModel?.childNodes![i] = regionInfoModel
                        isOnly = false
                        break
                    }
                }


                if isOnly{
                    self.regionInfoModel?.childNodes?.append(regionInfoModel)
                }
                
                
                self.cityArray[index] = regionInfoModel
                        
                //全选的变化
                var isAllChoice = true
                for i in 0..<tableview.titleStringArray.count{
                    let regionInfoModel1 = tableview.titleStringArray[i]
                    if regionInfoModel1.regionName == "全选"{
                        continue
                    }
                    if regionInfoModel1.checked == false{
                        isAllChoice = false
                        break
                    }
                }
                
                if isAllChoice{
                    
                    var regionInfoModel2 = tableview.titleStringArray[0]
                    regionInfoModel2.checked = true
                    tableview.titleStringArray[0] = regionInfoModel2
//                  self.titleArray.insert(regionInfoModel2, at: 1)
                    self.cityArray[0] = regionInfoModel2
                    
                    //全选的状态
                    self.regionInfoModel?.checked = true
                    
                    
                    var regionInfoModel = self.titleArray[1]
                    regionInfoModel.regionName = "全选"
                    regionInfoModel.checked = true
                    self.titleArray[1] = regionInfoModel
                    
                    
//                    let regionInfoModelC = self.cityArray[0]
//                    regionInfoModel.checked = true
//                    self.cityArray[0] = regionInfoModelC
                    
                    
                    
                    
                }else{
                    
                    
                    var regionInfoModel2 = tableview.titleStringArray[0]
                    regionInfoModel2.checked = false
                    tableview.titleStringArray[0] = regionInfoModel2
                    self.cityArray[0] = regionInfoModel2
                    //不是全选的状态
                    self.regionInfoModel?.checked = false
                    var regionInfoModel = self.titleArray[1]
                    
                    if (self.regionInfoModel?.childNodes?.count ?? 0) > 0{
                        for i in 0..<(self.regionInfoModel?.childNodes?.count ?? 0){
                            let regionInfoModel1 = self.regionInfoModel?.childNodes?[i]
                            if regionInfoModel1?.checked == true{
                               regionInfoModel.regionName = regionInfoModel1?.regionName
                               regionInfoModel.checked = true
                               break
                            }else{
                                regionInfoModel.regionName = "请选择"
                                regionInfoModel.checked = false
                            }
                        }
                    }else{
                        regionInfoModel.regionName = "请选择"
                        regionInfoModel.checked = false
                    }
                    self.titleArray[1] = regionInfoModel
                    
                    
//                    let regionInfoModelC = self.cityArray[0]
//                    regionInfoModel.checked = false
//                    self.cityArray[0] = regionInfoModelC
                    
//                    for i in 0..<self.titleArray.count {
//                        var regionInfoModel3 = self.titleArray[i]
//                        if regionInfoModel3.regionName == "全选"{
//                            regionInfoModel3.checked = false
//                            self.titleArray[i] = regionInfoModel3
//                        }
//                    }
                }
                
//                self.titleArray = self.titleArray.filter({ regionInfoModel in
//                    regionInfoModel.checked == true
//                })
                
                if (self.regionInfoModel?.childNodes?.count ?? 0) > 0{
                    self.regionInfoModel!.childNodes = self.regionInfoModel!.childNodes?.filter({ regionInfoModel in
                        regionInfoModel.checked == true
                    })
                }
                

//                if self.titleArray.count == 1{
//                    let regionInfoModel1 = RegionInfoModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "请选择", checked: false,childNodes: [RegionInfoModel]())
//                    self.titleArray.append(regionInfoModel1)
//                }
                
                
                
                
                
            }
            
            
            tableview.titleArray = self.titleArray
            tableview.titleStringArray = self.cityArray
            self.addTitleView()
            tableview.reloadData()
//                     let count = (self.titleArray.count > 2 ? 1 : self.titleArray.count - 1)
            let btn = self.titleBtnArray[self.titleArray.count - 1]
//                     self.changBtnTitle(titleBtn: btn)
            self.titleBtnClick(titleBtn: btn)
            
        }
        
        //全选
        tableview.allSelectType = { regionInfoModel,index,tableview,isAllChoice in
            
            if isAllChoice{
                
                
                for regionInfoModel1 in tableview.titleStringArray{
                    if regionInfoModel1.regionName == "全选"{
                       continue
                    }
                    if regionInfoModel1.checked == true{
//                        self.titleArray.append(regionInfoModel1)
                        self.regionInfoModel?.childNodes?.append(regionInfoModel1)
                    }
                }
                
                
                
                var regionInfoModel2 = self.titleArray[1]
                regionInfoModel2.checked = true
                regionInfoModel2.regionName = "全选"
                self.titleArray[1] = regionInfoModel2
                self.regionInfoModel?.checked = true
                
//                for i in 0..<self.titleArray.count {
//                    var regionInfoModel3 = self.titleArray[i]
//                    if regionInfoModel3.regionName == "全选"{
//                        regionInfoModel3.checked = false
//                        self.titleArray[i] = regionInfoModel3
//                    }
//                }
                
//                self.titleArray = self.titleArray.filter({ regionInfoModel in
//                    regionInfoModel.checked == true
//                })
                
                
                var regionInfoModel3 = tableview.titleStringArray[0]
                regionInfoModel3.checked = true
                tableview.titleStringArray[0] = regionInfoModel3
                self.cityArray[0] = regionInfoModel3
                
                for i in 1..<self.cityArray.count {
                    var regionInfoModel = self.cityArray[i]
                    regionInfoModel.checked = true
                    self.cityArray[i] = regionInfoModel
                }
                
                
//                self.titleArray.insert(regionInfoModel2, at: 1)
//                self.titleArray = self.titleArray.noRepetitionUseSet
                
                if (self.regionInfoModel?.childNodes?.count ?? 0) > 0{
                    self.regionInfoModel!.childNodes = self.regionInfoModel!.childNodes!.noRepetitionUseSet
                }
            
            }else{
                
                self.regionInfoModel?.childNodes?.removeAll()
                self.regionInfoModel?.checked = false
                var regionInfoModel3 = tableview.titleStringArray[0]
                regionInfoModel3.checked = false
                tableview.titleStringArray[0] = regionInfoModel3
                self.cityArray[0] = regionInfoModel3
                
//                for i in 1..<self.titleArray.count {
//                    var regionInfoModel = self.titleArray[i]
//                    regionInfoModel.checked = false
//                }
                
//                self.titleArray = self.titleArray.filter({ regionInfoModel in
//                    regionInfoModel.checked == true
//                })
                
                var regionInfoModel2 = self.titleArray[1]
                regionInfoModel2.checked = false
                regionInfoModel2.regionName = "请选择"
                self.titleArray[1] = regionInfoModel2
                
                
                for i in 1..<self.cityArray.count {
                    var regionInfoModel = self.cityArray[i]
                    regionInfoModel.checked = false
                    self.cityArray[i] = regionInfoModel
                }
                
            }
            
            
//            self.titleArray = self.titleArray.filter({ regionInfoModel in
//                regionInfoModel.checked == true
//            })
            
            
//            if self.titleArray.count == 1{
//                let regionInfoModel1 = RegionInfoModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "请选择", checked: false,childNodes: [RegionInfoModel]())
//                self.titleArray.append(regionInfoModel1)
//            }
            
            tableview.titleArray = self.titleArray
            self.addTitleView()
            tableview.reloadData()
//            let count = (self.titleArray.count - 1)
//            let btn = self.titleBtnArray[count]
            // self.changBtnTitle(titleBtn: btn)
            let btn = self.titleBtnArray[self.titleArray.count - 1]
            self.titleBtnClick(titleBtn: btn)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //取消
    @objc func cancelBtnClicked(){
        cancelBlock!()
    }
    
    //确定
    @objc func sureBtnClicked(){
//        LXFLog("=========================\(self.titleArray)")
        var isChoiceComplete:Bool = true
        //这里要把需要的东西传递出去
        for view in titleView.subviews {
            if view.isKind(of: UIButton.self){
                let btn = view as! UIButton
                if btn.currentTitle == "请选择"{
                    isChoiceComplete = false
                    break
                }
            }
        }
        if isChoiceComplete == false{
            JFPopup.toast(hit: "请选择完整的地址")
            return
        }
        //把数组传递出去
//        LXFLog("===========================\(titleArray)")
        //这边要做得事情是把数组传递出去
        if self.addNewNoAreaList.count > 0{
            for n in 0..<self.addNewNoAreaList.count {
                let regionInfoModel = self.addNewNoAreaList[n]
                if regionInfoModel.regionId == self.regionInfoModel?.regionId{
                    self.addNewNoAreaList[n] = self.regionInfoModel!
                    break
                }
            }
            /**
             这种情况是判断数组中是否包含所求的 String
             let class3_2 = ["LiMing", "LiHua", "XiaoWang", "Uzi"]
             let studentName = "Uzi"

             if class3_2.contains(where: { $0.caseInsensitiveCompare(studentName) == .orderedSame }) {
                 print("Uzi! He is still alive!")
             }
             */
            if self.addNewNoAreaList.contains(where: { $0.regionId == self.regionInfoModel?.regionId}){
               LXFLog("=====================1")
                
            }else{
                self.addNewNoAreaList.append(self.regionInfoModel!)
                LXFLog("====================2")
            }
        }else{
            self.addNewNoAreaList.append(self.regionInfoModel!)
        }
        sureChoiceAddress?(self.addNewNoAreaList)
    }
}

extension Array where Element:Hashable{
    /// 返回剔除重复元素后的数组,其元素顺序不变
    public var noRepetitionUseSet:[Element]{
        var set = Set<Element>(self)
        var resultAry = [Element]()
        for item in self{
            if set.contains(item){
                //只会保留第一个重复元素!!!
                resultAry.append(item)
                set.remove(item)
            }
        }
        return resultAry
    }
}



class NoDeliveryTableView:UITableView{
    
  
    //选择值得时候
    var backSelectType:((_ addressmodel:RegionInfoModel,_ index:Int,_ tableview:NoDeliveryTableView)->Void)?
    
    //全选和取消的时候
    var allSelectType:((_ addressmodel:RegionInfoModel,_ index:Int,_ tableview:NoDeliveryTableView,_ isAllChoice:Bool)->Void)?
    
    
    var titleStringArray:[RegionInfoModel] = [RegionInfoModel]()
    
    //用来判断是省份还是城市
    var titleArray:[RegionInfoModel] = [RegionInfoModel]()
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        estimatedSectionFooterHeight = 0
        estimatedSectionHeaderHeight = 0
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollIndicatorInsets = false
        }
        if #available(iOS 15.0, *) {
            sectionHeaderTopPadding = 0
        }
        self.register(NoDeliveryTableviewCell.self, forCellReuseIdentifier: "NoDeliveryTableviewCell")
    }
    
    
    //选择全省
//    @objc func allProvinceChoiceAction(isChoiceBtn:UIButton){
//
//
//    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NoDeliveryTableView:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleStringArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoDeliveryTableviewCell") as! NoDeliveryTableviewCell
        let provinceM = titleStringArray[indexPath.row]
        cell.addressLabel.text = provinceM.regionName
        cell.isChoiceBtn.tag = indexPath.row
//        cell.isChoiceBtn.addTarget(self, action: #selector(allProvinceChoiceAction), for: .touchUpInside)
        //这里还要判断是否已经选择
        if titleArray.count == 1{
            cell.isChoiceBtn.isHidden = true
            cell.addressLabel.snp.remakeConstraints { make in
                make.left.equalTo(scale(16))
                make.right.equalTo(-scale(40))
                make.height.equalTo(scale(22))
                make.centerY.equalToSuperview()
            }
        }else{
            cell.isChoiceBtn.isHidden = false
            cell.addressLabel.snp.remakeConstraints { make in
                make.left.equalTo(cell.isChoiceBtn.snp.right).offset(scale(8))
                make.right.equalTo(-scale(40))
                make.height.equalTo(scale(22))
                make.centerY.equalToSuperview()
            }
        }
        if titleArray.count > 1{
            if provinceM.checked ?? false{
                cell.isChoiceBtn.isSelected = true
            }else{
                cell.isChoiceBtn.isSelected = false
            }
        }
        
        if titleArray.count == 1{
            cell.rightImage.isHidden = false
        }else{
            cell.rightImage.isHidden = true
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //这边要带回去
        if titleArray.count == 1{
            var provinceM = titleStringArray[indexPath.row]
           //这边要进行更改
            let cell = tableView.cellForRow(at: indexPath) as! NoDeliveryTableviewCell
            for i in 0..<self.titleStringArray.count{
               var provinceM1 = titleStringArray[i]
               provinceM1.checked = false
               titleStringArray[i] = provinceM1
            }
            cell.isChoiceBtn.isSelected = !cell.isChoiceBtn.isSelected
            provinceM.checked = cell.isChoiceBtn.isSelected
            titleStringArray[indexPath.row] = provinceM
            if cell.isChoiceBtn.isSelected{
                backSelectType!(provinceM,indexPath.row,self)
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }else{
            //点击了全选
            if indexPath.row == 0{
                var provinceM = titleStringArray[indexPath.row]
                let cell = tableView.cellForRow(at: indexPath) as! NoDeliveryTableviewCell
                cell.isChoiceBtn.isSelected = !cell.isChoiceBtn.isSelected
                provinceM.checked = cell.isChoiceBtn.isSelected
                titleStringArray[indexPath.row] = provinceM
                for i in 0..<titleStringArray.count{
                    var addressmodel = titleStringArray[i]
                    addressmodel.checked = cell.isChoiceBtn.isSelected
                    titleStringArray[i] = addressmodel
                }
                allSelectType!(provinceM,indexPath.row,self,cell.isChoiceBtn.isSelected)
            }else{
                //没有点击全选
                let cell = tableView.cellForRow(at: indexPath) as! NoDeliveryTableviewCell
                var provinceM = titleStringArray[indexPath.row]
                cell.isChoiceBtn.isSelected = !cell.isChoiceBtn.isSelected
                provinceM.checked = cell.isChoiceBtn.isSelected
                titleStringArray[indexPath.row] = provinceM
                backSelectType!(provinceM,indexPath.row,self)
            }
        }
      
    }
}
