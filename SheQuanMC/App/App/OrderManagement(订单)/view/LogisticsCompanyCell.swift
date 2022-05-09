//
//  LogisticsCompanyCell.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class LogisticsCompanyCell: UITableViewCell {
    
    
    //分割线
    lazy var diviver:UIView = {
       let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return diviver
    }()
    
    //物流公司名称
    lazy var companyLabel:UILabel = {
       let companyLabel = UILabel()
        companyLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        companyLabel.text = "申通快递"
        companyLabel.textAlignment = .left
        companyLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return companyLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        contentView.addSubview(diviver)
        contentView.addSubview(companyLabel)
        
        diviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.right.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        companyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(20))
            make.bottom.equalTo(-scale(14))
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
