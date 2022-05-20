//
//  UIView+Extension.swift
//
//
//  Created by LXF on 16/3/29.
//  Copyright © 2016年 LXF. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    /**
     依照图片轮廓对控制进行裁剪
     
     - parameter stretchImage:  模子图片
     - parameter stretchInsets: 模子图片的拉伸区域
     */
    public func clipShape(stretchImage: UIImage, stretchInsets: UIEdgeInsets) {
        // 绘制 imageView 的 bubble layer
        let bubbleMaskImage = stretchImage.resizableImage(withCapInsets: stretchInsets, resizingMode: .stretch)
        
        // 设置图片的mask layer
        let layer = CALayer()
        layer.contents = bubbleMaskImage.cgImage
        layer.contentsCenter = self.CGRectCenterRectForResizableImage(bubbleMaskImage)
        layer.frame = self.bounds
        layer.contentsScale = UIScreen.main.scale
        layer.opacity = 1
        self.layer.mask = layer
        self.layer.masksToBounds = true
    }
    
    public func CGRectCenterRectForResizableImage(_ image: UIImage) -> CGRect {
        return CGRect(
            x: image.capInsets.left / image.size.width,
            y: image.capInsets.top / image.size.height,
            width: (image.size.width - image.capInsets.right - image.capInsets.left) / image.size.width,
            height: (image.size.height - image.capInsets.bottom - image.capInsets.top) / image.size.height
        )
    }
    
    /// 将View画成图
    public func trans2Image() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        let ctx = UIGraphicsGetCurrentContext()
        self.layer.render(in: ctx!)
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImg
    }
    
 
//    设置有阴影部分---解决离屏渲染
    /**
     shadowColor:设置阴影的颜色
     shadowOpacity :设置阴影的透明度
     shadowRadius:设置阴影的倒角
     shadowOffset:设置阴影偏移量
     */
    public func shadowOffWithColor(shadowColor:UIColor,shadowOpacity:Float=1.0,shadowRadius:CGFloat,shadowOffset:CGSize){
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        let path = UIBezierPath(rect: self.frame)
        self.layer.shadowPath = path.cgPath
    }
    
    
    
    // MARK: 5.1、添加圆角
       /// 添加圆角
       /// - Parameters:
       ///   - conrners: 具体哪个圆角
       ///   - radius: 圆角的大小
    public func addCorner(conrners: UIRectCorner , radius: CGFloat) {
           let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
           let maskLayer = CAShapeLayer()
           maskLayer.frame = self.bounds
           maskLayer.path = maskPath.cgPath
           self.layer.mask = maskLayer
       }

       // MARK: 5.2、给继承于view的类添加阴影
       /// 给继承于view的类添加阴影
       /// - Parameters:
       ///   - shadowColor: 阴影的颜色
       ///   - shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移]);
       ///   - shadowOpacity: 阴影的透明度
       ///   - shadowRadius: 阴影半径，默认 3
    public func addShadow(shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat = 3) {
           // 设置阴影颜色
           layer.shadowColor = shadowColor.cgColor
           // 设置透明度
           layer.shadowOpacity = shadowOpacity
           // 设置阴影半径
           layer.shadowRadius = shadowRadius
           // 设置阴影偏移量
           layer.shadowOffset = shadowOffset
       }
    
    // MARK: 5.3、添加阴影和圆角并存
       /// 添加阴影和圆角并存
       /// - Parameters:
       ///   - conrners: 具体哪个圆角
       ///   - radius: 圆角大小
       ///   - shadowColor: 阴影的颜色
       ///   - shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移]);
       ///   - shadowOpacity: 阴影的透明度
       ///   - shadowRadius: 阴影半径，默认 3
    public func addCornerAndShadow(superview: UIView, conrners: UIRectCorner , radius: CGFloat = 3, shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat = 3) {
       
           let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
           let maskLayer = CAShapeLayer()
           maskLayer.frame = self.bounds
           maskLayer.path = maskPath.cgPath
           self.layer.mask = maskLayer
       
           let subLayer = CALayer()
           let fixframe = self.frame
           subLayer.frame = fixframe
           subLayer.cornerRadius = shadowRadius
           subLayer.backgroundColor = shadowColor.cgColor
           subLayer.masksToBounds = false
           // shadowColor阴影颜色
           subLayer.shadowColor = shadowColor.cgColor
           // shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
           subLayer.shadowOffset = shadowOffset
           // 阴影透明度，默认0
           subLayer.shadowOpacity = shadowOpacity
           // 阴影半径，默认3
           subLayer.shadowRadius = shadowRadius
           superview.layer.insertSublayer(subLayer, below: self.layer)
       }

       // MARK: 5.4、添加边框
       /// 添加边框
       /// - Parameters:
       ///   - width: 边框宽度
       ///   - color: 边框颜色
    public func addBorder(borderWidth: CGFloat, borderColor: UIColor) {
           layer.borderWidth = borderWidth
           layer.borderColor = borderColor.cgColor
           layer.masksToBounds = true
       }

    
    // MARK: 获取当前view的viewcontroller
    /// 获取当前view的viewcontroller
    public var currentVC: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    public var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.x = newValue.x
            self.y = newValue.y
        }
    }
    
    public var size: CGSize{
        get{
            return self.frame.size
        }
        set{
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    
    
    //左边
    public var left:CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    
     //顶部
     public var top:CGFloat{
         get{
             return self.frame.origin.y
         }
         set{
             var r = self.frame
             r.origin.y = newValue
             self.frame = r
         }
     }
    
    /// 右边界的x值
    public var right:CGFloat{
        get{
            return self.x + self.width
        }
        set{
            var r = self.frame
            r.origin.x = newValue - frame.size.width
            self.frame = r
        }
    }
    
    /// 下边界的y值
    public var bottom: CGFloat{
        get{
            return self.y + self.height
        }
        set{
            var r = self.frame
            r.origin.y = newValue - frame.size.height
            self.frame = r
        }
    }
    
    //这个和left一样
    public var x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }

    //这个和top一样
    public var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    
    public var centerX : CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }

    public var centerY : CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }

    public var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    public var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }


    

    

}
