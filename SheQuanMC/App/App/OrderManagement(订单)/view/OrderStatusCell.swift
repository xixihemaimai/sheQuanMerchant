//
//  OrderStatusCell.swift
//  App
//
//  Created by mac on 2022/5/7.
//

import UIKit
import Util
import SDWebImage

class OrderStatusCell: UITableViewCell {
    
    
    //这边是UIView
    lazy var orderView:UIView = {
       let orderView = UIView()
        orderView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        return orderView
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
        returnGoodsLabel.text = "退货退款中"
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
        statusLabel.text = "待支付"
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
        buyerLabel.text = "买家留言:"
        return buyerLabel
    }()
    
    //买家的内容
    lazy var buyerTrueLabel:UILabel = {
        let buyerTrueLabel = UILabel()
        buyerTrueLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#4D4D4D")
        buyerTrueLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        buyerTrueLabel.textAlignment = .left
        buyerTrueLabel.text = "希望尽快发货"
        return buyerTrueLabel
    }()
    
    
    //-----------待支付
    //关闭订单按键
    lazy var closeOrderBtn:UIButton = {
       let closeOrderBtn = UIButton()
        closeOrderBtn.setTitle("关闭订单", for: .normal)
        closeOrderBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        closeOrderBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return closeOrderBtn
    }()
    
    
    //改价按键
    lazy var modifyPriceBtn:UIButton = {
       let modifyPriceBtn = UIButton()
        modifyPriceBtn.setTitle("改价", for: .normal)
        modifyPriceBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        modifyPriceBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return modifyPriceBtn
    }()
    
    
    
    //-----------待发货
    //去发货按键
    lazy var toShipBtn:UIButton = {
       let toShipBtn = UIButton()
        toShipBtn.setTitle("去发货", for: .normal)
        toShipBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        toShipBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return toShipBtn
    }()
    
    
    //-----------已发货
    //修改物流按键
    lazy var modifyLogisticsBtn:UIButton = {
       let modifyLogisticsBtn = UIButton()
        modifyLogisticsBtn.setTitle("修改物流", for: .normal)
        modifyLogisticsBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        modifyLogisticsBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return modifyLogisticsBtn
    }()
    
    
    //查看物流按键
    lazy var checkLogisticsBtn:UIButton = {
       let checkLogisticsBtn = UIButton()
        checkLogisticsBtn.setTitle("查看物流", for: .normal)
        checkLogisticsBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        checkLogisticsBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return checkLogisticsBtn
    }()
    
    
    //------------交易成功和交易关闭都没有按键
    var model:OrederInfoModel!{
        didSet{
            guard let _model = model else { return }
            returnGoodsLabel.text = _model.refundingText

            if (returnGoodsLabel.text?.count ?? 0) > 0{
                midView.isHidden = false
            }else{
                midView.isHidden = true
            }
            
            statusLabel.text = _model.orderStatusText

            nicknameLabel.text = _model.nickName

            orderImage.sd_setImage(with: URL(string: _model.products?.first?.productPic ?? ""), placeholderImage: UIImage(named: "Group 2784"))
            priceLabel.text = "¥" + (_model.products?.first?.price ?? "0")

            truePriceLabel.text = "¥" + (_model.payAmount ?? "0")

            let width = (truePriceLabel.text?.singleLineWidth(font: UIFont.systemFont(ofSize: scale(16), weight: .semibold)) ?? 0)

            truePriceLabel.snp.remakeConstraints { make in
                make.top.equalTo(orderImage.snp.bottom).offset(scale(12))
                make.right.equalTo(-scale(16))
                make.width.equalTo(width)
                make.height.equalTo(scale(12))
            }


            productName.text = _model.products?.first?.specs

            let qtyStr = String(format: "%d", _model.products?.first?.qty ?? 0)
            numberLabel.text = "x" + qtyStr

            orderIntroductLabel.text = _model.products?.first?.productName

            if (_model.leaveMsg?.count ?? 0) < 1{
                buyersView.snp.remakeConstraints { make in
                    make.left.equalTo(scale(16))
                    make.right.equalTo(-scale(16))
                    make.height.equalTo(scale(0.1))
                    make.top.equalTo(truePriceLabel.snp.bottom).offset(scale(12))
                }
            }else{
                buyersView.snp.remakeConstraints { make in
                    make.left.equalTo(scale(16))
                    make.right.equalTo(-scale(16))
                    make.height.equalTo(scale(32))
                    make.top.equalTo(truePriceLabel.snp.bottom).offset(scale(12))
                }
            }
            if  (_model.leaveMsg?.count ?? 0) > 0{
                buyersView.isHidden = false
//                buyerTrueLabel.text = _model.remarks
                buyerTrueLabel.text = _model.leaveMsg
            }else{
                buyersView.isHidden = true
            }

            if _model.orderStatus == 10{
                //待支付
                midView.isHidden = true
                returnGoodsLabel.isHidden = true
                closeOrderBtn.isHidden = false
                modifyPriceBtn.isHidden = false
                toShipBtn.isHidden = true
                checkLogisticsBtn.isHidden = true
                modifyLogisticsBtn.isHidden = true
//                returnGoodsLabel.text = "退款退款中"
            }else if  _model.orderStatus == 20 {
                //待发货
                closeOrderBtn.isHidden = true
                modifyPriceBtn.isHidden = true
                toShipBtn.isHidden = false
                checkLogisticsBtn.isHidden = true
                modifyLogisticsBtn.isHidden = true
//                returnGoodsLabel.text = "仅退款"
//                statusLabel.text = _productInfoModel.statusText
            }else if _model.orderStatus == 21{
               //已发货
                closeOrderBtn.isHidden = true
                modifyPriceBtn.isHidden = true
                toShipBtn.isHidden = true
                checkLogisticsBtn.isHidden = false
                modifyLogisticsBtn.isHidden = false
            }else{
                //交易成功 交易失败
//                orderView.snp.makeConstraints { make in
//                    make.left.right.equalToSuperview()
//                    make.top.equalTo(scale(8))
//                    make.height.equalTo(scale(200))
//                    make.bottom.equalToSuperview()
//                }
                midView.isHidden = true
                returnGoodsLabel.isHidden = true
                closeOrderBtn.isHidden = true
                modifyPriceBtn.isHidden = true
                toShipBtn.isHidden = true
                checkLogisticsBtn.isHidden = true
                modifyLogisticsBtn.isHidden = true

                if (_model.leaveMsg?.count ?? 0) < 1{
                    buyersView.snp.remakeConstraints { make in
                        make.left.equalTo(scale(16))
                        make.right.equalTo(-scale(16))
                        make.height.equalTo(scale(0.1))
                        make.top.equalTo(truePriceLabel.snp.bottom).offset(scale(12))
                        make.bottom.equalTo(-scale(12))
                    }
                }else{
                    buyersView.snp.remakeConstraints { make in
                        make.left.equalTo(scale(16))
                        make.right.equalTo(-scale(16))
                        make.height.equalTo(scale(32))
                        make.top.equalTo(truePriceLabel.snp.bottom).offset(scale(12))
                        make.bottom.equalTo(-scale(12))
                    }
                }
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        contentView.addSubview(orderView)
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
        
        
        orderView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(8))
//            make.bottom.equalToSuperview()
        }
        
        
        headerImage.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(orderView.snp.bottom).offset(scale(13))
            make.width.height.equalTo(scale(12))
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.left.equalTo(headerImage.snp.right).offset(scale(4))
            make.top.equalTo(orderView.snp.bottom).offset(scale(10))
            make.width.equalTo(scale(200))
            make.height.equalTo(scale(17))
        }
        
        statusLabel.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            //make.top.equalTo(scale(8))
            make.top.equalTo(orderView.snp.bottom).offset(scale(8))
            make.width.equalTo(scale(60))
            make.height.equalTo(scale(20))
        }
        
        
        midView.snp.makeConstraints { make in
            make.right.equalTo(statusLabel.snp.left).offset(scale(8))
//            make.top.equalTo(scale(9))
            make.top.equalTo(orderView.snp.bottom).offset(scale(9))
            make.width.equalTo(scale(1))
            make.height.equalTo(scale(16))
        }
        
        
        returnGoodsLabel.snp.makeConstraints { make in
            make.right.equalTo(midView.snp.left).offset(-scale(8))
//            make.top.equalTo(scale(7))
            make.top.equalTo(orderView.snp.bottom).offset(scale(7))
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
        
        
        
        
        contentView.addSubview(buyersView)
        buyersView.addSubview(buyerLabel)
        buyersView.addSubview(buyerTrueLabel)
        
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
        
        contentView.addSubview(closeOrderBtn)
        contentView.addSubview(modifyPriceBtn)
        

        modifyPriceBtn.snp.makeConstraints { make in
            make.top.equalTo(buyersView.snp.bottom).offset(scale(16))
            make.bottom.equalTo(-scale(12))
            make.height.equalTo(scale(26))
            make.width.equalTo(scale(60))
            make.right.equalTo(-scale(12))
        }
        
        modifyPriceBtn.layer.cornerRadius = scale(4)
        modifyPriceBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        modifyPriceBtn.layer.borderWidth = scale(1)
        
        closeOrderBtn.snp.makeConstraints { make in
            make.top.equalTo(buyersView.snp.bottom).offset(scale(16))
            make.bottom.equalTo(-scale(12))
            make.height.equalTo(scale(26))
            make.width.equalTo(scale(80))
            make.right.equalTo(modifyPriceBtn.snp.left).offset(-scale(12))
        }
        
        
        closeOrderBtn.layer.cornerRadius = scale(4)
        closeOrderBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        closeOrderBtn.layer.borderWidth = scale(1)
        
        contentView.addSubview(toShipBtn)
        
        toShipBtn.snp.makeConstraints { make in
            make.top.equalTo(buyersView.snp.bottom).offset(scale(16))
            make.bottom.equalTo(-scale(12))
            make.height.equalTo(scale(26))
            make.width.equalTo(scale(74))
            make.right.equalTo(-scale(12))
        }
        
        toShipBtn.layer.cornerRadius = scale(4)
        toShipBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        toShipBtn.layer.borderWidth = scale(1)
        
        
        contentView.addSubview(modifyLogisticsBtn)
        contentView.addSubview(checkLogisticsBtn)
        
        checkLogisticsBtn.snp.makeConstraints { make in
            make.top.equalTo(buyersView.snp.bottom).offset(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(26))
            make.width.equalTo(scale(88))
            make.bottom.equalTo(-scale(12))
        }
        
        checkLogisticsBtn.layer.cornerRadius = scale(4)
        checkLogisticsBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        checkLogisticsBtn.layer.borderWidth = scale(1)
        
        
        modifyLogisticsBtn.snp.makeConstraints { make in
            make.top.equalTo(buyersView.snp.bottom).offset(scale(16))
            make.height.equalTo(scale(26))
            make.width.equalTo(scale(88))
            make.right.equalTo(checkLogisticsBtn.snp.left).offset(-scale(12))
            make.bottom.equalTo(-scale(12))
        }
        
        modifyLogisticsBtn.layer.cornerRadius = scale(4)
        modifyLogisticsBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        modifyLogisticsBtn.layer.borderWidth = scale(1)
        
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
