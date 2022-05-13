//
//  NoDeliveryTableviewCell.swift
//  App
//
//  Created by mac on 2022/5/13.
//

import UIKit
import Util

class NoDeliveryTableviewCell: UITableViewCell {
    
    
    lazy var isChoiceBtn:UIButton = {
       let isChoiceBtn = UIButton()
//        isChoiceBtn.isEnabled = false
        isChoiceBtn.isUserInteractionEnabled = false
        isChoiceBtn.setBackgroundImage(UIImage(named: "Ellipse 38"), for: .normal)
        isChoiceBtn.setBackgroundImage(UIImage(named: "Group 2742"), for: .selected)
        return isChoiceBtn
    }()
    
    
    lazy var addressLabel:UILabel = {
       let addressLabel = UILabel()
        addressLabel.text = "1"
        addressLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addressLabel.textAlignment = .left
        addressLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return addressLabel
    }()
    
    lazy var rightImage:UIImageView = {
      let rightImage = UIImageView()
        rightImage.image = UIImage(named: "Frame-right")
        return rightImage
    }()
    
    
   
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        contentView.addSubview(isChoiceBtn)
        contentView.addSubview(addressLabel)
        contentView.addSubview(rightImage)
        
        
        isChoiceBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.height.equalTo(scale(16))
        }
        
        addressLabel.snp.makeConstraints { make in
            make.left.equalTo(isChoiceBtn.snp.right).offset(scale(8))
            make.right.equalTo(-scale(40))
            make.height.equalTo(scale(22))
            make.centerY.equalToSuperview()
        }
        
        rightImage.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.centerY.equalToSuperview()
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
