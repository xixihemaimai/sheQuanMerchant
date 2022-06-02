//
//  CommodityParameterCell.swift
//  App
//
//  Created by mac on 2022/5/27.
//

import UIKit
import Util

class CommodityParameterCell: UITableViewCell {
    
    
    //星号
    lazy var brandStarLabel:UILabel = {
        let brandStarLabel = UILabel()
        brandStarLabel.text = "*"
        brandStarLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#E82626")
        brandStarLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
        return brandStarLabel
    }()
    
    
    
    
    lazy var parameterLabel:UILabel = {
        let parameterLabel = UILabel()
        parameterLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        parameterLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        parameterLabel.textAlignment = .left
        return parameterLabel
    }()
    
    
    lazy var parameterTextfield:UITextField = {
        let parameterTextfield = UITextField()
        parameterTextfield.placeholder = "请输入"
        parameterTextfield.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        parameterTextfield.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        parameterTextfield.tintColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        parameterTextfield.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        return parameterTextfield
    }()
    
    
    
    lazy var brandRightImage:UIImageView = {
        let brandRightImage = UIImageView()
        brandRightImage.image = UIImage(named: "Frame-right")
        return brandRightImage
    }()
    
    
    
    lazy var midView:UIView = {
       let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return midView
    }()
    
    
    
    var model:Spus?{
        didSet{
            guard let _model = model else { return }
            parameterLabel.text = _model.spuAttrName
            if _model.required == true{
                brandStarLabel.isHidden = false
                brandRightImage.isHidden = false
            }else{
                brandStarLabel.isHidden = true
                brandRightImage.isHidden = true
            }
            if _model.spuValue != nil{
                if _model.spuAttrName == "正品证书"{
                    parameterTextfield.text = "已上传"
                }else{
                    parameterTextfield.text = _model.spuValue
                }
            }
        }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        contentView.addSubview(brandStarLabel)
        contentView.addSubview(parameterLabel)
        contentView.addSubview(brandRightImage)
        contentView.addSubview(parameterTextfield)
        contentView.addSubview(midView)
        
        
        brandStarLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(8))
            make.height.equalTo(scale(20))
        }
        
        
        parameterLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(24))
            make.centerY.equalToSuperview()
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
            make.top.equalTo(scale(14))
            make.bottom.equalTo(-scale(14))
        }
        
        
        
        parameterTextfield.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(parameterLabel.snp.right).offset(scale(32))
            make.height.equalTo(scale(30))
            make.right.equalTo(-scale(40))
            make.bottom.equalTo(-scale(10))
        }
        
        brandRightImage.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
            make.centerY.equalToSuperview()
        }
        
        midView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.bottom.right.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        
        
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        contentView.addSubview(midView)
        
        midView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.bottom.equalToSuperview()
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
