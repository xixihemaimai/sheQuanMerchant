//
//  MomentsViewCell.swift
//  App
//
//  Created by mac on 2022/6/23.
//

import UIKit
import Util

class MomentsViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    //删除
    lazy var deleteBtn:UIButton = {
       let deleteBtn = UIButton()
       deleteBtn.setBackgroundImage(UIImage(named: "Frame"), for: .normal)
       return deleteBtn
    }()
    
    //主图
    lazy var mainImage:UIImageView = {
        let mainImage = UIImageView()
        mainImage.image = UIImage(named: "Group 2786")
        return mainImage
    }()
    
    
    
//    deleteBtn = UIButton()
//    imageView.addSubview(deleteBtn)
//    deleteBtn.addTarget(self, action: #selector(deleteGoodsAction), for: .touchUpInside)
//    deleteBtn.tag = i
       
         
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            
            imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.isUserInteractionEnabled = true
            imageView.layer.masksToBounds = true
            contentView.addSubview(imageView)
            
            imageView.snp.makeConstraints { (make) in
                make.left.right.top.bottom.equalToSuperview()
            }
            
            
            imageView.layer.cornerRadius = scale(4)
            imageView.layer.borderWidth = scale(1)
            imageView.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#E2E2E2").cgColor
            
            
            contentView.addSubview(mainImage)
            mainImage.snp.makeConstraints { make in
                make.left.top.equalToSuperview()
                make.width.equalTo(scale(31))
                make.height.equalTo(scale(19))
            }
            
            contentView.addSubview(deleteBtn)
            deleteBtn.snp.makeConstraints { make in
                make.right.equalTo(scale(5))
                make.top.equalTo(-scale(5))
                make.width.height.equalTo(scale(24))
            }
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
