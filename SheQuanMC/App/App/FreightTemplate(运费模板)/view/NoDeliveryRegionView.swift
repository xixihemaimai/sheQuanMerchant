//
//  NoDeliveryRegionView.swift
//  App
//
//  Created by mac on 2022/5/13.
//

import UIKit
import JFPopup
import Util

class NoDeliveryRegionView: UIView {
    
    
    //取消的闭包
    var cancelBlock:(()->Void)?
    //确定的闭包
    var sureChoiceAddress:((_ addreList:[AddressModel]) ->Void)?


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
        let tableview = NoDeliveryTableView(frame: .zero, style: .grouped)
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
    var titleArray:[AddressModel] = [AddressModel]()
    
    
    var titleBtnArray:[UIButton] = [UIButton]()
    

    //省份数组
    var dataArray:[AddressModel] = [AddressModel]()
    var cityArray : [AddressModel] = [AddressModel]()
    var districtArray : [AddressModel] = [AddressModel]()
    
    
    init(frame: CGRect,addressList:[AddressModel]) {
        super.init(frame: frame)
        
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
        
        
        contentScrollView.addSubview(tableview)
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        tableview.snp.makeConstraints { make in
            make.top.equalTo(-scale(20))
            make.height.equalTo(scale(442) - scale(106))
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
        }
        
       //同一个包情况
       //let path = Bundle.main.path(forResource:"city", ofType: "json")
       //不同一个包的情况
       let path = Bundle(for: type(of: self)).url(forResource: "city", withExtension: "json")
       do{
           //let url = URL(fileURLWithPath: path!)
           let addressData = try NSData.init(contentsOf: path!)
           let addressDic = try JSONSerialization.jsonObject(with: addressData as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
           let dic = addressDic.object(at: 0) as! NSDictionary
           let provinceArray = dic["childs"] as! NSArray
           for i in 0..<provinceArray.count {
                let provinceDic = provinceArray.object(at: i) as! NSDictionary
                let provinceM = AddressModel.init()
                provinceM.region_name = (provinceDic["region_name"] as? String)
                provinceM.region_id = (provinceDic["region_id"] as! String)
                provinceM.agency_id = (provinceDic["agency_id"] as? String)
                provinceM.parent_id = (provinceDic["parent_id"] as! String)
                provinceM.region_type = (provinceDic["region_type"] as! String)
                provinceM.isChoice = false
                provinceM.childs = (provinceDic["childs"] as! [NSDictionary])
                self.dataArray.append(provinceM)
           }
       }catch{}
        if self.titleArray.count < 1{
            let addressmodel = AddressModel()
            addressmodel.region_name = "请选择"
            titleArray = [addressmodel]
        }else{
            //这边要进行判断
            let addressmodel = titleArray[0] as AddressModel
            for i in 0..<self.dataArray.count {
                let provinceM = self.dataArray[i] as AddressModel
                if provinceM.region_name == (addressmodel.region_name)!{
                    self.cityArray.removeAll()
                    let cityDicArray = provinceM.childs!
                    for j in 0..<cityDicArray.count {
                       let cityDic = cityDicArray[j]
                       let cityM = AddressModel.init()
                       cityM.region_name = (cityDic["region_name"] as? String)
                       cityM.region_id = (cityDic["region_id"] as! String)
                       cityM.agency_id = (cityDic["agency_id"] as? String)
                       cityM.parent_id = (cityDic["parent_id"] as! String)
                       cityM.region_type = (cityDic["region_type"] as! String)
                       cityM.childs = (cityDic["childs"] as! [NSDictionary])
                       cityM.isChoice = (cityDic["isChoice"] as! Bool)
                       self.cityArray.append(cityM)
                    }
                }
            }
            
            
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
//            }
        }
        
        addTitleView()
        addSubviewContentView()
        let btn = titleBtnArray[titleArray.count - 1]
//        titleBtnClick(titleBtn: btn)
        changBtnTitle(titleBtn: btn)
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
        let btnW = (SCW/2)/3
        for i in 0..<(titleArray.count > 2 ? 2 : titleArray.count){
            let addressmodel = titleArray[i] as AddressModel
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
            titleBtn.setTitle(addressmodel.region_name, for: .normal)
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
                    for addressmodel in self.dataArray {
                        addressmodel.isChoice = false
                    }
                    let addressmodel = AddressModel()
                    addressmodel.region_name = "请选择"
                    addressmodel.isChoice = false
                    titleArray.append(addressmodel)
                    
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
//        else if titleBtn.tag == 1{
//            if titleBtn.currentTitle != "请选择" {
//                contentScrollView.subviews.forEach { view in
//                    if view.isKind(of: UITableView.self){
//                        let tableview = view as! NoDeliveryTableView
//                        let addressmodel = titleArray[0] as AddressModel
//                        titleArray.removeLast()
//                        for i in 0..<self.dataArray.count {
//                            let provinceM = self.dataArray[i] as AddressModel
//                            if provinceM.region_name == (addressmodel.region_name)!{
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
//                                    cityM.isChoice = (cityDic["isChoice"] as! Bool)
//                                   self.cityArray.append(cityM)
//                                }
//                            }
//                        }
//                        let addressmodel1 = titleArray[1] as AddressModel
//                        addressmodel1.region_name = "请选择"
//
//                        tableview.titleStringArray = cityArray
//                        tableview.reloadData()
//                        self.addTitleView()
//                        let btn = titleBtnArray[titleArray.count - 1]
//                        changBtnTitle(titleBtn: btn)
//                    }
//                }
//            }
//        }
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
//        let tableview = RegionTableView(frame: .zero, style: .grouped)
        if titleArray.count == 1{
            tableview.titleStringArray = self.dataArray
        }else{
            tableview.titleStringArray = self.cityArray
        }
        tableview.titleArray = self.titleArray
        tableview.reloadData()
        tableview.backSelectType = {addressmodel,index,tableview in
            if self.titleArray.count == 1{
                let provinceM = self.dataArray[index]
                self.titleArray[0] = addressmodel
                let addressmodel1 = AddressModel()
                addressmodel1.region_name = "请选择"
                addressmodel1.isChoice = false
                self.titleArray.append(addressmodel1)
                self.cityArray.removeAll()
                let cityDicArray = provinceM.childs!
                for j in 0..<cityDicArray.count {
                   let cityDic = cityDicArray[j]
                   let cityM = AddressModel.init()
                   cityM.region_name = (cityDic["region_name"] as? String)
                   cityM.region_id = (cityDic["region_id"] as! String)
                   cityM.agency_id = (cityDic["agency_id"] as? String)
                   cityM.parent_id = (cityDic["parent_id"] as! String)
                   cityM.region_type = (cityDic["region_type"] as! String)
                   cityM.childs = (cityDic["childs"] as! [NSDictionary])
                   cityM.isChoice = false
                   self.cityArray.append(cityM)
                }
                let addressmodel2 = AddressModel()
                addressmodel2.isChoice = false
                addressmodel2.region_name = "全选"
                self.cityArray.insert(addressmodel2, at: 0)
                tableview.titleArray = self.titleArray
                tableview.titleStringArray = self.cityArray
                
            }else{
                
                
                
                //对数组进行处理
                var isOnly:Bool = true
                for i in 0..<self.titleArray.count{
                    let addressmodel1 = self.titleArray[i]
                    if addressmodel.region_name == addressmodel1.region_name{
                        self.titleArray[i] = addressmodel
                        isOnly = false
                        break
                    }
                }
                
                if isOnly{
                    self.titleArray.append(addressmodel)
                }
                
                
                //全选的变化
                var isAllChoice = true
                for i in 0..<tableview.titleStringArray.count{
                    let addressmodel1 = tableview.titleStringArray[i]
                    if addressmodel1.region_name == "全选"{
                        continue
                    }
                    if addressmodel1.isChoice == false{
                        isAllChoice = false
                        break
                    }
                }
                //tableview.titleStringArray
                if isAllChoice{
                    
                    let addressmodel2 = tableview.titleStringArray[0]
                    addressmodel2.isChoice = true
                    let addressmodel3 = AddressModel()
                    addressmodel3.isChoice = true
                    addressmodel3.region_name = "全选"
                    self.titleArray.insert(addressmodel2, at: 1)
                    
                }else{
                    
                   let addressmodel2 = tableview.titleStringArray[0]
                   addressmodel2.isChoice = false
                    
                   
                    for i in 0..<self.titleArray.count{
                        let addremssmodel3 = self.titleArray[i]
                        if addremssmodel3.region_name == "全选"{
                            addremssmodel3.isChoice = false
                            self.titleArray[i] = addremssmodel3
                        }
                    }
                
                }
                
                self.titleArray = self.titleArray.filter { addressmodel in
                    addressmodel.isChoice == true
                }
                
                
                if self.titleArray.count == 1{
                    let addressmodel1 = AddressModel()
                    addressmodel1.region_name = "请选择"
                    addressmodel.isChoice = false
                    self.titleArray.append(addressmodel1)
                }
                
                
                tableview.titleArray = self.titleArray
            }
            
            self.addTitleView()
            tableview.reloadData()
            let count = (self.titleArray.count > 2 ? 1 : self.titleArray.count - 1)
            let btn = self.titleBtnArray[count]
            self.changBtnTitle(titleBtn: btn)
        }
        
        //全选
        tableview.allSelectType = { addressmodel,index,tableview,isAllChoice in
    
            if isAllChoice{
                
                for addressModel1 in tableview.titleStringArray {
                    if addressModel1.isChoice == true{
                        self.titleArray.append(addressModel1)
                    }
                }
                
                
                
                
                for i in 0..<self.titleArray.count{
                    let addremssmodel3 = self.titleArray[i]
                    if addremssmodel3.region_name == "全选"{
                        addremssmodel3.isChoice = false
                        self.titleArray[i] = addremssmodel3
                    }
                }
                
                
                self.titleArray = self.titleArray.filter { addressmodel in
                    addressmodel.isChoice == true
                }
                
                let addressmodel2 = tableview.titleStringArray[0]
                addressmodel2.isChoice = true
                let addressmodel3 = AddressModel()
                addressmodel3.isChoice = true
                addressmodel3.region_name = "全选"
                self.titleArray.insert(addressmodel2, at: 1)
                
                
                
                self.titleArray = self.titleArray.noRepetitionUseSet
                                
                
            }else{
                
                for i in 1..<self.titleArray.count{
                    let addressmodel = self.titleArray[i]
                    addressmodel.isChoice = false
                   
                }
                
                self.titleArray = self.titleArray.filter { addressmodel in
                    addressmodel.isChoice == true
                }
                
                
            }
            
            self.titleArray = self.titleArray.filter { addressmodel in
                addressmodel.isChoice == true
            }
            
            if self.titleArray.count == 1{
                let addressmodel1 = AddressModel()
                addressmodel1.region_name = "请选择"
                addressmodel.isChoice = false
                self.titleArray.append(addressmodel1)
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
        
        
//        var isChoiceComplete:Bool = true
        //这里要把需要的东西传递出去
//        for view in titleView.subviews {
//            if view.isKind(of: UIButton.self){
//                let btn = view as! UIButton
//                if btn.currentTitle == "请选择"{
//                    isChoiceComplete = false
//                    break
//                }
//            }
//        }
//        if isChoiceComplete == false{
//            JFPopup.toast(hit: "请选择完整的地址")
//            return
//        }
//
//        //把数组传递出去
//        sureChoiceAddress!(titleArray)
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
    var backSelectType:((_ addressmodel:AddressModel,_ index:Int,_ tableview:NoDeliveryTableView)->Void)?
    
    //全选和取消的时候
    var allSelectType:((_ addressmodel:AddressModel,_ index:Int,_ tableview:NoDeliveryTableView,_ isAllChoice:Bool)->Void)?
    
    
    var titleStringArray:[AddressModel] = [AddressModel]()
    
    //用来判断是省份还是城市
    var titleArray:[AddressModel] = [AddressModel]()
    
    
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
    @objc func allProvinceChoiceAction(isChoiceBtn:UIButton){
        
        
    }
    
    
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
        cell.addressLabel.text = provinceM.region_name
        cell.isChoiceBtn.tag = indexPath.row
        cell.isChoiceBtn.addTarget(self, action: #selector(allProvinceChoiceAction), for: .touchUpInside)
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
            let provinceM = titleStringArray[indexPath.row]
           //这边要进行更改
            let cell = tableView.cellForRow(at: indexPath) as! NoDeliveryTableviewCell
            for i in 0..<self.titleStringArray.count{
               let provinceM1 = titleStringArray[i]
               provinceM1.isChoice = false
            }
            cell.isChoiceBtn.isSelected = !cell.isChoiceBtn.isSelected
            provinceM.isChoice = cell.isChoiceBtn.isSelected
            if cell.isChoiceBtn.isSelected{
                backSelectType!(provinceM,indexPath.row,self)
            }
        }else{
            //点击了全选
            if indexPath.row == 0{
                
                let provinceM = titleStringArray[indexPath.row]
                let cell = tableView.cellForRow(at: indexPath) as! NoDeliveryTableviewCell
                cell.isChoiceBtn.isSelected = !cell.isChoiceBtn.isSelected
                provinceM.isChoice = cell.isChoiceBtn.isSelected
                for addressmodel in titleStringArray{
                    addressmodel.isChoice = cell.isChoiceBtn.isSelected
                }
                
                
//                backSelectType!(provinceM,indexPath.row,self,true)
                allSelectType!(provinceM,indexPath.row,self,cell.isChoiceBtn.isSelected)
                
            }else{
                
                //没有点击全选
                let cell = tableView.cellForRow(at: indexPath) as! NoDeliveryTableviewCell
                let provinceM = titleStringArray[indexPath.row]
                cell.isChoiceBtn.isSelected = !cell.isChoiceBtn.isSelected
                provinceM.isChoice = cell.isChoiceBtn.isSelected

                
                
                
                backSelectType!(provinceM,indexPath.row,self)
            }
        }
      
    }
}
