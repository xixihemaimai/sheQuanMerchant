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
    //城市数组
    var cityArray:[NoDeliveryRegionModel] = [NoDeliveryRegionModel]()
    //取消的闭包
    var cancelBlock:(()->Void)?
    //确定的闭包
    var sureChoiceAddress:((_ addreList:[NoDeliveryRegionModel]) ->Void)?
    
    
    
    init(frame: CGRect,addressList:[NoDeliveryRegionModel],dataArray:[NoDeliveryRegionModel]) {
        super.init(frame: frame)
        
        self.titleArray = addressList
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
        
        addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom)
            make.width.equalTo(SCW)
        }
        
        contentScrollView.addSubview(tableview)
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        tableview.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.height.equalTo(scale(442) - scale(106))
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
        }
        
       //同一个包情况
       //let path = Bundle.main.path(forResource:"city", ofType: "json")
       //不同一个包的情况
//       let path = Bundle(for: type(of: self)).url(forResource: "city", withExtension: "json")
        if self.titleArray.count < 1{
            let noDeliveryRegionModel = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "请选择", isChoice: false)
            titleArray = [noDeliveryRegionModel]
            addTitleView()
            addSubviewContentView()
            let count = (titleArray.count > 2 ? 1 : titleArray.count - 1)
            let btn = titleBtnArray[count]
            changBtnTitle(titleBtn: btn)
        }else{
            var noDeliveryRegionModel = titleArray[0] as NoDeliveryRegionModel
//            for i in 0..<self.dataArray.count {
//                let noDeliveryRegionModel1 = self.dataArray[i] as NoDeliveryRegionModel
//                if noDeliveryRegionModel1.regionName == noDeliveryRegionModel.regionName{
                    //这个是要选中状态
                    noDeliveryRegionModel.isChoice = true
                    let noDeliveryRegionModel2 = titleArray[1] as NoDeliveryRegionModel
                    if noDeliveryRegionModel2.regionName == "全选"{
                        let parameters = ["level":3,"regionId":noDeliveryRegionModel.regionId as Any] as [String:Any]
                        NetWorkResultRequest(OrderApi.getRegionInfoList(parameters: parameters), needShowFailAlert: true) { result, data in
                            guard let model = try? JSONDecoder().decode(GenericResponse<[NoDeliveryRegionModel]>.self, from: data) else { return }
                            self.cityArray.removeAll()
                            if let _data = model.data{
                                self.cityArray = _data
                            }
                            for i  in 0..<self.cityArray.count {
                                var noDevliveryRegionMoel4 = self.cityArray[i]
                                noDevliveryRegionMoel4.isChoice = true
                                self.cityArray[i] = noDevliveryRegionMoel4
                            }
                            let noDeliveryRegionModel5 = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "全选", isChoice: true)
                            self.cityArray.insert(noDeliveryRegionModel5, at: 0)
                            self.addTitleView()
                            self.addSubviewContentView()
                            let count = (self.titleArray.count > 2 ? 1 : self.titleArray.count - 1)
                            let btn = self.titleBtnArray[count]
                            self.changBtnTitle(titleBtn: btn)
                        } failureCallback: { error, code in
                            code.loginOut()
                        }
                    }else{
                        let parameters = ["level":3,"regionId":noDeliveryRegionModel.regionId as Any] as [String:Any]
                        NetWorkResultRequest(OrderApi.getRegionInfoList(parameters: parameters), needShowFailAlert: true) { result, data in
                            
                            guard let model = try? JSONDecoder().decode(GenericResponse<[NoDeliveryRegionModel]>.self, from: data) else { return }
                            self.cityArray.removeAll()
                            if let _data = model.data{
                                self.cityArray = _data
                            }
                            let noDeliveryRegionModel5 = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "全选", isChoice: false)
                            self.cityArray.insert(noDeliveryRegionModel5, at: 0)
                            for i in 0..<self.titleArray.count{
                                let noDeliveryRegionModel6 = self.titleArray[i]
                                for j in 0..<self.cityArray.count {
                                    let noDeliveryRegionModel7 = self.cityArray[j]
                                    if noDeliveryRegionModel7.regionName == noDeliveryRegionModel6.regionName{
                                        self.cityArray[j] = noDeliveryRegionModel6
                                    }
                                }
                            }
                            self.addTitleView()
                            self.addSubviewContentView()
                            let count = (self.titleArray.count > 2 ? 1 : self.titleArray.count - 1)
                            let btn = self.titleBtnArray[count]
                            self.changBtnTitle(titleBtn: btn)
                        } failureCallback: { error, code in
                            code.loginOut()
                        }
                    }
//                }
//            }
        }
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
        for i in 0..<(titleArray.count > 2 ? 2 : titleArray.count){
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
            titleBtn.setTitle(noDeliveryRegionModel.regionName, for: .normal)
            titleBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"), for: .normal)
            titleBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .selected)
            titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
            titleBtnArray.append(titleBtn)
        }
    }
    
    func addUnLineView(){
        let count = (titleArray.count > 2 ? 1 : titleArray.count - 1)
        let titleBtn = titleBtnArray[count]
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
//                make.width.equalTo(scale(40))
                make.width.equalTo((titleBtn.titleLabel?.bounds.size.width)!)
                make.centerX.equalTo(titleBtn.snp.centerX)
                make.height.equalTo(scale(2))
            })
        }
        if titleBtn.tag == 0{
            contentScrollView.subviews.forEach { view in
                if view.isKind(of: UITableView.self){
                    let tableview = view as! NoDeliveryTableView
                    titleArray.removeAll()
                    for var addressmodel in self.dataArray {
                        addressmodel.isChoice = false
                    }
                    let noDeliveryRegionModel = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "请选择", isChoice: false)
                    titleArray.append(noDeliveryRegionModel)
                    tableview.titleStringArray = self.dataArray
                    tableview.titleArray = titleArray
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
        }else{
            tableview.titleStringArray = self.cityArray
        }
        tableview.titleArray = self.titleArray
        tableview.reloadData()
        tableview.backSelectType = {noDeliveryRegionModel,index,tableview in
            if self.titleArray.count == 1{
                let provinceM = self.dataArray[index]
                self.titleArray[0] = noDeliveryRegionModel
                let noDeliveryRegionModel1 = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "请选择", isChoice: false)
                self.titleArray.append(noDeliveryRegionModel1)
                 let parameters = ["level":3,"regionId":provinceM.regionId as Any] as [String:Any]
                 NetWorkResultRequest(OrderApi.getRegionInfoList(parameters: parameters), needShowFailAlert: true) { result, data in
                     guard let model = try? JSONDecoder().decode(GenericResponse<[NoDeliveryRegionModel]>.self, from: data) else { return }
                     self.cityArray.removeAll()
                     if let _data = model.data{
                         self.cityArray = _data
                     }
                     let noDeliveryRegionModel2 = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "全选", isChoice: false)
                    self.cityArray.insert(noDeliveryRegionModel2, at: 0)
                    tableview.titleArray = self.titleArray
                    tableview.titleStringArray = self.cityArray
                    self.addTitleView()
                    tableview.reloadData()
                    let count = (self.titleArray.count > 2 ? 1 : self.titleArray.count - 1)
                    let btn = self.titleBtnArray[count]
                    self.changBtnTitle(titleBtn: btn)
                } failureCallback: { error, code in
                    code.loginOut()
                }
            }else{
                //对数组进行处理
                var isOnly:Bool = true
                for i in 0..<self.titleArray.count{
                    let noDeliveryRegionModel1 = self.titleArray[i]
                    if noDeliveryRegionModel.regionName == noDeliveryRegionModel1.regionName{
                        self.titleArray[i] = noDeliveryRegionModel
                        isOnly = false
                        break
                    }
                }
                if isOnly{
                    self.titleArray.append(noDeliveryRegionModel)
                }
                //全选的变化
                var isAllChoice = true
                for i in 0..<tableview.titleStringArray.count{
                    let noDeliveryRegionModel1 = tableview.titleStringArray[i]
                    if noDeliveryRegionModel1.regionName == "全选"{
                        continue
                    }
                    if noDeliveryRegionModel1.isChoice == false{
                        isAllChoice = false
                        break
                    }
                }
                if isAllChoice{
                    var noDeliveryRegionModel2 = tableview.titleStringArray[0]
                    noDeliveryRegionModel2.isChoice = true
                    self.titleArray.insert(noDeliveryRegionModel2, at: 1)
                }else{
                    var noDeliveryRegionModel2 = tableview.titleStringArray[0]
                    noDeliveryRegionModel2.isChoice = false
                    tableview.titleStringArray[0] = noDeliveryRegionModel2
                    for i in 0..<self.titleArray.count {
                        var noDeliveryRegionModel3 = self.titleArray[i]
                        if noDeliveryRegionModel3.regionName == "全选"{
                            noDeliveryRegionModel3.isChoice = false
                            self.titleArray[i] = noDeliveryRegionModel3
                        }
                    }
                }
                self.titleArray = self.titleArray.filter({ noDeliveryRegionModel in
                    noDeliveryRegionModel.isChoice == true
                })
                if self.titleArray.count == 1{
                    let noDeliveryRegionModel1 = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "请选择", isChoice: false)
                    self.titleArray.append(noDeliveryRegionModel1)
                }
                tableview.titleArray = self.titleArray
                self.addTitleView()
                tableview.reloadData()
                let count = (self.titleArray.count > 2 ? 1 : self.titleArray.count - 1)
                let btn = self.titleBtnArray[count]
                self.changBtnTitle(titleBtn: btn)
            }
        }
        
        //全选
        tableview.allSelectType = { addressmodel,index,tableview,isAllChoice in
            if isAllChoice{
                for noDeliveryRegionModel in tableview.titleStringArray{
                    if noDeliveryRegionModel.isChoice == true{
                        self.titleArray.append(noDeliveryRegionModel)
                    }
                }
                for i in 0..<self.titleArray.count {
                    var noDeliveryRegionModel3 = self.titleArray[i]
                    if noDeliveryRegionModel3.regionName == "全选"{
                        noDeliveryRegionModel3.isChoice = false
                        self.titleArray[i] = noDeliveryRegionModel3
                    }
                }
                self.titleArray = self.titleArray.filter({ noDeliveryRegionModel in
                    noDeliveryRegionModel.isChoice == true
                })
                
                var noDeliveryRegionModel2 = tableview.titleStringArray[0]
                noDeliveryRegionModel2.isChoice = true
                self.titleArray.insert(noDeliveryRegionModel2, at: 1)
                
                self.titleArray = self.titleArray.noRepetitionUseSet
                
            
            }else{
                for i in 1..<self.titleArray.count {
                    var noDeliveryRegionModel = self.titleArray[i]
                    noDeliveryRegionModel.isChoice = false
                }
                self.titleArray = self.titleArray.filter({ noDeliveryRegionModel in
                    noDeliveryRegionModel.isChoice == true
                })
            }
            self.titleArray = self.titleArray.filter({ noDeliveryRegionModel in
                noDeliveryRegionModel.isChoice == true
            })
            if self.titleArray.count == 1{
                let noDeliveryRegionModel1 = NoDeliveryRegionModel(initials: "0", lat: 0, level: 0, lng: 0, regionId: 0, regionName: "请选择", isChoice: false)
                self.titleArray.append(noDeliveryRegionModel1)
            }
            tableview.titleArray = self.titleArray
            self.addTitleView()
            tableview.reloadData()
            let count = (self.titleArray.count > 2 ? 1 : self.titleArray.count - 1)
            let btn = self.titleBtnArray[count]
            self.changBtnTitle(titleBtn: btn)
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
        LXFLog("=========================\(self.titleArray)")
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
        LXFLog("===========================\(titleArray)")
//        sureChoiceAddress!(titleArray)
        sureChoiceAddress?(titleArray)
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
    var backSelectType:((_ addressmodel:NoDeliveryRegionModel,_ index:Int,_ tableview:NoDeliveryTableView)->Void)?
    
    //全选和取消的时候
    var allSelectType:((_ addressmodel:NoDeliveryRegionModel,_ index:Int,_ tableview:NoDeliveryTableView,_ isAllChoice:Bool)->Void)?
    
    
    var titleStringArray:[NoDeliveryRegionModel] = [NoDeliveryRegionModel]()
    
    //用来判断是省份还是城市
    var titleArray:[NoDeliveryRegionModel] = [NoDeliveryRegionModel]()
    
    
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
            if provinceM.isChoice ?? false{
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
               provinceM1.isChoice = false
               titleStringArray[i] = provinceM1
            }
            cell.isChoiceBtn.isSelected = !cell.isChoiceBtn.isSelected
            provinceM.isChoice = cell.isChoiceBtn.isSelected
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
                provinceM.isChoice = cell.isChoiceBtn.isSelected
                titleStringArray[indexPath.row] = provinceM
                for i in 0..<titleStringArray.count{
                    var addressmodel = titleStringArray[i]
                    addressmodel.isChoice = cell.isChoiceBtn.isSelected
                    titleStringArray[i] = addressmodel
                }
                allSelectType!(provinceM,indexPath.row,self,cell.isChoiceBtn.isSelected)
            }else{
                //没有点击全选
                let cell = tableView.cellForRow(at: indexPath) as! NoDeliveryTableviewCell
                var provinceM = titleStringArray[indexPath.row]
                cell.isChoiceBtn.isSelected = !cell.isChoiceBtn.isSelected
                provinceM.isChoice = cell.isChoiceBtn.isSelected
                titleStringArray[indexPath.row] = provinceM
                backSelectType!(provinceM,indexPath.row,self)
            }
        }
      
    }
}
