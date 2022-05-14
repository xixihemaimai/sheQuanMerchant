//
//  LogisticsInformationCell.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class LogisticsInformationCell: UITableViewCell {
    

    //发货方式
    lazy var deliveryMethodLabel:UILabel = {
       let deliveryMethodLabel = UILabel()
        deliveryMethodLabel.text = "发货方式"
        deliveryMethodLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        deliveryMethodLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        deliveryMethodLabel.textAlignment = .left
        return deliveryMethodLabel
    }()
    
    
    //内容
    lazy var deliveryContentLabel:UILabel = {
        let deliveryContentLabel = UILabel()
        deliveryContentLabel.text = "物流发货"
        deliveryContentLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        deliveryContentLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        deliveryContentLabel.textAlignment = .left
         return deliveryContentLabel
    }()
    
    //商品描述
    
    lazy var goodsDetailBtn:UIButton = {
       let goodsDetailBtn = UIButton()
        goodsDetailBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return goodsDetailBtn
    }()
    
    
    lazy var goodsDescribeLabel:UILabel = {
        let goodsDescribeLabel = UILabel()
        goodsDescribeLabel.text = "商品描述"
        goodsDescribeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        goodsDescribeLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        goodsDescribeLabel.textAlignment = .left
         return goodsDescribeLabel
    }()
    
    
    lazy var goodsDetailLabel:UILabel = {
       let goodsDetailLabel = UILabel()
        goodsDetailLabel.text = "请选择物流公司"
        goodsDetailLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        goodsDetailLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        goodsDetailLabel.textAlignment = .left
       return goodsDetailLabel
    }()
    

    
    //快递单号
    lazy var expressLabel:UILabel = {
        let expressLabel = UILabel()
        expressLabel.text = "快递单号"
        expressLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        expressLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        expressLabel.textAlignment = .left
        return expressLabel
    }()
    
    lazy var expressTextField:UITextField = {
      let expressTextField = UITextField()
        expressTextField.placeholder = "请输入快递单号"
        expressTextField.clearButtonMode = .whileEditing
        expressTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入快递单号", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#BFBFBF")])
        return expressTextField
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        contentView.addSubview(deliveryMethodLabel)
        contentView.addSubview(deliveryContentLabel)
        
        
        deliveryMethodLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(14))
            make.width.equalTo(scale(70))
            make.height.equalTo(scale(22))
        }
        
        deliveryContentLabel.snp.makeConstraints { make in
            make.left.equalTo(deliveryMethodLabel.snp.right).offset(scale(40))
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(14))
            make.height.equalTo(scale(22))
        }
        
        
        
        let firstView = UIView()
        firstView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        contentView.addSubview(firstView)
        
        
        firstView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalToSuperview()
            make.top.equalTo(deliveryMethodLabel.snp.bottom).offset(scale(14))
            make.height.equalTo(scale(0.5))
        }
        
        
        contentView.addSubview(goodsDetailBtn)
        goodsDetailBtn.addSubview(goodsDescribeLabel)
        goodsDetailBtn.addSubview(goodsDetailLabel)
        
        goodsDetailBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(firstView.snp.bottom)
            make.height.equalTo(scale(50))
        }
        
        
        let rightImage = UIImageView()
        rightImage.image = UIImage(named: "Frame-right")
        goodsDetailBtn.addSubview(rightImage)
        
        
        goodsDescribeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(70))
        }
        
        goodsDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(goodsDescribeLabel.snp.right).offset(scale(40))
            make.centerY.equalToSuperview()
            make.height.equalTo(scale(22))
            make.right.equalTo(-scale(80))
        }
        
        rightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
        }
        
        
        
        let secondView = UIView()
        secondView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        contentView.addSubview(secondView)
        
        
        secondView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalToSuperview()
            make.height.equalTo(scale(0.5))
            make.top.equalTo(goodsDetailBtn.snp.bottom)
        }
        
        
        contentView.addSubview(expressLabel)
        contentView.addSubview(expressTextField)
        
        expressLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(secondView.snp.bottom).offset(scale(14))
            make.width.equalTo(scale(70))
            make.height.equalTo(scale(22))
            make.bottom.equalTo(-scale(14))
        }
        
        expressTextField.snp.makeConstraints { make in
            make.left.equalTo(expressLabel.snp.right).offset(scale(40))
            make.height.equalTo(scale(22))
            make.right.equalTo(-scale(16))
            make.top.equalTo(secondView.snp.bottom).offset(scale(14))
            make.bottom.equalTo(-scale(14))
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
