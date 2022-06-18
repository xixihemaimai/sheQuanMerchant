//
//  RegionView.swift
//  App
//
//  Created by mac on 2022/5/12.
//

import UIKit
import Util
import SwiftUI
import JFPopup
import SwiftyJSON

class RegionView: UIView {
    
   

    
    
    
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
    
    
    //底部添加uicontentscrollview
    lazy var contentScrollView:UIScrollView = {
       let contentScrollView = UIScrollView()
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.bounces = false
//        contentScrollView.delegate = self
//        contentScrollView.panGestureRecognizer.require(toFail: (self.navigationController?.interactivePopGestureRecognizer)!)
        return contentScrollView
    }()
    
    //中间值的按键和底部横线
    var preBtn:UIButton?
    
    
    //这边要进行修改这个数组
    var titleArray:[NoDeliveryRegionModel] = [NoDeliveryRegionModel]()
    
    
    var titleBtnArray:[UIButton] = [UIButton]()
    

    //省份数组
    var dataArray:[NoDeliveryRegionModel] = [NoDeliveryRegionModel]()
    var cityArray : [NoDeliveryRegionModel] = [NoDeliveryRegionModel]()
    var districtArray : [NoDeliveryRegionModel] = [NoDeliveryRegionModel]()
    
    
    
    //取消的闭包
    var cancelBlock:(()->Void)?
    //确定的闭包
    var sureChoiceAddress:((_ addreList:[NoDeliveryRegionModel]) ->Void)?
    
    
    init(frame: CGRect,addressList:[NoDeliveryRegionModel],dataArray:[NoDeliveryRegionModel]) {
        super.init(frame: frame)
        self.dataArray = dataArray
        self.titleArray = addressList
        
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
        
        
        addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom)
            make.width.equalTo(SCW)
        }
        
        
       //同一个包情况
       //let path = Bundle.main.path(forResource:"city", ofType: "json")
       //不同一个包的情况
//       let path = Bundle(for: type(of: self)).url(forResource: "city", withExtension: "json")
//       do{
//           //let url = URL(fileURLWithPath: path!)
//           let addressData = try NSData.init(contentsOf: path!)
//           let addressDic = try JSONSerialization.jsonObject(with: addressData as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
//           let dic = addressDic.object(at: 0) as! NSDictionary
//           let provinceArray = dic["childs"] as! NSArray
//           for i in 0..<provinceArray.count {
//                let provinceDic = provinceArray.object(at: i) as! NSDictionary
//                let provinceM = AddressModel.init()
//                provinceM.region_name = (provinceDic["region_name"] as? String)
//                provinceM.region_id = (provinceDic["region_id"] as! String)
//                provinceM.agency_id = (provinceDic["agency_id"] as? String)
//                provinceM.parent_id = (provinceDic["parent_id"] as! String)
//                provinceM.region_type = (provinceDic["region_type"] as! String)
//                provinceM.childs = (provinceDic["childs"] as! [NSDictionary])
//                self.dataArray.append(provinceM)
//           }
//       }catch{}
        
        if self.titleArray.count < 1{
            
            let noDeliveryRegionModel = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "请选择", isChoice: false)
            
//            let noDeliveryRegionModel = NoDeliveryRegionModel()
//            noDeliveryRegionModel.regionName = "请选择"
            titleArray.append(noDeliveryRegionModel)
//            let addressmodel = AddressModel()
//            addressmodel.region_name = "请选择"
//            titleArray = [addressmodel]
            
            addTitleView()
            addSubviewContentView()
            let btn = titleBtnArray[titleArray.count - 1]
            changBtnTitle(titleBtn: btn)
            
        }else{
            
            //这边要进行判断
            //第一个是省份
            let noDeliveryRegionModel = titleArray[0] as NoDeliveryRegionModel
            for i in 0..<self.dataArray.count {
                let provinceM = self.dataArray[i] as NoDeliveryRegionModel
                if provinceM.regionName == noDeliveryRegionModel.regionName{
                    //这边要去获取城市
                    let parameters = ["level":3,"regionId":provinceM.regionId as Any] as [String:Any]
                    NetWorkResultRequest(OrderApi.getRegionInfoList(parameters: parameters), needShowFailAlert: true) { result, data in
//                        do{
//                            self.cityArray.removeAll()
//                            let json = try JSON(data: data)
//                            if let arrayJSON = json["data"].array{
//                                self.cityArray = arrayJSON.map({ return NoDeliveryRegionModel(json: $0)})
//                            }
                        guard let model = try? JSONDecoder().decode(GenericResponse<[NoDeliveryRegionModel]>.self, from: data) else { return }
                        self.cityArray.removeAll()
                        if let _data = model.data{
                            self.cityArray = _data
                        }
                        
                            LXFLog("====================\(self.cityArray)")
                            self.addTitleView()
                            self.addSubviewContentView()
                            let btn = self.titleBtnArray[self.titleArray.count - 1]
                            self.changBtnTitle(titleBtn: btn)
//                        }catch{}
                    } failureCallback: { error, code in
                        code.loginOut()
                    }
                }
            }
            
//            let addressmodel = titleArray[0] as AddressModel
//            for i in 0..<self.dataArray.count {
//                let provinceM = self.dataArray[i] as AddressModel
//                if provinceM.region_name == (addressmodel.region_name)!{
//                    self.cityArray.removeAll()
//                    let cityDicArray = provinceM.childs!
//                    for j in 0..<cityDicArray.count {
//                       let cityDic = cityDicArray[j]
//                       let cityM = AddressModel.init()
//                       cityM.region_name = (cityDic["region_name"] as? String)
//                       cityM.region_id = (cityDic["region_id"] as! String)
//                       cityM.agency_id = (cityDic["agency_id"] as? String)
//                       cityM.parent_id = (cityDic["parent_id"] as! String)
//                       cityM.region_type = (cityDic["region_type"] as! String)
//                       cityM.childs = (cityDic["childs"] as! [NSDictionary])
//                       self.cityArray.append(cityM)
//                    }
//                }
//            }
//            let addressmodel1 = titleArray[1] as AddressModel
//            for i in 0..<self.cityArray.count {
//                let cityModel = self.cityArray[i]
//                if cityModel.region_name == (addressmodel1.region_name)!{
//                    self.districtArray.removeAll()
//                    let areaArray = cityModel.childs!
//                    for j in 0..<areaArray.count {
//                        let areaDic = areaArray[j]
//                        let areaModel = AddressModel.init()
//                        areaModel.region_name = (areaDic["region_name"] as? String)
//                        areaModel.region_id = (areaDic["region_id"] as! String)
//                        areaModel.agency_id = (areaDic["agency_id"] as? String)
//                        areaModel.parent_id = (areaDic["parent_id"] as! String)
//                        areaModel.region_type = (areaDic["region_type"] as! String)
//                        self.districtArray.append(areaModel)
//                    }
//                }
            if titleArray.count > 1{
                //这边是城市要去获取区域
                let noDeliveryRegionModel = titleArray[1] as NoDeliveryRegionModel
//                LXFLog("==========================\(noDeliveryRegionModel.regionId)")
//                for i in 0..<self.cityArray.count {
//                    let citymodel = self.cityArray[i] as NoDeliveryRegionModel
//                    if citymodel.regionName == noDeliveryRegionModel.regionName{
                        //这边要去获取城市
                        let parameters = ["level":4,"regionId":noDeliveryRegionModel.regionId as Any] as [String:Any]
                        NetWorkResultRequest(OrderApi.getRegionInfoList(parameters: parameters), needShowFailAlert: true) { result, data in
//                            do{
//                                self.districtArray.removeAll()
//                                let json = try JSON(data: data)
//                                if let arrayJSON = json["data"].array{
//                                    self.districtArray = arrayJSON.map({ return NoDeliveryRegionModel(json: $0)})
//                                }
                            guard let model = try? JSONDecoder().decode(GenericResponse<[NoDeliveryRegionModel]>.self, from: data) else { return }
                            self.districtArray.removeAll()
                            if let _data = model.data{
                                self.districtArray = _data
                            }
                                LXFLog("====================\(self.districtArray)")
                                self.addTitleView()
                                self.addSubviewContentView()
                                let btn = self.titleBtnArray[self.titleArray.count - 1]
                                self.changBtnTitle(titleBtn: btn)
//                            }catch{}
                        } failureCallback: { error, code in
                            code.loginOut()
                        }
//                    }
//                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
//        let btnW = (SCW/2)/3
        let btnW = scale(120)
        for i in 0..<titleArray.count {
//            let addressmodel = titleArray[i] as AddressModel
            let noDeliveryRegionModel = titleArray[i] as NoDeliveryRegionModel
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
//            titleBtn.setTitle(addressmodel.region_name, for: .normal)
            titleBtn.setTitle(noDeliveryRegionModel.regionName, for: .normal)
            titleBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"), for: .normal)
            titleBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .selected)
            titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
            titleBtnArray.append(titleBtn)
        }
    }
    
    func addUnLineView(){
        let titleBtn = titleBtnArray[0]
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
//            self.contentScrollView.contentOffset = CGPoint(x: tag * Int(self.contentScrollView.width), y: 0)
        }
        if titleBtn.tag == 0{
            contentScrollView.subviews.forEach { view in
                if view.isKind(of: UITableView.self){
                    let tableview = view as! RegionTableView
                    titleArray.removeAll()
//                    let addressmodel = AddressModel()
//                    addressmodel.region_name = "请选择"
//                    titleArray = [addressmodel]
                    
//                    let noDeliveryRegionModel = NoDeliveryRegionModel()
//                    noDeliveryRegionModel.regionName = "请选择"
                    let noDeliveryRegionModel = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "请选择", isChoice: false)
                    titleArray.append(noDeliveryRegionModel)
                    
                    tableview.titleStringArray = self.dataArray
                    tableview.reloadData()
                    self.addTitleView()
                    
                    for view in titleView.subviews {
                        if view.isKind(of: UIButton.self){
                            let btn = view as! UIButton
                            btn.isSelected = true
                        }
                    }
                }
            }
        }
        else if titleBtn.tag == 1{
//            if titleBtn.currentTitle != "请选择" {
                contentScrollView.subviews.forEach { view in
                    if view.isKind(of: UITableView.self){
                        let tableview = view as! RegionTableView
//                        let addressmodel = titleArray[0] as AddressModel
                        let noDeliveryRegionModel = titleArray[0] as NoDeliveryRegionModel
                        if titleArray.count > 2{
                            titleArray.removeLast()
                        }
                        for i in 0..<self.dataArray.count {
//                            let provinceM = self.dataArray[i] as AddressModel
                            let provinceM = self.dataArray[i] as NoDeliveryRegionModel
                            if provinceM.regionName == (noDeliveryRegionModel.regionName)!{
                                let parameters = ["level":3,"regionId":provinceM.regionId as Any] as [String:Any]
                                NetWorkResultRequest(OrderApi.getRegionInfoList(parameters: parameters), needShowFailAlert: true) { result, data in
//                                    do{
//                                        self.cityArray.removeAll()
//                                        let json = try JSON(data: data)
//                                        if let arrayJSON = json["data"].array{
//                                            self.cityArray = arrayJSON.map({ return NoDeliveryRegionModel(json: $0)})
//                                        }
                                    
                                    guard let model = try? JSONDecoder().decode(GenericResponse<[NoDeliveryRegionModel]>.self, from: data) else { return }
                                    self.cityArray.removeAll()
                                    if let _data = model.data{
                                        self.cityArray = _data
                                    }
                                        LXFLog("====================\(self.cityArray)")
                                        
//                                        if self.cityArray.count > 0{
//                                            let noDeliveryRegionModel = NoDeliveryRegionModel()
//                                            noDeliveryRegionModel.regionName = "请选择"
//                                            self.titleArray.append(noDeliveryRegionModel)
//                                        }
                                        tableview.titleStringArray = self.cityArray
                                        self.addTitleView()
                                        tableview.reloadData()
                                        let btn = self.titleBtnArray[self.titleArray.count - 1]
                                        self.changBtnTitle(titleBtn: btn)
                                        
//                                    }catch{}
                                } failureCallback: { error, code in
                                    code.loginOut()
                                }
                                
                                
//                                self.cityArray.removeAll()
//                                let cityDicArray = provinceM.childs!
//                                for j in 0..<cityDicArray.count {
//                                   let cityDic = cityDicArray[j]
//                                   let cityM = AddressModel.init()
//                                   cityM.region_name = (cityDic["region_name"] as? String)
//                                   cityM.region_id = (cityDic["region_id"] as! String)
//                                   cityM.agency_id = (cityDic["agency_id"] as? String)
//                                   cityM.parent_id = (cityDic["parent_id"] as! String)
//                                   cityM.region_type = (cityDic["region_type"] as! String)
//                                   cityM.childs = (cityDic["childs"] as! [NSDictionary])
//                                   self.cityArray.append(cityM)
//                                }
//                            }
                        }
                    }
                }
            }
        }
    }
    
    func changBtnTitle(titleBtn:UIButton){
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
//            self.contentScrollView.contentOffset = CGPoint(x: tag * Int(self.contentScrollView.width), y: 0)
        }
    }
    
    func addSubviewContentView(){
        let tableview = RegionTableView(frame: .zero, style: .plain)
        if titleArray.count == 1{
            tableview.titleStringArray = self.dataArray
        }else if titleArray.count == 2{
            tableview.titleStringArray = self.cityArray
        }else{
            tableview.titleStringArray = self.districtArray
        }
//        tableview.selectType = self.titleArray.count
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        contentScrollView.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.height.equalTo(scale(442) - scale(106))
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
        }
        tableview.reloadData()
//        contentScrollView.contentSize = CGSize(width: titleArray.count * Int(SCW), height: 0)
        tableview.backSelectType = {noDeliveryRegionModel,index,tableview in
            if self.titleArray.count == 1{
                let provinceM = self.dataArray[index]
//                self.titleArray[0] = provinceM.region_name ?? "请选择"
//                var addressmodel = self.titleArray[0] as AddressModel
//                addressmodel = provinceM
                self.titleArray[0] = provinceM
                
                
               
                
//                let addressmodel1 = AddressModel()
//                addressmodel1.region_name = "请选择"
//                self.titleArray.append(addressmodel1)
                
                
//                self.cityArray.removeAll()
//                let cityDicArray = provinceM.childs!
//                for j in 0..<cityDicArray.count {
//                   let cityDic = cityDicArray[j]
//                   let cityM = AddressModel.init()
//                   cityM.region_name = (cityDic["region_name"] as? String)
//                   cityM.region_id = (cityDic["region_id"] as! String)
//                   cityM.agency_id = (cityDic["agency_id"] as? String)
//                   cityM.parent_id = (cityDic["parent_id"] as! String)
//                   cityM.region_type = (cityDic["region_type"] as! String)
//                   cityM.childs = (cityDic["childs"] as! [NSDictionary])
//                   self.cityArray.append(cityM)
//                }
                
                
                let parameters = ["level":3,"regionId":provinceM.regionId as Any] as [String:Any]
                NetWorkResultRequest(OrderApi.getRegionInfoList(parameters: parameters), needShowFailAlert: true) { result, data in
//                    do{
//                        self.cityArray.removeAll()
//                        let json = try JSON(data: data)
//                        if let arrayJSON = json["data"].array{
//                            self.cityArray = arrayJSON.map({ return NoDeliveryRegionModel(json: $0)})
//                        }
                    
                    guard let model = try? JSONDecoder().decode(GenericResponse<[NoDeliveryRegionModel]>.self, from: data) else { return }
                    self.cityArray.removeAll()
                    if let _data = model.data{
                        self.cityArray = _data
                    }
                    
                        LXFLog("====================\(self.cityArray)")
//                    }catch{}
                    if self.cityArray.count > 0{
//                        let noDeliveryRegionModel = NoDeliveryRegionModel()
//                        noDeliveryRegionModel.regionName = "请选择"
                        let noDeliveryRegionModel = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "请选择", isChoice: false)
                        self.titleArray.append(noDeliveryRegionModel)
                        tableview.titleStringArray = self.cityArray
                    }
                    
                    self.addTitleView()
                    tableview.reloadData()
                    let btn = self.titleBtnArray[self.titleArray.count - 1]
                    self.changBtnTitle(titleBtn: btn)
                    
                    
                } failureCallback: { error, code in
                    code.loginOut()
                }
                
                
                
                
            }else if self.titleArray.count == 2{
                
                let cityModel = self.cityArray[index]
//                var addressmodel = self.titleArray[1] as AddressModel
                self.titleArray[1] = cityModel
//               addressmodel = cityModel
//                self.titleArray[1] = cityModel.region_name ?? "请选择"
//                self.titleArray.append("请选择")
//                self.cityArray.removeAll()
//                let areaArray = cityModel.childs!
//                self.districtArray.removeAll()
//                for j in 0..<areaArray.count {
//                    let areaDic = areaArray[j]
//                    let areaModel = AddressModel.init()
//                    areaModel.region_name = (areaDic["region_name"] as? String)
//                    areaModel.region_id = (areaDic["region_id"] as! String)
//                    areaModel.agency_id = (areaDic["agency_id"] as? String)
//                    areaModel.parent_id = (areaDic["parent_id"] as! String)
//                    areaModel.region_type = (areaDic["region_type"] as! String)
//                    self.districtArray.append(areaModel)
//                }
//
//                if self.districtArray.count > 0{
//                    let addressmodel1 = AddressModel()
//                    addressmodel1.region_name = "请选择"
//                    self.titleArray.append(addressmodel1)
//                    tableview.titleStringArray = self.districtArray
//                }
//
                
                
                let parameters = ["level":4,"regionId":cityModel.regionId as Any] as [String:Any]
                NetWorkResultRequest(OrderApi.getRegionInfoList(parameters: parameters), needShowFailAlert: true) { result, data in
                    
                    guard let model = try? JSONDecoder().decode(GenericResponse<[NoDeliveryRegionModel]>.self, from: data) else { return }
                    self.districtArray.removeAll()
                    if let _data = model.data{
                        self.districtArray = _data
                    }
//                    do{
//                        self.districtArray.removeAll()
//                        let json = try JSON(data: data)
//                        if let arrayJSON = json["data"].array{
//                            self.districtArray = arrayJSON.map({ return NoDeliveryRegionModel(json: $0)})
//                        }
                        LXFLog("====================\(self.districtArray)")
//                    }catch{}
                    if self.districtArray.count > 0{
//                        let noDeliveryRegionModel = NoDeliveryRegionModel()
//                        noDeliveryRegionModel.regionName = "请选择"
                        let noDeliveryRegionModel = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "请选择", isChoice: false)
                        self.titleArray.append(noDeliveryRegionModel)
                        tableview.titleStringArray = self.districtArray
                    }
                    self.addTitleView()
                    tableview.reloadData()
                    let btn = self.titleBtnArray[self.titleArray.count - 1]
                    self.changBtnTitle(titleBtn: btn)
                } failureCallback: { error, code in
                    code.loginOut()
                }
            }else{
//                self.titleArray[2] = selectedProvince
                self.titleArray[2] = noDeliveryRegionModel
                self.addTitleView()
                tableview.reloadData()
                let btn = self.titleBtnArray[self.titleArray.count - 1]
                self.changBtnTitle(titleBtn: btn)
            }
           
        }
    }
        
        
        
        
        
        /**
         
         tableview.titleStringArray = self.cityArray
         self.addTitleView()
         self.addSubviewContentView()
         self.contentScrollView.contentOffset = CGPoint(x: self.titleArray.count - 1 * Int(SCW), y: 0)
         let btn = self.titleBtnArray[self.titleArray.count - 1]
         self.titleBtnClick(titleBtn: btn)
         
         */
        
        
//        tableview.backSelectType = { selectType,selectProvince,index in
//            if selectType == 2{
//                let provinceM = self.dataArray[index]
//                self.cityArray.removeAll()
//                let cityDicArray = provinceM.childs!
//                for j in 0..<cityDicArray.count {
//                     let cityDic = cityDicArray[j]
//                     let cityM = AddressModel.init()
//                     cityM.region_name = (cityDic["region_name"] as? String)
//                     cityM.region_id = (cityDic["region_id"] as! String)
//                     cityM.agency_id = (cityDic["agency_id"] as? String)
//                     cityM.parent_id = (cityDic["parent_id"] as! String)
//                     cityM.region_type = (cityDic["region_type"] as! String)
//                     cityM.childs = (cityDic["childs"] as! [NSDictionary])
//                    self.cityArray.append(cityM)
//                }
//            }else{
//                let cityModel = self.cityArray[index]
//                let areaArray = cityModel.childs!
//                self.districtArray.removeAll()
//                for j in 0..<areaArray.count {
//                     let areaDic = areaArray[j]
//                     let areaModel = AddressModel.init()
//                     areaModel.region_name = (areaDic["region_name"] as? String)
//                     areaModel.region_id = (areaDic["region_id"] as! String)
//                     areaModel.agency_id = (areaDic["agency_id"] as? String)
//                     areaModel.parent_id = (areaDic["parent_id"] as! String)
//                     areaModel.region_type = (areaDic["region_type"] as! String)
//                    self.districtArray.append(areaModel)
//                }
//            }
//        }
        
        
//    }
    
    //取消
    @objc func cancelBtnClicked(){
        cancelBlock!()
    }
    
    //确定
    @objc func sureBtnClicked(){
        
        
        
        
        
//                        titleArray.append("请选择")
//                        if titleArray.count > 1{
//                            titleArray[0] = "省份"
//                        }
//                        if titleArray.count > 2{
//                            titleArray[1] = "城市"
//                        }
//                        addTitleView()
//                        addSubviewContentView()
//                        contentScrollView.contentOffset = CGPoint(x:titleArray.count - 1 * Int(SCW), y: 0)
//                        let btn = titleBtnArray[titleArray.count - 1]
//                        titleBtnClick(titleBtn: btn)
        
        
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
        sureChoiceAddress!(titleArray)
    }
}



extension RegionView:UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var ratio = scrollView.contentOffset.x / scrollView.width
        ratio = ratio - CGFloat(preBtn?.tag ?? 0)
        lineView.centerX = (preBtn?.centerX ?? 0) + ratio * (preBtn?.width ?? 0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let radit = scrollView.contentOffset.x / scrollView.width
        let btn = titleBtnArray[Int(radit)]
        titleBtnClick(titleBtn: btn)
    }
    
}






class RegionTableView:UITableView{
    
    //选中的位置，要进行区分，省份，城市，区域3中方式
    
    //要是重新选择了省份要对城市的部分进行重新修改--并删除第3个区域的部分
    
    //要是重新修改了城市，那么要多区域的的内容进行修改
//    var selectProvince 1
//    var city 2
//    var region 3
    
    var backSelectType:((_ noDeliveryRegionModel:NoDeliveryRegionModel,_ index:Int,_ tableview:RegionTableView)->Void)?
    
    
    var titleStringArray:[NoDeliveryRegionModel] = [NoDeliveryRegionModel]()
    //1为省份，2为城市 3区县
//    var selectType:Int = 0
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
//        estimatedRowHeight = 0
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
        self.register(RegionAddressCell.self, forCellReuseIdentifier: "RegionAddressCell")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegionTableView:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleStringArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionAddressCell") as! RegionAddressCell
//        cell.addressLabel.text = titleStringArray[indexPath.row]
        let provinceM = titleStringArray[indexPath.row]
        cell.addressLabel.text = provinceM.regionName
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //这边要带回去
        let provinceM = titleStringArray[indexPath.row]
//        backSelectType!(provinceM.region_name!,indexPath.row,self)
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        backSelectType!(provinceM,indexPath.row,self)
    }
}

