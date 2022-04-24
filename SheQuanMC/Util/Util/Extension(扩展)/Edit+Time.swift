//
//  Edit+Time.swift
//  测试暗黑和白天模式
//
//  Created by mac on 2022/3/22.
//

import Foundation


extension Timer{
    
    class func rp_scheduledTimer(timeInterval ti:TimeInterval,repeats yesOrNo:Bool,closure:@escaping (Timer) -> Void)->Timer{
        return Timer.scheduledTimer(timeInterval: ti, target: self, selector: #selector(RP_TimerHandle), userInfo: closure, repeats: yesOrNo)
    }
    
    @objc func RP_TimerHandle(timer:Timer){
        var handleClose = {}
        handleClose = timer.userInfo as! () -> ()
        handleClose()
    }
    
}



//调用方法
/**
 if #available(iOS 10.0, *) {
       /// iOS 10之后采用`Block`方式解决Timer 循环引用问题
       time = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [weak self] (timer) in
             guard let `self` = self else { return }
             self.timePrint()
       })
 } else {
       /// iOS 10之前的解决方案： 模仿系统的`closure` 解决Timer循环引用问题
       time = Timer.rp_scheduledTimer(timeInterval: 2, repeats: true, closure: { [weak self] (timer) in
             guard let `self` = self else { return }
             self.timePrint()
       })
 }
         
 func timePrint() {
      // de something...
 }
     
 deinit {
     time?.invalidate()
     time = nil
 }
 */
