//
//  OrderDeliveryLogisticsCell.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util


class OrderDeliveryLogisticsCell: UITableViewCell {
    
    
    //进入签收的地方
    lazy var joinSignBtn:UIButton = {
       let joinSignBtn = UIButton()
        joinSignBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return joinSignBtn
    }()
    
    //签收时间
    lazy var logisticsTimeLabel:UILabel = {
       let logisticsTimeLabel = UILabel()
        logisticsTimeLabel.text = "2022-03-02 19:15:23"
        logisticsTimeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#808080")
        logisticsTimeLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        logisticsTimeLabel.textAlignment = .left
        return logisticsTimeLabel
    }()
    
    //昵称
    lazy var nickNameLabel:UILabel = {
       let nickNameLabel = UILabel()
        nickNameLabel.text = "农大侠"
        nickNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        nickNameLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .semibold)
        nickNameLabel.textAlignment = .left
        return nickNameLabel
    }()
    
    //电话号码
    lazy var phoneNumberLabel:UILabel = {
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.text = "12312338910"
        phoneNumberLabel.text = phoneNumberLabel.text?.hidePhone()
        phoneNumberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#808080")
        phoneNumberLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        phoneNumberLabel.textAlignment = .left
         return phoneNumberLabel
    }()
    // 地址
    lazy var addressLabel:UILabel = {
        let addressLabel = UILabel()
        addressLabel.text = "福建省 厦门市 思明区 莲前街道岭兜二路75号"
        addressLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        addressLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        addressLabel.textAlignment = .left
         return addressLabel
    }()
    
    lazy var addressImage:UIImageView = {
        let addressImage = UIImageView()
        addressImage.image = UIImage(named: "Group 2711")
        return addressImage
    }()
    
    
    
    var orderLogisticsModel:OrderLogisticsModel?{
        didSet{
            guard let _orderLogisticsModel = orderLogisticsModel else { return }
            nickNameLabel.text = _orderLogisticsModel.retAddress?.consignee
            phoneNumberLabel.text = _orderLogisticsModel.retAddress?.mobile?.hidePhone(combine: "****")
            phoneNumberLabel.text = _orderLogisticsModel.retAddress?.mobile
            addressLabel.text = String(format: "%@%@%@%@", _orderLogisticsModel.retAddress?.provinceName ?? "",_orderLogisticsModel.retAddress?.cityName ?? "",_orderLogisticsModel.retAddress?.regionName ?? "",_orderLogisticsModel.retAddress?.address ?? "")
            var width = (_orderLogisticsModel.retAddress?.consignee?.singleLineWidth(font: UIFont.systemFont(ofSize: scale(16), weight: .semibold)) ?? 10)
            width += scale(5)
            nickNameLabel.snp.remakeConstraints { make in
                make.left.equalTo(addressImage.snp.right).offset(scale(3))
                make.top.equalTo(joinSignBtn.snp.bottom).offset(scale(10))
                make.height.equalTo(scale(22))
                make.width.equalTo(width)
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
        
        let logisticsLabel = UILabel()
        logisticsLabel.text = "发货物流"
        logisticsLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        logisticsLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        logisticsLabel.textAlignment = .left
        contentView.addSubview(logisticsLabel)
        logisticsLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
            make.top.equalTo(scale(14))
        }
        
        //分割线
        let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        contentView.addSubview(diviver)
        
        diviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(logisticsLabel.snp.bottom).offset(scale(9))
            make.height.equalTo(scale(0.5))
        }
        
        //这边添加一个btn
        contentView.addSubview(joinSignBtn)
        joinSignBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(diviver.snp.bottom)
            make.height.equalTo(scale(63))
        }
        
        
        let logisticsImage = UIImageView()
        logisticsImage.image = UIImage(named: "Group 2742")
        joinSignBtn.addSubview(logisticsImage)
        
        logisticsImage.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(11))
            make.width.height.equalTo(scale(16))
        }
        
        let logisticsSLabel = UILabel()
        logisticsSLabel.text = "已签收，签收人凭取件码取件"
        logisticsSLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        logisticsSLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .semibold)
        logisticsSLabel.textAlignment = .left
        joinSignBtn.addSubview(logisticsSLabel)
        
        logisticsSLabel.snp.makeConstraints { make in
            make.left.equalTo(logisticsImage.snp.right).offset(scale(4))
            make.top.equalTo(scale(7))
            make.right.equalTo(-scale(100))
            make.height.equalTo(scale(22))
        }
        
        //签收时间
        joinSignBtn.addSubview(logisticsTimeLabel)
        logisticsTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(logisticsSLabel.snp.bottom).offset(scale(4))
            make.height.equalTo(scale(17))
            make.right.equalTo(-scale(16))
        }
        
        
        //方向图片
        let rightImage = UIImageView()
        rightImage.image = UIImage(named: "Frame-right")
        joinSignBtn.addSubview(rightImage)
        
        rightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
        }
        
        
        //分割线
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        joinSignBtn.addSubview(midView)
        
        midView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.bottom.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        
        
        
        contentView.addSubview(addressImage)
        
        addressImage.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(joinSignBtn.snp.bottom).offset(scale(10))
            make.width.height.equalTo(scale(16))
        }
        
        
        contentView.addSubview(nickNameLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(addressLabel)
        
        nickNameLabel.snp.makeConstraints { make in
            make.left.equalTo(addressImage.snp.right).offset(scale(3))
            make.top.equalTo(joinSignBtn.snp.bottom).offset(scale(10))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(100))
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(nickNameLabel.snp.right).offset(scale(12))
            make.top.equalTo(joinSignBtn.snp.bottom).offset(scale(10))
            make.height.equalTo(scale(22))
            make.right.equalTo(-scale(16))
        }
        
        addressLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(34))
            make.right.equalTo(-scale(16))
            make.top.equalTo(nickNameLabel.snp.bottom).offset(scale(8))
            make.height.equalTo(scale(16))
            make.bottom.equalTo(-scale(23))
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
