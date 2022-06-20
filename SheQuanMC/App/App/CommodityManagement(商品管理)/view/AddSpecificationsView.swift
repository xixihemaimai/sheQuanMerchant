//
//  AddSpecificationsView.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util
import JFPopup
import SwiftyJSON
import SwiftUI



class AddSpecificationsView: UIView {

    
    //这边要进行修改这类的动作
    var cancelBlock:(()->Void)?
    //确定之后传递过来的数组
    var sendSureSpecificationList:((_ list:SpecGroups)->Void)?
    //添加新的规格
    var addCustomNewSpecification:(()->Void)?
    
    
    
    var categoryId:Int32 = 0
    var productId:Int64 = 0
    
    
    var specificationsList:[SpecGroups] = [SpecGroups]()
    
    //这边是自己写入一个规格值
    
    
    lazy var tableview:UITableView = {
        let tableview = UITableView(frame: .zero, style: .plain)
        tableview.estimatedSectionFooterHeight = 0
        tableview.estimatedSectionHeaderHeight = 0
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        tableview.separatorStyle = .none
        if #available(iOS 15.0, *){
            tableview.sectionHeaderTopPadding = 0
        }
        if #available(iOS 11.0, *){
            tableview.contentInsetAdjustmentBehavior = .never
        }
        return tableview
    }()
    
    
    lazy var addNewSpecificationBtn:UIButton = {
       let addNewSpecificationBtn = UIButton()
        addNewSpecificationBtn.setTitle("添加新的规格", for: .normal)
        addNewSpecificationBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        addNewSpecificationBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        addNewSpecificationBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(15), weight: .regular)
        return addNewSpecificationBtn
    }()
    
    
    

    
    //规格一
//    lazy var speciFirstTextfield:UITextField = {
//       let speciFirstTextfield = UITextField()
//        speciFirstTextfield.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        speciFirstTextfield.textAlignment = .left
//        speciFirstTextfield.placeholder = "请输入规格名"
//        speciFirstTextfield.attributedPlaceholder = NSAttributedString.init(string:"请输入规格名", attributes: [
//            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#999999")])
//        return speciFirstTextfield
//    }()
//    //规格二
//    lazy var speciSecondTextfield:UITextField = {
//       let speciSecondTextfield = UITextField()
//        speciSecondTextfield.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        speciSecondTextfield.textAlignment = .left
//        speciSecondTextfield.placeholder = "请输入规格名"
//        speciSecondTextfield.attributedPlaceholder = NSAttributedString.init(string:"请输入规格名", attributes: [
//            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#999999")])
//        return speciSecondTextfield
//    }()
//
//    //添加新的规格名按键
//    lazy var addSpeciNameBtn:UIButton = {
//       let addSpeciNameBtn = UIButton()
//        addSpeciNameBtn.setTitle("添加新的规格名", for: .normal)
//        addSpeciNameBtn.contentHorizontalAlignment = .left
//        addSpeciNameBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#2882EB"), for: .normal)
//        addSpeciNameBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
//        return addSpeciNameBtn
//    }()
//
//
//    var speciSecondSLabel:UILabel!
//    var bottomSView:UIView!
//    var deleteSBtn:UIButton!
    
//    var addSpecificationList:[Int64] = [Int64]()
    
    
    
    
    init(frame:CGRect,productId:Int64,categoryId:Int32) {
        super.init(frame: frame)
//        self.addSpecificationList = addSpecificationList
        self.productId = productId
        self.categoryId = categoryId
        
        backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        

        let specificationLabel = UILabel()
        specificationLabel.text = "添加规格"
        specificationLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        specificationLabel.font = UIFont.systemFont(ofSize: scale(17), weight: .regular)
        addSubview(specificationLabel)

        specificationLabel.snp.makeConstraints { make in
            make.top.equalTo(scale(15))
            make.centerX.equalToSuperview()
            make.width.equalTo(scale(80))
            make.height.equalTo(scale(24))
        }

        let cancelBtn = UIButton()
        cancelBtn.setBackgroundImage(UIImage(named: "关闭1 1"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelAddAction), for: .touchUpInside)
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(16))
            make.width.height.equalTo(scale(22))
        }

        //分割线
        let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        addSubview(diviver)
        diviver.snp.makeConstraints { make in
            make.left.left.right.equalToSuperview()
            make.height.equalTo(scale(0.5))
            make.top.equalTo(specificationLabel.snp.bottom).offset(scale(15))
        }
        
        addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(diviver.snp.bottom)
            make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
        }
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(AppSpecificationsCell.self, forCellReuseIdentifier: "AppSpecificationsCell")
//        tableview.contentInset = UIEdgeInsets(top: scale(20), left: 0, bottom: scale(40), right: 0)
        
        addSubview(addNewSpecificationBtn)
        addNewSpecificationBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
            make.height.equalTo(scale(44))
        }
        
        addNewSpecificationBtn.addTarget(self, action: #selector(addNewSpecificationAction), for: .touchUpInside)
        addNewSpecificationBtn.layer.cornerRadius = scale(4)
        
        
        
        
//        //规格一
//        let speciFirstLabel = UILabel()
//        speciFirstLabel.text = "规格一:"
//        speciFirstLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
//        speciFirstLabel.textAlignment = .left
//        speciFirstLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        addSubview(speciFirstLabel)
//
//        speciFirstLabel.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.top.equalTo(diviver.snp.bottom).offset(13)
//            make.height.equalTo(scale(22))
//            make.width.equalTo(scale(60))
//        }
//
//        addSubview(speciFirstTextfield)
//        speciFirstTextfield.snp.makeConstraints { make in
//            make.left.equalTo(speciFirstLabel.snp.right).offset(scale(16))
//            make.right.equalTo(-scale(16))
//            make.height.equalTo(scale(22))
//            make.top.equalTo(diviver.snp.bottom).offset(scale(13))
//        }
//        //分割线
//        let midView = UIView()
//        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
//        addSubview(midView)
//
//        midView.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.height.equalTo(scale(0.5))
//            make.top.equalTo(speciFirstLabel.snp.bottom).offset(scale(13))
//        }
//
//
//        //添加新的规格名
//        addSubview(addSpeciNameBtn)
//        addSpeciNameBtn.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.right.equalTo(-scale(16))
//            make.top.equalTo(midView.snp.bottom).offset(scale(8))
//            make.height.equalTo(scale(20))
//        }
//        addSpeciNameBtn.addTarget(self, action: #selector(addSpecificationNameAction), for: .touchUpInside)
//
//        //规格二
//        let speciSecondLabel = UILabel()
//        speciSecondLabel.text = "规格二:"
//        speciSecondLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
//        speciSecondLabel.textAlignment = .left
//        speciSecondLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        addSubview(speciSecondLabel)
//        speciSecondSLabel = speciSecondLabel
//        speciSecondLabel.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.top.equalTo(midView.snp.bottom).offset(13)
//            make.height.equalTo(scale(22))
//            make.width.equalTo(scale(60))
//        }
////        speciSecondLabel.isHidden = true
//
//
//        addSubview(speciSecondTextfield)
//        speciSecondTextfield.snp.makeConstraints { make in
//            make.left.equalTo(speciFirstLabel.snp.right).offset(scale(16))
//            make.right.equalTo(-scale(60))
//            make.height.equalTo(scale(22))
//            make.top.equalTo(midView.snp.bottom).offset(scale(13))
//        }
////        speciSecondTextfield.isHidden = true
//
//
//        let deleteBtn = UIButton()
//        deleteBtn.setTitle("删除", for: .normal)
//        deleteBtn.contentHorizontalAlignment = .left
//        deleteBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#2882EB"), for: .normal)
//        deleteBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
//        addSubview(deleteBtn)
//        deleteBtn.snp.makeConstraints { make in
//            make.right.equalTo(-scale(16))
//            make.height.equalTo(scale(30))
//            make.width.equalTo(scale(40))
//            make.top.equalTo(midView.snp.bottom).offset(scale(10))
//        }
////        deleteBtn.isHidden = true
//        deleteSBtn = deleteBtn
//        deleteBtn.addTarget(self, action: #selector(deleteNewSpecificationNameAction), for: .touchUpInside)
//
//
//        //分割线
//        let bottomView = UIView()
//        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
//        addSubview(bottomView)
//        bottomView.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.height.equalTo(scale(0.5))
//            make.top.equalTo(speciSecondLabel.snp.bottom).offset(scale(13))
//        }
//        bottomSView = bottomView
////        bottomSView.isHidden = true
//
//        let sureBtn = UIButton()
//        sureBtn.setTitle("确定", for: .normal)
//        sureBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
//        sureBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
//        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
//        sureBtn.addTarget(self, action: #selector(sureAction), for: .touchUpInside)
//        addSubview(sureBtn)
//
//        sureBtn.snp.makeConstraints { make in
//            make.left.equalTo(scale(16))
//            make.right.equalTo(-scale(16))
//            make.height.equalTo(scale(44))
//            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
//        }
//
//        sureBtn.layer.cornerRadius = scale(4)
//
//        if self.addSpecificationList.count < 1{
//            speciSecondLabel.isHidden = false
//            speciSecondTextfield.isHidden = false
//            deleteBtn.isHidden = false
//            bottomSView.isHidden = false
//            addSpeciNameBtn.isHidden = true
//
//        }else{
//            speciSecondLabel.isHidden = true
//            speciSecondTextfield.isHidden = true
//            deleteBtn.isHidden = true
//            bottomSView.isHidden = true
//            addSpeciNameBtn.isHidden = false
//        }
//        self.addSpecificationList.removeAll()
        
        
        
        //这边要去获取商品规格列表
        
        
        loadProductSpecList()
        
        
    }
    
    
    
    //添加新的规格值
    @objc func addNewSpecificationAction(addNewSpecificationBtn:UIButton){
//        cancelBlock!()
        addCustomNewSpecification!()
    }
    
    
    
    func loadProductSpecList(){
        let parameters = ["categoryId":categoryId,"productId":productId] as [String:Any]
        NetWorkResultRequest(OrderApi.getProductSpecList(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
           
            do{
                let json = try JSON(data: data)
//                LXFLog("================\(json)")
                let array = json["data"]["specGroups"]
                
//                guard let model = try? JSONDecoder().decode(GenericResponse<[SpecGroups]>.self, from: data) else { return }
//                LXFLog("================\(model)")
       
//                LXFLog("==========\(data)")
//                if let array1s = json["data"]["specGroups"].array{
//                   LXFLog("=================\(array1s)")
//                   LXFLog("===============\(array1s[0])")
//                   LXFLog("===============\(String(describing: array1s[0]["specGroupType"].int32))")
//                }
                
                for i in 0..<array.count {
                    let dict = array[i]
                    //let specGroups = data1[i]
                    var specGroups = SpecGroups(required: false, specGroupId: 0, specGroupName: "", specGroupType: 0, specs: [String]())
                    specGroups.required = dict["required"].boolValue
                    specGroups.specGroupType = dict["specGroupType"].int32Value
                    specGroups.specGroupId = dict["specGroupId"].int64Value
                    specGroups.specGroupName = dict["specGroupName"].stringValue
//                    specGroups.specs = dict["specs"].arrayValue
                    let specsArray = dict["specs"]
                    if specsArray.count > 0{
                        for j in 0..<specsArray.count {
                            let str = specsArray[j].stringValue
                            specGroups.specs?.append(str)
                        }
                        self?.specificationsList.append(specGroups)
                    }else{
                        specGroups.specs = [String]()
                        self?.specificationsList.append(specGroups)
                    }
//                    self?.saveList.append(specGroups)
//                    let colorList = [Specs]()
//                    self?.saveValueList.append(colorList)
                }
//                for n in 0..<(self?.saveList.count ?? 0){
//                var specGroups = self?.saveList[n]
//                var colorList = self?.saveValueList[n]
//                 if (specGroups?.specs?.count ?? 0) > 0{
//                    for j in 0..<(specGroups?.specs?.count ?? 0){
//                        let str = specGroups?.specs?[j]
//                        let specs = Specs(specGroupId: specGroups?.specGroupId,specValue:str)
//                        colorList?.append(specs)
//                    }
//                      self?.saveValueList[n] = colorList!
//                 }else{
//                    specGroups?.specs = [String]()
//                    self?.saveList[n] = specGroups!
//                    }
//                }
//                self?.UnionSetArray(tag: 0, index: 0)
//                self?.newTableView.reloadData()
                
                
                LXFLog("====================\(String(describing: self?.specificationsList))")
                self?.tableview.reloadData()
            }catch{}
            
            
            
//            if let data1 = model.data{
//                //这边就是要进行设置了
//                for i in 0..<data1.count {
//                    let specGroups = data1[i]
//                    self?.saveList.append(specGroups)
////                    self?.addCoutList.append(specGroups.specGroupName ?? "")
//                    let colorList = [Specs]()
//                    self?.saveValueList.append(colorList)
//                }
//
//                //这边是设置规格值得地方
//                for n in 0..<(self?.saveList.count ?? 0){
//                    var specGroups = self?.saveList[n]
//                    var colorList = self?.saveValueList[n]
//                    if (specGroups?.specs?.count ?? 0) > 0{
//                        for j in 0..<(specGroups?.specs?.count ?? 0){
//                            let str = specGroups?.specs?[j]
//                            let specs = Specs(specGroupId: specGroups?.specGroupId,specValue:str)
//                            colorList?.append(specs)
//                        }
//                        self?.saveValueList[n] = colorList!
//                    }else{
//                        specGroups?.specs = [String]()
//                        self?.saveList[n] = specGroups!
//                    }
//                }
//                self?.UnionSetArray(tag: 0, index: 0)
//                self?.newTableView.reloadData()
//            }
        } failureCallback: { error, code in
            code.loginOut()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //取消
    @objc func cancelAddAction(cancelBtn:UIButton){
        cancelBlock!()
    }
    
    //确定
//    @objc func sureAction(sureBtn:UIButton){
//        //传递过来
//        var addSpecList:[String] = [String]()
//        if (speciFirstTextfield.text?.count ?? 0) > 0{
//            addSpecList.append(speciFirstTextfield.text ?? "")
//        }
//
//        if (speciSecondTextfield.text?.count ?? 0) > 0{
//            addSpecList.append(speciSecondTextfield.text ?? "")
//        }
//
//
//
//
//        if addSpecList.count > 0{
////            let resultStr = addSpecificationList.joined()
//            var resultstr = "["
//            for i in 0..<addSpecList.count{
//                let str = addSpecList[i]
//                if i == 0{
//                    resultstr += "\"" + str + "\""
//                }else{
//                    resultstr += "," + "\"" + str + "\""
//                }
//            }
//            resultstr += "]"
//            let paramters = ["categoryId":categoryId,"specGroupNames":resultstr] as [String:Any]
//            NetWorkResultRequest(OrderApi.addSpecGroup(paramters: paramters), needShowFailAlert: true) { result, data in
//                guard let model = try? JSONDecoder().decode(GenericResponse<[SpecGroups]>.self, from: data) else {
//                    return
//                }
//                LXFLog("===================\(model.data)")
//                var newDataList:[SpecGroups] = [SpecGroups]()
//                for i in 0..<model.data!.count{
//                    let groups = model.data![i]
////                    let specGroups = SpecGroups(specGroupId: groups.specGroupId, specGroupName: groups.specGroupName, specs: [String]())
//                    let specGroups = SpecGroups(required: groups.required, specGroupId: groups.specGroupId, specGroupName: groups.specGroupName, specGroupType: groups.specGroupType, specs: [String]())
//                    newDataList.append(specGroups)
//                }
//                LXFLog("===================\(newDataList)")
//                self.sendSureSpecificationList!(newDataList)
//            } failureCallback: { error, code in
//                code.loginOut()
//            }
//        }
//
//    }
    
    //添加新的规格名
//    @objc func addSpecificationNameAction(addSpeciNameBtn:UIButton){
//        if addSpecificationList.count < 1 {
//            deleteSBtn.isHidden = false
//            bottomSView.isHidden = false
//            speciSecondTextfield.isHidden = false
//            speciSecondTextfield.text = ""
//            speciSecondSLabel.isHidden = false
//            addSpeciNameBtn.isHidden = true
//        }else{
//            JFPopup.toast(hit: "只允许添加俩个规格")
//        }
//    }
    
    //删除新添加的规格名
//    @objc func deleteNewSpecificationNameAction(deleteBtn:UIButton){
//        deleteSBtn.isHidden = true
//        bottomSView.isHidden = true
//        speciSecondTextfield.isHidden = true
//        speciSecondTextfield.text = ""
//        speciSecondSLabel.isHidden = true
//        addSpeciNameBtn.isHidden = false
//    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


extension AddSpecificationsView:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specificationsList.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "AppSpecificationsCell") as! AppSpecificationsCell
        let specGroups = specificationsList[indexPath.row]
        cell.specificationsLabel.text = specGroups.specGroupName
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let specGroups = specificationsList[indexPath.row]
//        sendSureSpecificationList!(specGroups)
        currentVC?.popup.alert {
            [.title("是否选择该规格"),
             .cancelAction([
                .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999")),
                .text("取消"),
                .tapActionCallback({
                })
              ]),
             .confirmAction([
                .text("确定"),
                .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                .tapActionCallback({
                    let specGroups = self.specificationsList[indexPath.row]
                    self.sendSureSpecificationList!(specGroups)
                })
              ])
            ]
        }
    }
}
