//
//  Edit+UIImageView.swift
//  测试暗黑和白天模式
//
//  Created by mac on 2022/3/15.
//

import Foundation
import UIKit


extension UIImageView{
    
    
   
    
    /// 使用 CALayer 绘制圆形头像
        ///
    /// - parameter imageView: 要被绘制的 imageView
    func circleFaviconFromCALayer(borderWidth:CGFloat,color:UIColor) -> Void {
//        let imageView = imageView
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.size.width * 0.5
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }

    
    /**

         * param: radius            圆角半径

         * 注意：只有当imageView.image不为nil时，调用此方法才有效果

         */
        func cornerRadius(radius:CGFloat){
            //开始图形上下文
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
            //获取图形上下文
            let ctx = UIGraphicsGetCurrentContext()
            //根据一个rect创建一个椭圆
            ctx!.addEllipse(in: self.bounds)
            //裁剪
            ctx!.clip()
            //将原照片画到图形上下文
             self.image!.draw(in: self.bounds)
            //从上下文上获取剪裁后的照片
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            //关闭上下文
            UIGraphicsEndImageContext()

            self.image = newImage
        }
    
    
    
    
}
