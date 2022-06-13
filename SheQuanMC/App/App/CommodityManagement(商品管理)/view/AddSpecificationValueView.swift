//
//  AddSpecificationValueView.swift
//  App
//
//  Created by mac on 2022/6/13.
//

import UIKit
import Util
import JFPopup

class AddSpecificationValueView: UIView {
    
    
    //规格
    lazy var textfield:UITextField = {
       let textfield = UITextField()
        textfield.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        textfield.placeholder = "  请输入规格名称"
        textfield.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        textfield.attributedPlaceholder = NSAttributedString.init(string:"  请输入规格名称", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#B3B3B3")])
        return textfield
    }()
    
    var cancelBlock:(()->Void)?

    var categoryId:Int32 = 0
    
    
    var sureAddCustomNewSpecificationList:((_ list:[SpecGroups])->Void)?
    
    init(frame:CGRect,categoryId:Int32){
        super.init(frame: frame)
        
        backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        self.categoryId = categoryId
        
        let customSpecificationLabel = UILabel()
        customSpecificationLabel.text = "新建自定义规格"
        customSpecificationLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        customSpecificationLabel.font = UIFont.systemFont(ofSize: scale(18), weight: .medium)
        customSpecificationLabel.textAlignment = .center
        addSubview(customSpecificationLabel)
        
        
        customSpecificationLabel.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(scale(57))
        }
        
        
        addSubview(textfield)
        textfield.snp.makeConstraints { make in
            make.left.equalTo(scale(32))
            make.right.equalTo(-scale(32))
            make.height.equalTo(scale(42))
            make.top.equalTo(customSpecificationLabel.snp.bottom)
        }
        textfield.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F4F4F4")
        textfield.layer.cornerRadius = scale(4)
        
        
        layer.cornerRadius = scale(4)
        
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        addSubview(midView)
        
        midView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(textfield.snp.bottom).offset(scale(17))
            make.height.equalTo(scale(0.5))
        }
        
        let cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999"), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addSubview(cancelBtn)
        
        
        cancelBtn.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(midView.snp.bottom)
            make.width.equalTo(frame.size.width/2 - 0.25)
        }
        
        
        cancelBtn.addTarget(self, action: #selector(cancelAddSpectionAction), for: .touchUpInside)
        
        
        let diViView = UIView()
        diViView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        addSubview(diViView)
        
        diViView.snp.makeConstraints { make in
            make.left.equalTo(cancelBtn.snp.right)
            make.top.equalTo(midView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(scale(0.5))
        }
        
        
        
        let sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        addSubview(sureBtn)
        
        sureBtn.snp.makeConstraints { make in
            make.left.equalTo(diViView.snp.right)
            make.bottom.right.equalToSuperview()
            make.top.equalTo(midView.snp.bottom)
        }
        sureBtn.addTarget(self, action: #selector(addNewSpecitionAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //取消新增规格
    @objc func cancelAddSpectionAction(cancelBtn:UIButton){
        cancelBlock!()
    }
    
    //添加新增规格值
    @objc func addNewSpecitionAction(sureBtn:UIButton){
        if (textfield.text?.count ?? 0) > 0{
            var addSpecList:[String] = [String]()
            addSpecList.append(textfield.text ?? "")
            if addSpecList.count > 0{
                var resultstr = "["
            for i in 0..<addSpecList.count{
                let str = addSpecList[i]
                if i == 0{
                    resultstr += "\"" + str + "\""
                }else{
                    resultstr += "," + "\"" + str + "\""
                }
            }
            resultstr += "]"
            let paramters = ["categoryId":categoryId,"specGroupNames":resultstr] as [String:Any]
            NetWorkResultRequest(OrderApi.addSpecGroup(paramters: paramters), needShowFailAlert: true) { result, data in
                guard let model = try? JSONDecoder().decode(GenericResponse<[SpecGroups]>.self, from: data) else {
                    return
                }
                LXFLog("===================\(String(describing: model.data))")
                var newDataList:[SpecGroups] = [SpecGroups]()
                for i in 0..<model.data!.count{
                let groups = model.data![i]
            //                    let specGroups = SpecGroups(specGroupId: groups.specGroupId, specGroupName: groups.specGroupName, specs: [String]())
                let specGroups = SpecGroups(required: groups.required, specGroupId: groups.specGroupId, specGroupName: groups.specGroupName, specGroupType: groups.specGroupType, specs: [String]())
                newDataList.append(specGroups)
                }
                LXFLog("===================\(newDataList)")
                //这边要返回你新增的值
                self.sureAddCustomNewSpecificationList!(newDataList)
            } failureCallback: { error, code in
                code.loginOut()
             }
           }
        }else{
            JFPopup.toast(hit: "请去添加规格的内容")
        }
    }
    
}
