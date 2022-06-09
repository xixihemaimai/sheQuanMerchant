//
//  SpecificationValueView.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util

import JFPopup


protocol SpecificationValueViewDelegate:NSObjectProtocol{
    func deleteShowValueIndex(_ index:Int)
    func textfieldEditEndValueAndIndex(text:String,index:Int)
}

class SpecificationValueView: UIView {
    
    weak var delegate:SpecificationValueViewDelegate?
   
    var showValueList:[Specs] = []{
        didSet{
            for i in 0..<showValueList.count{
                let textfield = UITextField()
                 addSubview(textfield)
                 textfield.snp.makeConstraints { make in
                     make.top.equalTo(scale(16) * CGFloat(i) + scale(44) * CGFloat(i) + scale(16))
                     make.left.equalTo(scale(16))
                     make.right.equalTo(-scale(44))
                     make.height.equalTo(scale(44))
                 }
                 textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: scale(8), height: scale(44)))
                 textfield.leftViewMode = .always
                 textfield.placeholder = "请输入"
                 textfield.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
                    NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
                 textfield.layer.cornerRadius = scale(4)
                 textfield.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#D6D6D6").cgColor
                 textfield.layer.borderWidth = scale(1)
                 textfield.tag = i
//                 textfield.text = showValueList[i]
                
                let specs = showValueList[i]
                textfield.text = specs.specValue
//                 textfield.becomeFirstResponder()
                 textfield.addTarget(self, action: #selector(specificationValueEditeing), for: .editingDidEnd)
                 let deleteBtn = UIButton()
                 deleteBtn.tag = i
                 deleteBtn.setBackgroundImage(UIImage(named: "Frame"), for: .normal)
                 deleteBtn.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
                 addSubview(deleteBtn)

                 deleteBtn.snp.makeConstraints { make in
                     make.centerY.equalTo(textfield)
                     make.right.equalTo(-scale(16))
                     make.width.height.equalTo(scale(20))
                 }
            }
        }
    }
    
    
    //删除
    @objc func deleteAction(deleteBtn:UIButton){
        LXFLog(deleteBtn.tag)
        delegate?.deleteShowValueIndex(deleteBtn.tag)
    }
    
    
    //通过编辑里面的值
    @objc func specificationValueEditeing(textfield:UITextField){
        var isIdentical = true
        for specs in showValueList{
            if specs.specValue == textfield.text{
                if  specs.specValue == "" && textfield.text == "" {
                    continue
                }else{
                    JFPopup.toast(hit: "不允许添加俩个相同值得规格值")
                    textfield.text = ""
                    isIdentical = false
                    break
                }
            }
        }
        if isIdentical{
            if (textfield.text?.count ?? 0) > 0{
                delegate?.textfieldEditEndValueAndIndex(text: textfield.text ?? "", index: textfield.tag)
                textfield.resignFirstResponder()
            }else{
                JFPopup.toast(hit: "请去添加规格值")
            }
        }
    }
    
}
