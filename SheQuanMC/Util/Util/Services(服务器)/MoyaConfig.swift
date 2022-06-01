//
//  MoyaConfig.swift
//  GHMoyaNetWorkTest
//
//  Created by Guanghui Liao on 4/3/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

import Foundation
import SwiftUI
import RealmSwift
/// 定义基础域名
public let sheQuanMCURL = "http://27.154.225.198:8996/sqshop/api/"

//header加签
public let appId = "IOS"


/// 定义返回的JSON数据字段
//public let RESULT_CODE = "flag"      //状态码

//public let RESULT_MESSAGE = "message"  //错误消息提示


/*  错误情况的提示
 {
 "flag": "0002",
 "msg": "手机号码不能为空",
 "lockerFlag": true
 }
 **/


//字典之后拼接不同类型的value，最后拼接成字符串
public func getJSONStringFromData(obj:Any,isEscape:Bool) -> String {
    if (!JSONSerialization.isValidJSONObject(obj)) {
        print("无法解析出JSONString")
        return ""
    }
    if let data : NSData = try? JSONSerialization.data(withJSONObject: obj, options: []) as NSData? {
        if var JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue) {
            if isEscape{
                JSONString = JSONString.replacingOccurrences(of: "\\", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
            }
            JSONString = JSONString.replacingOccurrences(of: "{", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
            JSONString = JSONString.replacingOccurrences(of: "}", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
            let fullNameArr = JSONString.components(separatedBy: ",")
            let sortedWords = fullNameArr.sorted()
            var body:String = ""
            for (index,value) in sortedWords.enumerated(){
                if index == 0{
                   body = "{" + value
                }else{
                    body = body + "," + value
                }
            }
            body = body + "}"
            LXFLog("-----------------2-1------------\(body)")
            return body
        }
    }
    return ""
}



public func getArrayOrDicFromJSONString(jsonString:String) -> Any {
    let jsonData:Data = jsonString.data(using: .utf8)!
    //可能是字典也可能是数组，再转换类型就好了
    if let info = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) {
        LXFLog("")
        return info
    }
    LXFLog("=======")
    return ""
}


//发布商品
public func getJSONStringFromPushblish(obj:[String:Any],isEscape:Bool) -> String{
    if (!JSONSerialization.isValidJSONObject(obj)) {
        print("无法解析出JSONString")
        return ""
    }
    if let data : NSData = try? JSONSerialization.data(withJSONObject: obj, options: []) as NSData? {
//        if var JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue) {
//            if isEscape{
//                JSONString = JSONString.replacingOccurrences(of: "\\", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
//            }
////            JSONString = JSONString.replacingOccurrences(of: "{", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
////            JSONString = JSONString.replacingOccurrences(of: "}", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
////            JSONString = JSONString.substring(from: 1) as NSString
////            JSONString = JSONString.substring(to: JSONString.length - 1) as NSString
//            LXFLog("=========\(JSONString)")
//            let jsonData:Data = jsonString.data(using: .utf8)!
            var body:String = ""
            do {
                let items = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? Dictionary<String, Any>
                LXFLog("---2323--------\(items)")
                let dictlist = items?.sorted { t1, t2 in
                    return t1.key < t2.key ? true : false
                }
                if let dicts = dictlist{
                    for (index,element) in dicts.enumerated() {
                        LXFLog(element.key)
                        LXFLog(element.value)
                        if let code = element.value as? Int {
                        let result = String(code)
                          LXFLog("======================\(result)")
                            if index == 0 {
                                if element.key == "freeRefundIn7Days" || element.key == "freightInsure" || element.key == "multiSpec"{
                                    if result == "1"{
                                        body +=  "," + "\"" + element.key + "\"" + ":" + "true"
                                    }else{
                                        body += "," + "\"" + element.key + "\"" + ":" + "false"
                                    }
                                }else{
                                    body += "{" + "\"" + element.key + "\"" + ":" + result
                                }
                            }else{
//                                body += "," + "\"" + element.key + "\"" + ":" + result
                                if element.key == "freeRefundIn7Days" || element.key == "freightInsure" || element.key == "multiSpec"{
                                    if result == "1"{
                                        body += "," + "\"" + element.key + "\"" + ":" + "true"
                                    }else{
                                        body += "," + "\"" + element.key + "\"" + ":" + "false"
                                    }
                                }else{
                                    body += "," + "\"" + element.key + "\"" + ":" + result
                                }
                            }
                        }
                      //productDesc  productId productCode productName
                        if let code = element.value as? String{
                            let result = String(code)
                            if index == 0 {
                                 
                                if element.key == "productDesc" || element.key == "productId" || element.key == "productCode" || element.key == "productName"{
                                    body += "{" + "\"" + element.key + "\"" + ":" + "\"" + result + "\""
                                }else{
                                    body += "{" + "\"" + element.key + "\"" + ":" + result
                                }
                            }else{
                                if element.key == "productDesc" || element.key == "productId" || element.key == "productCode" || element.key == "productName"{
                                    body += "," + "\"" + element.key + "\"" + ":" + "\"" + result + "\""
                                }else{
                                    body += "," + "\"" + element.key + "\"" + ":" + result
                                }
                            }
                        }
                    }
                    body += "}"
                    LXFLog("=========232============\(body)")
                }
            } catch {
                print(error)
                return body
            }
            
            
            
//            if let dict = getArrayOrDicFromJSONString(jsonString: JSONString as String) as? [String:String]{
//
//                LXFLog(dict)
//
//               let dictList = dict.sorted { t1, t2 in
//                   return t1.key < t2.key ? true : false
//                }
//
//
//                for (index,element) in dictList.enumerated() {
//                    LXFLog(element.key)
//                    LXFLog(element.value)
//                }
//
//            }
            

            //"productDesc"商品描述
//            let range = JSONString.range(of: "\"productDesc\":")
//            var productStr = JSONString.substring(from: range.location)
//            let productDescStr = productStr.sub(to: range.length + 2)
//            LXFLog("==========\(productDescStr)")
//            //productDescStr == "\"productDesc\":\"\""
//            if JSONString.contains("productDesc" + ":" + "" + ","){
//                let location = productStr.position(of: ",")
//                productStr = productStr.sub(start: 0, length: location)
//                LXFLog("==========\(productStr)")
//            }else if JSONString.contains("productDesc" + ":" + ""){
//                //最后一行
//                let location = productStr.positionOf(sub: "\"", backwards: true)
//                productStr = productStr.sub(start: 0, length: location)
//                LXFLog("==========\(productStr)")
//            }else{
//                LXFLog("==========\(productStr)")
//                let location = productStr.position(of: "]")
//                productStr = productStr.sub(start: 0, length: location + 2)
//                LXFLog("========\(productStr)")
//            }
//
//            //图片
//            let range1 = JSONString.range(of: "\"productPics\":")
//            var productPicsStr = JSONString.substring(from: range1.location)
//            let productPStr = productPicsStr.sub(to: range1.length + 2)
//            if productPStr == "\"productPics\":[]"{
//                let location = productPicsStr.position(of: "]")
//                productPicsStr = productPicsStr.sub(start: 0, length: location + 2)
//                LXFLog("==========\(productPicsStr)")
//            }else{
//
//                LXFLog("==========\(productPicsStr)")
//                let location = productPicsStr.position(of: "]")
//                productPicsStr = productPicsStr.sub(start: 0, length: location + 2)
//                LXFLog("========\(productPicsStr)")
//            }
//
//
//            LXFLog("=====================================================================")
//            //skus     价格库存 里面  specs 商品规格
//            let range2 = JSONString.range(of: "\"skus\":")
//            var skusStr = JSONString.substring(from: range2.location)
//            let skusPStr = skusStr.sub(to: range2.length + 4)
//            LXFLog("+=========\(skusPStr)")
//            if skusPStr == "\"skus\":\"[]\""{
//                let location = skusStr.position(of: ",")
//                skusStr = skusStr.sub(start: 0, length: location + 2)
//                LXFLog("==========\(skusStr)")
//            }else if skusPStr == "\"skus\":\"[]\"," {
//                let location = skusStr.position(of: "]")
//                skusStr = skusStr.sub(start: 0, length: location + 3)
//                LXFLog("==========\(skusStr)")
//            }else{
//                LXFLog("==========\(skusStr)")
//                let location = skusStr.positionOf(sub: "stock", backwards: true)
//                let newSkustr = skusStr.sub(start: 0, length: location)
//                let ssstr = skusStr
//                var str = ssstr.replacingOccurrences(of: newSkustr, with: "")
//                let newlocation = str.position(of: "}]")
//                str = str.sub(start: 0, length: newlocation + 4)
////                skusStr += str
//                skusStr = newSkustr + str
//                LXFLog("----------\(str)")
//                LXFLog("========\(skusStr)")
//            }
//
//            LXFLog("==3-====================================================")
//            //specs    商品规格
//            let range3 = JSONString.range(of: "\"specs\":")
//            var specsStr = JSONString.substring(from: range3.location)
//            let SpecsPStr = specsStr.sub(to: range3.length + 4)
//            LXFLog("+=========\(SpecsPStr)")
//            if SpecsPStr == "\"specs\":\"[]\""{
//                let location = specsStr.position(of: "]")
//                specsStr = specsStr.sub(start: 0, length: location + 2)
//                LXFLog("==========\(specsStr)")
//            }else if SpecsPStr == "\"specs\":\"[]\","{
//                let location = specsStr.position(of: ",")
//                specsStr = specsStr.sub(start: 0, length: location + 3)
//                LXFLog("==========\(specsStr)")
//            }else{
//                let location = specsStr.position(of: "}]")
//                specsStr = specsStr.sub(start: 0, length: location + 4)
//                LXFLog("========\(specsStr)")
//            }
//
//            LXFLog("==4-====================================================")
//
//            //spus     商品参数(Spu)
//            let range4 = JSONString.range(of: "\"spus\":")
//            var spusStr = JSONString.substring(from: range4.location)
//            let SpusPStr = spusStr.sub(to: range4.length + 4)
//            LXFLog("+=========\(SpusPStr)")
//            if SpusPStr == "\"spus\":\"[]\""{
//                let location = spusStr.position(of: "]")
//                spusStr = spusStr.sub(start: 0, length: location + 3)
//                LXFLog("==========\(spusStr)")
//            }else if SpecsPStr == "\"specs\":\"[]\","{
//                let location = spusStr.position(of: "]")
//                spusStr = spusStr.sub(start: 0, length: location + 2)
//                LXFLog("==========\(spusStr)")
//            }
//            else{
//                let location = spusStr.position(of: "}]")
//                spusStr = spusStr.sub(start: 0, length: location + 4)
//                LXFLog("========\(spusStr)")
//            }
//
//            JSONString = JSONString.replacingOccurrences(of: productStr, with: "") as NSString
//            JSONString = JSONString.replacingOccurrences(of: productPicsStr, with: "") as NSString
//            JSONString = JSONString.replacingOccurrences(of: skusStr, with: "") as NSString
//            JSONString = JSONString.replacingOccurrences(of: specsStr, with: "") as NSString
//            JSONString = JSONString.replacingOccurrences(of: spusStr, with: "") as NSString
//
//
//            LXFLog("====================================\(JSONString)")
//
//             //这边就是对jsonstring进行添加
//            //
////            NSString *str=[NSString initWithFormat:@"%@,%@" , a , b];
////            JSONString = (JSONString as String) + "\"productDesc\":\"\"," + "\"productPics\":[]," + "\"skus\":[]," +  "\"specs\":[]," + "\"spus\":[],"
//
////            JSONString = JSONString.stringByAppendingFormat("%@%@%@%%@", "\"productDesc\":\"\",","\"productPics\":[],","\"skus\":[],", "\"specs\":[],","\"spus\":[],")
//
//            let str = "," + "productDesc" + ":" + "\"\"" + "," + "productPics" + ":" + "[]" + "," + "skus" + ":" + "[]" + "," + "specs" + ":" + "[]" + "," + "spus" + ":" + "[]"
//            //.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
//            JSONString = ((JSONString as String) + str) as NSString
//
//            LXFLog("==========32=========================\(JSONString)")
//
//
//            //这边要做得就是对一些有""""的进行删除skus":"[]" ,"specs":"[]" "spus":"[]"
//           skusStr = skusStr.sub(to: skusStr.count - 1)
//            let skusIndex = skusStr.position(of: ":")
//            skusStr = skusStr.sub(from: skusIndex + 1)
//            LXFLog("============\(skusStr)")
//            skusStr = "\"skus\":" + skusStr.sub(to: skusStr.count - 1)
//            LXFLog("----------------\(skusStr)")
//
//
//            specsStr = specsStr.sub(to: skusStr.count - 1)
//            let specsStrIndex = specsStr.position(of: ":")
//            specsStr = specsStr.sub(from: specsStrIndex + 1)
//            specsStr = "\"specs\":" + specsStr.sub(to: specsStr.count - 1)
//            LXFLog("----------------\(specsStr)")
//
//
//            spusStr = spusStr.sub(to: skusStr.count - 1)
//            let spusStrIndex = spusStr.position(of: ":")
//            spusStr = spusStr.sub(from: spusStrIndex + 1)
//            spusStr = "\"spus\":" + spusStr.sub(to: spusStr.count - 1)
//            LXFLog("----------------\(spusStr)")



//
//            let charset = CharacterSet(charactersIn: ",}]")
//            let fullNameArr = (JSONString as String).components(separatedBy: charset)
//            LXFLog(fullNameArr)
//            LXFLog("+==============\(fullNameArr.count)")
//            let sortedWords = fullNameArr.sorted()
//            LXFLog("=============\(sortedWords)")
//            var body:String = ""
//            for (index,var value) in sortedWords.enumerated(){
////                if value == "\"productDesc\":"{
////                    let productDescStr = str.sub(to: 2)
////                    if productDescStr != "\"\""{
////                        value +=  str + "\""
////                    }
////                }
////                if value == "\"productPics\":"{
////                    let productPicsStr = strPic.sub(to: 2)
////                    if productPicsStr != "[]"{
////                        value +=  strPic
////                    }
////                }
//
//
//                if index == 0{
//                   body = "{" + value
//                }else{
//                    body = body + "," + value
//                }
//            }
//            body = body + "}"
////            LXFLog("-----------------2-1------------\(body)")
//            return body
//        }
        return body
    }
    return ""
}







//生成随机数
public func generateRandomNumber(_ numDigits:Int) -> Int{
   var place = 1
   var finalNumber = 0
    for _ in 0..<numDigits  {
        place *= 10
        let randomNumber = arc4random_uniform(10)
        finalNumber += (Int(randomNumber) * place)
    }
   return finalNumber
}

//获取sign的值--没有data的情况下
public func obtainSignValue(_ time:String,_ nonce:String,_ deviceId:String) -> String{
    var sign:String = ""
    sign = "accessToken=" + (StoreService.shared.accessToken ?? "") + "&apiVer=" + String.apiVersion + "&appId=" + appId +  "&appSecret=1f794aa641b5c1528e92aaf38074d35c&appVer=" + String.appVersion + "&data=&deviceId=" + deviceId + "&nonce=" + nonce + "&timeStamp=" + time
    sign = sign.md5
    return sign
}

//获取sign的值--有data的情况下
public func obtainSignValueData(_ time:String,_ nonce:String,_ deviceId:String,_ data:String) -> String{
    var sign:String = ""
    sign = "accessToken=" + (StoreService.shared.accessToken ?? "") + "&apiVer=" + String.apiVersion + "&appId=" + appId + "&appSecret=1f794aa641b5c1528e92aaf38074d35c&appVer=" + String.appVersion + "&data=" + data + "&deviceId=" + deviceId + "&nonce=" + nonce + "&timeStamp=" + time
    LXFLog(sign)
    sign = sign.md5
    LXFLog(sign)
    return sign
}


//字典的value是相同的拼接的字符串
public func dictSory(_ parameters:[String:String]) -> String{
    let keys = parameters.sorted { t1, t2 in
        return t1.0 < t2.0
    }
    LXFLog(keys)
    var returnStr:String = ""
    for (index,value) in keys.enumerated() {
        LXFLog(value.value)
            if index == 0{
                returnStr = "{" + "\"" + value.key + "\"" + ":" + "\"" + value.value + "\""
            }else{
                returnStr = returnStr + "," + "\"" + value.key + "\"" + ":" + "\"" + value.value + "\""
            }
        if index == keys.count - 1{
            returnStr = returnStr + "}"
        }
    }
//    LXFLog("--21----12-------------------\(returnStr)")
    return returnStr
}



//请求参数最后的部分的转换
public func getObjFromDataToData(obj:Data,isEscape:Bool) -> Data{
    var parames = (String(data: obj, encoding: String.Encoding.utf8) ?? "")
    if isEscape{
        parames = parames.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
    }
    parames = parames.replacingOccurrences(of: "{", with: "", options: .literal, range: nil)
    parames = parames.replacingOccurrences(of: "}", with: "", options: .literal, range: nil)
    let fullNameArr = parames.components(separatedBy: ",")
    let sortedWords = fullNameArr.sorted()
    var body:String = ""
    for (index,value) in sortedWords.enumerated(){
        if index == 0{
           body = "{" + value
        }else{
            body = body + "," + value
        }
    }
    body = body + "}"
//    LXFLog("-----------------------\(body)")
    return body.data(using: String.Encoding.utf8)!
}

//发布商品进行整理
public func getJSONStringFromPushblishData(obj:Data,isEscape:Bool) -> Data{
    //    if var JSONString = NSString(data:obj,encoding: String.Encoding.utf8.rawValue) {
    //        if isEscape{
    //            JSONString = JSONString.replacingOccurrences(of: "\\", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
    //        }
    ////        JSONString = JSONString.replacingOccurrences(of: "{", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
    ////        JSONString = JSONString.replacingOccurrences(of: "}", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
    //
    //        LXFLog("------------------32233---------------\(JSONString)")
    var body:String = ""
    do {
        let items = try? JSONSerialization.jsonObject(with: obj, options: []) as? Dictionary<String, Any>
//        LXFLog("---2323--------\(items)")
        let dictlist = items?.sorted { t1, t2 in
            return t1.key < t2.key ? true : false
        }
        if let dicts = dictlist{
            for (index,element) in dicts.enumerated() {
                LXFLog(element.key)
                LXFLog(element.value)
                if let code = element.value as? Int {
                    let result = String(code)
//                    LXFLog("======================\(result)")
                    if index == 0 {
                        if element.key == "freeRefundIn7Days" || element.key == "freightInsure" || element.key == "multiSpec"{
                            if result == "1"{
                                body +=  "," + "\"" + element.key + "\"" + ":" + "true"
                            }else{
                                body += "," + "\"" + element.key + "\"" + ":" + "false"
                            }
                        }else{
                            body += "{" + "\"" + element.key + "\"" + ":" + result
                        }
                    }else{
                        //                                body += "," + "\"" + element.key + "\"" + ":" + result
                        if element.key == "freeRefundIn7Days" || element.key == "freightInsure" || element.key == "multiSpec"{
                            if result == "1"{
                                body += "," + "\"" + element.key + "\"" + ":" + "true"
                            }else{
                                body += "," + "\"" + element.key + "\"" + ":" + "false"
                            }
                        }else{
                            body += "," + "\"" + element.key + "\"" + ":" + result
                        }
                    }
                }
                //productDesc  productId productCode productName
                if let code = element.value as? String{
                    let result = String(code)
                    if index == 0 {
                        
                        if element.key == "productDesc" || element.key == "productId" || element.key == "productCode" || element.key == "productName"{
                            body += "{" + "\"" + element.key + "\"" + ":" + "\"" + result + "\""
                        }else{
                            body += "{" + "\"" + element.key + "\"" + ":" + result
                        }
                    }else{
                        if element.key == "productDesc" || element.key == "productId" || element.key == "productCode" || element.key == "productName"{
                            body += "," + "\"" + element.key + "\"" + ":" + "\"" + result + "\""
                        }else{
                            body += "," + "\"" + element.key + "\"" + ":" + result
                        }
                    }
                }
            }
            body += "}"
            LXFLog("=========232============\(body)")
        }
     } catch {
         print(error)
         return "".data(using: String.Encoding.utf8)!
      }
    return body.data(using: String.Encoding.utf8)!
//    }
//    return "".data(using: String.Encoding.utf8)!
}
