//
//  BusinessTypeHeaderView.swift
//  App
//
//  Created by mac on 2022/4/26.
//

import UIKit
import Util

class BusinessTypeHeaderView: UITableViewHeaderFooterView {
   
    
    //
    lazy var showOpenBtn:UIButton = {
       let showOpenBtn = UIButton()
        return showOpenBtn
    }()
    
    
    //这边是是否选择
    lazy var choiceBtn:UIButton = {
       let choiceBtn = UIButton()
        choiceBtn.setBackgroundImage(UIImage(named: ""), for: .normal)
        choiceBtn.setBackgroundImage(UIImage(named: "Group 2742"), for: .selected)
        return choiceBtn
    }()
    
    //一集分类
    lazy var productLabel:UILabel = {
       let productLabel = UILabel()
        productLabel.text = "水果生鲜"
        productLabel.textAlignment = .left
        productLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        productLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .semibold)
        return productLabel
    }()
    
    
    //展开的按键
    lazy var openBtn:UIButton = {
       let openBtn = UIButton()
        openBtn.setBackgroundImage(UIImage(named: "Frame-right"), for: .normal)
        openBtn.setBackgroundImage(UIImage(named: "Frame-down"), for: .selected)
        return openBtn
    }()
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        contentView.addSubview(showOpenBtn)
        showOpenBtn.addSubview(choiceBtn)
        showOpenBtn.addSubview(productLabel)
        showOpenBtn.addSubview(openBtn)
        
       
        showOpenBtn.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        choiceBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.width.height.equalTo(scale(16))
        }
        
        productLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(choiceBtn.snp.right).offset(scale(8))
            make.height.equalTo(scale(22))
            make.right.equalTo(-scale(100))
        }
        
        openBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(16))
        }
//        showOpenBtn.addTarget(self, action: #selector(openAction), for: .touchUpInside)
    }
    
    
    func openTwoType(section:Int,isOpen:Bool){
         openBtn.isSelected = isOpen
        showOpenBtn.isSelected = isOpen
    }
    
    
//    //展开和关闭
//    @objc func openAction(showOpenBtn:UIButton){
//        showOpenBtn.isSelected = !showOpenBtn.isSelected
//
//
//
//    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
