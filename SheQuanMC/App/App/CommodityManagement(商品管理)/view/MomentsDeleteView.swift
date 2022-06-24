//
//  MomentsDeleteView.swift
//  App
//
//  Created by mac on 2022/6/23.
//

import UIKit

class MomentsDeleteView: UILabel {
    
    let normalText = "拖到此处删除"
    
//    let normalColor = UIColor(hex: "ff0033").withAlphaComponent(0.9)
    let normalColor = UIColor.colorWithDyColorChangObject(lightColor: "#ff0033")
    
    let deleteText = "松手即可删除"
    
//    let deleteColor = UIColor(hex: "cc0000").withAlphaComponent(0.9)
    let deleteColor = UIColor.colorWithDyColorChangObject(lightColor: "#cc0000")
    
    var isDelete: Bool = false {
        didSet {
            if isDelete {
                text = deleteText
                backgroundColor = deleteColor
            } else {
                text = normalText
                backgroundColor = normalColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = normalColor
        text = normalText
        textColor = .white
        font = UIFont.systemFont(ofSize: 14)
        textAlignment = .center
    }
    
    func showView() {
        transform = .identity
    }
    
    
    func hideView() {
        transform = CGAffineTransform(translationX: 0, y: 60)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
