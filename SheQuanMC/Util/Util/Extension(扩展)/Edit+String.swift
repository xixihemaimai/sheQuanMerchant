//
//  Edit+String.swift
//  newShiLaiShiWang
//
//  Created by mac on 2021/11/29.
//

import CommonCrypto
import Foundation
import UIKit


extension String{
    
    
    //获取APP的版本号
    public static var appVersion:String{
        let infoDic = Bundle.main.infoDictionary
        return infoDic?["CFBundleShortVersionStrin"] as! String
    }
    
    
    public static var deviceUUID:String{
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    
    
    var uuid:String{
        return UUID().uuidString
    }
    
    
    //let needStr = "1234"
//    let md5Str = needStr.md5
  public var md5: String {
            let str = self.cString(using: String.Encoding.utf8)
            let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
            let digestLen = Int(CC_MD5_DIGEST_LENGTH)
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            CC_MD5(str!, strLen, result)
            let hash = NSMutableString()
            for i in 0..<digestLen {
                hash.appendFormat("%02x", result[i])
            }
            result.deallocate()
            return hash as String
    }
    
    
    /// 输入字符串 输出数组
    /// e.g  "qwert" -> ["q","w","e","r","t"]
    /// - Returns: ["q","w","e","r","t"]
    func stringToArr() -> [String] {
        let num = self.count
        if !(num > 0) { return [""] }
        var arr: [String] = []
        for i in 0..<num {
            let tempStr: String = self[self.index(startIndex, offsetBy: i)].description
            arr.append(tempStr)
        }
        return arr
    }
    
    /// 字符串截取         3  6
    /// e.g let aaa = "abcdefghijklmnopqrstuvwxyz"  -> "cdef"
    /// - Parameters:
    ///   - start: 开始位置 3
    ///   - end: 结束位置 6
    /// - Returns: 截取后的字符串 "cdef"
    func startToEnd(start: Int,end: Int) -> String {
        if !(end < self.count) || start > end { return "取值范围错误" }
        //f90f2aca5c640289d0a29417bcb63a37
        //from:3 to:7
        var tempStr: String = ""
        for i in start...end {
            let temp: String = self[self.index(startIndex, offsetBy: i - 1)].description
            tempStr += temp
        }
        return tempStr
    }
    
    func hexStringToInt() -> Int {//十六进制转int
        let str = self.uppercased()
        var sum = 0
        for i in str.utf8 {
            sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum -= 7
            }
        }
        return sum
    }
    
    /// 字符URL格式化
    ///
    /// - Returns: 格式化的 url
    func stringEncoding() -> String {
        let url = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return url!
    }
    
//    func nsRange(from range: Range<String.Index>) -> NSRange {
//        let from = range.lowerBound.samePosition(in: utf16)
//        let to = range.upperBound.samePosition(in: utf16)
//        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from ?? utf16.endIndex),
//                       length: utf16.distance(from: from, to: to))
//    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from..<to
    }

    //返回第一次出现的指定子字符串在此字符串中的索引
    //（如果backwards参数设置为true，则返回最后出现的位置）
    func positionOf(sub:String, backwards:Bool = false)->Int {
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
    
    

    /**
     --------------------------------字符串的转换
     */
    
    // MARK: 3.1、字符串 转 CGFloat
    /// 字符串 转 Float
    /// - Returns: CGFloat
    public func toCGFloat() -> CGFloat? {
        if let doubleValue = Double(self) {
            return CGFloat(doubleValue)
        }
        return nil
    }

    // MARK: 3.2、字符串转 bool
    /// 字符串转 bool
    var bool: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }

    // MARK: 3.3、字符串转 Int
    /// 字符串转 Int
    /// - Returns: Int
    func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }

    // MARK: 3.4、字符串转 Double
    /// 字符串转 Double
    /// - Returns: Double
    func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
       }
    }

    // MARK: 3.5、字符串转 Float
    /// 字符串转 Float
    /// - Returns: Float
    func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }

    // MARK: 3.6、字符串转 Bool
    /// 字符串转 Bool
    /// - Returns: Bool
    func toBool() -> Bool? {
        let trimmedString = lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }

    // MARK: 3.7、字符串转 NSString
    /// 字符串转 NSString
    var toNSString: NSString {
        return self as NSString
    }
    
    
    /**
     
     -------------------------------字符串UI的处理
     */
    
    // MARK: 4.1、对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)
       /// 对字符串(多行)指定出字体大小和最大的 Size，获取展示的 Size
       /// - Parameters:
       ///   - font: 字体大小
       ///   - size: 字符串的最大宽和高
       /// - Returns: 按照 font 和 Size 的字符的Size
       public func rectSize(font: UIFont, size: CGSize) -> CGSize {
           let attributes = [NSAttributedString.Key.font: font]
           /**
            usesLineFragmentOrigin: 整个文本将以每行组成的矩形为单位计算整个文本的尺寸
            usesFontLeading:
            usesDeviceMetrics:
            @available(iOS 6.0, *)
            truncatesLastVisibleLine:
            */
           let option = NSStringDrawingOptions.usesLineFragmentOrigin
           let rect: CGRect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
           return rect.size
       }

       // MARK: 4.2、对字符串(多行)指定字体及Size，获取 (高度)
       /// 对字符串指定字体及Size，获取 (高度)
       /// - Parameters:
       ///   - font: 字体的大小
       ///   - size: 字体的size
       /// - Returns: 返回对应字符串的高度
       public func rectHeight(font: UIFont, size: CGSize) -> CGFloat {
           return rectSize(font: font, size: size).height
       }
    
    // MARK: 4.3、对字符串(多行)指定字体及Size，获取 (宽度)
        /// 对字符串指定字体及Size，获取 (宽度)
        /// - Parameters:
        ///   - font: 字体的大小
        ///   - size: 字体的size
        /// - Returns: 返回对应字符串的宽度
        public func rectWidth(font: UIFont, size: CGSize) -> CGFloat {
            return rectSize(font: font, size: size).width
        }

        // MARK: 4.4、对字符串(单行)指定字体，获取 (Size)
        /// 对字符串(单行)指定字体，获取 (Size)
        /// - Parameter font: 字体的大小
        /// - Returns: 返回单行字符串的 size
        public func singleLineSize(font: UIFont) -> CGSize {
            let attrs = [NSAttributedString.Key.font: font]
            return self.size(withAttributes: attrs as [NSAttributedString.Key: Any])
        }
    
    // MARK: 4.5、对字符串(单行)指定字体，获取 (width)
       /// 对字符串(单行)指定字体，获取 (width)
       /// - Parameter font: 字体的大小
       /// - Returns: 返回单行字符串的 width
       public func singleLineWidth(font: UIFont) -> CGFloat {
           let attrs = [NSAttributedString.Key.font: font]
           return self.size(withAttributes: attrs as [NSAttributedString.Key: Any]).width
       }

       // MARK: 4.6、对字符串(单行)指定字体，获取 (Height)
       /// 对字符串(单行)指定字体，获取 (height)
       /// - Parameter font: 字体的大小
       /// - Returns: 返回单行字符串的 height
       public func singleLineHeight(font: UIFont) -> CGFloat {
           let attrs = [NSAttributedString.Key.font: font]
           return self.size(withAttributes: attrs as [NSAttributedString.Key: Any]).height
       }

     
    
      /**
       -------------------------------------字符串包含表情的处理
       */
    
    // MARK: 7.1.1、检查字符串是否包含 Emoji 表情
        /// 检查字符串是否包含 Emoji 表情
        /// - Returns: bool
        public func containsEmoji() -> Bool {
            for scalar in unicodeScalars {
                switch scalar.value {
                case 0x1F600...0x1F64F,
                     0x1F300...0x1F5FF,
                     0x1F680...0x1F6FF,
                     0x2600...0x26FF,
                     0x2700...0x27BF,
                     0xFE00...0xFE0F:
                    return true
                default:
                    continue
                }
            }
            return false
        }

    
    
    
    /**
     -------------------------------------------- 字符串的一些正则校验
     */
    
    // MARK: 8.1、判断是否全是空白,包括空白字符和换行符号，长度为0返回true
        /// 判断是否全是空白,包括空白字符和换行符号，长度为0返回true
        public var isBlank: Bool {
            return trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == ""
        }

        // MARK: 8.2、判断是否全十进制数字，长度为0返回false
        /// 判断是否全十进制数字，长度为0返回false
        public var isDecimalDigits: Bool {
            if isEmpty {
                return false
            }
            // 去除什么的操作
            return trimmingCharacters(in: NSCharacterSet.decimalDigits) == ""
        }

        // MARK: 8.3、判断是否是整数
        /// 判断是否是整数
        public var isPureInt: Bool {
            let scan: Scanner = Scanner(string: self)
            var n: Int = 0
            return scan.scanInt(&n) && scan.isAtEnd
        }

        // MARK: 8.4、判断是否是Float,此处Float是包含Int的，即Int是特殊的Float
        /// 判断是否是Float，此处Float是包含Int的，即Int是特殊的Float
        public var isPureFloat: Bool {
            let scan: Scanner = Scanner(string: self)
            var n: Float = 0.0
            return scan.scanFloat(&n) && scan.isAtEnd
        }

        // MARK: 8.5、判断是否全是字母，长度为0返回false
        /// 判断是否全是字母，长度为0返回false
        public var isLetters: Bool {
            if isEmpty {
                return false
            }
            return trimmingCharacters(in: NSCharacterSet.letters) == ""
        }
    
    
    

        // MARK: 8.6、判断是否是中文, 这里的中文不包括数字及标点符号
        /// 判断是否是中文, 这里的中文不包括数字及标点符号
        public var isChinese: Bool {
            let mobileRgex = "(^[\u{4e00}-\u{9fef}]+$)"
            let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
            return checker.evaluate(with: self)
        }

        // MARK: 8.7、是否是有效昵称，即允许“中文”、“英文”、“数字”
        /// 是否是有效昵称，即允许“中文”、“英文”、“数字”
        public var isValidNickName: Bool {
            let rgex = "(^[\u{4e00}-\u{9faf}_a-zA-Z0-9]+$)"
            let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", rgex)
            return checker.evaluate(with: self)
        }
    
    
        //强密码（必须包含字母、数字，长度8到16位）
    //^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~!@#$%^&*()_+`\-={}:";'<>,.\/]).{8,16}$
    public var isPassword:Bool{
        let rgex = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", rgex)
        return checker.evaluate(with: self)
    }
    

        // MARK: 8.8、判断是否是有效的手机号码
        /// 判断是否是有效的手机号码
        public var isValidMobile: Bool {
            let mobileRgex = "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199)\\d{8}$"
            let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
            return checker.evaluate(with: self)
        }

        // MARK: 8.9、判断是否是有效的电子邮件地址
        /// 判断是否是有效的电子邮件地址
        public var isValidEmail: Bool {
            let mobileRgex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
            return checker.evaluate(with: self)
        }

        // MARK: 8.10、判断是否有效的身份证号码，不是太严格
        /// 判断是否有效的身份证号码，不是太严格
        public var isValidIDCardNumber: Bool {
            let mobileRgex = "^(\\d{15})|((\\d{17})(\\d|[X]))$"
            let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
            return checker.evaluate(with: self)
        }

        // MARK: 8.11、严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码
        /// 严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码
        public var isValidIDCardNumStrict: Bool {
            let str = trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            let len = str.count
            if !str.isValidIDCardNumber {
                return false
            }
            // 省份代码
            let areaArray = ["11", "12", "13", "14", "15", "21", "22", "23", "31", "32", "33", "34", "35", "36", "37", "41", "42", "43", "44", "45", "46", "50", "51", "52", "53", "54", "61", "62", "63", "64", "65", "71", "81", "82", "91"]
            if !areaArray.contains(str.sub(to: 2)) {
                return false
            }
            var regex = NSRegularExpression()
            var numberOfMatch = 0
            var year = 0
            switch len {
            case 15:
                // 15位身份证
                // 这里年份只有两位，00被处理为闰年了，对2000年是正确的，对1900年是错误的，不过身份证是1900年的应该很少了
                year = Int(str.sub(start: 6, length: 2))!
                if isLeapYear(year: year) { // 闰年
                    do {
                        // 检测出生日期的合法性
                        regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$", options: .caseInsensitive)
                    } catch {}
                } else {
                    do {
                        // 检测出生日期的合法性
                        regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$", options: .caseInsensitive)
                    } catch {}
                }
                numberOfMatch = regex.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, len))

                if numberOfMatch > 0 {
                    return true
                } else {
                    return false
                }
            case 18:
                // 18位身份证
                year = Int(str.sub(start: 6, length: 4))!
                if isLeapYear(year: year) {
                    // 闰年
                    do {
                        // 检测出生日期的合法性
                        regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$", options: .caseInsensitive)
                    } catch {}
                } else {
                    do {
                        // 检测出生日期的合法性
                        regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$", options: .caseInsensitive)
                    } catch {}
                }
                numberOfMatch = regex.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, len))
                if numberOfMatch > 0 {
                    var s = 0
                    let jiaoYan = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3]
                    for i in 0 ..< 17 {
                        if let d = Int(str.slice(i ..< (i + 1))) {
                            s += d * jiaoYan[i % 10]
                        } else {
                            return false
                        }
                    }
                    let Y = s % 11
                    let JYM = "10X98765432"
                    let M = JYM.sub(start: Y, length: 1)
                    if M == str.sub(start: 17, length: 1) {
                       return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            default:
                return false
            }
        }
            
        // MARK: 8.12、校验字符串位置是否合理，并返回String.Index
        /// 校验字符串位置是否合理，并返回String.Index
        /// - Parameter original: 位置
        /// - Returns: String.Index
        public func validIndex(original: Int) -> String.Index {
            switch original {
            case ...startIndex.utf16Offset(in: self):
                 return startIndex
            case endIndex.utf16Offset(in: self)...:
                 return endIndex
            default:
                 return index(startIndex, offsetBy: original)
            }
        }

        // MARK: 8.13、隐藏手机号中间的几位
        /// 隐藏手机号中间的几位
        /// - Parameter combine: 隐藏的字符串(替换的类型)
        /// - Returns: 返回隐藏的手机号
        public func hidePhone(combine: String = "****") -> String {
             if self.count >= 11 {
                let pre = self.sub(start: 0, length: 3)
                let post = self.sub(start: 7, length: 4)
                return pre + combine + post
            } else {
                return self
            }
        }

        // MARK:- private 方法
        // MARK: 是否是闰年
        /// 是否是闰年
        /// - Parameter year: 年份
        /// - Returns: 返回是否是闰年
        private func isLeapYear(year: Int) -> Bool {
            if year % 400 == 0 {
                return true
            } else if year % 100 == 0 {
                return false
            } else if year % 4 == 0 {
                return true
            } else {
                return false
            }
        }
    
    
    
    /**
     
     ---------------------------------------、字符串截取的操作
     */
    
    // MARK: 9.1、截取字符串从开始到 index
        /// 截取字符串从开始到 index
        /// - Parameter index: 截取到的位置
        /// - Returns: 截取后的字符串
        public func sub(to index: Int) -> String {
            let end_Index = validIndex(original: index)
            return String(self[startIndex ..< end_Index])
        }
    
    
    // MARK: 9.2、截取字符串从index到结束
    /// 截取字符串从index到结束
   /// - Parameter index: 截取结束的位置
    /// - Returns: 截取后的字符串
    public func sub(from index: Int) -> String {
        let start_index = validIndex(original: index)
        return String(self[start_index ..< endIndex])
    }

    // MARK: 9.3、获取指定位置和长度的字符串
    /// 获取指定位置和大小的字符串
    /// - Parameters:
    ///   - start: 开始位置
    ///   - length: 长度
    /// - Returns: 截取后的字符串
    public func sub(start: Int, length: Int = -1) -> String {
        var len = length
        if len == -1 {
            len = count - start
        }
        let st = index(startIndex, offsetBy: start)
        let en = index(st, offsetBy: len)
        let range = st ..< en
        return String(self[range]) // .substring(with:range)
    }

    // MARK: 9.4、切割字符串(区间范围 前闭后开)
    /**
     https://blog.csdn.net/wang631106979/article/details/54098910
     CountableClosedRange：可数的闭区间，如 0...2
     CountableRange：可数的开区间，如 0..<2
     ClosedRange：不可数的闭区间，如 0.1...2.1
     Range：不可数的开居间，如 0.1..<2.1
     */
    /// 切割字符串(区间范围 前闭后开)
    /// - Parameter range: 范围
    /// - Returns: 切割后的字符串
    public func slice(_ range: CountableRange<Int>) -> String { // 如 sliceString(2..<6)
        /**
         upperBound（上界）
         lowerBound（下界）
         */
        let startIndex = validIndex(original: range.lowerBound)
        let endIndex = validIndex(original: range.upperBound)
        guard startIndex < endIndex else {
            return ""
        }
        return String(self[startIndex ..< endIndex])
    }

    // MARK: 9.5、用整数返回子字符串开始的位置
    /// 用整数返回子字符串开始的位置
    /// - Parameter sub: 字符串
    /// - Returns: 返回字符串的位置
    public func position(of sub: String) -> Int {
        if sub.isEmpty {
            return 0
        }
        var pos = -1
        if let range = self.range(of: sub) {
            if !range.isEmpty {
                pos = distance(from: startIndex, to: range.lowerBound)
            }
        }
        return pos
    }
    
}
