//
//  commodityExamineCell.swift
//  App
//
//  Created by mac on 2022/4/28.
//

import UIKit
import Util

class commodityExamineCell: UITableViewCell {
    
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
    
    //申请时间
    lazy var applyTimeLabel:UILabel = {
      let applyTimeLabel = UILabel()
        applyTimeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#999999")
        applyTimeLabel.font = UIFont.systemFont(ofSize: scale(12), weight: .regular)
        applyTimeLabel.textAlignment = .left
        applyTimeLabel.text = "申请时间：2022-02-15 14:45"
        return applyTimeLabel
    }()
    
    //分割线
    lazy var diviver:UIView = {
       let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        return diviver
    }()
    //背景颜色
    lazy var statusView:UIView = {
       let statusView = UIView()
        statusView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F2F2F2")
        return statusView
    }()
    
    //审核中的
    lazy var statusLabel:UILabel = {
       let statusLabel = UILabel()
        statusLabel.textAlignment = .left
        statusLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        statusLabel.text = "审核中"
        statusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#666666")
        return statusLabel
    }()
    //审核中和已驳回的原因
    lazy var reasonLabel:UILabel = {
       let reasonLabel = UILabel()
        reasonLabel.textAlignment = .left
        reasonLabel.numberOfLines = 0
        reasonLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        reasonLabel.text = "预计2个工作日内反馈申请结果"
        reasonLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#666666")
        return reasonLabel
    }()
    
    //取消按键
    lazy var cancelBtn:UIButton = {
       let cancelBtn = UIButton()
        cancelBtn.setTitle("取消申请", for: .normal)
        cancelBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        cancelBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        cancelBtn.layer.borderWidth = scale(1)
        cancelBtn.layer.cornerRadius = scale(4)
        return cancelBtn
    }()
    
    //删除按键deleteBtn
    lazy var deleteBtn:UIButton = {
       let deleteBtn = UIButton()
        deleteBtn.setTitle("删除", for: .normal)
        deleteBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        deleteBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        deleteBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        deleteBtn.layer.borderWidth = scale(1)
        deleteBtn.layer.cornerRadius = scale(4)
        return deleteBtn
    }()
    
    //编辑按键 editBtn
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
    
    //分界面
    //下方的分割view
    lazy var bottomView:UIView = {
       let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
       return bottomView
    }()
    
    
    var model:productListModel?{
        didSet{
            guard let _model = model else { return }
            goodsImageView.sd_setImage(with: URL(string: _model.productPic ?? ""), placeholderImage: UIImage(named: "Group 2784"))
            goodsIntroductLabel.text = _model.productName
            applyTimeLabel.text = "申请时间:" + (_model.applyTime ?? "")
            
            if _model.auditStatus == 4 {
                //审核失败
                deleteBtn.isHidden = false
                editBtn.isHidden = false
                cancelBtn.isHidden = true
                statusLabel.text = "已驳回"
                reasonLabel.text = (_model.rejectType ?? "") + " " + (_model.auditOpinion ?? "")
                var height = reasonLabel.text?.rectHeight(font: UIFont.systemFont(ofSize: scale(13), weight: .regular), size: CGSize(width: SCW - scale(126), height: scale(20)))
                if (height ?? scale(15)) < scale(15){
                    height = scale(15)
                }else{
                    height! += scale(30)
                }
                reasonLabel.snp.remakeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.left.equalTo(statusLabel.snp.right).offset(scale(12))
                    make.right.equalTo(-scale(16))
                    make.height.equalTo(height!)
                }

                statusView.snp.remakeConstraints { make in
                    make.left.equalTo(scale(16))
                    make.right.equalTo(-scale(16))
                    make.top.equalTo(diviver.snp.bottom).offset(scale(12))
                    make.height.equalTo(height! + scale(8))
                }
                
                
                statusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F13232")
            }else{
                
                
                
                //审核中
                deleteBtn.isHidden = true
                editBtn.isHidden = true
                cancelBtn.isHidden = false
                statusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#666666")
                statusLabel.text = "审核中"
                reasonLabel.text = _model.auditOpinion
                
                
//                let height = reasonLabel.text?.rectHeight(font: UIFont.systemFont(ofSize: scale(13), weight: .regular), size: CGSize(width: SCW - scale(110), height: scale(20)))
//                LXFLog("=========2=============\(height)")
            }
        }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        contentView.addSubview(goodsImageView)
        contentView.addSubview(goodsIntroductLabel)
        contentView.addSubview(applyTimeLabel)
        contentView.addSubview(diviver)
        contentView.addSubview(statusView)
        statusView.addSubview(statusLabel)
        statusView.addSubview(reasonLabel)
        
        contentView.addSubview(cancelBtn)
        contentView.addSubview(deleteBtn)
        contentView.addSubview(editBtn)
        contentView.addSubview(bottomView)
        
        
        goodsImageView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(16))
            make.width.height.equalTo(scale(78))
        }
        
        goodsImageView.layer.cornerRadius = scale(2)
        goodsImageView.layer.borderWidth = scale(0.5)
        goodsImageView.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0").cgColor
        goodsImageView.contentMode = .scaleAspectFill
        goodsImageView.layer.masksToBounds = true
        
        goodsIntroductLabel.snp.makeConstraints { make in
            make.left.equalTo(goodsImageView.snp.right).offset(scale(12))
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(16))
            make.height.equalTo(scale(40))
        }
        
        applyTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(goodsImageView.snp.right).offset(scale(12))
            make.top.equalTo(goodsIntroductLabel.snp.bottom).offset(scale(8))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(17))
        }
        
        diviver.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(goodsImageView.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(0.5))
        }
        
        
        statusView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(diviver.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(28))
        }
        
        statusView.layer.cornerRadius = scale(4)
        
        statusLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(50))
            make.height.equalTo(scale(20))
        }
        
        reasonLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(statusLabel.snp.right).offset(scale(12))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(20))
        }
        
        
        cancelBtn.snp.makeConstraints { make in
            make.top.equalTo(statusView.snp.bottom).offset(scale(16))
            make.right.equalTo(-scale(16))
            make.width.equalTo(scale(88))
            make.height.equalTo(scale(26))
        }
        
        
        editBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(statusView.snp.bottom).offset(scale(12))
            make.width.equalTo(scale(60))
            make.height.equalTo(scale(26))
        }
        
        deleteBtn.snp.makeConstraints { make in
            make.top.equalTo(statusView.snp.bottom).offset(scale(12))
            make.right.equalTo(editBtn.snp.left).offset(-scale(12))
            make.width.equalTo(scale(60))
            make.height.equalTo(scale(26))
        }
        
        
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(statusView.snp.bottom).offset(scale(57))
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
