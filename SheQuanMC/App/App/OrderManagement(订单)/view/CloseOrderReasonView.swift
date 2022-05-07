//
//  CloseOrderReasonView.swift
//  App
//
//  Created by mac on 2022/5/7.
//

import UIKit
import Util

class CloseOrderReasonView: UIView {

    lazy var tableview:UITableView = {
        let tableview = UITableView(frame: .zero, style: .plain)
        tableview.isScrollEnabled = false
        tableview.estimatedSectionFooterHeight = 0
        tableview.estimatedSectionHeaderHeight = 0
        tableview.separatorStyle = .none
        if #available(iOS 15.0, *){
            tableview.sectionHeaderTopPadding = 0
        }
        if #available(iOS 11.0, *){
            tableview.contentInsetAdjustmentBehavior = .never
        }
        return tableview
    }()
    
    //这边要进行修改这类的动作
    var cancelBlock:(()->Void)?
    
    var reasonList:[String] = [String]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
            
        
        let titleLabel = UILabel()
        titleLabel.text = "选择关闭订单理由"
        titleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        titleLabel.font = UIFont.systemFont(ofSize: scale(17), weight: .regular)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scale(15))
            make.width.equalTo(scale(150))
            make.height.equalTo(scale(24))
        }
        
        let cancelBtn = UIButton()
        cancelBtn.setBackgroundImage(UIImage(named: "关闭1 1"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelAddAction), for: .touchUpInside)
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(16))
            make.width.height.equalTo(scale(22))
        }
        
        
        addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(scale(15))
        }
        
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        tableview.delegate = self
        tableview.dataSource = self
        
        
        reasonList = ["无法联系上买家","买家误拍或重拍了","买家无诚意完成交易","已经缺货无法交易"]
        tableview.register(CloseOrderReasonCell.self, forCellReuseIdentifier: "CloseOrderReasonCell")
        
        //确定
        let sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        sureBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        sureBtn.addTarget(self, action: #selector(sureAction), for: .touchUpInside)
        addSubview(sureBtn)

        sureBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(-scale(34))
        }
        
        sureBtn.layer.cornerRadius = scale(4)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //取消
    @objc func cancelAddAction(cancelBtn:UIButton){
       cancelBlock!()
    }
    
    //确定
    @objc func sureAction(sureBtn:UIButton){
        
    }
    
    
    //选择关闭订单原因
    @objc func choiceCloseReasoonAction(choiceBtn:UIButton){
        for i in 0..<reasonList.count{
            let cell = tableview.cellForRow(at: IndexPath(row: i, section: 0)) as! CloseOrderReasonCell
            if choiceBtn.tag == i{
            }else{
                cell.choiceBtn.isSelected = false
            }
        }
        choiceBtn.isSelected = !choiceBtn.isSelected
    }
}

extension CloseOrderReasonView:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reasonList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CloseOrderReasonCell") as! CloseOrderReasonCell
        cell.reasonLabel.text = reasonList[indexPath.row]
        cell.choiceBtn.tag = indexPath.row
        cell.choiceBtn.addTarget(self, action: #selector(choiceCloseReasoonAction), for: .touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
