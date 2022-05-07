//
//  OrderDetailStatusCell.swift
//  App
//
//  Created by mac on 2022/5/7.
//

import UIKit
import Util

class OrderDetailStatusCell: UITableViewCell {
    
    //状态
    lazy var orderStatusLabel:UILabel = {
       let orderStatusLabel = UILabel()
        orderStatusLabel.text = "已发货"
        orderStatusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        orderStatusLabel.font = UIFont.systemFont(ofSize: scale(20), weight: .semibold)
        orderStatusLabel.textAlignment = .left
        return orderStatusLabel
    }()
    
    
    //状态详情
    lazy var orderDetailStatusLabel:UILabel = {
       let orderDetailStatusLabel = UILabel()
        orderDetailStatusLabel.text = "退货退款中"
        orderDetailStatusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F13232")
        orderDetailStatusLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        orderDetailStatusLabel.textAlignment = .left
        return orderDetailStatusLabel
    }()
    
    
    //时间或者信息
    lazy var timeLabel:UILabel = {
      let timeLabel = UILabel()
        timeLabel.text = "13天23时59分59秒后自动收货"
        timeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#666666")
        timeLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        timeLabel.textAlignment = .left
      return timeLabel
    }()
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        contentView.addSubview(orderStatusLabel)
        contentView.addSubview(orderDetailStatusLabel)
        contentView.addSubview(timeLabel)
        
        
        orderStatusLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(19))
            make.width.equalTo(scale(60))
            make.top.equalTo(scale(12))
            make.height.equalTo(scale(28))
        }
        
        orderDetailStatusLabel.snp.makeConstraints { make in
            make.left.equalTo(orderStatusLabel.snp.right).offset(scale(8))
            make.top.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(20))
        }
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(19))
            make.top.equalTo(orderStatusLabel.snp.bottom).offset(scale(4))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(20))
            make.bottom.equalTo(-scale(12))
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
