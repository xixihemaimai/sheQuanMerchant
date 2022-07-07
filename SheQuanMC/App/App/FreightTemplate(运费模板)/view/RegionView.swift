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
//    lazy var contentScrollView:UIScrollView = {
//       let contentScrollView = UIScrollView()
//        contentScrollView.showsHorizontalScrollIndicator = false
//        contentScrollView.bounces = false
//        return contentScrollView
//    }()
    
    
    
    lazy var tableview:RegionTableView = {
        let tableview = RegionTableView(frame: .zero, style: .plain)
        return tableview
    }()
    
    
    //中间值的按键和底部横线
    var preBtn:UIButton?
    
    
    //这边要进行修改这个数组
    var titleArray:[RegionInfoModel] = [RegionInfoModel]()
    
    var titleBtnArray:[UIButton] = [UIButton]()
    
    //省份数组
    var dataArray:[RegionInfoModel] = [RegionInfoModel]()
    //城市数组
    var cityArray : [RegionInfoModel] = [RegionInfoModel]()
    //县/区数组
    var districtArray : [RegionInfoModel] = [RegionInfoModel]()
    //街道/乡村数组
    var streetsArray:[RegionInfoModel] = [RegionInfoModel]()
    
    //取消的闭包
    var cancelBlock:(()->Void)?
    //确定的闭包
    var sureChoiceAddress:((_ addreList:[RegionInfoModel]) ->Void)?
    
    
    init(frame: CGRect,addressList:[RegionInfoModel],dataArray:[RegionInfoModel]) {
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
        
        
        addSubview(tableview)
        tableview.deleagate = self
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        tableview.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
        }
        
        
//        addSubview(contentScrollView)
//        contentScrollView.snp.makeConstraints { make in
//            make.left.bottom.equalToSuperview()
//            make.top.equalTo(titleView.snp.bottom)
//            make.width.equalTo(SCW)
//        }
        
        
       //同一个包情况
       //let path = Bundle.main.path(forResource:"city", ofType: "json")
       //不同一个包的情况
//       let path = Bundle(for: type(of: self)).url(forResource: "city", withExtension: "json")
//       do{
//           //let url = URL(fileURLWithPath: path!)
//           let addressData = try NSData.init(contentsOf: path!)
//           let addressDic = try JSONSerialization.jsonObject(with: addressData as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        
        
        
        if self.titleArray.count < 1{
            
            let regionInfoModel = RegionInfoModel(initials: "0", lat: 0, level: 2, lng: 0, regionId: 0, regionName: "请选择", checked: false,childNodes: [RegionInfoModel]())
            titleArray.append(regionInfoModel)
            addTitleView()
            addSubviewContentView()
            let btn = titleBtnArray[titleArray.count - 1]
//            changBtnTitle(titleBtn: btn)
            titleBtnClick(titleBtn: btn)
        }else{
            //这边要进行判断
            //第一个是省份
            
            //let regionInfoModel = RegionInfoModel(initials: "0", lat: 0, level: 2, lng: 0, regionId: 0, regionName: "请选择", checked: false,childNodes: [RegionInfoModel]())
            
            if titleArray.count == 1{
                //省
                tableview.titleStringArray = self.dataArray
                tableview.reloadData()
                addTitleView()
                addSubviewContentView()
                let btn = titleBtnArray[titleArray.count - 1]
                titleBtnClick(titleBtn: btn)
                
            }else if titleArray.count == 2{
                //省 城市
                let regionInfoModel = titleArray[0]
                //第二个是城市
                for i in 0..<self.dataArray.count {
                    let provinceM = self.dataArray[i]
                    if provinceM.regionId == regionInfoModel.regionId{
                        //这边要去获取城市
                        self.cityArray.removeAll()
                        if (provinceM.childNodes?.count ?? 0) > 0{
                            self.cityArray = provinceM.childNodes!
                        }
                        break
                    }
                }
                tableview.titleStringArray = self.cityArray
                tableview.reloadData()
                addTitleView()
                addSubviewContentView()
                let btn = titleBtnArray[titleArray.count - 1]
                titleBtnClick(titleBtn: btn)
                
            }else if titleArray.count == 3{
                //省 城市 区/县
                let regionInfoModel = titleArray[0]
                //第二个是城市
                for i in 0..<self.dataArray.count {
                    let provinceM = self.dataArray[i]
                    if provinceM.regionId == regionInfoModel.regionId{
                        //这边要去获取城市
                        self.cityArray.removeAll()
                        if (provinceM.childNodes?.count ?? 0) > 0{
                            self.cityArray = provinceM.childNodes!
                        }
                        break
                    }
                }
                //第三个是县和区之类
                let regionInfoModel1 = titleArray[1]
                for i in 0..<self.cityArray.count {
                    let cityModel = self.cityArray[i]
                    if cityModel.regionId == regionInfoModel1.regionId{
                        //这边要去获取城市
                        self.districtArray.removeAll()
                        if (cityModel.childNodes?.count ?? 0) > 0{
                            self.districtArray = cityModel.childNodes!
                        }
                        break
                    }
                }
                tableview.titleStringArray = self.districtArray
                
                tableview.reloadData()
                addTitleView()
                addSubviewContentView()
                let btn = titleBtnArray[titleArray.count - 1]
                titleBtnClick(titleBtn: btn)
            }else{
                //街道/乡村
                //省 城市 区/县
                let regionInfoModel = titleArray[0]
                //第二个是城市
                for i in 0..<self.dataArray.count {
                    let provinceM = self.dataArray[i]
                    if provinceM.regionId == regionInfoModel.regionId{
                        //这边要去获取城市
                        self.cityArray.removeAll()
                        if (provinceM.childNodes?.count ?? 0) > 0{
                            self.cityArray = provinceM.childNodes!
                        }
                        break
                    }
                }
                //第三个是县和区之类
                let regionInfoModel1 = titleArray[1]
                for i in 0..<self.cityArray.count {
                    let cityModel = self.cityArray[i]
                    if cityModel.regionId == regionInfoModel1.regionId{
                        //这边要去获取城市
                        self.districtArray.removeAll()
                        if (cityModel.childNodes?.count ?? 0) > 0{
                            self.districtArray = cityModel.childNodes!
                        }
                        break
                    }
                }
                let regionModel = titleArray[2]
                self.streetsArray.removeAll()
                //这边要去获取数据
                let parameters = ["level":0,"regionId":regionModel.regionId as Any,"subHierarchy":4] as [String:Any]
                //getRegionInfoList
                NetWorkResultRequest(OrderApi.getRegionInfoList(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
                    guard let model = try? JSONDecoder().decode(GenericResponse<[RegionInfoModel]>.self, from: data) else { return }
                    if let _data = model.data{
                        if _data.count > 0{
                            if _data.first?.childNodes?.count ?? 0 > 0{
                                self?.streetsArray = (_data.first?.childNodes)!
                                if (regionModel.childNodes?.count ?? 0) > 0{
                                    self?.streetsArray = regionModel.childNodes!
                                }
                                self?.tableview.titleStringArray = self!.streetsArray
                                self?.addTitleView()
                                self?.tableview.reloadData()
                                let btn = self?.titleBtnArray[(self?.titleArray.count)! - 1]
                                self?.changBtnTitle(titleBtn: btn!)
                            }
                        }
                    }
                } failureCallback: { error, code in
                    code.loginOut()
                }
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
//        let btnW = scale(100)
        let btnW = SCW/CGFloat(titleArray.count)
        for i in 0..<titleArray.count {
            let regionInfoModel = titleArray[i] as RegionInfoModel
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
            titleBtn.setTitle(regionInfoModel.regionName, for: .normal)
            titleBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"), for: .normal)
            titleBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .selected)
            titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
            titleBtnArray.append(titleBtn)
        }
    }
    
    func addUnLineView(){
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
            var regionName:String = "请选择"
            var regionId:Int32 = 0
            if titleArray.count == 1{
                let regionInfoModel = titleArray.first
                regionName = regionInfoModel?.regionName ?? "请选择"
                regionId = regionInfoModel?.regionId ?? 0
            }
            titleArray.removeAll()
            let regionInfoModel = RegionInfoModel(initials: "0", lat: 0, level: 2, lng: 0, regionId: regionId, regionName: regionName, checked: false,childNodes: [RegionInfoModel]())
            titleArray.append(regionInfoModel)
            addTitleView()
            tableview.titleStringArray = self.dataArray
            tableview.reloadData()
            let btn = self.titleBtnArray[titleArray.count - 1]
            changBtnTitle(titleBtn: btn)
        }
        else if titleBtn.tag == 1{
            if titleArray.count > 2{
//                titleArray.removeLast()
                //let length = (self?.commodityModel?.productPics?.count ?? 1) - 1
                let length = titleArray.count - 1
                titleArray.removeSubrange(2...length)
                var regionInfoModel = titleArray[1]
                regionInfoModel.regionName = "请选择"
                titleArray[1] = regionInfoModel
                addTitleView()
            }
            let regionInfoModel1 = titleArray[0]
            for i in 0..<self.dataArray.count {
                let provinceM = self.dataArray[i]
                if provinceM.regionId == regionInfoModel1.regionId{
                    cityArray.removeAll()
                    if (provinceM.childNodes?.count ?? 0) > 0{
                        cityArray = provinceM.childNodes!
                    }
                }
            }
            tableview.titleStringArray = cityArray
            tableview.reloadData()
            let btn = self.titleBtnArray[titleArray.count - 1]
            changBtnTitle(titleBtn: btn)
        }else if titleBtn.tag == 2{
            if titleArray.count > 3{
                titleArray.removeLast()
                var regionInfoModel = titleArray.last
                regionInfoModel?.regionName = "请选择"
//                titleArray[2] = regionInfoModel!
                titleArray[titleArray.count - 1] = regionInfoModel!
                addTitleView()
            }
            let regionInfoModel1 = titleArray[1]
            for i in 0..<self.cityArray.count {
                let provinceM = self.cityArray[i]
                if provinceM.regionId == regionInfoModel1.regionId{
                    districtArray.removeAll()
                    if (provinceM.childNodes?.count ?? 0) > 0{
                        districtArray = provinceM.childNodes!
                    }
                }
            }
            tableview.titleStringArray = districtArray
            tableview.reloadData()
            let btn = self.titleBtnArray[titleArray.count - 1]
            changBtnTitle(titleBtn: btn)
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
        }
    }
    
    func addSubviewContentView(){
        if titleArray.count == 1{
            tableview.titleStringArray = self.dataArray
        }else if titleArray.count == 2{
            tableview.titleStringArray = self.cityArray
        }else if titleArray.count == 3{
            tableview.titleStringArray = self.districtArray
        }else{
            tableview.titleStringArray = self.streetsArray
        }
        tableview.reloadData()
//        tableview.backSelectType = {regionInfoModel,index,tableview in
//            LXFLog("=====================\(self.titleArray.count)")
//            if self.titleArray.count == 1{
//                let provinceM = self.dataArray[index]
//                self.titleArray[0] = provinceM
//                self.cityArray.removeAll()
//                if (provinceM.childNodes?.count ?? 0) > 0{
//                    self.cityArray = provinceM.childNodes!
//                }
//                if self.cityArray.count > 0{
//                    let regionInfoModel = RegionInfoModel(initials: "0", lat: 0, level: 3, lng: 0, regionId: 0, regionName: "请选择", checked: false,childNodes: [RegionInfoModel]())
//                    self.titleArray.append(regionInfoModel)
//                }
//                tableview.titleStringArray = self.cityArray
//                self.districtArray.removeAll()
//                self.addTitleView()
//                tableview.reloadData()
//                let btn = self.titleBtnArray[self.titleArray.count - 1]
//                self.changBtnTitle(titleBtn: btn)
//            }else if self.titleArray.count == 2{
//
//                let cityModel = self.cityArray[index]
//                self.titleArray[1] = cityModel
//                self.districtArray.removeAll()
//                if (cityModel.childNodes?.count ?? 0) > 0{
//                    self.districtArray = cityModel.childNodes!
//                }
//                if self.districtArray.count > 0{
//                    let regionInfoModel = RegionInfoModel(initials: "0", lat: 0, level: 4, lng: 0, regionId: 0, regionName: "请选择", checked: false,childNodes: [RegionInfoModel]())
//                    self.titleArray.append(regionInfoModel)
//                }
//                tableview.titleStringArray = self.districtArray
//                self.addTitleView()
//                tableview.reloadData()
//                let btn = self.titleBtnArray[self.titleArray.count - 1]
//                self.changBtnTitle(titleBtn: btn)
//
//            }else if self.titleArray.count == 3{
//                let regionModel = self.districtArray[index]
//                self.titleArray[2] = regionModel
//                self.streetsArray.removeAll()
//                //这边要去获取数据
//                let parameters = ["level":0,"regionId":regionModel.regionId as Any,"subHierarchy":4] as [String:Any]
//                //getRegionInfoList
//                NetWorkResultRequest(OrderApi.getRegionInfoList(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
//                    guard let model = try? JSONDecoder().decode(GenericResponse<[RegionInfoModel]>.self, from: data) else { return }
//                    if let _data = model.data{
//                        if _data.count > 0{
//                            if _data.first?.childNodes?.count ?? 0 > 0{
//                                self?.streetsArray = (_data.first?.childNodes)!
//                                if (regionModel.childNodes?.count ?? 0) > 0{
//                                    self?.streetsArray = regionModel.childNodes!
//                                }
//                                if self?.streetsArray.count ?? 0 > 0{
//                                    let regionInfoModel = RegionInfoModel(initials: "0", lat: 0, level: 4, lng: 0, regionId: 0, regionName: "请选择", checked: false,childNodes: [RegionInfoModel]())
//                                    self?.titleArray.append(regionInfoModel)
//                                }
//                                self?.tableview.titleStringArray = self!.streetsArray
//                                self?.addTitleView()
//                                self?.tableview.reloadData()
//                                let btn = self?.titleBtnArray[(self?.titleArray.count)! - 1]
//                                self?.changBtnTitle(titleBtn: btn!)
//                            }
//                        }
//                    }
//                } failureCallback: { error, code in
//                    code.loginOut()
//                }
//            }else{
//                self.titleArray[3] = regionInfoModel
//                self.addTitleView()
//                tableview.reloadData()
//                let btn = self.titleBtnArray[self.titleArray.count - 1]
//                self.changBtnTitle(titleBtn: btn)
//            }
//        }
    }
    
    //取消
    @objc func cancelBtnClicked(){
        cancelBlock!()
    }
    
    //确定
    @objc func sureBtnClicked(){
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

extension RegionView:RegionTableViewDelegate{
    func backSelectType(_ regionInfoModel: RegionInfoModel, _ index: Int, _ tableview: RegionTableView) {
        if self.titleArray.count == 1{
            let provinceM = self.dataArray[index]
            self.titleArray[0] = provinceM
            self.cityArray.removeAll()
            if (provinceM.childNodes?.count ?? 0) > 0{
                self.cityArray = provinceM.childNodes!
            }
            if self.cityArray.count > 0{
                let regionInfoModel = RegionInfoModel(initials: "0", lat: 0, level: 3, lng: 0, regionId: 0, regionName: "请选择", checked: false,childNodes: [RegionInfoModel]())
                self.titleArray.append(regionInfoModel)
            }
            tableview.titleStringArray = self.cityArray
            self.districtArray.removeAll()
            self.addTitleView()
            tableview.reloadData()
            let btn = self.titleBtnArray[self.titleArray.count - 1]
            self.changBtnTitle(titleBtn: btn)
        }else if self.titleArray.count == 2{
            let cityModel = self.cityArray[index]
            self.titleArray[1] = cityModel
            self.districtArray.removeAll()
            if (cityModel.childNodes?.count ?? 0) > 0{
                self.districtArray = cityModel.childNodes!
            }
            if self.districtArray.count > 0{
                let regionInfoModel = RegionInfoModel(initials: "0", lat: 0, level: 4, lng: 0, regionId: 0, regionName: "请选择", checked: false,childNodes: [RegionInfoModel]())
                self.titleArray.append(regionInfoModel)
            }
            tableview.titleStringArray = self.districtArray
            self.addTitleView()
            tableview.reloadData()
            let btn = self.titleBtnArray[self.titleArray.count - 1]
            self.changBtnTitle(titleBtn: btn)
            
        }else if self.titleArray.count == 3{
            let regionModel = self.districtArray[index]
            self.titleArray[2] = regionModel
            self.streetsArray.removeAll()
            //这边要去获取数据
            let parameters = ["level":0,"regionId":regionModel.regionId as Any,"subHierarchy":4] as [String:Any]
            //getRegionInfoList
            NetWorkResultRequest(OrderApi.getRegionInfoList(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
                guard let model = try? JSONDecoder().decode(GenericResponse<[RegionInfoModel]>.self, from: data) else { return }
                if let _data = model.data{
                    if _data.count > 0{
                        if _data.first?.childNodes?.count ?? 0 > 0{
                            self?.streetsArray = (_data.first?.childNodes)!
                            if (regionModel.childNodes?.count ?? 0) > 0{
                                self?.streetsArray = regionModel.childNodes!
                            }
                            if self?.streetsArray.count ?? 0 > 0{
                                if (self?.titleArray.count ?? 4) < 4{
                                    let regionInfoModel = RegionInfoModel(initials: "0", lat: 0, level: 4, lng: 0, regionId: 0, regionName: "请选择", checked: false,childNodes: [RegionInfoModel]())
                                    self?.titleArray.append(regionInfoModel)
                                }
                            }
                            self?.tableview.titleStringArray = self!.streetsArray
                            self?.addTitleView()
                            self?.tableview.reloadData()
                            let btn = self?.titleBtnArray[(self?.titleArray.count)! - 1]
                            self?.changBtnTitle(titleBtn: btn!)
                        }
                    }
                }
            } failureCallback: { error, code in
                code.loginOut()
            }
        }else{
            
            self.titleArray[3] = regionInfoModel
            self.addTitleView()
            tableview.reloadData()
            let btn = self.titleBtnArray[self.titleArray.count - 1]
            self.changBtnTitle(titleBtn: btn)
            
        }
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





protocol RegionTableViewDelegate {
    
    func backSelectType(_ regionInfoModel:RegionInfoModel,_ index:Int,_ tableview:RegionTableView)
    
}



class RegionTableView:UITableView{
    
    //选中的位置，要进行区分，省份，城市，区域3中方式
    
    //要是重新选择了省份要对城市的部分进行重新修改--并删除第3个区域的部分
    
    //要是重新修改了城市，那么要多区域的的内容进行修改
//    var selectProvince 1
//    var city 2
//    var region 3
//    var backSelectType:((_ regionInfoModel:RegionInfoModel,_ index:Int,_ tableview:RegionTableView)->Void)?
    
    var titleStringArray:[RegionInfoModel] = [RegionInfoModel]()
    
    var deleagate:RegionTableViewDelegate?
    
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
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
//        backSelectType?(provinceM,indexPath.row,self)
        self.deleagate?.backSelectType(provinceM, indexPath.row, self)
    }
}

