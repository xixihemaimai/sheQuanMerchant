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
import SwiftyJSON


class NoDeliveryViewController: BaseViewController {
    
    
//    var addressList:[AddressModel] = [AddressModel]()
    //最外层数组
    var regionList:[RegionInfoModel] = [RegionInfoModel]()
    //省份数组
    var provinceList:[RegionInfoModel] = [RegionInfoModel]()
    
    var freightListModel:FreightListModel?
    //数据数组
//    var noDeliveryAreaIds:[Int32] = [Int32]()
    //添加不配送区域的回调
    var noDeliveryCompleteBlock:((_ freightListModel:FreightListModel)->Void)?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "不配送区域"
        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
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
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        addRegionBtn.layer.cornerRadius = scale(4)
        
        loadNoDeliveryList()
        
        //这边获取省份
        let parameters = ["freightVerId":freightListModel?.freightId as Any,"level":2,"regionId":0,"subHierarchy":1] as [String:Any]
        NetWorkResultRequest(OrderApi.getFreightRegionList(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
                guard let model = try? JSONDecoder().decode(GenericResponse<[RegionInfoModel]>.self, from: data) else { return }
                self?.provinceList.removeAll()
                if let _data = model.data{
                    self?.provinceList = _data
                }
        } failureCallback: { error, code in
            code.loginOut()
        }
        
    }
    
    
    
    func loadNoDeliveryList(){
        //这边获取
        var resultstr = "["
        for i in 0..<(freightListModel?.noDeliveryRegionIds?.count ?? 0){
            guard let value = freightListModel?.noDeliveryRegionIds?[i] else{
                return
            }
            if i == 0{
                resultstr += String(format: "%d",value)
            }else{
                resultstr += ","  + String(format: "%d",value)
            }
        }
        resultstr += "]"
        let parameters1 = ["freightVerId":freightListModel?.freightId as Any,"noDeliveryRegionIds":(resultstr.count > 0 ? resultstr : [Int32]())] as [String:Any]
        NetWorkResultRequest(OrderApi.getNoDeliveryRegionList(parameters: parameters1), needShowFailAlert: true) {[weak self] result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<[RegionInfoModel]>.self, from: data) else { return }
            self?.regionList.removeAll()
            if let _data = model.data{
//                self.regionList = _data
                for i in 0..<_data.count{
                    var regionInfoModel = _data[i]
                    regionInfoModel.childNodes = regionInfoModel.childNodes?.filter({ regionInfoModel2 in
                        regionInfoModel2.checked == true
                    })
                    self?.regionList.append(regionInfoModel)
                }
            }
            self?.tableview.reloadData()
            self?.tableview.mj_header?.endRefreshing()
        } failureCallback: {[weak self] error, code in
            code.loginOut()
            self?.tableview.mj_header?.endRefreshing()
        }
    }
    
    
    override func headerRereshing() {
        loadNoDeliveryList()
    }
    

    
    //添加区域不配送
    @objc func addRegionNoDeliveryAction(addRegionBtn:UIButton){
        LXFLog("添加不配送区域")
        //这边要把所有的界面展示的都带过去
        self.popup.bottomSheet {
            //(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(442)), addressList: [],dataArray:self.provinceList)
            let nodeliveryRegionView = NoDeliveryRegionView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(442)) , regionInfoModel: RegionInfoModel(initials: "", lat: 0, level: 2, lng: 0, regionId: 0, regionName: "", checked: false, childNodes: [RegionInfoModel]()), addNewNoAreaList: self.regionList, dataArray: self.provinceList, jumpType: 0)
            
            nodeliveryRegionView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            
            nodeliveryRegionView.sureChoiceAddress = {[weak self] list in
                self?.regionList = list
                
                
                var noDeliveryRegionIds:[Int32] = [Int32]()
                for n in 0..<(self?.regionList.count ?? 0){
                    let regionInfoModel = self?.regionList[n]
                    noDeliveryRegionIds.append((regionInfoModel?.regionId)!)
                    for j in 0..<(regionInfoModel?.childNodes?.count ?? 0){
                        let regionInfoModel2 = regionInfoModel?.childNodes?[j]
                        noDeliveryRegionIds.append((regionInfoModel2?.regionId)!)
                    }
                }
                self?.freightListModel?.noDeliveryRegionIds = noDeliveryRegionIds
                self?.noDeliveryCompleteBlock?((self?.freightListModel)!)
                
                //有全选的要对省份进行判断
                //要是没有的话要对区域进行判断
//                let addressModel = list[1]
//                if addressModel.regionName == "全选"{
//                    var isAdd:Bool = true
//                    for i in 0..<(self?.regionList.count ?? 0){
//                        let array = self?.regionList[i]
//                        for j in 0..<(array?.count ?? 0){
//                            let addressmodel2 = array![j] as RegionInfoModel
//                            for n in 0..<list.count{
//                            let addressmodel1 = list[n]
//                            if addressmodel2.regionName == "全选" || addressmodel1.regionName == "全选"{
//                               continue
//                            }
//                            if addressmodel2.regionName == addressmodel1.regionName{
//                               isAdd = false
//                               break
//                            }
//                          }
//                        }
//                    }
//                    if isAdd{
//                        self?.regionList.append(list)
//                    }else{
//                        JFPopup.toast(hit: "添加的地址有相同的地方")
//                    }
//                }else{
//                    //没有全选的时候
//                    var isAdd:Bool = true
//                    for i in 0..<(self?.regionList.count ?? 0){
//                        if let array = self?.regionList[i]{
//                            for j in 1..<array.count{
//                                let addressmodel2 = array[j] as RegionInfoModel
//                                for n in 0..<list.count{
//                                let addressmodel1 = list[n]
//                                if addressmodel2.regionName == "全选" || addressmodel1.regionName == "全选"{
//                                   continue
//                                }
//                                if addressmodel2.regionName == addressmodel1.regionName{
//                                   isAdd = false
//                                   break
//                                }
//                              }
//                            }
//                        }
//                    }
//                    if isAdd{
//                        self?.regionList.append(list)
//                    }else{
//                        JFPopup.toast(hit: "添加的地址有相同的地方")
//                    }
//                }
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
                    var noDeliveryRegionIds:[Int32] = [Int32]()
                    for n in 0..<(self?.regionList.count ?? 0){
                        let regionInfoModel = self?.regionList[n]
                        noDeliveryRegionIds.append((regionInfoModel?.regionId)!)
                        for j in 0..<(regionInfoModel?.childNodes?.count ?? 0){
                            let regionInfoModel2 = regionInfoModel?.childNodes?[j]
                            noDeliveryRegionIds.append((regionInfoModel2?.regionId)!)
                        }
                    }
                    self?.freightListModel?.noDeliveryRegionIds = noDeliveryRegionIds
                    self?.noDeliveryCompleteBlock?((self?.freightListModel)!)
                    
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
        //判断是否为全选的一个状态
        //第1中是全选的话，显示为省份的值
        //第2中是省份在显示各个选中的城市
        let regionInfoModel = regionList[indexPath.row]
//        let addressmodel = array[1] as RegionInfoModel
        if regionInfoModel.checked == true{
//        if addressmodel.regionName == "全选"{
//            let addressmodel1 = array[0] as RegionInfoModel
            cell.addressText = regionInfoModel.regionName ?? ""
        }else{
            //这边是省份和后续的东西
            var addressText:String = (regionInfoModel.regionName ?? "") + "("
            for i in 0..<(regionInfoModel.childNodes?.count ?? 0){
                let addressmodel = regionInfoModel.childNodes?[i]
                if regionInfoModel.childNodes?.count == 1{
                        addressText += (addressmodel?.regionName ?? "") + ")"
                }else{
                    if i == 0{
                        addressText += (addressmodel?.regionName ?? "")
                    }else if i == regionInfoModel.childNodes!.count - 1{
                        addressText += "、" + (addressmodel?.regionName ?? "") + ")"
                    }else{
                        addressText +=  "、" + (addressmodel?.regionName ?? "")
                    }
                }
            }
//            for i in 0..<array.count{
//                let addressmodel = array[i] as RegionInfoModel
//                if i == 0{
//                    addressText += (addressmodel.regionName)! + "("
//                }else if i == array.count - 1{
//                    addressText += (addressmodel.regionName)! + ")"
//                }else{
//                    addressText += (addressmodel.regionName)! + "、"
//                }
//            }
//          cell.regionLabel.text = addressText
            cell.addressText = addressText
        }
        
        cell.cancelBtn.tag = indexPath.row
        cell.cancelBtn.addTarget(self, action: #selector(deleteNoDeliveryAction), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //判断是否为全选的一个状态
        //第1中情况要是全选的话就需要添加一个全选的模型，并插入到数组1个位置
        //第2中情况不需要添加这个全选的状态，该省的所有的城市进行城市网络获取请求,并要判断是该省的那个城市是选中了的城市添加到数组中
//        var cityArray = [NoDeliveryRegionModel]()
//        var list = self.regionList[indexPath.row]
//        let noDeliveryRegionModel = list[0]
//        let parameters = ["level":3,"regionId":noDeliveryRegionModel.regionId as Any] as [String:Any]
//        NetWorkResultRequest(OrderApi.getRegionInfoList(parameters: parameters), needShowFailAlert: true) { result, data in
//            do{
//                let json = try JSON(data: data)
//                if let arrayJSON = json["data"].array{
//                    cityArray = arrayJSON.map({ return NoDeliveryRegionModel(json: $0)})
//                }
//                LXFLog("====================\(cityArray)")
//            }catch{}
//            //要是完整的话就对该省的所有的城市都添加到这个数组中
//            //要是不是就对该确定的城市进行添加
//            //0为省份，之后是城市 有regId
//            var addCityArray = [NoDeliveryRegionModel]()
//            for i in 1..<list.count{
//                let cityModel = list[i]
//                for n in 0..<cityArray.count {
//                    let cityRegionModel = cityArray[n]
//                    if cityModel.regionId == cityRegionModel.regionId{
//                        addCityArray.append(cityRegionModel)
//                    }
//                }
//            }
//            if addCityArray.count == cityArray.count{
//                //全选
//                let noDeliveryRegionModel1 = NoDeliveryRegionModel()
//                noDeliveryRegionModel1.isChoice = true
//                noDeliveryRegionModel1.regionName = "全选"
//                addCityArray.insert(noDeliveryRegionModel1, at: 0)
//                addCityArray.insert(noDeliveryRegionModel, at: 0)
//                list = addCityArray
//            }else{
//                //不是全选
//                addCityArray.insert(noDeliveryRegionModel, at: 0)
//                list = addCityArray
//            }
//        } failureCallback: { error, code in
//            code.loginOut()
//        }
            
        let list = self.regionList[indexPath.row]
        self.popup.bottomSheet {
//            LXFLog("====================-----------------------------------------")
            let nodeliveryRegionView = NoDeliveryRegionView(frame:CGRect(x: 0, y: 0, width: SCW, height: scale(442)), regionInfoModel: list, addNewNoAreaList: self.regionList, dataArray: self.provinceList, jumpType: 1)
            nodeliveryRegionView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
            }
            nodeliveryRegionView.sureChoiceAddress = {[weak self] list in
                //self?.addressList = list
                self?.regionList = list
                //这边要传递出去数据
                var noDeliveryRegionIds:[Int32] = [Int32]()
                for n in 0..<(self?.regionList.count ?? 0){
                    let regionInfoModel = self?.regionList[n]
                    noDeliveryRegionIds.append((regionInfoModel?.regionId)!)
                    for j in 0..<(regionInfoModel?.childNodes?.count ?? 0){
                        let regionInfoModel2 = regionInfoModel?.childNodes?[j]
                        noDeliveryRegionIds.append((regionInfoModel2?.regionId)!)
                    }
                }
                self?.freightListModel?.noDeliveryRegionIds = noDeliveryRegionIds
                self?.noDeliveryCompleteBlock?((self?.freightListModel)!)
                
                
                
//                //有全选的要对省份进行判断
//                //要是没有的话要对区域进行判断
//                let addressModel = list[1]
//                if addressModel.regionName == "全选"{
//                    var isAdd:Bool = true
//                    for i in 0..<(self?.regionList.count ?? 0){
//                        let array = self?.regionList[i]
//                        if i == indexPath.row{
//                          continue
//                        }
//                        for j in 0..<(array?.count ?? 0){
//                            let addressmodel2 = array![j] as RegionInfoModel
//                            for n in 0..<list.count{
//                            let addressmodel1 = list[n]
//                            if addressmodel2.regionName == "全选" || addressmodel1.regionName == "全选"{
//                                continue
//                            }
//                            if addressmodel2.regionName == addressmodel1.regionName{
//                               isAdd = false
//                               break
//                            }
//                          }
//                        }
//                    }
//                    if isAdd{
//                        self?.regionList[indexPath.row] = list
//                    }else{
//                        JFPopup.toast(hit: "添加的地址有相同的地方")
//                    }
//                }else{
//                    //没有全选的时候
//                    var isAdd:Bool = true
//                    for i in 0..<(self?.regionList.count ?? 0){
//                        if let array = self?.regionList[i]{
//                            if i == indexPath.row{
//                              continue
//                            }
//                            for j in 1..<array.count{
//                                let addressmodel2 = array[j] as RegionInfoModel
//                                for n in 0..<list.count{
//                                let addressmodel1 = list[n]
//                                if addressmodel2.regionName == "全选" || addressmodel1.regionName == "全选"{
//                                    continue
//                                }
//                                if addressmodel2.regionName == addressmodel1.regionName{
//                                   isAdd = false
//                                   break
//                                }
//                              }
//                           }
//                        }
//                    }
//                    if isAdd{
//                        self?.regionList[indexPath.row] = list
//                    }else{
//                        JFPopup.toast(hit: "添加的地址有相同的地方")
//                    }
//                }
                self?.tableview.reloadData()
                self?.popup.dismissPopup()
            }
            return nodeliveryRegionView
        }
    }
}
        
        
