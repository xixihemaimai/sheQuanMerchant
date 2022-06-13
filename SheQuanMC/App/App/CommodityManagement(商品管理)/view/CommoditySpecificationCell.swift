//
//  CommoditySpecificationCell.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util

protocol CommoditySpecificationCellDelegate:NSObjectProtocol{
    //清除那个cell，那个位置的index
    func deleteSaveListTagAndIndex(tag:Int,index:Int)
    //修改那个cell，那个位置的index 和value
    func modityTextfieldTagAndIndexAndValue(tag:Int,index:Int,value:String)
}


class CommoditySpecificationCell: UITableViewCell {
    
    weak var delegate:CommoditySpecificationCellDelegate?
    
    //规格名称
    lazy var specificationLabel:UILabel = {
       let specificationLabel = UILabel()
        specificationLabel.text = "颜色"
        specificationLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        specificationLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        specificationLabel.textAlignment = .left
        return specificationLabel
    }()
    
    //删除的按键
    lazy var deleteBtn:UIButton = {
       let deleteBtn = UIButton()
        deleteBtn.setTitle("删除", for: .normal)
        deleteBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#2882EB"), for: .normal)
        deleteBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return deleteBtn
    }()
    
    
    //规格值（可以最多20个）
    //这边添加一个UIView用来保存规格值
    lazy var specificationView:SpecificationValueView = {
       let specificationView = SpecificationValueView()
        return specificationView
    }()
    
    
    
    
    //添加按键
    lazy var addBtn:UIButton = {
       let addBtn = UIButton()
        addBtn.setTitle("添加", for: .normal)
        addBtn.setImage(UIImage(named: "Group 2759"), for: .normal)
        addBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        addBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        return addBtn
    }()
    
    
    
    //这边是保存数组
    var colorList:[Specs] = []{
        didSet{
            for view in specificationView.subviews {
                view.removeFromSuperview()
            }
            specificationView.showValueList = colorList
            specificationView.snp.updateConstraints { make in
                make.height.equalTo(CGFloat(colorList.count) * scale(44) + CGFloat(colorList.count) * scale(16) + scale(16))
            }
        }
    }
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //这边要显示有多少个
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        contentView.addSubview(specificationLabel)
        contentView.addSubview(deleteBtn)
        contentView.addSubview(specificationView)
        contentView.addSubview(addBtn)
        
        
        specificationLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(14))
            make.right.equalTo(-scale(150))
            make.height.equalTo(scale(22))
        }
        deleteBtn.snp.makeConstraints { make in
            make.top.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.width.equalTo(scale(50))
            make.height.equalTo(scale(25))
        }
        
        specificationView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(specificationLabel.snp.bottom)
            make.height.equalTo(0)
        }
        
        specificationView.delegate = self
        
        addBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(83))
            make.height.equalTo(scale(32))
            make.top.equalTo(specificationView.snp.bottom)
//            make.bottom.equalTo(-scale(16))
        }
        
        addBtn.layer.cornerRadius = scale(4)
        addBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#D6D6D6").cgColor
        addBtn.layer.borderWidth = scale(1)
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F4F4F4")
        contentView.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(scale(8))
            make.top.equalTo(addBtn.snp.bottom).offset(scale(16))
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


extension CommoditySpecificationCell:SpecificationValueViewDelegate{
    
    //删除需要的地方
    func deleteShowValueIndex(_ index: Int) {
        delegate?.deleteSaveListTagAndIndex(tag: tag, index: index)
    }
    
    
    
    
    func textfieldEditEndValueAndIndex(text: String, index: Int) {
        delegate?.modityTextfieldTagAndIndexAndValue(tag: tag, index: index, value: text)
    }
    
    
    
}
