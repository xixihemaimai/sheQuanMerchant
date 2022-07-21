//
//  FundCell.swift
//  App
//
//  Created by mac on 2022/7/20.
//

import UIKit
import Util

class FundCell: UITableViewCell {
    
    lazy var titleView:UIView = {
       let titleView = UIView()
        titleView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return titleView
    }()
    
    
    lazy var fundLabel:UILabel = {
       let fundLabel = UILabel()
        fundLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        fundLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        fundLabel.textAlignment = .left
        return fundLabel
    }()
    
    
    lazy var midView:UIView = {
       let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return midView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        
        contentView.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(58))
            make.top.bottom.equalToSuperview()
        }
        titleView.addSubview(fundLabel)
        fundLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.top.bottom.equalToSuperview()
            make.right.equalTo(-scale(80))
        }
        
        let rightImage = UIImageView()
        rightImage.image = UIImage(named: "Frame-goods")
        titleView.addSubview(rightImage)
        rightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.height.width.equalTo(scale(24))
        }
        
       
        titleView.addSubview(midView)
        midView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.bottom.equalToSuperview()
            make.height.equalTo(scale(0.5))
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
