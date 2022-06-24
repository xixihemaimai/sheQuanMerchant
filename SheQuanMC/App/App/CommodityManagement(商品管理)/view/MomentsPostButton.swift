//
//  MomentsPostButton.swift
//  App
//
//  Created by mac on 2022/6/23.
//

import UIKit
import Util

class MomentsPostButton: UIButton {
    
    
    lazy var mainImage:UIImageView = {
        let mainImage = UIImageView()
        mainImage.image = UIImage(named: "Group 2786")
        return mainImage
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let borderWidth: CGFloat = 2
//        let borderColor: UIColor = .gray
//        backgroundColor = UIColor.groupTableViewBackground
        
        setTitle("商品图0/6", for: .normal)
        setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2"), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize:scale(13), weight: .regular)
        setImagePostion(type: .imageTop, Space: scale(57))
        setBackgroundImage(UIImage(named: "Group 2650"), for: .normal)
        
        addSubview(mainImage)
        mainImage.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.equalTo(scale(31))
            make.height.equalTo(scale(19))
        }
        
        
        /// 横
//        let vHorizontal = UIView()
//        vHorizontal.backgroundColor = borderColor
//        addSubview(vHorizontal)
//
//        vHorizontal.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//            make.width.equalToSuperview().multipliedBy(0.25)
//            make.height.equalTo(borderWidth)
//        }
//
//        /// 竖
//        let vVertical = UIView()
//        vVertical.backgroundColor = borderColor
//        addSubview(vVertical)
//
//        vVertical.snp.makeConstraints { (make) in
//            make.width.equalTo(borderWidth)
//            make.center.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.25)
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
