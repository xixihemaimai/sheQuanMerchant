//
//  ReplenishInventoryCell.swift
//  App
//
//  Created by mac on 2022/4/28.
//

import UIKit
import Util

class ReplenishInventoryCell: UITableViewCell {
    
    //规格名称
    lazy var replenishNameLabel:UILabel = {
       let replenishNameLabel = UILabel()
        replenishNameLabel.text = "蓝色"
        replenishNameLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        replenishNameLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        replenishNameLabel.textAlignment = .left
        return replenishNameLabel
    }()
    
    //分割线
    lazy var diviver:UIView = {
       let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return diviver
    }()
    
    //增加库存
    lazy var addlabel:UILabel = {
       let addlabel = UILabel()
        addlabel.text = "增加库存"
        addlabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        addlabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addlabel.textAlignment = .left
        return addlabel
    }()
    
    //输入的值
    lazy var addTextField:UITextField = {
       let addTextField = UITextField()
        addTextField.placeholder = "请输入"
        addTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        addTextField.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return addTextField
    }()
    
    //一个分割UIView
    lazy var bottomView:UIView = {
       let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
       return bottomView
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        contentView.addSubview(replenishNameLabel)
        contentView.addSubview(diviver)
        contentView.addSubview(addlabel)
        contentView.addSubview(addTextField)
        contentView.addSubview(bottomView)
        
        replenishNameLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(14))
            make.height.equalTo(scale(22))
        }
        
        diviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalToSuperview()
            make.top.equalTo(replenishNameLabel.snp.bottom).offset(scale(14))
            make.height.equalTo(scale(0.5))
        }
        
        addlabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(diviver.snp.bottom).offset(scale(14))
            make.height.equalTo(scale(22))
            make.width.equalTo(scale(75))
        }
        
        addTextField.snp.makeConstraints { make in
            make.left.equalTo(addlabel.snp.right).offset(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(diviver.snp.bottom).offset(scale(14))
            make.height.equalTo(scale(22))
        }
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(addlabel.snp.bottom).offset(scale(14))
            make.height.equalTo(scale(4))
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
