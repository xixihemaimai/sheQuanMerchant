//
//  MyCell.swift
//  App
//
//  Created by mac on 2022/6/28.
//

import UIKit
import Util

class MyCell: UITableViewCell {
    
    lazy var myImage:UIImageView = {
        let myImage = UIImageView()
        return myImage
    }()
    
    
    lazy var myLabel:UILabel = {
       let myLabel = UILabel()
        myLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        myLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        myLabel.textAlignment = .left
        return myLabel
    }()
    
    
    lazy var rightImage:UIImageView = {
       let rightImage = UIImageView()
        rightImage.image = UIImage(named: "Frame-my-right")
        return rightImage
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        contentView.addSubview(myImage)
        contentView.addSubview(myLabel)
        contentView.addSubview(rightImage)
        
        
        myImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.width.height.equalTo(scale(24))
        }
        
        
        myLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(myImage.snp.right).offset(scale(12))
            make.height.equalTo(scale(22))
            make.right.equalTo(-scale(100))
        }
        
        rightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(scale(18))
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(20))
            make.bottom.equalTo(-scale(18))
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
