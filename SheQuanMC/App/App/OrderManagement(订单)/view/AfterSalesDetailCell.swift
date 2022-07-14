//
//  AfterSalesDetailCell.swift
//  App
//
//  Created by mac on 2022/7/14.
//

import UIKit
import Util

class AfterSalesDetailCell: UITableViewCell {
    
    
    //状态
    lazy var statusLabel:UILabel = {
       let statusLabel = UILabel()
        statusLabel.text = "买家申请仅退款，待处理"
        statusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        statusLabel.font = UIFont.systemFont(ofSize: scale(20), weight: .semibold)
        statusLabel.textAlignment = .left
        return statusLabel
    }()
    
    
    //时间
    lazy var timeLabel:UILabel = {
       let timeLabel = UILabel()
        timeLabel.numberOfLines = 2
        timeLabel.text = "请在02天23时59分内处理，逾期未处理，将自动同意退款申请并退款给买家"
        timeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#666666")
        timeLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        timeLabel.textAlignment = .left
        return timeLabel
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        contentView.addSubview(statusLabel)
        contentView.addSubview(timeLabel)
        
        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(12))
            make.height.equalTo(scale(28))
        }
        
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(statusLabel.snp.bottom).offset(scale(4))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(-scale(12))
        }
        
        
        //买家发起平台介入，平台正在处理中，2个工作日内将做出判决结果
        let str = "请在02天23时59分内处理，逾期未处理，将自动同意退款申请并退款给买家"
        let attrStr = NSMutableAttributedString(string: str)
        attrStr.addAttributes([NSAttributedString.Key.foregroundColor :UIColor.colorWithDyColorChangObject(lightColor: "#F13232")], range: NSRange(location: 2, length: 10))
        timeLabel.attributedText = attrStr
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
