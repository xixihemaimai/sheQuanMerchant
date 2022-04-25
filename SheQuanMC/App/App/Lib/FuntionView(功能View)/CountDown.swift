//
//  CountDown.swift
//  App
//
//  Created by mac on 2022/4/25.
//

import UIKit

class CountDown: NSObject {
    class func countDown(_ timeOut: Int, btn: UIButton){
           //倒计时时间
           var timeout = timeOut
           let queue:DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
           let _timer:DispatchSource = DispatchSource.makeTimerSource(flags: [], queue: queue) as! DispatchSource
           _timer.scheduleRepeating(wallDeadline: DispatchWallTime.now(), interval: .seconds(1))
           //每秒执行
           _timer.setEventHandler(handler: { () -> Void in
               if(timeout<=0){ //倒计时结束，关闭
                   _timer.cancel();
                   DispatchQueue.main.sync(execute: { () -> Void in
                       btn.setTitle("获取验证码", for: .normal)
                       btn.isEnabled = true
//                       btn.layer.backgroundColor = UIColor.red.cgColor
                   })
               }else{//正在倒计时
                   let seconds = timeout
                   DispatchQueue.main.sync(execute: { () -> Void in
                       let str = String(describing: seconds)
                       btn.setTitle(str + "秒", for: .normal)
                       btn.isEnabled = false
//                       btn.layer.backgroundColor = UIColor.gray.cgColor
                   })
                   timeout -= 1;
               }
           })
           _timer.resume()
       }
}


