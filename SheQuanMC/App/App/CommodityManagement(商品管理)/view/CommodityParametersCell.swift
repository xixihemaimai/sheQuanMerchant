//
//  CommodityParametersCell.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util

class CommodityParametersCell: UITableViewCell {
    
    
    //分割线
    lazy var diviver:UIView = {
       let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#D9D9D9")
        return diviver
    }()
    
    
    
    //要操作的名称
    lazy var parametersLabel:UILabel = {
       let parametersLabel = UILabel()
        parametersLabel.textAlignment = .left
        parametersLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        parametersLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return parametersLabel
    }()
    
    
    //是否填写了
    lazy var contentLabel:UILabel = {
       let contentLabel = UILabel()
        contentLabel.textAlignment = .left
        contentLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        contentLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
        contentLabel.text = "未填写"
        return contentLabel
    }()
    
    
    //方向图片
    lazy var commoditySImage:UIImageView = {
        let commoditySImage = UIImageView()
        commoditySImage.image = UIImage(named: "Frame-goods")
        return commoditySImage
    }()
  

    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        contentView.addSubview(diviver)
        contentView.addSubview(parametersLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(commoditySImage)
        
        
        diviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        parametersLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
        }
        
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(parametersLabel.snp.right).offset(scale(20))
            make.height.equalTo(scale(22))
            make.right.equalTo(-scale(50))
        }
        
        commoditySImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
            make.bottom.equalTo(-scale(15))
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
