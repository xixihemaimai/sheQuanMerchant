//
//  NegotiationHistoryCell.swift
//  App
//
//  Created by mac on 2022/7/15.
//

import UIKit
import Util

class NegotiationHistoryCell: UITableViewCell {
    
    //上面间隔
    lazy var topView:UIView = {
       let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F4F4F4")
        return topView
    }()
    
    //图片
    lazy var shopImage:UIImageView = {
       let shopImage = UIImageView()
        shopImage.image = UIImage(named: "Group 2760")
        return shopImage
    }()
    
    //状态值
    lazy var shopStatusLabel:UILabel = {
       let shopStatusLabel = UILabel()
        shopStatusLabel.text = "买家已退回，待商家收货"
        shopStatusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        shopStatusLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .semibold)
        shopStatusLabel.textAlignment = .left
        return shopStatusLabel
    }()
    
    //时间
    lazy var timeLabel:UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "2022-04-24 15:05:18"
        timeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        timeLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .semibold)
        timeLabel.textAlignment = .left
         return timeLabel
    }()
    
    //买家还是商家
    lazy var identityLabel:UILabel = {
        let identityLabel = UILabel()
        identityLabel.text = "商家"
        identityLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F06337")
        identityLabel.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#FEEFEB")
        identityLabel.font = UIFont.systemFont(ofSize: scale(10), weight: .regular)
        identityLabel.textAlignment = .center
         return identityLabel
    }()
    
    //获取状态
    lazy var cargoStatusLabel:UILabel = {
       let cargoStatusLabel = UILabel()
        cargoStatusLabel.text = "货物状态:已收到货"
        cargoStatusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        cargoStatusLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        cargoStatusLabel.textAlignment = .left
        return cargoStatusLabel
    }()
    
    
    //拒绝原因
    lazy var reasonLabel:UILabel = {
        let reasonLabel = UILabel()
        reasonLabel.text = "拒绝原因：商品不支持7天无理由退货"
        reasonLabel.numberOfLines = 0
        reasonLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        reasonLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        reasonLabel.textAlignment = .left
        return reasonLabel
    }()
    
    
    //说明
    lazy var explainLabel:UILabel = {
        let explainLabel = UILabel()
        explainLabel.text = "说明:"
        explainLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        explainLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        explainLabel.textAlignment = .left
        return explainLabel
    }()
    
    
   
    lazy var historyImageArrayView:NegotiationHistoryImageView = {
       let historyImageArrayView = NegotiationHistoryImageView()
        historyImageArrayView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return historyImageArrayView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF")
        
        contentView.addSubview(topView)
        contentView.addSubview(shopImage)
        contentView.addSubview(shopStatusLabel)
        contentView.addSubview(identityLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(cargoStatusLabel)
        contentView.addSubview(reasonLabel)
        contentView.addSubview(explainLabel)
        contentView.addSubview(historyImageArrayView)
        
        topView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(scale(8))
        }
        
        shopImage.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(topView.snp.bottom).offset(scale(16))
            make.width.height.equalTo(scale(36))
        }
        shopImage.layer.cornerRadius = scale(4)
        
        
        shopStatusLabel.snp.makeConstraints { make in
            make.left.equalTo(shopImage.snp.right).offset(scale(8))
            make.top.equalTo(topView.snp.bottom).offset(scale(14))
            make.height.equalTo(scale(20))
            make.width.equalTo(scale(100))
        }
        
        identityLabel.snp.makeConstraints { make in
            make.left.equalTo(shopStatusLabel.snp.right).offset(scale(4))
            make.top.equalTo(topView.snp.bottom).offset(scale(18))
            make.width.equalTo(scale(28))
            make.height.equalTo(scale(16))
        }
        
        identityLabel.layer.cornerRadius = scale(2)
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(shopImage.snp.right).offset(scale(8))
            make.right.equalTo(-scale(16))
            make.top.equalTo(shopStatusLabel.snp.bottom).offset(scale(1))
            make.height.equalTo(scale(17))
        }
        
        
        cargoStatusLabel.snp.makeConstraints { make in
            make.left.equalTo(shopImage.snp.right).offset(scale(8))
            make.right.equalTo(-scale(16))
            make.top.equalTo(shopImage.snp.bottom).offset(scale(8))
            make.height.equalTo(scale(20))
        }
        
        
        reasonLabel.snp.makeConstraints { make in
            make.left.equalTo(shopImage.snp.right).offset(scale(8))
            make.right.equalTo(-scale(16))
            make.top.equalTo(cargoStatusLabel.snp.bottom).offset(scale(8))
            make.height.equalTo(scale(20))
        }
        
        explainLabel.snp.makeConstraints { make in
            make.left.equalTo(shopImage.snp.right).offset(scale(8))
            make.right.equalTo(-scale(16))
            make.top.equalTo(reasonLabel.snp.bottom).offset(scale(8))
            make.height.equalTo(scale(20))
        }
        
        historyImageArrayView.snp.makeConstraints { make in
            make.left.equalTo(shopImage.snp.right).offset(scale(8))
            make.right.equalToSuperview()
            make.top.equalTo(explainLabel.snp.bottom).offset(scale(4))
            make.height.equalTo(scale(0))
            make.bottom.equalTo(scale(4))
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
