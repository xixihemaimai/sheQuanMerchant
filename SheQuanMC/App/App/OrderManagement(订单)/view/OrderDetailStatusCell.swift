//
//  OrderDetailStatusCell.swift
//  App
//
//  Created by mac on 2022/5/7.
//

import UIKit
import Util

class OrderDetailStatusCell: UITableViewCell {
    
    
    var sencondStr:Int64?
    var minitStr:Int64?
    var hourStr:Int64?
    var dayStr:Int64?
    var timer:Timer?
    var totalTime:String?
    
    var countdownComplete:(()->Void)?
    
    //状态
    lazy var orderStatusLabel:UILabel = {
       let orderStatusLabel = UILabel()
        orderStatusLabel.text = "待支付"
        orderStatusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        orderStatusLabel.font = UIFont.systemFont(ofSize: scale(20), weight: .semibold)
        orderStatusLabel.textAlignment = .left
        return orderStatusLabel
    }()
    
    
    //状态详情
    lazy var orderDetailStatusLabel:UILabel = {
       let orderDetailStatusLabel = UILabel()
        orderDetailStatusLabel.text = "退货退款中"
        orderDetailStatusLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#F13232")
        orderDetailStatusLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        orderDetailStatusLabel.textAlignment = .left
//        orderDetailStatusLabel.isHidden = true
        return orderDetailStatusLabel
    }()
    
    
    //时间或者信息
    lazy var timeLabel:UILabel = {
      let timeLabel = UILabel()
        //23时52分15秒未付款则自动关闭订单
        timeLabel.text = ""
        timeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#666666")
        timeLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        timeLabel.textAlignment = .left
      return timeLabel
    }()
    
    
    var orderInfoModel:OrederInfoModel?{
        didSet{
            guard let _orderInfoModel = orderInfoModel else { return }
            
            
            orderStatusLabel.text = _orderInfoModel.orderStatusText
            //这边添加一个倒计时的方法
            if (_orderInfoModel.refundingText?.count ?? 0) > 0{
                orderDetailStatusLabel.text = _orderInfoModel.refundingText
                orderDetailStatusLabel.isHidden = false
            }else{
                orderDetailStatusLabel.isHidden = true
            }
            if _orderInfoModel.orderStatus == 10{
                timer?.invalidate()
                timer = nil
//                orderStatusLabel.text = "待支付"
//                inputTimeAndEndTime(_orderInfoModel.orderTime ?? "", _orderInfoModel.payRemainingTime ?? "")
//                if _orderInfoModel.payRemainingTime != 0{
//                    inputEndTime(endTime: _orderInfoModel.payRemainingTime ?? 0)
//                }else{
//                    timeLabel.text = (totalTime ?? "0天0时0分0秒") + (_orderInfoModel.orderRemarks ?? "未付款则自动关闭订单")
//                }
                if _orderInfoModel.countDownTime != 0{
                    inputEndTime(endTime: _orderInfoModel.countDownTime ?? 0)
                }else{
                    timeLabel.text = (totalTime ?? "0天0时0分0秒") + (_orderInfoModel.orderRemarks ?? "未付款则自动关闭订单")
                }
            }else if _orderInfoModel.orderStatus == 20{
                timer?.invalidate()
                timer = nil
//                orderStatusLabel.text = "待发货"
                timeLabel.text = (_orderInfoModel.orderRemarks ?? "合理发货，请勿虚假发货，请及时发货")
//                "合理发货，请勿虚假发货，请及时发货"
            }else if _orderInfoModel.orderStatus == 21{
                timer?.invalidate()
                timer = nil
//                orderStatusLabel.text = "已发货"
//                inputTimeAndEndTime(_orderInfoModel.orderTime ?? "", _orderInfoModel.payRemainingTime ?? "")
//                if _orderInfoModel.payRemainingTime != 0{
//                    inputEndTime(endTime: _orderInfoModel.payRemainingTime ?? 0)
//                }else{
//                    timeLabel.text = (totalTime ?? "0天0时0分0秒") + (_orderInfoModel.orderRemarks ?? "后自动收货")
//                }
//                orderDetailStatusLabel.text = _orderInfoModel.refundingText
                if _orderInfoModel.countDownTime != 0{
                    inputEndTime(endTime: _orderInfoModel.countDownTime ?? 0)
                }else{
                    timeLabel.text = (totalTime ?? "0天0时0分0秒") + (_orderInfoModel.orderRemarks ?? "后自动收货")
                }
            }else if _orderInfoModel.orderStatus == 30{
                timer?.invalidate()
                timer = nil
//                orderStatusLabel.text = "交易成功"
                timeLabel.isHidden = true
                orderStatusLabel.snp.remakeConstraints { make in
                    make.left.equalTo(scale(19))
                    make.width.equalTo(scale(80))
                    make.height.equalTo(scale(28))
                    make.center.equalToSuperview()
                    make.bottom.equalTo(-scale(12))
                }
            }else if _orderInfoModel.orderStatus == 41{
                timer?.invalidate()
                timer = nil
//                orderStatusLabel.text = "交易关闭"
                timeLabel.text = _orderInfoModel.orderRemarks
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        contentView.addSubview(orderStatusLabel)
        contentView.addSubview(orderDetailStatusLabel)
        contentView.addSubview(timeLabel)
        
        orderStatusLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(19))
            make.width.equalTo(scale(120))
            make.top.equalTo(scale(12))
            make.height.equalTo(scale(28))
        }
        
        orderDetailStatusLabel.snp.makeConstraints { make in
            make.left.equalTo(orderStatusLabel.snp.right).offset(scale(8))
            make.top.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(20))
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(19))
            make.top.equalTo(orderStatusLabel.snp.bottom).offset(scale(4))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(20))
            make.bottom.equalTo(-scale(12))
        }
        
    }
    
    
    func inputEndTime(endTime:Int64){
        //毫秒转换
//        dayStr = Int(endTime)/24/60/60/1000
//        hourStr = (Int(endTime)/60/60/1000)%24
//        minitStr = (Int(endTime)/60/1000)%60
//        sencondStr = Int(endTime/1000)%60
        
        
        let hoursTemp = endTime / 1000 / 60 / 60
        let days = hoursTemp / 24
        let hours = (endTime - days * 24 * 60 * 60 * 1000) / 1000 / 60 / 60
        let minutes = (endTime - days * 24 * 60 * 60 * 1000 - hours * 60 * 60 * 1000) / 1000 / 60
        let seconds = (endTime - days * 24 * 60 * 60 * 1000 - hours * 60 * 60 * 1000 - minutes * 60 * 1000) / 1000
        dayStr = days
        hourStr = hours
        minitStr = minutes
        sencondStr = seconds
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    
    
//    func inputTimeAndEndTime(_ startTime:String,_ endTime:String){
//        // 输入时间
//        let startTime = startTime
//        let endTime = endTime
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let CTMZone = NSTimeZone.init(forSecondsFromGMT: 0)
//        formatter.timeZone = CTMZone as TimeZone
//        let startDate = formatter.date(from: startTime)
//        let endDate = formatter.date(from: endTime)
//        //接下来计算
//        let calender = Calendar.current
//        let unit:Set<Calendar.Component> = [.day,.hour,.minute,.second]
//        let commponent:DateComponents = calender.dateComponents(unit, from: startDate!, to: endDate!)
//        sencondStr = commponent.second
//        minitStr = commponent.minute
//        hourStr = commponent.hour
//        dayStr = commponent.day
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
//        RunLoop.main.add(timer!, forMode: .common)
//    }
    
    @objc func timerAction(){
        sencondStr! -= 1
        if sencondStr == -1{
           sencondStr = 59
           minitStr! -= 1
            if minitStr == -1{
                minitStr = 59
                hourStr! -= 1
                if hourStr == -1{
                    hourStr = 23
                    dayStr! -= 1
                }
            }
        }
        if sencondStr == 0 && minitStr! == 0 && hourStr == 0 && dayStr == 0{
            timer?.invalidate()
            timer = nil
            countdownComplete?()
        }
        totalTime = "\(dayStr ?? 0)天\(hourStr ?? 0)时\(minitStr ?? 0)分\(sencondStr ?? 0)秒"
        if sencondStr == 0 && minitStr == 0 && hourStr == 0 && dayStr == 0{
            timer?.invalidate()
            timer = nil
            countdownComplete?()
        }
        if self.orderInfoModel?.orderStatus == 10{
            timeLabel.text = (totalTime ?? "0天0时0分0秒") + "未付款则自动关闭订单"
        }else{
            timeLabel.text = (totalTime ?? "0天0时0分0秒") + "后自动收货"
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

