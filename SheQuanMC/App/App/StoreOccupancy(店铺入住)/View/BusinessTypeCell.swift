//
//  BusinessTypeCell.swift
//  App
//
//  Created by mac on 2022/4/26.
//

import UIKit
import Util

class BusinessTypeCell: UITableViewCell {
    
    lazy var productLabel:UILabel = {
       let productLabel = UILabel()
        productLabel.text = "水产肉类/新鲜蔬菜/熟食>半成品菜"
        productLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        productLabel.textAlignment = .left
        productLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return productLabel
    }()
    
    //分割线
    lazy var diviver:UIView = {
        let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#A6A6A6")
        return diviver
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F9F9F9")

        contentView.addSubview(productLabel)
        contentView.addSubview(diviver)
        
        diviver.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(scale(42))
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        
        
        productLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(scale(42))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(20))
            make.top.equalTo(scale(12))
            make.bottom.equalTo(-scale(12))
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
