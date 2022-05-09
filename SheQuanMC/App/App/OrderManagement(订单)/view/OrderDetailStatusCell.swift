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
        
        
        
        //这边添加一个倒计时的方法
        inputTimeAndEndTime("2022-05-09 18:00:00", "2022-05-10 18:00:00")
//        timeLabel.text = "\(totalTime)" + "未付款则自动关闭订单"
        
    }
    
    
    
    
    func inputTimeAndEndTime(_ input:String,_ endTime:String){
        
        // 输入时间
        let dateString = input
        let formatter = DateFormatter()
        let timeZone = NSTimeZone(name: "UTC")
        formatter.timeZone = timeZone! as TimeZone
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeDate = formatter.date(from: dateString)
        
        
        //结束的时间
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //注意这里将时间以秒为单位 如一天：24*60*60
        let time = 15*24*60*60 - 60*60
        let futureDate = timeDate?.addingTimeInterval(TimeInterval(time))
        
        
        //接下来计算
        let calender = Calendar.current
        let unit:Set<Calendar.Component> = [.day,.hour,.minute,.second]
        let commponent:DateComponents = calender.dateComponents(unit, from: timeDate!, to: futureDate!)
        
        sencondStr = commponent.second
        minitStr = commponent.minute
        hourStr = commponent.hour
        dayStr = commponent.day
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    @objc func timerAction(){
        sencondStr = sencondStr! - 1
        if sencondStr == -1{
           sencondStr = 59
           minitStr = minitStr! - 1
            if minitStr == -1{
                minitStr = 59
                if hourStr == -1{
                    hourStr = 23
                    dayStr = dayStr! - 1
                }
            }
        }
        if sencondStr == 0 && minitStr! == 0 && hourStr == 0 && dayStr == 0{
            timer?.invalidate()
            timer = nil
        }
        totalTime = "\(dayStr ?? 0)天\(hourStr ?? 0)时\(minitStr ?? 0)分\(sencondStr ?? 0)秒"
        timeLabel.text = totalTime! + "未付款则自动关闭订单"
        LXFLog(totalTime)
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
