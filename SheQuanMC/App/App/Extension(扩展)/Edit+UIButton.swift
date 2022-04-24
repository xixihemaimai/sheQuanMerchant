//
//  Edit+UIButton.swift
//  newShiLaiShiWang
//
//  Created by mac on 2021/11/30.
//

import UIKit
import Util


enum ButtonImagePosition:Int{
    case imageTop = 0
    case imageLeft
    case imageBottom
    case imageRight
}





extension UIButton {
    // 遍历构造函数必须调用本类中的其他指定构造器
  
    /// - parameter setImage:           默认状态图片
    /// - parameter setBackgroundImage: 背景图片

    convenience init(setImage:String,setBackgroundImage:String,target:Any?,action:Selector? ){
        self.init(type: .custom)
        
        self.setImage(UIImage(named:setImage), for: .normal)
        self.setImage(UIImage(named:"\(setImage)_highlighted"), for: .highlighted)
        self.setBackgroundImage(UIImage(named:setBackgroundImage), for: .normal)
        self.setBackgroundImage(UIImage(named:"\(setBackgroundImage)_highlighted"), for: .highlighted)
        
        if target != nil && action != nil
        {
            self.addTarget(target, action: action!, for: .touchUpInside)
        }
        
        self.sizeToFit()
    }
    
     convenience init(title:String?,titleColor:UIColor?,fontSize:CGFloat? ){
        self.init(type: .custom)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: scale(fontSize!))
        self.sizeToFit()
        
    }
    
    //有背景颜色和文字的按钮
    /// - parameter backGroundColor:           背景颜色
    /// - parameter title: 文字
    //titleColor :文字颜色
     convenience init(backGroundColor:UIColor?,title:String?,titleColor:UIColor?,target:Any?,action:Selector? ){
        self.init(type: .custom)
        
        self.setBackGroundColor(color: backGroundColor!)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        if target != nil && action != nil
        {
            self.addTarget(target, action: action!, for: .touchUpInside)
        }
        
        self.sizeToFit()
    }
    
    /// 返回带文字的高亮图片的按钮
    /// - parameter setHighlightImage: 图片
    /// - parameter title:             文字
    
     convenience init(setHighlightImage:String?,title:String?,titleColor:UIColor,target:Any?,action:Selector? ){
        self.init(type: .custom)
        
        if let img = setHighlightImage {
            self.setImage(UIImage(named:img), for: .normal)
            
            self.setImage(UIImage(named:"\(img)_highlighted"), for: .highlighted)
        }
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        if target != nil && action != nil
        {
            self.addTarget(target, action: action!, for: .touchUpInside)
        }
        
        self.sizeToFit()
        
    }
    /// 返回带文字的背景图片的按钮
    /// - parameter BackgroundImage: 背景图片
    /// - parameter title:             文字
     convenience init(BackgroundImage:String?,title:String?,titleColor:UIColor, target:Any?,action:Selector? ){
        
        self.init(type: .custom)
        
        self.setBackgroundImage(UIImage(named:BackgroundImage!), for: .normal)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        
        if target != nil && action != nil
        {
            self.addTarget(target, action: action!, for: .touchUpInside)
        }
        
        self.sizeToFit()
        
    }
    
    func setBackGroundColor(color:UIColor?,_ state:UIControl.State = .normal)
    {
//        self.setBackgroundImage(Tools.imageWithColor(color: color!), for: state)
        self.setBackGroundColor(color: color, state)
    }
    
     func setCoradius(_ radius:CGFloat)
    {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius

    }
    
    
    
   func setImagePostion(type:ButtonImagePosition,Space space:CGFloat){
        let imageWith:CGFloat = (imageView?.frame.size.width)!
        let imageHeight:CGFloat = (imageView?.frame.size.height)!
        var lableWith:CGFloat = 0.0
        var lableHeight:CGFloat = 0.0
        
        lableWith = CGFloat(titleLabel!.intrinsicContentSize.width)
        lableHeight = CGFloat(titleLabel!.intrinsicContentSize.height)
        
        var imageEdgeInset:UIEdgeInsets = UIEdgeInsets()
        var labelEdgeInset:UIEdgeInsets = UIEdgeInsets()
        
        
        switch type {
        case .imageTop:
            imageEdgeInset = UIEdgeInsets(top: -lableHeight - space/2.0, left: 0, bottom: 0, right: -lableWith)
            labelEdgeInset = UIEdgeInsets(top: 0, left: -imageWith, bottom: -imageHeight - space/2.0, right: 0)
        case .imageLeft:
            imageEdgeInset = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0)
            labelEdgeInset = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0)
        case .imageBottom:
            imageEdgeInset = UIEdgeInsets(top: 0, left: 0, bottom: -lableHeight-space/2.0, right: -lableWith)
            labelEdgeInset = UIEdgeInsets(top: -imageHeight-space/2.0, left: -imageWith, bottom: 0, right: 0)
        case .imageRight:
            imageEdgeInset = UIEdgeInsets(top: 0, left: lableWith+space/2.0, bottom: 0, right: -lableWith-space/2.0)
            labelEdgeInset = UIEdgeInsets(top: 0, left: -imageWith-space/2.0, bottom: 0, right: imageWith+space/2.0)
        }
        
        self.titleEdgeInsets = labelEdgeInset
        self.imageEdgeInsets = imageEdgeInset
    }
}

