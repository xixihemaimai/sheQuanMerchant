//
//  NoDeliveryCell.swift
//  App
//
//  Created by mac on 2022/5/12.
//

import UIKit
import Util

class NoDeliveryCell: UITableViewCell {
    
    lazy var regionView:UIView = {
       let regionView = UIView()
        regionView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return regionView
    }()
    
    lazy var regionLabel:UILabel = {
       let regionLabel = UILabel()
        regionLabel.numberOfLines = 0
        regionLabel.text = "北京市(保定市)"
        regionLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#000000")
        regionLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        regionLabel.textAlignment = .left
        return regionLabel
    }()
    
    lazy var cancelBtn:UIButton = {
       let cancelBtn = UIButton()
        cancelBtn.setBackgroundImage(UIImage(named: "关闭1 1"), for: .normal)
        return cancelBtn
    }()
    
    
    
    
    
    
    var addressText:String = "" {
        didSet{
           
            //这边获取高度
            
           var height = addressText.rectHeight(font: UIFont.systemFont(ofSize: scale(16), weight: .regular), size:CGSize(width:  SCW - scale(88), height: CGFloat(MAXFLOAT)))
            if height > 30{
                height += scale(10)
            }
            regionLabel.text = addressText
            
            regionLabel.snp.remakeConstraints { make in
                make.left.equalTo(scale(16))
                make.centerY.equalToSuperview()
                make.height.equalTo(height)
                make.right.equalTo(-scale(40))
                make.bottom.equalTo(-scale(15))
            }
            
        }
    }
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        
        
        contentView.addSubview(regionView)
        regionView.addSubview(regionLabel)
        
        regionView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.centerY.equalToSuperview()
            make.bottom.equalTo(-scale(4))
        }
        
        regionLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.height.equalTo(scale(22))
            make.right.equalTo(-scale(40))
            make.bottom.equalTo(-scale(15))
        }
        
        regionView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(20))
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
