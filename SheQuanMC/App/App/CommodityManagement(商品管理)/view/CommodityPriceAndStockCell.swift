//
//  CommodityPriceAndStockCell.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util

class CommodityPriceAndStockCell: UITableViewCell {
    
    
    //分割线
    lazy var diviver:UIView = {
       let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return diviver
    }()
    
    
    //规格值得内容
    lazy var specificationLabel:UILabel = {
       let specificationLabel = UILabel()
        specificationLabel.textAlignment = .left
        specificationLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        specificationLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        specificationLabel.text = "红色"
        return specificationLabel
    }()
    
    
    //是否已经设置
    lazy var isSettingLabel:UILabel = {
       let isSettingLabel = UILabel()
        isSettingLabel.textAlignment = .right
        isSettingLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F13232")
        isSettingLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        isSettingLabel.text = "未设置"
        return isSettingLabel
    }()
    
    
    //方向图片
    lazy var commoditySImage:UIImageView = {
        let commoditySImage = UIImageView()
        commoditySImage.image = UIImage(named: "Frame-goods")
        return commoditySImage
    }()
    
    //中间
    lazy var midView:UIView = {
       let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F2F2F2")
        return midView
    }()
    
    //中间分割线
    lazy var midDiviver:UIView = {
       let midDiviver = UIView()
        midDiviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#DBDBDB")
        return midDiviver
    }()
    
    
    //价格
    lazy var priceLabel:UILabel = {
       let priceLabel = UILabel()
        priceLabel.text = "价格"
        priceLabel.textAlignment = .center
        priceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        priceLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return priceLabel
    }()
    
    //库存
    lazy var stockLabel:UILabel = {
       let stockLabel = UILabel()
        stockLabel.text = "库存"
        stockLabel.textAlignment = .center
        stockLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        stockLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return stockLabel
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        contentView.addSubview(diviver)
        contentView.addSubview(specificationLabel)
        contentView.addSubview(isSettingLabel)
        contentView.addSubview(commoditySImage)
        
        
        diviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        specificationLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(14))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(250))
        }
        
        commoditySImage.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(13))
            make.width.height.equalTo(scale(24))
        }
        
        isSettingLabel.snp.makeConstraints { make in
            make.right.equalTo(commoditySImage.snp.left).offset(-scale(4))
            make.top.equalTo(scale(14))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
        }
        
        contentView.addSubview(midView)
        midView.addSubview(midDiviver)
        midView.addSubview(priceLabel)
        midView.addSubview(stockLabel)
        
        midView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(specificationLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(32))
            make.bottom.equalTo(-scale(14))
        }
        
        midView.layer.cornerRadius = scale(4)
        
        midDiviver.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(scale(0.5))
            make.height.equalTo(scale(24))
            
        }
        
        priceLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo((SCW - scale(32))/2 - scale(1))
        }

        stockLabel.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo((SCW - scale(32))/2 - scale(1))
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
