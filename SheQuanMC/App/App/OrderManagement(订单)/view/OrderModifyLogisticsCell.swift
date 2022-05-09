//
//  OrderModifyLogisticsCell.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class OrderModifyLogisticsCell: UITableViewCell {
    
    //商品图片
    lazy var orderImage:UIImageView = {
       let orderImage = UIImageView()
        orderImage.image = UIImage(named: "Group 2750")
        return orderImage
    }()
    
    //商品介绍
    lazy var orderIntroductLabel:UILabel = {
       let orderIntroductLabel = UILabel()
        orderIntroductLabel.numberOfLines = 2
        orderIntroductLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        orderIntroductLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        orderIntroductLabel.textAlignment = .left
        orderIntroductLabel.text = "Nike耐克官方AIR 男子训练鞋运动老爹鞋休闲鞋"
        return orderIntroductLabel
    }()
    
    //数量
    lazy var numberLabel:UILabel = {
       let numberLabel = UILabel()
        numberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#B0B0B0")
        numberLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        numberLabel.textAlignment = .left
        numberLabel.text = "黑橙色×1"
        return numberLabel
    }()
    
    
    //实收的价钱
    lazy var netReceiptsLabel:UILabel = {
        let netReceiptsLabel = UILabel()
        netReceiptsLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        netReceiptsLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        netReceiptsLabel.textAlignment = .right
        netReceiptsLabel.text = "实收(含运费):"
        return netReceiptsLabel
    }()
    
    //真实的价钱
    lazy var truePriceLabel:UILabel = {
       let truePriceLabel = UILabel()
        truePriceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        truePriceLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        truePriceLabel.textAlignment = .right
        truePriceLabel.text = "¥258.00"
        return truePriceLabel
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
        
        
        let orderInformationLabel = UILabel()
        orderInformationLabel.text = "订单信息"
        orderInformationLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        orderInformationLabel.textAlignment = .left
        orderInformationLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        contentView.addSubview(orderInformationLabel)
        
        orderInformationLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(12))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(20))
        }
        
        
        let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0DFDF")
        contentView.addSubview(diviver)
        diviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(orderInformationLabel.snp.bottom).offset(scale(9))
            make.height.equalTo(scale(0.5))
        }
        
        
        contentView.addSubview(orderImage)
        contentView.addSubview(orderIntroductLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(netReceiptsLabel)
        contentView.addSubview(truePriceLabel)
        
        
        orderImage.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(diviver.snp.bottom).offset(scale(15))
            make.width.height.equalTo(scale(80))
        }
        
        
        orderIntroductLabel.snp.makeConstraints { make in
            make.left.equalTo(orderImage.snp.right).offset(scale(12))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(40))
            make.top.equalTo(diviver.snp.bottom).offset(scale(15))
        }
        
        
        
        numberLabel.snp.makeConstraints { make in
            make.left.equalTo(orderImage.snp.right).offset(scale(12))
            make.height.equalTo(scale(12))
            make.top.equalTo(orderIntroductLabel.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(120))
        }
        
        
        
        truePriceLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(orderIntroductLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(12))
            make.width.equalTo(scale(80))
        }
        
        
        netReceiptsLabel.snp.makeConstraints { make in
            make.right.equalTo(truePriceLabel.snp.left).offset(scale(6))
            make.height.equalTo(scale(12))
            make.top.equalTo(orderIntroductLabel.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(90))
        }
        
        
        
        contentView.addSubview(bottomView)
        
        
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(scale(8))
            make.top.equalTo(orderImage.snp.bottom).offset(scale(16))
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
