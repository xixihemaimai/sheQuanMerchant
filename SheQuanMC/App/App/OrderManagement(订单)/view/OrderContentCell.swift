//
//  OrderContentCell.swift
//  App
//
//  Created by mac on 2022/5/7.
//

import UIKit
import Util

class OrderContentCell: UITableViewCell {
    
    
    //添加一个分割view
    lazy var topView:UIView = {
       let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        return topView
    }()
    
    
    
    //头像
    
    lazy var headerImage:UIImageView = {
       let headerImage = UIImageView()
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
        numberLabel.textAlignment = .right
        numberLabel.text = "黑橙色×1"
        return numberLabel
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
    
    
    
    
    
    
    //价格
    lazy var priceLabel:UILabel = {
       let priceLabel = UILabel()
        priceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        priceLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        priceLabel.textAlignment = .right
        priceLabel.text = "¥258.00"
        return priceLabel
    }()
    
    //商品总价
    lazy var goodsTotalLabel:UILabel = {
        let goodsTotalLabel = UILabel()
        goodsTotalLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        goodsTotalLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        goodsTotalLabel.textAlignment = .left
        goodsTotalLabel.text = "商品总价"
        return goodsTotalLabel
    }()
    
    
    //商品总价价格
    lazy var goodsTotalPriceLabel:UILabel = {
        let goodsTotalPriceLabel = UILabel()
        goodsTotalPriceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        goodsTotalPriceLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        goodsTotalPriceLabel.textAlignment = .right
        goodsTotalPriceLabel.text = "¥268.00"
        return goodsTotalPriceLabel
    }()
    
    //运费
    lazy var freightLabel:UILabel = {
        let freightLabel = UILabel()
        freightLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        freightLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        freightLabel.textAlignment = .left
        freightLabel.text = "运费"
        return freightLabel
    }()
    //运费价格
    lazy var freightPriceLabel:UILabel = {
        let freightPriceLabel = UILabel()
        freightPriceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        freightPriceLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        freightPriceLabel.textAlignment = .right
        freightPriceLabel.text = "¥10.00"
        return freightPriceLabel
    }()
    
    //优惠
    lazy var discountLabel:UILabel = {
        let discountLabel = UILabel()
        discountLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        discountLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        discountLabel.textAlignment = .left
        discountLabel.text = "优惠"
        return discountLabel
    }()
    //优惠的价格
    lazy var discountPriceLabel:UILabel = {
        let discountPriceLabel = UILabel()
        discountPriceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        discountPriceLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        discountPriceLabel.textAlignment = .right
        discountPriceLabel.text = "¥0.00"
        return discountPriceLabel
    }()
    
    //买家留言的UIview
    lazy var buyersView:UIView = {
       let buyersView = UIView()
        buyersView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F6F6F6")
        return buyersView
    }()
    
    //买家留言
    lazy var buyerLabel:UILabel = {
        let buyerLabel = UILabel()
        buyerLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        buyerLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        buyerLabel.textAlignment = .left
        buyerLabel.text = "买家留言:"
        return buyerLabel
    }()
    
    //理由
    lazy var buyerTrueLabel:UILabel = {
        let buyerTrueLabel = UILabel()
        buyerTrueLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#4D4D4D")
        buyerTrueLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        buyerTrueLabel.textAlignment = .left
        buyerTrueLabel.text = "希望尽快发货"
        return buyerTrueLabel
    }()
    
    //分割线
    lazy var bottomView:UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return bottomView
    }()
    
    
    //价钱
    lazy var totalPriceLabel:UILabel = {
        let totalPriceLabel = UILabel()
        totalPriceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        totalPriceLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        totalPriceLabel.textAlignment = .right
        totalPriceLabel.text = "¥278.00"
        return totalPriceLabel
    }()
    
    
    //实收(含运费):
    lazy var trueCollectLabel:UILabel = {
        let trueCollectLabel = UILabel()
        trueCollectLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        trueCollectLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        trueCollectLabel.textAlignment = .right
        trueCollectLabel.text = "实收(含运费):"
        return trueCollectLabel
    }()
    
    
    var orderInfoModel:OrederInfoModel?{
        didSet{
            guard let _orderInfoModel = orderInfoModel else { return }
            
            headerImage.sd_setImage(with: URL(string: _orderInfoModel.faceUrl ?? ""), placeholderImage: UIImage(named: "Group 2784"))
            
            nicknameLabel.text = _orderInfoModel.nickName
            
            orderImage.sd_setImage(with: URL(string: _orderInfoModel.products?.first?.productPic ?? ""), placeholderImage: UIImage(named: "Group 2750"))
            
            orderIntroductLabel.text = _orderInfoModel.products?.first?.productName
            
            
            let qtyStr = String(format: "%d", _orderInfoModel.products?.first?.qty ?? 0)
            
            productName.text = _orderInfoModel.products?.first?.specs
            numberLabel.text = "x" + qtyStr
            
            priceLabel.text = "¥" + (_orderInfoModel.products?.first?.price ?? "0.00")
            
            goodsTotalPriceLabel.text = "¥" + (_orderInfoModel.totalAmount ?? "0.00")
            
            freightPriceLabel.text = "¥" + (_orderInfoModel.freight ?? "0.00")
            
            discountPriceLabel.text = "¥" + (_orderInfoModel.discount ?? "希望尽快发货")
            
            buyerTrueLabel.text = _orderInfoModel.remarks
            
            totalPriceLabel.text = "¥" + (_orderInfoModel.payAmount ?? "0.00")
            
            
            let width = (totalPriceLabel.text?.singleLineWidth(font: UIFont.systemFont(ofSize: scale(16), weight: .semibold)) ?? 0)
            
            totalPriceLabel.snp.remakeConstraints { make in
                make.top.equalTo(bottomView.snp.bottom).offset(scale(11))
                make.right.equalTo(-scale(16))
                make.width.equalTo(width)
                make.height.equalTo(scale(12))
            }
            
            //这变也需要判断是否有买家留言
            if (_orderInfoModel.remarks?.count ?? 0) < 1{
                buyersView.snp.remakeConstraints { make in
                    make.left.equalTo(scale(16))
                    make.right.equalTo(-scale(16))
                    make.height.equalTo(scale(0.1))
                    make.top.equalTo(discountPriceLabel.snp.bottom).offset(scale(12))
                }
                buyersView.isHidden = true
            }
            
        }
    }
    
    
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
        
        
        contentView.addSubview(numberLabel)
        contentView.addSubview(productName)
        
        
        
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
            make.top.equalTo(orderIntroductLabel.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(120))
        }
        
        
        
//        priceLabel.snp.makeConstraints { make in
//            make.right.equalTo(-scale(16))
//            make.top.equalTo(orderIntroductLabel.snp
//                .bottom).offset(scale(12))
//            make.width.equalTo(scale(120))
//            make.height.equalTo(scale(12))
//        }
    
        
        
        contentView.addSubview(goodsTotalLabel)
        contentView.addSubview(goodsTotalPriceLabel)
        
        goodsTotalLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(orderImage.snp.bottom).offset(scale(18))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(20))
        }
        
        goodsTotalPriceLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(20))
            make.top.equalTo(orderImage.snp.bottom).offset(scale(18))
        }
        
        
        
        
        contentView.addSubview(freightLabel)
        contentView.addSubview(freightPriceLabel)
        
        freightLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(20))
            make.top.equalTo(goodsTotalLabel.snp.bottom).offset(scale(12))
        }
        
        
        freightPriceLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(20))
            make.top.equalTo(goodsTotalPriceLabel.snp.bottom).offset(scale(12))
        }
        
        
        contentView.addSubview(discountLabel)
        contentView.addSubview(discountPriceLabel)
        
        
        discountLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(20))
            make.top.equalTo(freightLabel.snp.bottom).offset(scale(12))
        }
        
        
        discountPriceLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(20))
            make.top.equalTo(freightPriceLabel.snp.bottom).offset(scale(12))
        }
        
        
        
        contentView.addSubview(buyersView)
        buyersView.addSubview(buyerLabel)
        buyersView.addSubview(buyerTrueLabel)
        
        
        buyersView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(32))
            make.top.equalTo(discountLabel.snp.bottom).offset(scale(11))
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
        
        contentView.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(0.5))
            make.top.equalTo(buyersView.snp.bottom).offset(scale(13))
        }
        
        contentView.addSubview(totalPriceLabel)
        contentView.addSubview(trueCollectLabel)
        
        totalPriceLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(12))
            make.top.equalTo(bottomView.snp.bottom).offset(scale(11))
            make.width.equalTo(scale(100))
//            make.left.equalTo(scale(16))
//            make.bottom.equalTo(-scale(16))
        }
        
        trueCollectLabel.snp.makeConstraints { make in
            make.right.equalTo(totalPriceLabel.snp.left).offset(-scale(6))
            make.width.equalTo(scale(120))
            make.height.equalTo(scale(12))
            make.top.equalTo(bottomView.snp
                .bottom).offset(scale(11))
            make.bottom.equalTo(-scale(16))
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
