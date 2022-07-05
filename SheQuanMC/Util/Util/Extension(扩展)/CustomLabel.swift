//
//  CustomLabel.swift
//  Util
//
//  Created by mac on 2022/7/4.
//

import UIKit

public class CustomLabel: UILabel {

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        textRect.origin.y = bounds.origin.y
        return textRect
    }
    
    
    public override func drawText(in rect: CGRect) {
        var actualRect = self.textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: actualRect)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
