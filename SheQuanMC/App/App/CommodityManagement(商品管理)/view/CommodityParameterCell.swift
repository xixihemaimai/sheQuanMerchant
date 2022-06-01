//
//  CommodityParameterCell.swift
//  App
//
//  Created by mac on 2022/5/27.
//

import UIKit
import Util

class CommodityParameterCell: UITableViewCell {
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
    
    
    var model:Spus?{
        didSet{
            guard let _model = model else { return }
            
            parameterLabel.text = _model.spuAttrName
            
        }
        
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        contentView.addSubview(parameterLabel)
        
        parameterLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
            make.top.equalTo(scale(14))
            make.bottom.equalTo(-scale(14))
        }
        
        
        contentView.addSubview(parameterTextfield)
        parameterTextfield.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(parameterLabel.snp.right).offset(scale(32))
            make.height.equalTo(scale(30))
            make.right.equalTo(-scale(40))
            make.bottom.equalTo(-scale(10))
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
