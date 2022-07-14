//
//  AfterSalesCell.swift
//  App
//
//  Created by mac on 2022/7/14.
//

import UIKit
import Util

class AfterSalesCell: UITableViewCell {
    
    
    
    //这边是UIView
    lazy var afterSalesView:UIView = {
       let afterSalesView = UIView()
        afterSalesView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F4F4F4")
        return afterSalesView
    }()
        
    //图片
    lazy var headerImage:UIImageView = {
       let headerImage = UIImageView()
        headerImage.image = UIImage(named: "Frame-评论")
        return headerImage
    }()
    
    
    //昵称
    lazy var nicknameLabel:UILabel = {
       let nicknameLabel = UILabel()
        nicknameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        nicknameLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        nicknameLabel.textAlignment = .left
        nicknameLabel.text = "天空****"
        return nicknameLabel
    }()
    
    
    //------已发货
    lazy var returnGoodsLabel:UILabel = {
       let returnGoodsLabel = UILabel()
        returnGoodsLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F13232")
        returnGoodsLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        returnGoodsLabel.textAlignment = .right
        returnGoodsLabel.text = "退货退款"
//        returnGoodsLabel.isHidden = true
        return returnGoodsLabel
    }()
    
    
    //分割线
    lazy var midView:UIView = {
      let midview = UIView()
        midview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4")
        return midview
    }()
    
    //状态label
    lazy var statusLabel:UILabel = {
       let statusLabel = UILabel()
        statusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        statusLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        statusLabel.textAlignment = .right
        statusLabel.text = "平台介入中"
        return statusLabel
    }()
    
    
    //分割线
    lazy var diviver:UIView = {
       let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0DFDF")
        return diviver
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
    
    //价钱
    lazy var priceLabel:UILabel = {
       let priceLabel = UILabel()
        priceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        priceLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        priceLabel.textAlignment = .right
        priceLabel.text = "¥258.00"
        return priceLabel
    }()
    
    
    
    //商品名称
    lazy var productName:UILabel = {
       let productName = UILabel()
        productName.text = "商品名称"
//      productName.textColor = UIColor.colorWithDyColorChangObject(lightColor: "")
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
        //numberLabel.textAlignment = .left
        numberLabel.textAlignment = .right
        numberLabel.text = "×1"
        return numberLabel
    }()
    
    
    //实收的价钱
    lazy var netReceiptsLabel:UILabel = {
        let netReceiptsLabel = UILabel()
        netReceiptsLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        netReceiptsLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        netReceiptsLabel.textAlignment = .right
        netReceiptsLabel.text = "退款金额:"
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
    
    //买家的留言的UIview
    lazy var buyersView:UIView = {
       let buyersView = UIView()
        buyersView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F6F6F6")
        return buyersView
    }()
    
    //买家留言的label
    lazy var buyerLabel:UILabel = {
        let buyerLabel = UILabel()
        buyerLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        buyerLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        buyerLabel.textAlignment = .left
        buyerLabel.text = "介入中"
        return buyerLabel
    }()
    
    //买家的内容
    lazy var buyerTrueLabel:UILabel = {
        let buyerTrueLabel = UILabel()
        buyerTrueLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#4D4D4D")
        buyerTrueLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        buyerTrueLabel.textAlignment = .left
        buyerTrueLabel.text = "请在协商历史中及时上传证据"
        return buyerTrueLabel
    }()
    
    
    //去处理
    lazy var handleBtn:UIButton = {
       let handleBtn = UIButton()
        handleBtn.setTitle("去处理", for: .normal)
        handleBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        handleBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return handleBtn
    }()
    
    
    
    
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        contentView.addSubview(afterSalesView)
        contentView.addSubview(headerImage)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(returnGoodsLabel)
        contentView.addSubview(midView)
        contentView.addSubview(statusLabel)
        contentView.addSubview(diviver)
        contentView.addSubview(orderImage)
        contentView.addSubview(orderIntroductLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(productName)
        contentView.addSubview(numberLabel)
        contentView.addSubview(netReceiptsLabel)
        contentView.addSubview(truePriceLabel)
        contentView.addSubview(buyersView)
        
        buyersView.addSubview(buyerLabel)
        buyersView.addSubview(buyerTrueLabel)
        
        contentView.addSubview(handleBtn)
        
        afterSalesView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(8))
        }
        
        headerImage.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(afterSalesView.snp.bottom).offset(scale(13))
            make.width.height.equalTo(scale(12))
        }
        
        
        nicknameLabel.snp.makeConstraints { make in
            make.left.equalTo(headerImage.snp.right).offset(scale(3))
//            make.top.equalTo(scale(10))
            make.top.equalTo(afterSalesView.snp.bottom).offset(scale(10))
            make.width.equalTo(scale(200))
            make.height.equalTo(scale(17))
        }
        
        
        statusLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            //make.top.equalTo(scale(8))
            make.top.equalTo(afterSalesView.snp.bottom).offset(scale(8))
            make.width.equalTo(scale(90))
            make.height.equalTo(scale(20))
        }
        
        
        midView.snp.makeConstraints { make in
            make.right.equalTo(statusLabel.snp.left).offset(scale(8))
//            make.top.equalTo(scale(9))
            make.top.equalTo(afterSalesView.snp.bottom).offset(scale(9))
            make.width.equalTo(scale(1))
            make.height.equalTo(scale(16))
        }
        
        
        returnGoodsLabel.snp.makeConstraints { make in
            make.right.equalTo(midView.snp.left).offset(-scale(8))
//            make.top.equalTo(scale(7))
            make.top.equalTo(afterSalesView.snp.bottom).offset(scale(7))
            make.width.equalTo(scale(90))
            make.height.equalTo(scale(20))
        }
        
        
        diviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(nicknameLabel.snp.bottom).offset(scale(10))
            make.height.equalTo(scale(0.5))
        }
        
        
        orderImage.snp.makeConstraints { make in
            make.top.equalTo(diviver.snp.bottom).offset(scale(15))
            make.left.equalTo(scale(16))
            make.width.height.equalTo(scale(80))
        }
        
        orderImage.layer.cornerRadius = scale(2)
        orderImage.layer.borderWidth = scale(0.5)
        orderImage.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#E9E9E9").cgColor
        orderImage.layer.masksToBounds = true
        
        orderIntroductLabel.snp.makeConstraints { make in
            make.left.equalTo(orderImage.snp.right).offset(scale(12))
            make.top.equalTo(diviver.snp.bottom).offset(scale(15))
            make.width.equalTo(scale(184))
            make.height.equalTo(scale(40))
        }
        
        priceLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(diviver.snp.bottom).offset(scale(19))
            make.height.equalTo(scale(12))
            make.left.equalTo(orderIntroductLabel.snp.right)
        }
        
        productName.snp.makeConstraints { make in
            make.left.equalTo(orderImage.snp.right).offset(scale(12))
            make.top.equalTo(orderIntroductLabel.snp.bottom).offset(scale(16))
            make.width.equalTo(scale(200))
            make.height.equalTo(scale(12))
        }
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(orderIntroductLabel.snp.bottom).offset(scale(16))
            make.right.equalTo(-scale(16))
            make.width.equalTo(scale(120))
            make.height.equalTo(scale(12))
        }
        
        truePriceLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(orderImage.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(12))
            make.width.equalTo(scale(80))
        }
        
        
        netReceiptsLabel.snp.makeConstraints { make in
            make.right.equalTo(truePriceLabel.snp.left).offset(-scale(6))
            make.height.equalTo(scale(12))
            make.top.equalTo(orderImage.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(110))
        }
        
        buyersView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(32))
            make.top.equalTo(truePriceLabel.snp.bottom).offset(scale(12))
        }
        
        buyersView.layer.cornerRadius = scale(2)
        
        buyerLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(8))
            make.centerY.equalToSuperview()
            make.height.equalTo(scale(12))
            make.width.equalTo(scale(60))
        }
        buyerTrueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(buyerLabel.snp.right).offset(scale(8))
            make.right.equalTo(-scale(8))
            make.height.equalTo(scale(12))
        }
        
        
        
        
        
        handleBtn.snp.makeConstraints { make in
            make.width.equalTo(scale(74))
            make.height.equalTo(scale(26))
            make.right.equalTo(-scale(16))
            make.top.equalTo(buyersView.snp.bottom).offset(scale(16))
            make.bottom.equalTo(-scale(12))
        }
        
        
        handleBtn.layer.cornerRadius = scale(4)
        handleBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        handleBtn.layer.borderWidth = scale(1)
        
        
        
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
