//
//  UserPrivacyView.swift
//  App
//
//  Created by mac on 2022/5/14.
//

import UIKit
import Util

class UserPrivacyView: UIView {

    var contentStr:String?
    //0 隐私 1 用户协议  2 同意 3不同
    var jumpType:((_ type:Int) ->Void)?
    
    
    
    init(frame: CGRect,content:String) {
        super.init(frame: frame)
        self.contentStr = content
        
        
        backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        let titleLabel = UILabel()
        titleLabel.text = "用户协议及隐私政策提示"
        titleLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scale(24))
            make.height.equalTo(scale(22))
        }
        
        let textview = UITextView()
//        textview.backgroundColor = UIColor.red
        
        
        /**
         NSString *agreeStr = [NSString stringWithFormat:@"%@", strContent];/// @"我已阅读并同意《隐私政策》《用户协议》";
             NSMutableAttributedString *diffString = [[NSMutableAttributedString alloc] initWithString:agreeStr];
             NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
             paragraphStyle.lineSpacing = 5 *kScale;

             [diffString addAttribute:NSForegroundColorAttributeName value:rgba(63, 70, 95, 1) range:[[diffString string] rangeOfString:strContent]];
             
             [diffString addAttribute:NSLinkAttributeName
                                    value:@"privacy://"
                                    range:[[diffString string] rangeOfString:[NSString stringWithFormat:@"《隐私政策》"]]];/// 《隐私政策》
             [diffString addAttribute:NSLinkAttributeName
                                value:@"delegate://"
                                range:[[diffString string] rangeOfString:[NSString stringWithFormat:@"《用户协议》"]]];/// 《用户协议》
             [diffString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,
                                               NSFontAttributeName:[UIFont systemFontOfSize:13]
                                               } range:NSMakeRange(0, strContent.length)];
              self.textView.linkTextAttributes = @{NSForegroundColorAttributeName: rgba(21, 190, 118, 1)};
              self.textView.attributedText = diffString;
         
         
         
         */
        
        textview.isScrollEnabled = false
        textview.isEditable = false
        textview.delegate = self
        textview.showsVerticalScrollIndicator = false
        textview.showsHorizontalScrollIndicator = false
//        textview.font = UIFont.systemFont(ofSize: scale(14), weight: .semibold)
//        textview.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#6f6f6f")
        textview.textAlignment = .center
//        textview.text = content
        
        let diffString = NSMutableAttributedString(string: content)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = scale(5)
        
        let range: NSRange = (content as NSString).range(of: content)
        diffString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorWithDyColorChangObject(lightColor: "#6f6f6f"), range: range)
        
        let range1:NSRange = (content as NSString).range(of: "《隐私政策》")
        let range2:NSRange = (content as NSString).range(of: "《用户协议》")
        diffString.addAttribute(NSAttributedString.Key.link, value: "privacy://", range: range1)
        diffString.addAttribute(NSAttributedString.Key.link, value: "delegate://", range: range2)
    
        diffString.addAttributes([NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.font:UIFont.systemFont(ofSize: scale(14), weight: .semibold)], range: NSRange(location: 0, length: content.count))
        textview.linkTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor: "#333333")]
        textview.attributedText = diffString

        
        
        
        addSubview(textview)
        
        textview.snp.makeConstraints { make in
            make.left.equalTo(scale(22))
            make.right.equalTo(-scale(22))
            make.top.equalTo(titleLabel.snp.bottom).offset(scale(14))
            make.bottom.equalTo(-scale(130))
        }
        
        
        let agreeBtn = UIButton()
        agreeBtn.setTitle("同意", for: .normal)
        agreeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF"), for: .normal)
        agreeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        agreeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addSubview(agreeBtn)
        agreeBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(22))
            make.right.equalTo(-scale(22))
            make.top.equalTo(textview.snp.bottom).offset(scale(20))
            make.height.equalTo(scale(44))
        }
        
        agreeBtn.layer.cornerRadius = scale(4)
        
        agreeBtn.addTarget(self, action: #selector(agreeBtnAction), for: .touchUpInside)
        
        
        let noAgreeBtn = UIButton()
        noAgreeBtn.setTitle("不同意", for: .normal)
        noAgreeBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        noAgreeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF")
        noAgreeBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addSubview(noAgreeBtn)
        noAgreeBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(22))
            make.right.equalTo(-scale(22))
            make.top.equalTo(agreeBtn.snp.bottom)
            make.height.equalTo(scale(44))
        }
        noAgreeBtn.addTarget(self, action: #selector(noAgreeBtnAction), for: .touchUpInside)
        
        layer.cornerRadius = scale(4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //不同意
    @objc func noAgreeBtnAction(){
        jumpType!(4)
    }
    
    //同意
    @objc func agreeBtnAction(){
        jumpType!(3)
    }
    

}


extension UserPrivacyView:UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
       
        if URL.scheme == "privacy"{
            //跳转隐私政策
            LXFLog("===========================1")
            
            jumpType!(0)
            
            
            
        }else if URL.scheme == "delegate"{
            //跳转用户协议
            LXFLog("----------------------------2")
            jumpType!(1)
        }
        
        return true
    }
}
