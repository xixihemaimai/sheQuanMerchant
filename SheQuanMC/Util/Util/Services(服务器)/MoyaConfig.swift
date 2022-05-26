//
//  MoyaConfig.swift
//  GHMoyaNetWorkTest
//
//  Created by Guanghui Liao on 4/3/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

import Foundation
import SwiftUI
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
func getJSONStringFromData(obj:Any,isEscape:Bool) -> String {
    if (!JSONSerialization.isValidJSONObject(obj)) {
        print("无法解析出JSONString")
        return ""
    }
    if let data : NSData = try? JSONSerialization.data(withJSONObject: obj, options: []) as NSData? {
        if var JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue) {
            LXFLog(JSONString)
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


//生成随机数
func generateRandomNumber(_ numDigits:Int) -> Int{
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
func obtainSignValue(_ time:String,_ nonce:String,_ deviceId:String) -> String{
    var sign:String = ""
    sign = "accessToken=" + (StoreService.shared.accessToken ?? "") + "&apiVer=" + String.apiVersion + "&appId=" + appId +  "&appSecret=1f794aa641b5c1528e92aaf38074d35c&appVer=" + String.appVersion + "&data=&deviceId=" + deviceId + "&nonce=" + nonce + "&timeStamp=" + time
    sign = sign.md5
    return sign
}

//获取sign的值--有data的情况下
func obtainSignValueData(_ time:String,_ nonce:String,_ deviceId:String,_ data:String) -> String{
    var sign:String = ""
    sign = "accessToken=" + (StoreService.shared.accessToken ?? "") + "&apiVer=" + String.apiVersion + "&appId=" + appId + "&appSecret=1f794aa641b5c1528e92aaf38074d35c&appVer=" + String.appVersion + "&data=" + data + "&deviceId=" + deviceId + "&nonce=" + nonce + "&timeStamp=" + time
    LXFLog(sign)
    sign = sign.md5
    LXFLog(sign)
    return sign
}


//字典的value是相同的拼接的字符串
func dictSory(_ parameters:[String:String]) -> String{
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
    LXFLog("--21----12-------------------\(returnStr)")
    return returnStr
}



//请求参数最后的部分的转换
func getObjFromDataToData(obj:Data,isEscape:Bool) -> Data{
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
    LXFLog("-----------------------\(body)")
    return body.data(using: String.Encoding.utf8)!
}

