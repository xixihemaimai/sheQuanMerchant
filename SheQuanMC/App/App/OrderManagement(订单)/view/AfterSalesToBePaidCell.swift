//
//  AfterSalesToBePaidCell.swift
//  App
//
//  Created by mac on 2022/7/14.
//

import UIKit
import Util

class AfterSalesToBePaidCell: UITableViewCell {
    
    
    //订单编号
    lazy var orderNumberLabel:UILabel = {
       let orderNumberLabel = UILabel()
        orderNumberLabel.text = "订单编号:20220301-123456789123456"
        orderNumberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        orderNumberLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        orderNumberLabel.textAlignment = .left
        return orderNumberLabel
    }()
    
    
    //售后编号
    lazy var refeulNumberLabel:UILabel = {
        let refeulNumberLabel = UILabel()
        refeulNumberLabel.text = "售后编号:20220301-123456789123456"
        refeulNumberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        refeulNumberLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        refeulNumberLabel.textAlignment = .left
        return refeulNumberLabel
    }()
    
    //申请时间
    lazy var appleTimeLabel:UILabel = {
        let appleTimeLabel = UILabel()
        appleTimeLabel.text = "申请时间：2022-03-01 14:21:31"
        appleTimeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        appleTimeLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        appleTimeLabel.textAlignment = .left
        return appleTimeLabel
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
        
        contentView.addSubview(orderNumberLabel)
        contentView.addSubview(refeulNumberLabel)
        contentView.addSubview(appleTimeLabel)
        
    
        orderNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(topView.snp.bottom).offset(scale(13))
            make.height.equalTo(scale(28))
        }
        
        refeulNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(28))
            make.top.equalTo(orderNumberLabel.snp.bottom).offset(scale(6))
        }
        
        appleTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(28))
            make.top.equalTo(refeulNumberLabel.snp.bottom).offset(scale(6))
            make.bottom.equalTo(-scale(6))
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
