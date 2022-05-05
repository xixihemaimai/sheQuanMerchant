//
//  SpecificationValueView.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util

class SpecificationValueView: UIView {
   
    var showValueList:[Int]?{
        didSet{
            LXFLog("-1======232===================")
            guard let _showValueList = showValueList else { return }
            _showValueList.forEach { index in
               let textfield = UITextField()
                addSubview(textfield)
                textfield.snp.makeConstraints { make in
                    make.top.equalTo(scale(16) * CGFloat(index) + scale(32) * CGFloat(index) + scale(16))
                    make.left.equalTo(scale(16))
                    make.right.equalTo(-scale(44))
                    make.height.equalTo(scale(44))
                }
                
                let deleteBtn = UIButton()
                deleteBtn.setBackgroundImage(UIImage(named: "Frame"), for: .normal)
                addSubview(deleteBtn)
                
                deleteBtn.snp.makeConstraints { make in
                    make.top.equalTo(scale(16) * CGFloat(index) + scale(32) * CGFloat(index) + scale(16))
                    make.right.equalTo(-scale(16))
                    make.width.height.equalTo(scale(16))
                }
            }
        }
    }
}
