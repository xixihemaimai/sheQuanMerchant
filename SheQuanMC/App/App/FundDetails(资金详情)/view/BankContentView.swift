//
//  BankContentView.swift
//  App
//
//  Created by mac on 2022/7/21.
//

import UIKit
import Util


protocol BankContentViewDelegate:NSObjectProtocol{
    
    func clickBankFlowIndex(_ index:Int)
    
}



class BankContentView: UIView {

    var delegate:BankContentViewDelegate?
    
    
    var bankList:[String]?{
        didSet{
            guard let _model = bankList else { return }
            
            for i in 0..<_model.count {
                let bankBtn = UIButton()
                bankBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
                addSubview(bankBtn)
                bankBtn.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.top.equalTo(CGFloat(i) * scale(72))
                    make.height.equalTo(scale(72))
                }
                bankBtn.tag = i
                bankBtn.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
                
                let bankImage = UIImageView()
                bankImage.image = UIImage(named: "Group 2784")
                bankBtn.addSubview(bankImage)
                bankImage.snp.makeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.left.equalTo(scale(16))
                    make.width.height.equalTo(scale(40))
                }
                
                let bankStatusLabel = UILabel()
                bankStatusLabel.text = "提现—建设银行（5522）"
                bankStatusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
                bankStatusLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
                bankStatusLabel.textAlignment = .left
                bankBtn.addSubview(bankStatusLabel)
                
                bankStatusLabel.snp.makeConstraints { make in
                    make.left.equalTo(bankImage.snp.right).offset(scale(12))
                    make.top.equalTo(scale(16))
                    make.height.equalTo(scale(20))
                    make.right.equalTo(-scale(100))
                }
                
                
                let timeLabel = UILabel()
                timeLabel.text = "16:58:00"
                timeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
                timeLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
                timeLabel.textAlignment = .left
                bankBtn.addSubview(timeLabel)
                
                timeLabel.snp.makeConstraints { make in
                    make.left.equalTo(bankImage.snp.right).offset(scale(12))
                    make.top.equalTo(bankStatusLabel.snp.bottom).offset(scale(3))
                    make.height.equalTo(scale(20))
                    make.right.equalTo(-scale(200))
                }
                
                
                let priceLabel = UILabel()
                priceLabel.text = "-99.00"
                priceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
                priceLabel.font = UIFont.systemFont(ofSize: scale(18), weight: .regular)
                priceLabel.textAlignment = .right
                bankBtn.addSubview(priceLabel)
                
                priceLabel.snp.makeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.width.equalTo(scale(150))
                    make.height.equalTo(scale(25))
                    make.right.equalTo(-scale(16))
                }
                
                
                let midView = UIView()
                midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
                bankBtn.addSubview(midView)
                midView.snp.makeConstraints { make in
                    make.left.equalTo(scale(68))
                    make.right.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.height.equalTo(scale(0.5))
                }
            }
        }
    }
    
    
    @objc func clickAction(bankBtn:UIButton){
        delegate?.clickBankFlowIndex(bankBtn.tag)
    }
    
    
}
