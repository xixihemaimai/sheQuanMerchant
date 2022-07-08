//
//  ShopDetailCardCell.swift
//  App
//
//  Created by mac on 2022/4/28.
//

import UIKit
import Util

class ShopDetailCardCell: UITableViewCell {
    
    
    lazy var nameLabel:UILabel = {
       let nameLabel = UILabel()
        nameLabel.text = "法人证件"
        nameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    
    lazy var bussLabel:UILabel = {
        let bussLabel = UILabel()
        bussLabel.text = "营业执照"
        bussLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        bussLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        bussLabel.textAlignment = .left
        return bussLabel
    }()
    
    //分割线
    lazy var diviver:UIView = {
       let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return diviver
    }()

    //正面
    lazy var cardFrotImageView:UIImageView = {
       let cardFrotImageView = UIImageView()
        cardFrotImageView.tag = 0
//        cardFrotImageView.contentMode = .scaleAspectFill
        cardFrotImageView.isUserInteractionEnabled = true
        return cardFrotImageView
    }()
    
    
    //反面
    lazy var cardBackImageView:UIImageView = {
       let cardBackImageView = UIImageView()
        cardBackImageView.tag = 1
//        cardBackImageView.contentMode = .scaleAspectFill
        cardBackImageView.isUserInteractionEnabled = true
        return cardBackImageView
    }()
    
    //营业执照
    lazy var bussImageView:UIImageView = {
       let bussImageView = UIImageView()
        bussImageView.tag = 2
//        bussImageView.contentMode = .scaleAspectFill
        bussImageView.isUserInteractionEnabled = true
        return bussImageView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        contentView.addSubview(nameLabel)
        contentView.addSubview(bussLabel)
        contentView.addSubview(diviver)
        contentView.addSubview(cardFrotImageView)
        contentView.addSubview(cardBackImageView)
        contentView.addSubview(bussImageView)
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(12))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
        }
        
        cardFrotImageView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(nameLabel.snp.bottom).offset(scale(8))
            make.width.equalTo((SCW - (scale(16) * 2) - scale(12))/2)
            make.height.equalTo(scale(106))
        }
        cardFrotImageView.layer.cornerRadius = scale(4)
        
        cardBackImageView.snp.makeConstraints { make in
            make.left.equalTo(cardFrotImageView.snp.right).offset(scale(12))
            make.top.equalTo(nameLabel.snp.bottom).offset(scale(8))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(106))
        }
        cardBackImageView.layer.cornerRadius = scale(4)
        
        
        diviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalToSuperview()
            make.top.equalTo(cardFrotImageView.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(0.5))
        }
        
        bussLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(diviver.snp.bottom).offset(12)
            make.height.equalTo(scale(22))
        }
        
        bussImageView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(bussLabel.snp.bottom).offset(scale(8))
            make.width.height.equalTo(scale(106))
            make.bottom.equalTo(-scale(75))
        }
        bussImageView.layer.cornerRadius = scale(4)
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
