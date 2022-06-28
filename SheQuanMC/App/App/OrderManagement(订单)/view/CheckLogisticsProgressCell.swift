//
//  CheckLogisticsProgressCell.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util

class CheckLogisticsProgressCell: UITableViewCell {
    
    
    //上边的uview
    
    lazy var topView:UIView = {
       let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return topView
    }()
    
    //中间UIview
    
    lazy var midView:UIView = {
       let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4")
        return midView
    }()
    
    //下边的UIview
    lazy var bottomView:UIView = {
       let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return bottomView
    }()
    
    
    //快递信息
    lazy var expressLabel:UILabel = {
       let expressLabel = UILabel()
        expressLabel.numberOfLines = 0
        expressLabel.textAlignment = .left
        expressLabel.text = "【发件】【福建省】快件离开【福建省厦门】"
        expressLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        expressLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return expressLabel
    }()
    
    
    //时间
    lazy var timeLabel:UILabel = {
       let timeLabel = UILabel()
        timeLabel.numberOfLines = 0
        timeLabel.textAlignment = .left
        timeLabel.text = "2022-03-02 19:15:23"
        timeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        timeLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return timeLabel
    }()
    
    
    
    var viewLogisticsListModel:ViewLogisticsListModel?{
        didSet{
            guard let _viewLogisticsListModel = viewLogisticsListModel else { return }
            
            let string = (_viewLogisticsListModel.trackStatus ?? "") + (_viewLogisticsListModel.trackName ?? "") + (_viewLogisticsListModel.trackStatusText ?? "")
            expressLabel.snp.remakeConstraints { make in
                make.left.equalTo(midView.snp.right).offset(scale(5))
                make.top.equalTo(scale(16))
                make.right.equalTo(-scale(16))
                make.height.equalTo(string.rectHeight(font: UIFont.systemFont(ofSize: scale(14), weight: .regular), size: CGSize(width: SCW - scale(50), height: CGFloat(MAXFLOAT))) + scale(10))
            }
            expressLabel.text = string
            timeLabel.text = _viewLogisticsListModel.trackTime
            
        }
    }
    
    
//    var first:String?{
//        didSet{
////            guard let _first = first else{return}
//
//
//
//            //这边重新获取文字高度
//
////            expressLabel.snp.makeConstraints { make in
////                make.left.equalTo(midView.snp.right).offset(scale(5))
////                make.top.equalTo(scale(16))
////                make.right.equalTo(-scale(16))
////                make.height.equalTo(scale(22))
////            }
//
//            let string = "【发件】【福建省】快件离开【福建省厦门】已发往【北京中转站】"
//
//            expressLabel.snp.remakeConstraints { make in
//                make.left.equalTo(midView.snp.right).offset(scale(5))
//                make.top.equalTo(scale(16))
//                make.right.equalTo(-scale(16))
//                make.height.equalTo(string.rectHeight(font: UIFont.systemFont(ofSize: scale(14), weight: .regular), size: CGSize(width: SCW - scale(50), height: CGFloat(MAXFLOAT))) + scale(10))
//            }
//
//            expressLabel.text = string
//
//
//            midView.snp.remakeConstraints { make in
//                make.left.equalTo(scale(18))
//                make.top.equalTo(topView.snp.bottom)
//                make.width.height.equalTo(scale(12))
//            }
//            midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
//            midView.layer.cornerRadius = scale(6)
//        }
//    }
    
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        contentView.addSubview(topView)
        contentView.addSubview(midView)
        contentView.addSubview(bottomView)

        contentView.addSubview(expressLabel)
        contentView.addSubview(timeLabel)
        
       
        
        topView.snp.makeConstraints { make in
            make.left.equalTo(scale(23))
            make.top.equalToSuperview()
            make.width.equalTo(scale(1))
            make.height.equalTo(scale(21))
        }
        
        midView.snp.makeConstraints { make in
            make.left.equalTo(scale(19.5))
            make.top.equalTo(topView.snp.bottom)
            make.width.height.equalTo(scale(8))
        }
        
        midView.layer.cornerRadius = scale(4)
        
        
        bottomView.snp.makeConstraints { make in
            make.left.equalTo(scale(23))
            make.bottom.equalToSuperview()
            make.top.equalTo(midView.snp.bottom)
            make.width.equalTo(scale(1))
        }
        
        
        expressLabel.snp.makeConstraints { make in
            make.left.equalTo(midView.snp.right).offset(scale(5))
            make.top.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(22)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(midView.snp.right).offset(scale(4))
            make.top.equalTo(expressLabel.snp.bottom)
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(17))
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
