//
//  AfterSalesOrderInfoCell.swift
//  App
//
//  Created by mac on 2022/7/14.
//

import UIKit
import Util


class AfterSalesOrderInfoCell: UITableViewCell {
    
    lazy var tureMoneyLabel:UILabel = {
       let tureMoneyLabel = UILabel()
        tureMoneyLabel.text = "实收金额: ¥278.00 (含运费+10.00)"
        tureMoneyLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333 ")
        tureMoneyLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        tureMoneyLabel.textAlignment = .left
        return tureMoneyLabel
    }()
    
    
    lazy var statusLabel:UILabel = {
       let statusLabel = UILabel()
        statusLabel.text = "发货状态: 已发货"
        statusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333 ")
        statusLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        statusLabel.textAlignment = .left
        return statusLabel
    }()
    
    lazy var sendLogissticsBtn:UIButton = {
       let sendLogissticsBtn = UIButton()
        sendLogissticsBtn.setTitle("查看物流", for: .normal)
        sendLogissticsBtn.contentHorizontalAlignment = .left
        sendLogissticsBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#4E8DEA"), for: .normal)
        sendLogissticsBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return sendLogissticsBtn
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        contentView.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(scale(8))
        }
        
        let orderInfoLabel = UILabel()
        orderInfoLabel.text = "订单信息"
        orderInfoLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333 ")
        orderInfoLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        orderInfoLabel.textAlignment = .left
        contentView.addSubview(orderInfoLabel)
        
        
        orderInfoLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
            make.top.equalTo(topView.snp.bottom).offset(14)
        }
        
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        contentView.addSubview(midView)
        midView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(orderInfoLabel.snp.bottom).offset(scale(9))
            make.height.equalTo(scale(0.5))
        }
        
        contentView.addSubview(tureMoneyLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(sendLogissticsBtn)
        
        
        tureMoneyLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(20))
            make.top.equalTo(midView.snp.bottom).offset(scale(13))
        }
        
        
        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(tureMoneyLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(20))
            make.width.equalTo(scale(110))
            make.bottom.equalTo(-scale(20))
        }
        
        
        sendLogissticsBtn.snp.makeConstraints { make in
            make.left.equalTo(statusLabel.snp.right).offset(scale(16))
            make.top.equalTo(tureMoneyLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(20))
            make.width.equalTo(scale(60))
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
