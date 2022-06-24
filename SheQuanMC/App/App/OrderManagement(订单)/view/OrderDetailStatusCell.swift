//
//  OrderDetailStatusCell.swift
//  App
//
//  Created by mac on 2022/5/7.
//

import UIKit
import Util

class OrderDetailStatusCell: UITableViewCell {
    
    
    var sencondStr:Int?
    var minitStr:Int?
    var hourStr:Int?
    var dayStr:Int?
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
        orderDetailStatusLabel.isHidden = true
        return orderDetailStatusLabel
    }()
    
    
    //时间或者信息
    lazy var timeLabel:UILabel = {
      let timeLabel = UILabel()
        timeLabel.text = "23时52分15秒未付款则自动关闭订单"
        timeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#666666")
        timeLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        timeLabel.textAlignment = .left
      return timeLabel
    }()
    
    
    var orderInfoModel:OrederInfoModel?{
        didSet{
            guard let _orderInfoModel = orderInfoModel else { return }
            //这边添加一个倒计时的方法
            
            if _orderInfoModel.orderStatus == 10{
                orderStatusLabel.text = "待支付"
                inputTimeAndEndTime(_orderInfoModel.orderTime ?? "", _orderInfoModel.payRemainingTime ?? "")
                timeLabel.text = totalTime! + "未付款则自动关闭订单"
            }else if _orderInfoModel.orderStatus == 20{
                orderStatusLabel.text = "待发货"
                timeLabel.text = "合理发货，请勿虚假发货，请及时发货"
            }else if _orderInfoModel.orderStatus == 21{
                orderStatusLabel.text = "已发货"
                inputTimeAndEndTime(_orderInfoModel.orderTime ?? "", _orderInfoModel.payRemainingTime ?? "")
                timeLabel.text = totalTime! + "后自动收货"
            }else if _orderInfoModel.orderStatus == 30{
                orderStatusLabel.text = "交易成功"
                timeLabel.isHidden = true
                orderStatusLabel.snp.remakeConstraints { make in
                    make.left.equalTo(scale(19))
                    make.width.equalTo(scale(80))
//                    make.top.equalTo(scale(12))
                    make.height.equalTo(scale(28))
                    make.center.equalToSuperview()
                    make.bottom.equalTo(-scale(12))
                }
            }else if _orderInfoModel.orderStatus == 41{
                orderStatusLabel.text = "交易关闭"
                timeLabel.text = "失败的原因"
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
            make.width.equalTo(scale(80))
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
    
    
    
    
    func inputTimeAndEndTime(_ startTime:String,_ endTime:String){
        
        // 输入时间
        let startTime = startTime
        let endTime = endTime
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        let CTMZone = NSTimeZone.init(forSecondsFromGMT: 0)
//        formatter.timeZone = timeZone! as TimeZone
        formatter.timeZone = CTMZone as TimeZone
        
        
//        let timeDate = formatter.date(from: dateString)
        
        
        let startDate = formatter.date(from: startTime)
        let endDate = formatter.date(from: endTime)

//        let late1 = (startDate?.timeIntervalSince1970 ?? 0) * 1
    
//        let late2 = (endDate?.timeIntervalSince1970 ?? 0) * 1
        
//        let timeInterVal = late2 - late1
        
        
        
        //结束的时间
//        let timeFormatter = DateFormatter()
//        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //注意这里将时间以秒为单位 如一天：24*60*60
//        let time = 15*24*60*60 - 60*60
//        timeDate.addTimeInterval(TimeInterval(time))
        
        
//        let time = 4*60*60 - 60*60
//        LXFLog(time)
//        let futureDate = startDate?.addingTimeInterval(TimeInterval(time))
//
//
//        //接下来计算
        let calender = Calendar.current
        let unit:Set<Calendar.Component> = [.day,.hour,.minute,.second]
        let commponent:DateComponents = calender.dateComponents(unit, from: startDate!, to: endDate!)

        sencondStr = commponent.second
        minitStr = commponent.minute
        hourStr = commponent.hour
        dayStr = commponent.day

        
//
//        sencondStr = Int(timeInterVal) % 60
//
//        minitStr = Int(timeInterVal) / 60 % 60
//
//        hourStr = Int(timeInterVal) / 3600 - 1
//
//        dayStr = Int(timeInterVal) % (24 * 3600)

        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
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
//        LXFLog(totalTime)
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

