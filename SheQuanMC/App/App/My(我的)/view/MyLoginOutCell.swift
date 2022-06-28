//
//  MyLoginOutCell.swift
//  App
//
//  Created by mac on 2022/6/28.
//

import UIKit
import Util

class MyLoginOutCell: UITableViewCell {
    
    lazy var loginOutBtn:UIButton = {
        let loginOutBtn = UIButton()
        loginOutBtn.setTitle("退出登录", for: .normal)
        loginOutBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        loginOutBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        loginOutBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return loginOutBtn
    }()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        contentView.addSubview(midView)
        midView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(8))
        }
        
        contentView.addSubview(loginOutBtn)
        loginOutBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(midView.snp.bottom)
            make.height.equalTo(scale(58))
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
