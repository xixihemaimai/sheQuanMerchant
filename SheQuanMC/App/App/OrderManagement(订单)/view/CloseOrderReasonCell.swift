//
//  CloseOrderReasonCell.swift
//  App
//
//  Created by mac on 2022/5/7.
//

import UIKit
import Util



class CloseOrderReasonCell: UITableViewCell {
    
    
    lazy var diviver:UIView = {
       let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return diviver
    }()
    
    
    
    lazy var reasonLabel:UILabel = {
       let reasonLabel = UILabel()
        reasonLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        reasonLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        reasonLabel.textAlignment = .left
        return reasonLabel
    }()
    
    
    
    lazy var choiceBtn:UIButton = {
       let choiceBtn = UIButton()
        choiceBtn.isUserInteractionEnabled = false
        choiceBtn.setBackgroundImage(UIImage(named: "Ellipse 38"), for: .normal)
        choiceBtn.setBackgroundImage(UIImage(named: "Group 2742"), for: .selected)
        return choiceBtn
    }()
    
    
    
    var model:BrandModel?{
        didSet{
            guard let _model = model else {
                return
            }
            reasonLabel.text = _model.brandName
        }
    }
    
    var modelCloseReason:CloseOrderTypeRspModel?{
        didSet{
            guard let _model = modelCloseReason else {
                return
            }
            reasonLabel.text = _model.closeReason
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        contentView.addSubview(diviver)
        contentView.addSubview(reasonLabel)
        contentView.addSubview(choiceBtn)
        
        diviver.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        reasonLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(120))
            make.height.equalTo(scale(22))
        }
        
        choiceBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.centerY.equalToSuperview()
            make.width.height.equalTo(scale(16))
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
