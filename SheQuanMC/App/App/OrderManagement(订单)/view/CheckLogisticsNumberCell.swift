//
//  CheckLogisticsNumberCell.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util


class CheckLogisticsNumberCell: UITableViewCell {
    
    //物流公司
    lazy var logisticsCompanyLabel:UILabel = {
       let logisticsCompanyLabel = UILabel()
        logisticsCompanyLabel.text = "物流公司：中通快递"
        logisticsCompanyLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        logisticsCompanyLabel.textAlignment = .left
        logisticsCompanyLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
       return logisticsCompanyLabel
    }()
    
    
    //运单编号
    lazy var waybillNumberLabel:UILabel = {
        let waybillNumberLabel = UILabel()
        waybillNumberLabel.text = "运单编号：123456789101112"
        waybillNumberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        waybillNumberLabel.textAlignment = .left
        waybillNumberLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return waybillNumberLabel
        
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        let logisticsImage = UIImageView()
        logisticsImage.image = UIImage(named: "物流 1")
        contentView.addSubview(logisticsImage)
        
        logisticsImage.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(26))
            make.width.height.equalTo(scale(20))
        }
        
        
        contentView.addSubview(logisticsCompanyLabel)
        contentView.addSubview(waybillNumberLabel)
        
        
        logisticsCompanyLabel.snp.makeConstraints { make in
            make.left.equalTo(logisticsImage.snp.right).offset(scale(8))
            make.top.equalTo(scale(13))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(20))
        }
        
        waybillNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(logisticsImage.snp.right).offset(scale(8))
            make.right.equalTo(-scale(16))
            make.top.equalTo(logisticsCompanyLabel.snp.bottom).offset(scale(2))
            make.height.equalTo(scale(20))
        }
        
        
        
        //底部分割线
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        contentView.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(waybillNumberLabel.snp.bottom).offset(scale(17))
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(scale(8))
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
