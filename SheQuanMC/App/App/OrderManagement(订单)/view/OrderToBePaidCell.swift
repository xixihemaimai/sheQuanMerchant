//
//  OrderToBePaidCell.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class OrderToBePaidCell: UITableViewCell {
    
    //订单编号
    
    lazy var orderNumberLabel:UILabel = {
       let orderNumberLabel = UILabel()
        orderNumberLabel.text = "20220301-123456789123456"
        orderNumberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        orderNumberLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        orderNumberLabel.textAlignment = .left
        return orderNumberLabel
    }()
    
    //下单时间
    lazy var orderTimeLabel:UILabel = {
       let orderTimeLabel = UILabel()
        orderTimeLabel.text = "2022-03-01 14:21:31"
        orderTimeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        orderTimeLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        orderTimeLabel.textAlignment = .left
        return orderTimeLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        contentView.addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(8))
        }
        
        let orderNumbersLabel = UILabel()
        orderNumbersLabel.text = "订单编号: "
        orderNumbersLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        orderNumbersLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        orderNumbersLabel.textAlignment = .left
        contentView.addSubview(orderNumbersLabel)
        
        orderNumbersLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(topView.snp.bottom).offset(scale(13))
            make.height.equalTo(scale(17))
            make.width.equalTo(scale(70))
        }
        
        
        contentView.addSubview(orderNumberLabel)
        
        orderNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(orderNumbersLabel.snp.right).offset(scale(8))
            make.right.equalTo(-scale(16))
            make.top.equalTo(topView.snp.bottom).offset(scale(13))
            make.height.equalTo(scale(17))
        }
        
        
        
        let orderTimesLabel = UILabel()
        orderTimesLabel.text = "下单时间: "
        orderTimesLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        orderTimesLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        orderTimesLabel.textAlignment = .left
        contentView.addSubview(orderTimesLabel)
        
        orderTimesLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(orderNumbersLabel.snp
                .bottom).offset(scale(11))
            make.height.equalTo(scale(17))
            make.width.equalTo(scale(70))
            make.bottom.equalTo(-scale(14))
        }
        contentView.addSubview(orderTimeLabel)
        
        
        orderTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(orderTimesLabel.snp.right).offset(scale(8))
            make.top.equalTo(orderNumbersLabel.snp
                .bottom).offset(scale(11))
            make.height.equalTo(scale(17))
            make.right.equalTo(-scale(16))
            make.bottom.equalTo(-scale(14))
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
