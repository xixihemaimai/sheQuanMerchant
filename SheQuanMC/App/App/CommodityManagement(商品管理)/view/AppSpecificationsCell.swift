//
//  AppSpecificationsCell.swift
//  App
//
//  Created by mac on 2022/6/13.
//

import UIKit
import Util

class AppSpecificationsCell: UITableViewCell {
    
    
    lazy var midView:UIView = {
       let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return midView
    }()
    
    lazy var specificationsLabel:UILabel = {
       let specificationsLabel = UILabel()
        specificationsLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        specificationsLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        specificationsLabel.textAlignment = .left
        return specificationsLabel
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF")
        
        
        contentView.addSubview(midView)
        contentView.addSubview(specificationsLabel)
        
        
        midView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        
        specificationsLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
            make.bottom.equalTo(scale(13))
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
