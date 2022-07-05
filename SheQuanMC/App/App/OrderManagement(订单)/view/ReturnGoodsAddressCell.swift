//
//  ReturnGoodsAddressCell.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class ReturnGoodsAddressCell: UITableViewCell {
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
        phoneNumberLabel.text = "123****8910"
        phoneNumberLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#808080")
        phoneNumberLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        phoneNumberLabel.textAlignment = .left
        return phoneNumberLabel
    }()
    //地址
    lazy var addressLabel:UILabel = {
        let addressLabel = UILabel()
        addressLabel.numberOfLines = 2
        addressLabel.lineBreakMode = .byCharWrapping
        addressLabel.text = "福建省 厦门市 思明区 莲前街道岭兜二路75号"
        addressLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        addressLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        addressLabel.textAlignment = .left
        return addressLabel
    }()
    //修改
    lazy var modifyBtn:UIButton = {
        let modifyBtn = UIButton()
        modifyBtn.setTitle("修改", for: .normal)
        modifyBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        modifyBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return modifyBtn
    }()
    
    lazy var diviver:UIView = {
        let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return diviver
    }()
    
    lazy var addressImage:UIImageView = {
        let addressImage = UIImageView()
        addressImage.image = UIImage(named: "Group 2711")
        return addressImage
    }()
    
    var retAddress:RetAddressInfoModel?{
        didSet{
            guard let _retAddress = retAddress else { return }
            nickNameLabel.text = _retAddress.consignee
//            phoneNumberLabel.text = _retAddress.mobile?.hidePhone(combine: "****")
            phoneNumberLabel.text = _retAddress.mobile
            addressLabel.text = String(format: "%@%@%@%@", _retAddress.provinceName ?? "",_retAddress.cityName ?? "",_retAddress.regionName ?? "",_retAddress.address ?? "")
            var width = (_retAddress.consignee?.singleLineWidth(font: UIFont.systemFont(ofSize: scale(16), weight: .semibold)) ?? 10)
            width += scale(5)
            nickNameLabel.snp.remakeConstraints { make in
                make.left.equalTo(addressImage.snp.right).offset(scale(3))
                make.top.equalTo(diviver.snp.bottom).offset(scale(9))
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
        
        let buyerLabel = UILabel()
        buyerLabel.text = "退货地址"
        buyerLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        buyerLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        buyerLabel.textAlignment = .left
        contentView.addSubview(buyerLabel)
        buyerLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
            make.top.equalTo(scale(14))
        }
        
        //分割线
        contentView.addSubview(diviver)
        diviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(buyerLabel.snp.bottom).offset(scale(9))
            make.height.equalTo(scale(0.5))
        }
        
        contentView.addSubview(addressImage)
        addressImage.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(diviver.snp.bottom).offset(scale(10))
            make.width.height.equalTo(scale(16))
        }
        contentView.addSubview(nickNameLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(addressLabel)
        
        nickNameLabel.snp.makeConstraints { make in
            make.left.equalTo(addressImage.snp.right).offset(scale(3))
            make.top.equalTo(diviver.snp.bottom).offset(scale(9))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(100))
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(nickNameLabel.snp.right).offset(scale(12))
            make.top.equalTo(diviver.snp.bottom).offset(scale(9))
            make.height.equalTo(scale(22))
            make.right.equalTo(-scale(16))
        }
        
        addressLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(34))
            make.right.equalTo(-scale(114))
            make.top.equalTo(nickNameLabel.snp.bottom).offset(scale(8))
            make.height.equalTo(scale(32))
        }
        
       contentView.addSubview(modifyBtn)
        
        modifyBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(addressLabel.snp.bottom).offset(scale(0))
            make.bottom.equalTo(-scale(20))
            make.width.equalTo(scale(60))
            make.height.equalTo(scale(26))
        }
        modifyBtn.layer.cornerRadius = scale(4)
        modifyBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        modifyBtn.layer.borderWidth = scale(1)
        
        
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
