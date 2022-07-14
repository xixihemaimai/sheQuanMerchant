//
//  AfterSalesHistoryCell.swift
//  App
//
//  Created by mac on 2022/7/14.
//

import UIKit
import Util

class AfterSalesHistoryCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F4F4F4")
        contentView.addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(8))
        }
        
        
        let histoyLabel = UILabel()
        histoyLabel.text = "协商历史"
        histoyLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        histoyLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        histoyLabel.textAlignment = .left
        contentView.addSubview(histoyLabel)
        
        histoyLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(topView.snp.bottom).offset(scale(12))
            make.bottom.equalTo(-scale(12))
            make.width.equalTo(scale(180))
        }
        
        
        let rightImage = UIImageView()
        rightImage.image = UIImage(named: "Frame-right")
        contentView.addSubview(rightImage)
        
        rightImage.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
            make.top.equalTo(topView.snp.bottom).offset(scale(12))
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
