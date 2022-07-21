//
//  CapitalFlowViewController.swift
//  App
//
//  Created by mac on 2022/7/21.
//

import UIKit
import Util

class CapitalFlowViewController: BaseViewController {
    
    
    lazy var tradeTypeView: MingXiTradeTypeView = {
        let tradeTypeView = MingXiTradeTypeView()
        return tradeTypeView
    }()
    
    
    lazy var topView:UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return topView
    }()
    
    
    lazy var allBtn:UIButton = {
        let allBtn = UIButton()
        allBtn.setTitle("全部", for: .normal)
        allBtn.setImage(UIImage(named: "Group 2736"), for: .normal)
        allBtn.setImagePostion(type: .imageRight, Space: scale(5))
        allBtn.contentHorizontalAlignment = .left
        allBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(15), weight: .semibold)
        allBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        return allBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "资金流水"
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
       
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(48))
        }
        
        topView.addSubview(allBtn)
        allBtn.addTarget(self, action: #selector(choiceStatusAction), for: .touchUpInside)
        allBtn.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(scale(16))
            make.width.equalTo(scale(100))
        }
        
        let calendarBtn = UIButton()
        calendarBtn.setImage(UIImage(named: "日历 1"), for: .normal)
        calendarBtn.setImagePostion(type: .imageRight, Space: scale(77))
        topView.addSubview(calendarBtn)
        
        calendarBtn.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.equalTo(scale(100))
        }
        
        calendarBtn.addTarget(self, action: #selector(choiceCalendarAction), for: .touchUpInside)
        
        
        let midView = UIView()
        midView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        view.addSubview(midView)
        midView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.height.equalTo(scale(8))
        }
        
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(midView.snp.bottom)
        }
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        tableview.register(CapitalFlowCell.self, forCellReuseIdentifier: "CapitalFlowCell")
        tableview.register(CapitalFlowHeaderView.self, forHeaderFooterViewReuseIdentifier: "CapitalFlowHeaderView")
    }
    
    
    
    //选择日历
    @objc func choiceCalendarAction(calendarBtn:UIButton){
        let year = Int(Date().getString(format: "yyyy"))! - 2
        let newYear = String(year)
        let datePicker = YBDatePicker(currentDate: Date(), minLimitDate: Date.getDate(dateStr:newYear + "-01", format:"yyyy-MM"), maxLimitDate: Date(), datePickerType:.YM) {[weak self] date in
            LXFLog("=---------------------------\(date)")
        }
        datePicker.show()
        tradeTypeView.onClickTradeTypeView()
    }
    
    //选择状态
    @objc func choiceStatusAction(allBtn:UIButton){
        if tradeTypeView.superview == nil {
            view.addSubview(tradeTypeView)
            tradeTypeView.snp.makeConstraints { make in
                make.top.equalTo(topView.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            }
            tradeTypeView.setDefaultSelect(title: allBtn.currentTitle ?? "")
            tradeTypeView.callback = { [weak self] statusTitle,type in
                self?.allBtn.setTitle(statusTitle, for: .normal)
                self?.allBtn.setImagePostion(type: .imageRight, Space: scale(4))
            }
        } else {
            tradeTypeView.onClickTradeTypeView()
        }
    }

}

extension CapitalFlowViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return scale(46)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CapitalFlowHeaderView") as! CapitalFlowHeaderView
        return header
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CapitalFlowCell") as! CapitalFlowCell
        cell.tag = indexPath.section
        cell.delegate = self
        cell.model = ["1","2","3"]
        return cell
    }
    
    
}


extension CapitalFlowViewController:CapitalFlowCellDelegate{
    func clickIndexpathColomAndRow(_ colom: Int, _ row: Int) {
        LXFLog("+============\(colom)===========\(row)")
    }
    
}



class MingXiTradeTypeView: UIButton {
    
    static let arr = ["全部","交易收入", "退款", "提现", "充值余额", "充值保证金", "发红包"]
    let types = [0, 100, 200, 300, 400, 500,600]
    var callback:((_ statusTitle:String,_ types:Int)->Void)?
    lazy var content: UIView = {
        let content = UIView()
        return content
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        addTarget(self, action: #selector(onClickTradeTypeView), for: UIControl.Event.touchUpInside)
        
        addSubview(content)
        content.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        content.backgroundColor = .white
        for (index, item) in MingXiTradeTypeView.arr.enumerated() {
            let btn1 = UIButton()
            content.addSubview(btn1)
            btn1.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(scale(44) * CGFloat(index))
                make.height.equalTo(scale(44))
                if (index == MingXiTradeTypeView.arr.count - 1) {
                    make.bottom.equalToSuperview()
                }
            }
            btn1.tag = index
            btn1.addTarget(self, action: #selector(onClickTrade(_:)), for: UIControl.Event.touchUpInside)
            let label1 = UILabel()
            btn1.addSubview(label1)
            label1.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(scale(15))
                make.centerY.equalToSuperview()
            }
//            label1.textColor = .hex(0x333333)
            label1.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
            label1.font = .systemFont(ofSize: scale(15))
            label1.text = item
            let selectView = UIImageView()
            btn1.addSubview(selectView)
            selectView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-scale(15))
            }
            selectView.image = .init(named: "选中 1")
            selectView.isHidden = true
            selectView.tag = 100
            let divider1 = UIView()
            btn1.addSubview(divider1)
            divider1.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(scale(0.5))
            }
            divider1.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        }
        
    }
    
    @objc func onClickTradeTypeView() -> Void {
        removeFromSuperview()
    }
    
    func setDefaultSelect(title: String) -> Void {
        let index = MingXiTradeTypeView.arr.firstIndex(of: title)
//        ,let btn = content.subviews[index],let imgView = btn.viewWithTag(100){
//            imgView.isHidden = false
//        }
        let btn = content.subviews[index ?? 0]
        let imgView = btn.viewWithTag(100)
        imgView?.isHidden = false
    }
    
    @objc func onClickTrade(_ s: UIButton) -> Void {
        for item in content.subviews {
            if let imgView = item.viewWithTag(100) {
                imgView.isHidden = true
            }
        }
        s.viewWithTag(1)?.isHidden = false
        if let _callback = callback {
            _callback(MingXiTradeTypeView.arr[s.tag], types[s.tag])
//            _callback(true, ["title": MingXiTradeTypeView.arr[s.tag] ?? "",
//                             "type": types[s.tag] ?? 0])
        }
        onClickTradeTypeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
