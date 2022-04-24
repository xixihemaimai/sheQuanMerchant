//
//  Edit+Color.swift
//  newShiLaiShiWang
//
//  Created by mac on 2021/11/29.
//

import UIKit

extension UIColor{
    
    static func colorWithHex(hexValue:NSInteger,alpha:CGFloat)->UIColor
    {
        return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((hexValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(hexValue & 0xFF))/255.0, alpha: alpha)
    }
    
    static func colorWithHexString(stringValue:String,alpha:CGFloat) -> UIColor
    {
        //        0xffffff格式
        let hex = stringValue.hexStringToInt()
        return self.colorWithHex(hexValue: hex, alpha: alpha)
    }
    
//
//    static func colorWithHex(hexValue:NSInteger,alpha:CGFloat)->UIColor
//    {
//        return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((hexValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(hexValue & 0xFF))/255.0, alpha: alpha)
//    }
    
    
    class func imageWithColor(color:UIColor) -> UIImage
    {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    
    //使用rgb方式生成自定义颜色
    convenience init(_ r : CGFloat, _ g : CGFloat, _ b : CGFloat)
    {
        let red = r / 255.0
        let green = g / 255.0
        let blue = b / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    //使用rgba方式生成自定义颜色
    convenience init(_ r : CGFloat, _ g : CGFloat, _ b : CGFloat, _ a : CGFloat)
    {
        let red = r / 255.0
        let green = g / 255.0
        let blue = b / 255.0
        self.init(red: red, green: green, blue: blue, alpha: a)
    }
    
    //16进制生成自定义颜色
    class func hexColorWithAlpha(color: String, alpha:CGFloat) -> UIColor
    {
        var colorString = color.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if colorString.count < 6 {
            return UIColor.clear
        }
        
        if colorString.hasPrefix("0x") {
            colorString = (colorString as NSString).substring(from: 2)
        }
        if colorString.hasPrefix("#") {
            colorString = (colorString as NSString).substring(from: 1)
        }
        
        if colorString.count < 6 {
            return UIColor.clear
        }
        
        var rang = NSRange()
        rang.location = 0
        rang.length = 2
        
        let rString = (colorString as NSString).substring(with: rang)
        rang.location = 2
        let gString = (colorString as NSString).substring(with: rang)
        rang.location = 4
        let bString = (colorString as NSString).substring(with: rang)
        
        var r:UInt64 = 0, g:UInt64 = 0,b: UInt64 = 0
        
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)
        
        return UIColor.init(CGFloat(r), CGFloat(g), CGFloat(b), alpha)
    }
    
    
    
  public class func colorWithDyColorChangObject(lightColor:String,darkColor:String = "#000000",alpha:CGFloat = 1.0)->UIColor {
        if #available(iOS 13.0, *) {
            let color = UIColor.init { (traitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return self.colorWithHexString(stringValue: lightColor, alpha:alpha)
                }else{
                    return self.colorWithHexString(stringValue: darkColor, alpha:alpha)
                }
            }
            return color
        }else{
            return self.colorWithHexString(stringValue: lightColor, alpha:alpha)
        }
    }
    
}
