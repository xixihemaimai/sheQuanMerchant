//
//  UserHelpCell.swift
//  App
//
//  Created by mac on 2022/7/5.
//

import UIKit
import Util

class UserHelpCell: UITableViewCell {
    
    lazy var diviver:UIView = {
        let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        return diviver
    }()
    
    lazy var helpTitleLabel:UILabel = {
       let helpTitleLabel = UILabel()
        helpTitleLabel.text = "如何"
        helpTitleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        helpTitleLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        helpTitleLabel.textAlignment = .left
        return helpTitleLabel
    }()
    
    
    lazy var rightImage:UIImageView = {
       let rightImage = UIImageView()
        rightImage.image = UIImage(named: "Frame-my-right")
        return rightImage
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        contentView.addSubview(diviver)
        contentView.addSubview(helpTitleLabel)
        contentView.addSubview(rightImage)
        
        diviver.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        helpTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(40))
            make.height.equalTo(scale(22))
        }
        
        rightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
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
