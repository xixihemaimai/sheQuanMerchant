//
//  FreightTemplateCell.swift
//  App
//
//  Created by mac on 2022/5/12.
//

import UIKit
import Util

class FreightTemplateCell: UITableViewCell {
    
    
    //模板名称
    lazy var templateName:UILabel = {
       let templateName = UILabel()
        templateName.text = "模板名称"
        templateName.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        templateName.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        templateName.textAlignment = .left
        return templateName
    }()
    
    
    //是否默认
    lazy var isDelautImage:UIImageView = {
       let isDelautImage = UIImageView()
        isDelautImage.image = UIImage(named: "Group 2828")
        return isDelautImage
    }()
    
    
    
    //按键收费
    lazy var chargeLabel:UILabel = {
        let chargeLabel = UILabel()
        chargeLabel.text = "模板名称"
        chargeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        chargeLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        chargeLabel.textAlignment = .left
        return chargeLabel
    }()
    
    
    //卖家包邮
    lazy var templateType:UILabel = {
        let templateType = UILabel()
        templateType.text = "卖家包邮"
        templateType.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        templateType.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        templateType.textAlignment = .left
        return templateType
    }()
    

    //分割线
//    lazy var midView:UIView = {
//       let midView = UIView()
//        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
//        return midView
//    }()
//
    
    //默认地址按键
    lazy var isDefaultBtn:UIButton = {
       let isDefaultBtn = UIButton()
        isDefaultBtn.setBackgroundImage(UIImage(named: "Ellipse 38"), for: .normal)
        isDefaultBtn.setBackgroundImage(UIImage(named: "Group 2742"), for: .selected)
        return isDefaultBtn
    }()
    
    
    lazy var editBtn:UIButton = {
       let editBtn = UIButton()
        editBtn.setBackgroundImage(UIImage(named: "编辑 1"), for: .normal)
        return editBtn
    }()
    
    //默认地址lable
//    lazy var defualtLabel:UILabel = {
//       let defualtLabel = UILabel()
//        defualtLabel.text = "默认地址"
//        defualtLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#808080")
//        defualtLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
//        defualtLabel.textAlignment = .left
//        return defualtLabel
//    }()
    
    //删除
    lazy var deleteBtn:UIButton = {
       let deleteBtn = UIButton()
        deleteBtn.setTitle("删除", for: .normal)
        deleteBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        deleteBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return deleteBtn
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        contentView.addSubview(templateName)
        contentView.addSubview(isDelautImage)
        contentView.addSubview(chargeLabel)
        contentView.addSubview(templateType)
        contentView.addSubview(isDefaultBtn)
        contentView.addSubview(editBtn)
        contentView.addSubview(deleteBtn)
        
        
        
        templateName.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(16))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(22))
        }
        
        isDelautImage.snp.makeConstraints { make in
            make.left.equalTo(templateName.snp.right).offset(scale(4))
            make.top.equalTo(scale(19))
            make.width.equalTo(scale(28))
            make.height.equalTo(scale(16))
        }
        

        
        editBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(17))
            make.width.height.equalTo(scale(20))
        }
        
        let editDiviver = UIView()
        editDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E7E7E7")
        contentView.addSubview(editDiviver)
        editDiviver.snp.makeConstraints { make in
            make.right.equalTo(editBtn.snp.left).offset(-scale(12))
            make.top.equalTo(scale(17))
            make.width.equalTo(scale(0.5))
            make.height.equalTo(scale(24))
        }

        let mailLabel = UILabel()
        mailLabel.text = "寄件方式:"
        mailLabel.textAlignment = .left
        mailLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        mailLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        contentView.addSubview(mailLabel)
        mailLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(templateName.snp.bottom).offset(scale(10))
            make.width.equalTo(scale(70))
            make.height.equalTo(scale(20))
        }
        
        
        chargeLabel.snp.makeConstraints { make in
            make.left.equalTo(mailLabel.snp.right).offset(scale(6))
            make.top.equalTo(templateName.snp.bottom).offset(scale(10))
            make.height.equalTo(scale(20))
            make.width.equalTo(scale(130))
        }
        
        
        
        let freeLabel = UILabel()
        freeLabel.text = "模板类型:"
        freeLabel.textAlignment = .left
        freeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        freeLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        contentView.addSubview(freeLabel)
        freeLabel.snp.makeConstraints { make in
            make.left.equalTo(chargeLabel.snp.right)
            make.top.equalTo(templateName.snp.bottom).offset(scale(10))
            make.width.equalTo(scale(70))
            make.height.equalTo(scale(20))
        }
        
        
        templateType.snp.makeConstraints { make in
            make.left.equalTo(freeLabel.snp.right).offset(scale(6))
            make.top.equalTo(templateName.snp.bottom).offset(scale(10))
            make.height.equalTo(scale(20))
            make.right.equalTo(-scale(16))
        }
        
        
        
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        
        contentView.addSubview(midView)
        midView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(freeLabel.snp.bottom).offset(scale(12))
        }
        
        
        
        
        isDefaultBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(midView.snp.bottom).offset(scale(19))
            make.width.height.equalTo(scale(15))
        }
        
        let setDelautLabel = UILabel()
        setDelautLabel.text = "设为默认"
        setDelautLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#808080")
        setDelautLabel.textAlignment = .left
        setDelautLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        contentView.addSubview(setDelautLabel)
        setDelautLabel.snp.makeConstraints { make in
            make.left.equalTo(isDefaultBtn.snp.right).offset(scale(4))
            make.top.equalTo(midView.snp.bottom).offset(scale(15))
            make.height.equalTo(scale(20))
            make.width.equalTo(scale(100))
        }
        
        deleteBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(midView.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(26))
            make.width.equalTo(scale(60))
        }
        
        deleteBtn.layer.cornerRadius = scale(4)
        deleteBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        deleteBtn.layer.borderWidth = scale(1)
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        contentView.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(scale(8))
            make.top.equalTo(deleteBtn.snp.bottom).offset(scale(12))
            make.bottom.equalToSuperview()
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
