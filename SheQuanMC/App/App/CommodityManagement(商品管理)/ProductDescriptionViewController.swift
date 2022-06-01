//
//  ProductDescriptionViewController.swift
//  App
//
//  Created by mac on 2022/4/30.
//

import UIKit
import Util
import HXPhotoPicker
import JFPopup
import IQKeyboardManager
import SwiftUI
import SwiftyJSON

class ProductDescriptionViewController: BaseViewController {
    
    
    //这边block返回填入的字符串
    var inputAttributedString:((_ string:String) ->Void)?

    //图片管理器
    lazy var manager:HXPhotoManager = {
         let manager = HXPhotoManager()
         manager.configuration.openCamera = true
         manager.configuration.photoMaxNum = 9
         //是否可以单选模式下选择图片跳转到编辑界面
         manager.configuration.singleJumpEdit = true
         //是否可以裁剪
         manager.configuration.movableCropBox = true
         //是否可以移动裁剪编辑大小
         manager.configuration.movableCropBoxEditSize = true
         //是否可以保存到媒体库
         manager.configuration.saveSystemAblum = true
         manager.configuration.hideOriginalBtn = false
         return manager
    }()
    
    
    var _image:UIImage?
    
    
    lazy var _textView:XDRichTextView = {
       let _textView = XDRichTextView()
        _textView.placeholder = "请输入详情"
        _textView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
        _textView.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return _textView
    }()
    
    lazy var _textTool:XDEditTextTool = {
       let _textTool = XDEditTextTool()
        return _textTool
    }()
    
    
    
    //这个值市用来判断是否修改过
    var isModify:Bool = false
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
    }
   
    
    //0为新发布，1位编辑
    var type:Int = 0
    
    var inputString:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "商品描述"
        navigationItem.leftBarButtonItem?.customView?.isHidden = true
        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        navigationItem.leftBarButtonItem?.customView = UIButton(setImage: "返回", setBackgroundImage: "", target: self, action: #selector(backSaveProduct))
        //添加导航栏右边按键
        createRightBarBtnItem(title: "完成", method: #selector(completeAction), titleColor: UIColor.colorWithDyColorChangObject(lightColor: "#333333"))
        initData()
        setUI()
        
        //这里利用模型来判断是编辑过得数据还是没有新要发布的
        if type == 1{
            if let array = getArrayOrDicFromJSONString(jsonString: inputString ?? "") as? [[String:Any]]{
                let mutableAttributedStr = NSMutableAttributedString()
                for dict in array {
                    if dict["image"] != nil{
                        //图片
//                        let decodedImageData = Data(base64Encoded: (dict["image"] as! String), options: .ignoreUnknownCharacters)!
//                        let image = UIImage(data: decodedImageData)!
                        let url = URL(string: dict["image"] as! String)!
                        let data = try? Data(contentsOf: url)
                        let image = UIImage(data:data!)!
                        let imgSize = image.size
                        var newImgW = imgSize.width
                        var newImgH = imgSize.height
                        let textW = SCW - CGFloat(30)
                        if newImgW > textW{
                            let ratio = textW / newImgW
                            newImgW = textW
                            newImgH *= ratio
                        }
                        
                        let attachment = NSTextAttachment(data: nil, ofType: nil)
                        
                        
                        
                        attachment.image = image
                        attachment.bounds = CGRect(x: 0, y: 0, width: newImgW, height: newImgH)
                        mutableAttributedStr.insert(NSAttributedString(attachment: attachment), at: mutableAttributedStr.length)
                    }
                    
                    let plainStr = dict["title"]
                    let attrubuteStr = NSMutableAttributedString(string: plainStr as! String)
                    //设置初始值
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = CGFloat(dict["lineSpace"] as! CGFloat)
                    var color = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
                    if let colorStr = dict["color"] as? String{
                        color = UIColor.colorWithDyColorChangObject(lightColor: colorStr)
                    }
                    let attributes = [NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.foregroundColor:color,NSAttributedString.Key.strokeWidth:(dict["bold"] as! Bool) ? -3 : 0,NSAttributedString.Key.obliqueness:(dict["obliq"] as! Bool) ? 0.3 : 0,NSAttributedString.Key.underlineStyle:(dict["underline"] as! Bool) ? 1 : 0,NSAttributedString.Key.underlineColor:color,NSAttributedString.Key.font:UIFont.systemFont(ofSize: (dict["font"] as! CGFloat))] as [NSAttributedString.Key : Any]
                    attrubuteStr.addAttributes(attributes, range: NSRange(location: 0, length: attrubuteStr.length))
                    mutableAttributedStr.append(attrubuteStr)
                    _textView.attributedText = mutableAttributedStr
                    _textView.setInitLocation()
                    _textView.selectedRange = NSRange(location: _textView.attributedText.length, length: 0)
                }
            }
        }else{
            _textView.becomeFirstResponder()
        }
    }
    
    
    func initData(){
        //keyboardDidShowNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)


        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    func setUI(){
        textViewConfig()
        setTextTool()
    }
    
    
    func textViewConfig(){
        view.addSubview(_textView)
        _textView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
//            make.left.equalTo(scale(16))
//            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(0.5))
//            make.height.equalTo(SCH - Height_NavBar - Height_TabBar)
        }
//        _textView.tintColor = UIColor.colorWithDyColorChangObject(lightColor: "#949494")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = scale(5) //字体的行间距
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: scale(16), weight: .regular),NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor: "#333333")]
        _textView.typingAttributes = attributes
        _textView.delegate = self
        _textView.setInitLocation()
    }
    
    func setTextTool(){
        view.addSubview(_textTool)
        _textTool.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalTo(-scale(43))
            make.width.equalTo(SCW)
            make.height.equalTo(scale(43))
        }
        _textView.block = {[weak self] in
            self?._textTool.hiddenView()
        }
        
        _textTool.addImageBlock = {[weak self] in
            self?.alert()
            self?._textView.resignFirstResponder()
        }
        
        //字体
        //撤销
        _textTool.undoBlock = {[weak self] in
            self?._textView.undo()
        }
        
        //恢复
        _textTool.restoreBlock = {[weak self] in
            self?._textView.redo()
        }
        
        //改变颜色
        _textTool.changeTextColerBlock = {[weak self] color in
            LXFLog(color)
            self?._textView.color = color
            LXFLog(self?._textView.color)
        }
        
        //弹起键盘和恢复键盘
        _textTool.changekeyboardBlock = {[weak self] isHidden in
            if isHidden{
                self?._textView.becomeFirstResponder()
            }else{
                self?._textView.resignFirstResponder()
            }
        }
        
        //加粗
        _textTool.changeToBoldBlock = {[weak self] isBold in
            self?._textView.bold = isBold
        }
        
        //斜体
        _textTool.changeToObliqueBlock = {[weak self] isOblique in
            self?._textView.oblique = isOblique
        }
        
        //下划线
        _textTool.changeToUnderLineBlock = {[weak self] isUnderLine in
            self?._textView.underLine = isUnderLine
        }
        
        //字体
        _textTool.textFontBlock = {[weak self] textFont in
            self?._textView.nextFont = textFont
        }
    }
    
    
    func alert(){
        manager.type = .photo
        manager.clearSelectedList()
        JFPopup.actionSheet {
            [
                JFPopupAction(with: "从手机相册选择", subTitle: nil, clickActionCallBack: { [weak self] in
                    self?.hx_presentSelectPhotoController(with: self?.manager, didDone: { allList, photoList, videoList, isOriginal, viewController, manager in
                        photoList?.forEach({ HXPhotoModel in
                            //对图片进行
                            guard let image = HXPhotoModel.thumbPhoto else {
                                return
                            }
                            self?.addImageOriginallImage(image:image)
                        })
                    })
                }),
                JFPopupAction(with: "拍照", subTitle: nil, clickActionCallBack: {[weak self] in
                    self?.hx_presentCustomCameraViewController(with: self?.manager) { photoList, viewController in
                        LXFLog(photoList)
                        if let photoModel:HXPhotoModel = photoList{
                            //对图片进行
                           guard let image = photoModel.thumbPhoto else {
                                return
                            }
                            self?.addImageOriginallImage(image: image)
                        }
                    } cancel: { viewController in
                    }
                })
            ]
        }
    }
    
    func addImageOriginallImage(image:UIImage){
        let imgSize = image.size
        var newImgW = imgSize.width
        var newImgH = imgSize.height
        let textW = _textView.frame.size.width
        UIGraphicsBeginImageContext(_image?.size ?? CGSize(width: 0, height: 0))
        if newImgW > textW{
            let ratio = textW/newImgW
            newImgW = textW
            newImgH *= ratio
            UIGraphicsBeginImageContext(CGSize(width: newImgW, height: newImgH))
            image.draw(in: CGRect(x: 0, y: 0, width: newImgW, height: newImgH))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            _image = newImage
        }else{
            _image = image
        }
        if (_image != nil){
            _textView.add(_image)
            _image = nil
        }
    }
    
    
    @objc func backSaveProduct(backBtn:UIButton){
        _textView.resignFirstResponder()
            
            if isModify{
                JFPopup.alert {
                    [
                        .title("确定要放弃编辑商品详情吗？"),
                        .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
        //                .subTitle("注:取消商品将移至未上架"),
        //                .subTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 ")),
                        .withoutAnimation(true),
                        .cancelAction([
                            .text("取消"),
                            .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 ")),
                            .tapActionCallback({
                                
                            })
                            
                        ]),
                        .confirmAction([
                            .text("确定"),
                            .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                            .tapActionCallback({
                                JFPopupView.popup.toast(hit: "点击了确定")
                                Coordinator.shared?.popViewController(self, true)
                                
                            })
                        ])
                    ]
                }
            }else{
                Coordinator.shared?.popViewController(self, true)
            }
            
    }
    
    
    //显示键盘
    @objc func keyboardWillShow(note:NSNotification){
       let keyboardBounds = (note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        _textTool.frame = CGRect(x: 0, y: keyboardBounds.origin.y - scale(43), width:
        //SCW, height: scale(43))
        
        LXFLog(keyboardBounds)
        
        _textTool.snp.remakeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
            make.bottom.equalTo(-keyboardBounds.size.height)
            make.height.equalTo(scale(43))
        }
        
        _textView.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
//            make.right.equalTo(-scale(16))
//            make.top.equalTo(scale(14))
            make.top.equalTo(scale(0.5))
            make.bottom.equalTo(_textTool.snp.top)
        }
        
    }
    
    //隐藏键盘
    @objc func keyboardWillHide(note:NSNotification){
//        _textTool.frame = CGRect(x: 0, y: SCH - scale(43), width: SCW, height: scale(43))
//        _textView.height = SCH - Height_NavBar - Height_TabBar - scale(43)
        
        _textTool.snp.remakeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
            make.height.equalTo(scale(43))
            make.bottom.equalToSuperview()
        }
        
        _textView.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
//            make.right.equalTo(-scale(16))
//            make.top.equalTo(scale(14))
            make.top.equalTo(scale(0.5))
            make.bottom.equalTo(_textTool.snp.top)
        }
        
        
    }
        
    //完成
    @objc func completeAction(){
        LXFLog("完成")
        if _textView.attributedText.length > 0{
            var imageArray = [String]()
            let arr1 = _textView.attributedText.getArrayWithAttributed()
            var imageList = [Data]()
            for i in 0..<(arr1?.count ?? 0) {
                let dict = arr1?[i] as! [String:Any]
                if (dict["image"] != nil){
                    let decodedImageData = Data(base64Encoded: (dict["image"] as! String), options: .ignoreUnknownCharacters)!
                    imageList.append(decodedImageData)
                }
            }
            if imageList.count > 0{
                let Parameters = ["fileType":20]
                NetWorkResultRequest(StoreAppleApi.batchUpload(parameters: Parameters, dataAry: imageList), needShowFailAlert: true) { result, data in
                    do{
                        let json = try JSON(data: data)
                        LXFLog(json)
                        let array = json["data"]
                        for i in 0..<array.count{
                            let cloudUrl = array[i]["cloudUrl"]
                            let data = try JSONEncoder().encode(cloudUrl)
                            var url = String(data: data, encoding:String.Encoding.utf8)!.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                            url = url.replacingOccurrences(of: "\"", with: "", options: .literal, range: nil)
                            LXFLog(url)
                            imageArray.append(url)
                        }
                    }catch{}
                    for urlStr in imageArray {
                        for i in 0..<(arr1?.count ?? 0) {
                            var dict = arr1?[i] as! [String:Any]
                            if (dict["image"] != nil && !(dict["image"] as! String).hasPrefix("http")){
                                dict["image"] = urlStr
    //                            LXFLog("--32============================\(String(describing: dict["image"]))")
                                arr1?[i] = dict
                                break
                            }
                        }
                    }
                    let jsonString = self.getArrayFromData(obj: arr1 as Any)
    //                LXFLog("+=================================\(jsonString)")
                    self.inputAttributedString!(jsonString)
                    Coordinator.shared?.popViewController(self, true)
                } failureCallback: { error, code in
                    code.loginOut()
                }
            }else{
                let jsonString = self.getArrayFromData(obj: arr1 as Any)
                self.inputAttributedString!(jsonString)
                Coordinator.shared?.popViewController(self, true)
            }
        }else{
            Coordinator.shared?.popViewController(self, true)
        }
        
        /**
         if (_textView.attributedText.length) {
             NSArray *arr1 =  [_textView.attributedText getArrayWithAttributed];
         
             NSString *image = @"";
             for (NSDictionary * dict in arr1) {
                 if (dict[@"image"]!=nil) {
                     默认图片
                     image = dict[@"image"];
                     break;
                 }
             }
             NSString *wors = @"";
             for (NSDictionary * dict1 in arr1) {
                 if (dict1[@"image"]!=nil || [dict1[@"title"] isEqualToString:@"\n"] || [dict1[@"title"] containsString:@"\n"] ) {
                     
                 }else{
                     NSString *title = dict1[@"title"];
                     NSString *newTitle = [title stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                     wors = [wors stringByAppendingString:newTitle];
                     NSLog(@"%ld", wors.length);
                 }
             }
             NSString *string = _textView.attributedText.string;
             NSArray *array = [string componentsSeparatedByString:@"\n"];
             NSString *content = @"";
             if (array.count) {
                 content = array[0];
                 if (!content.length) {
                     for (NSString *str in array) {
                         content = [content stringByAppendingString:str];
                     }
                 }
             }else{
                 content = string;
             }
             //字数
             NSInteger words = wors.length;
             //保存索引
             NSDictionary *dic = @{
                                   @"day":_model.day,
                                   @"type":@"1",
                                   @"year":_model.year,
                                   @"moth":_model.moth,
                                   @"index":[NSString stringWithFormat:@"%ld",_model.index],
                                   @"image":image,
                                   @"words":[NSString stringWithFormat:@"%ld",words],
                                   @"content":content
                                   };
             
             NSString *conten = [NSString dicToString:dic];
             if (_model.type ==1) {//更新
                 NSString *sql1 = [NSString stringWithFormat:@"update t_index set contexText = '%@' where workId = '%@'",conten,[NSString stringWithFormat:@"%@%@%@",_model.year, _model.moth,_model.day]];
                 [_indexdb insertOrUpdateData:sql1];
             }else{//插入
                 NSString *sql1 = [NSString stringWithFormat:@"INSERT INTO t_index (contexText, workId) VALUES ('%@','%@');",conten,[NSString stringWithFormat:@"%@%@%@",_model.year, _model.moth,_model.day]];
                 [_indexdb insertOrUpdateData:sql1];
             }
             NSString *sqlcontent = [NSString arrayToString:arr1];
             if (_model.type ==1) {//更新
                 NSString *sql1 = [NSString stringWithFormat:@"update t_works set contexText = '%@' where workId = '%@'",sqlcontent,[NSString stringWithFormat:@"%@%@%@",_model.year, _model.moth,_model.day]];
                 [_db insertOrUpdateData:sql1];
             }else{//插入
                 NSString *sql1 = [NSString stringWithFormat:@"INSERT INTO t_works (contexText, workId) VALUES ('%@','%@');",sqlcontent,[NSString stringWithFormat:@"%@%@%@",_model.year, _model.moth,_model.day]];
                 [_db insertOrUpdateData:sql1];
             }
             [[NSNotificationCenter defaultCenter] postNotificationName:@"resh" object:dic];
             NSArray *pushArr =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
             NSString *documents = [pushArr lastObject];
             NSString *documentPath = [documents stringByAppendingPathComponent:@"arrayXML.xml"];
             NSArray *resultArray = [NSArray arrayWithContentsOfFile:documentPath];
             NSMutableArray *pushMarr = [NSMutableArray array];
             [pushMarr addObjectsFromArray:resultArray];
             [pushMarr addObject:[NSString stringWithFormat:@"%@%@%@",_model.year,_model.moth,_model.day]];
             [pushMarr writeToFile:documentPath atomically:YES];
             [[UIApplication sharedApplication] cancelAllLocalNotifications];
           
         }else{//如果啥都没有删除掉它
             NSString *sql1 = [NSString stringWithFormat:@"DELETE FROM t_index WHERE workId = '%@'",[NSString stringWithFormat:@"%@%@%@",_model.year,_model.moth,_model.day]];
             [_indexdb deleteData:sql1];
             NSString *sql2 = [NSString stringWithFormat:@"DELETE FROM t_works WHERE workId = '%@'",[NSString stringWithFormat:@"%@%@%@",_model.year,_model.moth,_model.day]];
             [_indexdb deleteData:sql1];
             [_db deleteData:sql2];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"resh" object:nil];
         }
         [self.navigationController popViewControllerAnimated:YES];
         */
    }
    
    
    func getArrayFromData(obj:Any) -> String {
        if (!JSONSerialization.isValidJSONObject(obj)) {
            print("无法解析出JSONString")
            return ""
        }
        if let data : NSData = try? JSONSerialization.data(withJSONObject: obj, options: []) as NSData? {
            if let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue) {
                return JSONString as String
            }
        }
        return ""
    }
    
//    func getArrayOrDicFromJSONString(jsonString:String) -> Any {
//        let jsonData:Data = jsonString.data(using: .utf8)!
//        //可能是字典也可能是数组，再转换类型就好了
//        if let info = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) {
//            return info
//        }
//        return ""
//    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        _textTool.hiddenView()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension ProductDescriptionViewController:UITextViewDelegate,UITextFieldDelegate{
    func textViewDidChange(_ textView: UITextView) {
        _textTool.hiddenView()
        LXFLog(_textView.locationStr)
        let len = textView.attributedText.length - _textView.locationStr.length
        if len > 0{
            _textView.isDelete = false
            _textView.newRange = NSRange(location: _textView.selectedRange.location - len, length: len)
//            _textView.newstr = textView.text.sub(start: _textView.newRange.location, length: _textView.newRange.length)
            _textView.newstr = (textView.text as NSString).substring(with: _textView.newRange)
            
        }else{
            _textView.isDelete = true
        }
        let isChinese:Bool; //判断当前输入法是否是中文
        if textView.textInputMode?.primaryLanguage == "en-US"{
            isChinese = false
        }else{
            isChinese = true
        }
        let str = _textView.text.replacingOccurrences(of: "?", with: "")
        if isChinese{
            let selectedRange = _textView.markedTextRange
            let position = _textView.position(from: (selectedRange?.start ?? UITextPosition()), offset: 0)
            //没有高亮选择的字，则对已输入的文字进行字数的统计和限制
            if (position != nil){
                _textView.setStyle()
            }else{
                LXFLog(str)
                LXFLog(NSStringFromRange(_textView.selectedRange))
            }
        }else{
            _textView.setStyle()
        }
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.length == 1{
            return true
        }else{
            //超过长度限制
            if textView.text.count >= 2000+3{
                return false
            }
        }
        return true
    }
   
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        _textTool.isEdit = true
        _textTool.hiddenView()
    }
    
    
    
}
