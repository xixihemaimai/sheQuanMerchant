//
//  NSDate+Date.swift
//
//  Created by 白华君 on 2018/5/17.
//  Copyright © 2018年 baihuajun. All rights reserved.
//


import UIKit

 extension Date {
    
    
    
    
    //获取当前的时间戳 -- 10位
     public var currentTimeStamp:String{
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    
    //获取当前的时间戳 -- 13位(毫秒)
     public var currentMilliStamp:String{
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    
    
    
    
    
    // MARK: - 获取时间字符串
    /// 获取时间字符串
    ///
    /// - Parameter fromDate: 时间
    /// - Returns: 返回字符串
    public func dateStringWithDate(_ fromDate : Date) -> String{
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.string(from: fromDate)
        return date.components(separatedBy: " ").first!
    }
    
    /// 获取时间差
    ///
    /// - Parameter fromDate: 开始时间
    /// - Returns: 返回时间差
    public func daltaFrom(_ fromDate : Date)  -> DateComponents{
        
        /// 获取当前日历
        let calendar = Calendar.current
        let components : Set<Calendar.Component> = [.year, .month,.day, .hour, .minute, .second]
        return calendar.dateComponents(components, from: self)
    }
    
    /// 是否是同一年
    ///
    /// - Returns: ture or false
    public func isThisYear() -> Bool {
        let calendar = Calendar.current
        let currendarYear = calendar.component(.year, from: Date())
        let selfYear =  calendar.component(.year, from: self)
        return currendarYear == selfYear
    }
    
    /// 是否是今天的时间
    ///
    /// - Returns: Bool
    public func isToday() -> Bool{
        
        let currentTime = Date().timeIntervalSince1970
        
        let selfTime = self.timeIntervalSince1970
        
        return (currentTime - selfTime) <= (24 * 60 * 60)
    }
    
    /// 是否是昨天的时间
    ///
    /// - Returns: Bool
    public func isYesToday() -> Bool {
        
        let currentTime = Date().timeIntervalSince1970
        
        let selfTime = self.timeIntervalSince1970
        
        return (currentTime - selfTime) > (24 * 60 * 60)
    }
     
    public static func getDate(dateStr: String, format: String) -> Date? {
         let dateFormatter = DateFormatter()
         dateFormatter.locale = Locale.current
         dateFormatter.timeZone = TimeZone.current
         dateFormatter.dateFormat = format
         let date = dateFormatter.date(from: dateStr)
         return date
     }
     
     public func getComponent(component: Calendar.Component) -> Int {
         let calendar = Calendar.current
         return calendar.component(component, from: self)
     }
     
     public func getString(format: String) -> String {
         let dateFormatter = DateFormatter()
         dateFormatter.locale = Locale.current
         dateFormatter.timeZone = TimeZone.current
         dateFormatter.dateFormat = format
         let dateString = dateFormatter.string(from: self)
         return dateString
     }
     
     
     
    
}

