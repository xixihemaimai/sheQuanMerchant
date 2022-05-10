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
   
    var showValueList:[String] = []{
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
                 textfield.text = showValueList[i]
                 textfield.layer.cornerRadius = scale(4)
                 textfield.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#D6D6D6").cgColor
                 textfield.layer.borderWidth = scale(1)
                 textfield.tag = i
                 textfield.addTarget(self, action: #selector(specificationValueEditeing), for: .editingDidEnd)
                 let deleteBtn = UIButton()
                 deleteBtn.tag = i
                 deleteBtn.setBackgroundImage(UIImage(named: "Frame"), for: .normal)
                deleteBtn.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
                 addSubview(deleteBtn)

                 deleteBtn.snp.makeConstraints { make in
                     make.centerY.equalTo(textfield)
                     make.right.equalTo(-scale(16))
                     make.width.height.equalTo(scale(16))
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
        LXFLog(textfield.text)
        if !showValueList.contains(textfield.text ?? "") {
            delegate?.textfieldEditEndValueAndIndex(text: textfield.text ?? "", index: textfield.tag)
        }else{
            textfield.text = ""
            JFPopup.toast(hit: "不允许添加相同的规格值")
        }
    }
}
