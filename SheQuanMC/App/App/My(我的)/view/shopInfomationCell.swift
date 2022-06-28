//
//  shopInfomationCell.swift
//  App
//
//  Created by mac on 2022/6/28.
//

import UIKit
import Util

class shopInfomationCell: UITableViewCell {
    
    lazy var shopTypeName:UILabel = {
       let shopTypeName = UILabel()
        shopTypeName.text = "店铺logo"
        shopTypeName.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        shopTypeName.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        shopTypeName.textAlignment = .left
        return shopTypeName
    }()
    
    //这边可以是图片
    lazy var shopAvavr:UIImageView = {
       let shopAvavr = UIImageView()
        return shopAvavr
    }()

    lazy var shopInfoName:UILabel = {
       let shopInfoName = UILabel()
        shopInfoName.text = "店铺名称"
        shopInfoName.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        shopInfoName.font = UIFont.systemFont(ofSize: scale(15), weight: .regular)
        shopInfoName.textAlignment = .right
        return shopInfoName
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        let diviview = UIView()
        diviview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#DBDBDB")
        contentView.addSubview(diviview)
        diviview.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        contentView.addSubview(shopAvavr)
        contentView.addSubview(shopTypeName)
        contentView.addSubview(shopInfoName)
        
        shopTypeName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(22))
        }
        
        
        shopAvavr.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(48))
            make.width.height.equalTo(scale(28))
        }
        
        shopAvavr.layer.cornerRadius = scale(14)
        shopAvavr.layer.masksToBounds = true
        
        shopInfoName.snp.makeConstraints { make in
            make.right.equalTo(-scale(48))
            make.centerY.equalToSuperview()
            make.height.equalTo(scale(21))
            make.width.equalTo(scale(200))
        }
        
        let rightImage = UIImageView()
        rightImage.image = UIImage(named: "Frame-my-right")
        contentView.addSubview(rightImage)
        rightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
