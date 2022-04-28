//
//  commodityStatusCell.swift
//  App
//
//  Created by mac on 2022/4/28.
//

import UIKit
import Util

class commodityStatusCell: UITableViewCell {
    
    //图片
    lazy var goodsImageView:UIImageView = {
       let goodsImageView = UIImageView()
        goodsImageView.image = UIImage(named: "Rectangle 2363")
        return goodsImageView
    }()
    
    //商品介绍
    lazy var goodsIntroductLabel:UILabel = {
       let goodsIntroductLabel = UILabel()
        goodsIntroductLabel.numberOfLines = 2
        goodsIntroductLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        goodsIntroductLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        goodsIntroductLabel.textAlignment = .left
        goodsIntroductLabel.lineBreakMode = .byCharWrapping
        goodsIntroductLabel.text = "商品名称Nike耐克官方AIR MONARCHIV男子训练鞋运懂老爹鞋休闲鞋"
        return goodsIntroductLabel
    }()
    
    //累计销售或者是商品规格
    lazy var goodSpeciLabel:UILabel = {
       let goodSpeciLabel = UILabel()
        goodSpeciLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        goodSpeciLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        goodSpeciLabel.textAlignment = .left
        goodSpeciLabel.text = "商品规格: 蓝色"
        return goodSpeciLabel
    }()
    
    
    
    
    //库存余量
    lazy var stockLabel:UILabel = {
       let stockLabel = UILabel()
        stockLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F13232")
        stockLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        stockLabel.textAlignment = .left
        stockLabel.text = "库存余量:0"
        return stockLabel
    }()
    //分割线
    
    lazy var diviver:UIView = {
       let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return diviver
    }()
    
    
    //编辑按键
    lazy var editBtn:UIButton = {
       let editBtn = UIButton()
        editBtn.setTitle("编辑", for: .normal)
        editBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        editBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        editBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        editBtn.layer.borderWidth = scale(1)
        editBtn.layer.cornerRadius = scale(4)
        return editBtn
    }()
    
    
    //上架和下架按键
    lazy var downBtn:UIButton = {
       let downBtn = UIButton()
        downBtn.setTitle("下架", for: .normal)
        downBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        downBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        downBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        downBtn.layer.borderWidth = scale(1)
        downBtn.layer.cornerRadius = scale(4)
        return downBtn
    }()
    //补库存，删除按键
    lazy var stockBtn:UIButton = {
       let stockBtn = UIButton()
        stockBtn.setTitle("补库存", for: .normal)
        stockBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        stockBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        stockBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        stockBtn.layer.borderWidth = scale(1)
        stockBtn.layer.cornerRadius = scale(4)
        return stockBtn
    }()
    //下方的分割view
    lazy var bottomView:UIView = {
       let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
       return bottomView
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        contentView.addSubview(goodsImageView)
        contentView.addSubview(goodsIntroductLabel)
        contentView.addSubview(goodSpeciLabel)
        contentView.addSubview(stockLabel)
        contentView.addSubview(diviver)
        contentView.addSubview(editBtn)
        contentView.addSubview(downBtn)
        contentView.addSubview(stockBtn)
        contentView.addSubview(bottomView)
        
        goodsImageView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(16))
            make.width.height.equalTo(scale(78))
        }
        
        goodsImageView.layer.cornerRadius = scale(2)
        
        
        goodsIntroductLabel.snp.makeConstraints { make in
            make.left.equalTo(goodsImageView.snp.right).offset(scale(12))
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(16))
            make.height.equalTo(scale(40))
        }

        
        goodSpeciLabel.snp.makeConstraints { make in
            make.left.equalTo(goodsImageView.snp.right).offset(scale(12))
            make.top.equalTo(goodsIntroductLabel.snp.bottom).offset(scale(8))
            make.height.equalTo(scale(17))
            make.width.equalTo(scale(100))
        }
        
        
        //这个库存为0的时候显示是红色的#F13232，有库存的时候显示#999999
        stockLabel.snp.makeConstraints { make in
            make.top.equalTo(goodsIntroductLabel.snp.bottom).offset(scale(8))
            make.left.equalTo(goodSpeciLabel.snp.right).offset(scale(58))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(17))
        }
        
        
        diviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(goodsImageView.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(0.5))
        }
        
        editBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(diviver.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(60))
            make.height.equalTo(scale(26))
        }
        
        
        downBtn.snp.makeConstraints { make in
            make.top.equalTo(diviver.snp.bottom).offset(scale(12))
            make.right.equalTo(editBtn.snp.left).offset(-scale(12))
            make.width.equalTo(scale(60))
            make.height.equalTo(scale(26))
        }
        
        stockBtn.snp.makeConstraints { make in
            make.top.equalTo(diviver.snp.bottom).offset(scale(12))
            make.right.equalTo(downBtn.snp.left).offset(-scale(12))
            make.width.equalTo(scale(74))
            make.height.equalTo(scale(26))
        }
        
        
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(editBtn.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(8))
            make.bottom.equalToSuperview()
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
