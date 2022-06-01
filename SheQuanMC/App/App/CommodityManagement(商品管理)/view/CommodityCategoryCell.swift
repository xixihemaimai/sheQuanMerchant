//
//  CommodityCategoryCell.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util

class CommodityCategoryCell: UITableViewCell {
    
    //选择按键
    lazy var choiceBtn:UIButton = {
       let choiceBtn = UIButton()
        choiceBtn.isUserInteractionEnabled = false
        choiceBtn.setBackgroundImage(UIImage(named: "Ellipse 38"), for: .normal)
        choiceBtn.setBackgroundImage(UIImage(named: "Group 2742"), for: .selected)
        return choiceBtn
    }()
    
    //类目
    lazy var categoryLabel:UILabel = {
       let categoryLabel = UILabel()
        categoryLabel.text = "彩妆/香水/美妆工具"
        categoryLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        categoryLabel.textAlignment = .left
        categoryLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        return categoryLabel
    }()
    
    //分割线
    lazy var diviver:UIView = {
       let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#D9D9D9")
        return diviver
    }()
    
    
    
    var model:BussinessSecondTypeModel?{
        didSet{
            guard let _model = model else { return }
            categoryLabel.text = model?.categoryName
        }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        contentView.addSubview(choiceBtn)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(diviver)
        
        
        
        choiceBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.width.height.equalTo(scale(16))
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(choiceBtn.snp.right).offset(scale(8))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
        }
        
        diviver.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(scale(0.5))
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
