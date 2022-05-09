//
//  AddressCell.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class AddressCell: UITableViewCell {
    
    //昵称
    lazy var nickNameLabel:UILabel = {
       let nickNameLabel = UILabel()
        nickNameLabel.text = "农大侠"
        nickNameLabel.textAlignment = .left
        nickNameLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .semibold)
        nickNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return nickNameLabel
    }()
    
    
    //电话号码
    lazy var phoneNumberLabel:UILabel = {
       let phoneNumberLabel = UILabel()
        phoneNumberLabel.text = "123****8910"
        phoneNumberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#808080")
        phoneNumberLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        phoneNumberLabel.textAlignment = .left
        return phoneNumberLabel
    }()
    
    
    //是否默认
    lazy var isDefaultLabel:UILabel = {
       let isDefaultLabel = UILabel()
        isDefaultLabel.text = "默认"
        isDefaultLabel.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E9FFEF")
        isDefaultLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#35CA5F")
        isDefaultLabel.textAlignment = .center
        isDefaultLabel.font = UIFont.systemFont(ofSize: scale(10), weight: .regular)
        return isDefaultLabel
    }()
    
    //地址
    lazy var addressLabel:UILabel = {
       let addressLabel = UILabel()
        addressLabel.text = "福建省 厦门市 思明区 莲前街道岭兜二路75号"
        addressLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        addressLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        addressLabel.textAlignment = .left
        return addressLabel
    }()
    
    //修改分割线
    lazy var modifyView:UIView = {
       let modifyView = UIView()
        modifyView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E6E6E6")
        return modifyView
    }()
    
    
    // 修改编辑 1
    lazy var modifyAddressBtn:UIButton = {
       let modifyAddressBtn = UIButton()
        modifyAddressBtn.setBackgroundImage(UIImage(named: "编辑 1"), for: .normal)
        return modifyAddressBtn
    }()
    
    
    
    //分割线
    
    lazy var midView:UIView = {
       let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return midView
    }()
    
    
    //默认地址按键
    lazy var isDefaultBtn:UIButton = {
       let isDefaultBtn = UIButton()
        isDefaultBtn.setBackgroundImage(UIImage(named: "Ellipse 38"), for: .normal)
        isDefaultBtn.setBackgroundImage(UIImage(named: "Group 2742"), for: .selected)
        return isDefaultBtn
    }()
    
    
    
    //默认地址lable
    lazy var defualtLabel:UILabel = {
       let defualtLabel = UILabel()
        defualtLabel.text = "默认地址"
        defualtLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#808080")
        defualtLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        defualtLabel.textAlignment = .left
        return defualtLabel
    }()
    
    //删除
    lazy var deleteBtn:UIButton = {
       let deleteBtn = UIButton()
        deleteBtn.setTitle("删除", for: .normal)
        deleteBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        deleteBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return deleteBtn
    }()
    
    //底部分割线
    lazy var bottomView:UIView = {
       let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        return bottomView
    }()
    
    

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        contentView.addSubview(nickNameLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(isDefaultLabel)
        contentView.addSubview(addressLabel)
        
        nickNameLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(22))
            make.top.equalTo(scale(16))
        }
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(scale(16))
            make.left.equalTo(nickNameLabel.snp.right).offset(scale(12))
            make.height.equalTo(scale(22))
            make.right.equalTo(-scale(50))
        }
        
        
        isDefaultLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(nickNameLabel.snp.bottom).offset(scale(8))
            make.width.equalTo(scale(28))
            make.height.equalTo(scale(16))
        }
        addressLabel.snp.makeConstraints { make in
            make.left.equalTo(isDefaultLabel.snp.right).offset(scale(4))
            make.height.equalTo(scale(16))
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(scale(8))
            make.right.equalTo(-scale(50))
        }
        
        
        
        contentView.addSubview(modifyAddressBtn)
        contentView.addSubview(modifyView)
        
        modifyAddressBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(29))
            make.width.height.equalTo(scale(20))
        }
        
        
        modifyView.snp.makeConstraints { make in
            make.right.equalTo(modifyAddressBtn.snp.left).offset(-scale(12))
            make.top.equalTo(scale(27))
            make.width.equalTo(scale(0.5))
            make.height.equalTo(scale(24))
        }
        
        
        contentView.addSubview(midView)
        contentView.addSubview(isDefaultBtn)
        contentView.addSubview(defualtLabel)
        
        
        midView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(addressLabel.snp.bottom).offset(scale(16))
        }
        
        
        isDefaultBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(midView.snp.bottom).offset(scale(17))
            make.width.height.equalTo(scale(12))
        }
        
        defualtLabel.snp.makeConstraints { make in
            make.left.equalTo(isDefaultBtn.snp.right).offset(scale(8))
            make.top.equalTo(midView.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(70))
            make.height.equalTo(scale(20))
        }
        
        
        contentView.addSubview(deleteBtn)
        contentView.addSubview(bottomView)
        
        deleteBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(midView.snp.bottom).offset(scale(9))
            make.width.equalTo(scale(60))
            make.height.equalTo(scale(26))
        }
        deleteBtn.layer.cornerRadius = scale(4)
        deleteBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        deleteBtn.layer.borderWidth = scale(1)
        
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(scale(8))
            make.top.equalTo(deleteBtn.snp.bottom).offset(scale(9))
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
