//
//  AfterSalesOrderCell.swift
//  App
//
//  Created by mac on 2022/7/14.
//

import UIKit
import Util


class AfterSalesOrderCell: UITableViewCell {
    
    //添加一个分割view
    lazy var topView:UIView = {
       let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        return topView
    }()
    
    //头像
    lazy var headerImage:UIImageView = {
       let headerImage = UIImageView()
        headerImage.contentMode = .scaleAspectFill
        headerImage.image = UIImage(named: "Frame-评论")
        return headerImage
    }()
    
    // 昵称
    lazy var nicknameLabel:UILabel = {
       let nicknameLabel = UILabel()
        nicknameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        nicknameLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        nicknameLabel.textAlignment = .left
        nicknameLabel.text = "天空****"
        return nicknameLabel
    }()
    
    //分割线
    lazy var midView:UIView = {
      let midview = UIView()
        midview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return midview
    }()
    
    //商品图片
    lazy var orderImage:UIImageView = {
       let orderImage = UIImageView()
        orderImage.contentMode = .scaleAspectFill
        orderImage.image = UIImage(named: "Group 2750")
        return orderImage
    }()
    
    //商品介绍
    lazy var orderIntroductLabel:CustomLabel = {
       let orderIntroductLabel = CustomLabel()
        orderIntroductLabel.numberOfLines = 2
        orderIntroductLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        orderIntroductLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        orderIntroductLabel.textAlignment = .left
        orderIntroductLabel.text = "Nike耐克官方AIR 男子训练鞋运动老爹鞋休闲鞋"
        return orderIntroductLabel
    }()
    
    
    //商品名称
    lazy var productName:UILabel = {
       let productName = UILabel()
        productName.text = "黑橙色"
        productName.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#B0B0B0")
        productName.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        productName.textAlignment = .left
        return productName
    }()
    
    
    //数量
    lazy var numberLabel:UILabel = {
       let numberLabel = UILabel()
        numberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#B0B0B0")
        numberLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        numberLabel.textAlignment = .right
        numberLabel.text = "×1"
        return numberLabel
    }()
    
    
   
    
    //价格
    lazy var priceLabel:UILabel = {
       let priceLabel = UILabel()
        priceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        priceLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        priceLabel.textAlignment = .right
        priceLabel.text = "¥258.00"
        return priceLabel
    }()
    
    
    //售后方式
    lazy var refeulStyleLabel:UILabel = {
        let refeulStyleLabel = UILabel()
        refeulStyleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        refeulStyleLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        refeulStyleLabel.textAlignment = .left
        refeulStyleLabel.text = "售后方式"
        return refeulStyleLabel
    }()
    
    
    //售后方式类型
    lazy var refeulLabel:UILabel = {
        let refeulLabel = UILabel()
        refeulLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        refeulLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        refeulLabel.textAlignment = .right
        refeulLabel.text = "退货退款"
        return refeulLabel
    }()
    
    
    //退货退额
    lazy var refeulMoneyLabel:UILabel = {
        let refeulMoneyLabel = UILabel()
        refeulMoneyLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        refeulMoneyLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        refeulMoneyLabel.textAlignment = .left
        refeulMoneyLabel.text = "退款金额"
        return refeulMoneyLabel
    }()
    //
    lazy var refeulPriceLabel:UILabel = {
        let refeulPriceLabel = UILabel()
        refeulPriceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        refeulPriceLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        refeulPriceLabel.textAlignment = .right
        refeulPriceLabel.text = "268.00元"
        return refeulPriceLabel
    }()
    
    //退款原因
    lazy var refeulReasonLabel:UILabel = {
        let refeulReasonLabel = UILabel()
        refeulReasonLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        refeulReasonLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        refeulReasonLabel.textAlignment = .left
        refeulReasonLabel.text = "退款原因"
        return refeulReasonLabel
    }()
    //退款原因的内容
    lazy var refeulReasonContentlabel:UILabel = {
        let refeulReasonContentlabel = UILabel()
        refeulReasonContentlabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        refeulReasonContentlabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        refeulReasonContentlabel.textAlignment = .right
        refeulReasonContentlabel.text = "拍错/多拍/不喜欢"
        return refeulReasonContentlabel
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        contentView.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(scale(8))
        }
        
        
        
        contentView.addSubview(headerImage)
        contentView.addSubview(nicknameLabel)
        
        
        headerImage.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(topView.snp.bottom).offset(scale(12))
            make.width.height.equalTo(scale(20))
        }
        headerImage.layer.cornerRadius = scale(10)
        headerImage.layer.masksToBounds = true
        
        
        nicknameLabel.snp.makeConstraints { make in
            make.left.equalTo(headerImage.snp.right).offset(scale(4))
            make.top.equalTo(topView.snp.bottom).offset(scale(13))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(17))
        }
        
        
        contentView.addSubview(midView)
        contentView.addSubview(orderImage)
        contentView.addSubview(orderIntroductLabel)
        
        
        midView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(headerImage.snp.bottom).offset(scale(9))
            make.height.equalTo(scale(0.5))
        }
        
        
        orderImage.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(midView.snp.bottom).offset(scale(15))
            make.width.height.equalTo(scale(80))
        }
        
        orderImage.layer.cornerRadius = scale(2)
        orderImage.layer.borderWidth = scale(0.5)
        orderImage.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#E9E9E9").cgColor
        orderImage.layer.masksToBounds = true
        
        
        
        
        orderIntroductLabel.snp.makeConstraints { make in
            
            make.left.equalTo(orderImage.snp.right).offset(scale(12))
            make.top.equalTo(midView.snp.bottom).offset(scale(15))
            make.width.equalTo(scale(184))
            make.height.equalTo(scale(40))
            
//            make.left.equalTo(orderImage.snp.right).offset(scale(12))
//            make.right.equalTo(-scale(16))
//            make.height.equalTo(scale(40))
//            make.top.equalTo(midView.snp.bottom).offset(scale(15))
        }
        
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(midView.snp.bottom).offset(scale(19))
            make.height.equalTo(scale(12))
            make.left.equalTo(orderIntroductLabel.snp.right)
        }
        
        contentView.addSubview(productName)
        contentView.addSubview(numberLabel)
        
        
        
        
        productName.snp.makeConstraints { make in
            make.left.equalTo(orderImage.snp.right).offset(scale(12))
            make.top.equalTo(orderIntroductLabel.snp.bottom).offset(scale(16))
            make.width.equalTo(scale(200))
            make.height.equalTo(scale(12))
        }
        
        
        numberLabel.snp.makeConstraints { make in
//            make.left.equalTo(orderImage.snp.right).offset(scale(12))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(12))
            make.top.equalTo(orderIntroductLabel.snp.bottom).offset(scale(16))
            make.width.equalTo(scale(120))
        }
        
        
        contentView.addSubview(refeulStyleLabel)
        contentView.addSubview(refeulLabel)
        contentView.addSubview(refeulMoneyLabel)
        contentView.addSubview(refeulPriceLabel)
        contentView.addSubview(refeulReasonLabel)
        contentView.addSubview(refeulReasonContentlabel)
        
        
        refeulStyleLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(orderImage.snp.bottom).offset(scale(18))
            make.width.equalTo(scale(70))
            make.height.equalTo(scale(20))
        }
        
        refeulLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(orderImage.snp.bottom).offset(scale(18))
            make.height.equalTo(scale(20))
            make.left.equalTo(refeulStyleLabel.snp.right)
        }
        
        refeulMoneyLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(refeulStyleLabel.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(70))
            make.height.equalTo(scale(20))
        }
        
        refeulPriceLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(refeulLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(20))
            make.left.equalTo(refeulMoneyLabel.snp.right)
        }
        
        refeulReasonLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(refeulMoneyLabel.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(70))
            make.height.equalTo(scale(20))
        }
        
        
        refeulReasonContentlabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(refeulPriceLabel.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(20))
            make.left.equalTo(refeulReasonLabel.snp.right)
            make.bottom.equalTo(-scale(18))
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
