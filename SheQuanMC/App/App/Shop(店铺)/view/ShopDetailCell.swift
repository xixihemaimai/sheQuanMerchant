//
//  ShopDetailCell.swift
//  App
//
//  Created by mac on 2022/4/28.
//

import UIKit
import Util

class ShopDetailCell: UITableViewCell {
    
    
    //头部的分割线
    lazy var diviver:UIView = {
       let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return diviver
    }()
    
    //标题
    lazy var titleNameLabel:UILabel = {
       let titleNameLabel = UILabel()
        titleNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#A6A6A6")
        titleNameLabel.textAlignment = .left
        titleNameLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return titleNameLabel
    }()
    
    
    
    //内容
    lazy var detailLabel:UILabel = {
        let detailLabel = UILabel()
        detailLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        detailLabel.textAlignment = .right
        detailLabel.numberOfLines = 2
        detailLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return detailLabel
    }()
    
    
   
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        contentView.addSubview(diviver)
        contentView.addSubview(titleNameLabel)
        contentView.addSubview(detailLabel)
        
        diviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.right.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        titleNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(80))
            make.left.equalTo(scale(16))
        }
        
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.left.equalTo(titleNameLabel.snp.right).offset(scale(30))
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
