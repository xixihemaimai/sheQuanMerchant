//
//  OrderToBePaidCell.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class OrderToBePaidCell: UITableViewCell {
    
    //订单编号
    lazy var orderNumberLabel:UILabel = {
       let orderNumberLabel = UILabel()
        orderNumberLabel.text = "订单编号:20220301-123456789123456"
        orderNumberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        orderNumberLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        orderNumberLabel.textAlignment = .left
        return orderNumberLabel
    }()
    
    
    //付款编号
    lazy var payNumberLabel:UILabel = {
        let payNumberLabel = UILabel()
        payNumberLabel.text = "付款编号:20220301-123456789123456"
        payNumberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        payNumberLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        payNumberLabel.textAlignment = .left
        return payNumberLabel
    }()
    
    
    
    //付款方式
    lazy var payTypeLabel:UILabel = {
        let payTypeLabel = UILabel()
        payTypeLabel.text = "付款方式:零钱支付"
        payTypeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        payTypeLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        payTypeLabel.textAlignment = .left
        return payTypeLabel
    }()
    //下单时间
    lazy var orderTimeLabel:UILabel = {
       let orderTimeLabel = UILabel()
        orderTimeLabel.text = "下单时间:2022-03-01 14:21:31"
        orderTimeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        orderTimeLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        orderTimeLabel.textAlignment = .left
        return orderTimeLabel
    }()
    
    //付款时间
    lazy var payTimeLabel:UILabel = {
        let payTimeLabel = UILabel()
        payTimeLabel.text = "付款时间:2022-03-01 14:21:31"
        payTimeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        payTimeLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        payTimeLabel.textAlignment = .left
         return payTimeLabel
    }()
    
    
    var orderInfoModel:OrederInfoModel?{
        didSet{
            guard let _orderInfoModel = orderInfoModel else { return }
            orderNumberLabel.text = "订单编号:" + (_orderInfoModel.orderNo ?? "")
            orderTimeLabel.text = "下单时间:" + (_orderInfoModel.orderTime ?? "")
            if _orderInfoModel.orderStatus == 10{
                payTypeLabel.isHidden = true
                payTimeLabel.isHidden = true
                payNumberLabel.isHidden = true
                orderTimeLabel.snp.remakeConstraints { make in
                    make.left.equalTo(scale(16))
                    make.right.equalTo(-scale(16))
                    make.height.equalTo(scale(28))
                    make.top.equalTo(orderNumberLabel.snp.bottom).offset(scale(6))
                    make.bottom.equalTo(-scale(8))
                }
            }else{
                
                payTypeLabel.isHidden = false
                payTimeLabel.isHidden = false
                payNumberLabel.isHidden = false
                //付款编号
                //付款方式
                //付款时间
            }
        }
    }
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        contentView.addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(8))
        }
        
        contentView.addSubview(orderNumberLabel)
        contentView.addSubview(payNumberLabel)
        contentView.addSubview(payTypeLabel)
        contentView.addSubview(orderTimeLabel)
        contentView.addSubview(payTimeLabel)
        
    
        orderNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(topView.snp.bottom).offset(scale(13))
            make.height.equalTo(scale(28))
        }
        
        payNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(28))
            make.top.equalTo(orderNumberLabel.snp.bottom).offset(scale(6))
        }
        
        payTypeLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(28))
            make.top.equalTo(payNumberLabel.snp.bottom).offset(scale(6))
        }
        
        orderTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(payTypeLabel.snp
                .bottom).offset(scale(6))
            make.height.equalTo(scale(28))
            make.right.equalTo(-scale(16))
        }
        payTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(28))
            make.top.equalTo(orderTimeLabel.snp.bottom).offset(scale(6))
            make.bottom.equalTo(-scale(8))
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
