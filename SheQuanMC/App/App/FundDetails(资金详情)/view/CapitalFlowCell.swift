//
//  CapitalFlowCell.swift
//  App
//
//  Created by mac on 2022/7/21.
//

import UIKit
import Util

protocol CapitalFlowCellDelegate:NSObjectProtocol{
    func clickIndexpathColomAndRow(_ colom:Int,_ row:Int)
}


class CapitalFlowCell: UITableViewCell {
    
    var delegate:CapitalFlowCellDelegate?
    
    lazy var calendarLabel:UILabel = {
       let calendarLabel = UILabel()
        calendarLabel.text = "    1月31日"
        calendarLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        calendarLabel.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        calendarLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .semibold)
        calendarLabel.textAlignment = .left
        return calendarLabel
    }()
    

    lazy var bankContentView:BankContentView = {
       let bankContentView = BankContentView()
        bankContentView.delegate = self
        return bankContentView
    }()
    
    var model:[String]?{
        didSet{
            guard let _model = model else { return }
            for view in bankContentView.subviews {
                view.removeFromSuperview()
            }
            bankContentView.bankList = _model
            bankContentView.snp.updateConstraints { make in
                make.height.equalTo(CGFloat(_model.count) * scale(72))
            }
        }
    }
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        
        contentView.addSubview(calendarLabel)
        calendarLabel.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(46))
        }
        
        contentView.addSubview(bankContentView)
        bankContentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(calendarLabel.snp.bottom)
            make.height.equalTo(0)
            make.bottom.equalTo(-scale(8))
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

extension CapitalFlowCell:BankContentViewDelegate{
    
    func clickBankFlowIndex(_ index: Int) {
        LXFLog("+======================\(index)")
        delegate?.clickIndexpathColomAndRow(self.tag, index)
        
    }

}
