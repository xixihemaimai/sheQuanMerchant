//
//  NegotiationHistoryImageView.swift
//  App
//
//  Created by mac on 2022/7/22.
//

import UIKit
import Util

class NegotiationHistoryImageView: UIView {

    var pictureImageArray:[String]?{
        didSet{
            guard let _model = pictureImageArray else { return }
            
            for i in 0..<_model.count {
                let img = UIImageView()
                img.image = UIImage(named: "Group 2784")
                addSubview(img)
                img.snp.makeConstraints { make in
                    make.left.equalTo(CGFloat(i) * scale(82) + scale(4))
                    make.width.height.equalTo(scale(82))
                    make.centerY.equalToSuperview()
                }
            }
        }
    }

}
