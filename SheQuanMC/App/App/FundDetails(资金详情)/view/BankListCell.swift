//
//  BankListCell.swift
//  App
//
//  Created by mac on 2022/7/20.
//

import UIKit
import Util

class BankListCell: UITableViewCell {
    
    lazy var bankImage:UIImageView = {
       let bankImage = UIImageView()
        bankImage.image = UIImage(named: "Group 2784")
        return bankImage
    }()
    
    lazy var bankNameLabel:UILabel = {
       let bankNameLabel = UILabel()
        bankNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        bankNameLabel.text = "建设银行"
        bankNameLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .semibold)
        bankNameLabel.textAlignment = .left
        return bankNameLabel
    }()
    
    
    lazy var bankStyleLabel:UILabel = {
        let bankStyleLabel = UILabel()
        bankStyleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        bankStyleLabel.text = "储蓄卡"
        bankStyleLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        bankStyleLabel.textAlignment = .left
        return bankStyleLabel
    }()
    
    
    lazy var bankCodeLabel:UILabel = {
        let bankStyleLabel = UILabel()
        bankStyleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        bankStyleLabel.text = "**** **** **** 7881"
        bankStyleLabel.font = UIFont.systemFont(ofSize: scale(20), weight: .semibold)
        bankStyleLabel.textAlignment = .left
        return bankStyleLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        
        let bankView = UIView()
        bankView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        contentView.addSubview(bankView)
        
        bankView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(6))
            make.height.equalTo(scale(111))
            make.bottom.equalTo(-scale(6))
        }
        
        bankView.layer.cornerRadius = scale(4)
        
        bankView.addSubview(bankImage)
        bankView.addSubview(bankNameLabel)
        bankView.addSubview(bankStyleLabel)
        bankView.addSubview(bankCodeLabel)
        bankImage.snp.makeConstraints { make in
            make.left.equalTo(scale(12))
            make.top.equalTo(scale(12))
            make.width.height.equalTo(scale(24))
        }
        
        bankNameLabel.snp.makeConstraints { make in
            make.left.equalTo(bankImage.snp.right).offset(scale(8))
            make.top.equalTo(scale(12))
            make.right.equalTo(-scale(88))
            make.height.equalTo(scale(20))
        }
        bankStyleLabel.snp.makeConstraints { make in
            make.left.equalTo(bankImage.snp.right).offset(scale(8))
            make.top.equalTo(bankNameLabel.snp.bottom).offset(scale(2))
            make.right.equalTo(-scale(88))
            make.height.equalTo(scale(17))
        }
        
        
        bankCodeLabel.snp.makeConstraints { make in
            make.left.equalTo(bankImage.snp.right).offset(scale(8))
            make.top.equalTo(bankStyleLabel.snp.bottom).offset(scale(16))
            make.right.equalTo(-scale(88))
            make.height.equalTo(scale(28))
        }
        
        let bankBackImage = UIImageView()
        bankBackImage.image = UIImage(named: "Mask Group bank")
        bankView.addSubview(bankBackImage)
        bankBackImage.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(scale(88))
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
        
        
    }

}
