//
//  NewWorkTool.swift
//  测试暗黑和白天模式
//
//  Created by mac on 2022/3/16.
//

import Foundation
import Moya


// 超时时长
private var requestTimeOut: Double = 30
// 成功数据的回调
typealias successCallback = ((NSData) -> Void)
// 失败的回调
typealias failedCallback = ((String) -> Void)
// 网络错误的回调
typealias errorCallback = (() -> Void)

//这边是设置网络请求
let moYaProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)

//网络请求的基本设置，这里可以拿到是具体的那个网络请求，可以在这里做一些设置
private let endpointClosure = { (target:TargetType) -> Endpoint in
    
    let url = target.baseURL.absoluteString + target.path
    var task = target.task
    
    /*
     如果需要在每个请求中都添加类似token参数的参数请取消注释下面代码
     */
//    let additionalParameters = ["token":"888888"]
//    let defaultEncoding = URLEncoding.default
//    switch target.task {
//        ///在你需要添加的请求方式中做修改就行，不用的case 可以删掉。。
//    case .requestPlain:
//        task = .requestParameters(parameters: additionalParameters, encoding: defaultEncoding)
//    case .requestParameters(var parameters, let encoding):
//        additionalParameters.forEach { parameters[$0.key] = $0.value }
//        task = .requestParameters(parameters: parameters, encoding: encoding)
//    default:
//        break
//    }
    
    /*
     如果需要在每个请求中都添加类似token参数的参数请取消注释上面代码
     */
    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData)},
        method: target.method,
        task: task,
        httpHeaderFields: target.headers)
    
    return endpoint
}

// NetworkActivityPlugin插件用来监听网络请求，界面上做相应的展示
/// 但这里我没怎么用这个。。。 loading的逻辑直接放在网络处理里面了
private let networkPlugin = NetworkActivityPlugin.init { changeType, _ in
    print("networkPlugin \(changeType)")
    // targetType 是当前请求的基本信息
    switch changeType {
    case .began:
        print("开始请求网络")
        
//        SVProgressHUD .setDefaultMaskType(SVProgressHUDMaskType.clear)
//        SVProgressHUD .setBackgroundLayerColor(UIColor .blue)
//        SVProgressHUD .setDefaultStyle(SVProgressHUDStyle.light)
//        SVProgressHUD .setForegroundColor(MainColor)
//        SVProgressHUD .setDefaultAnimationType(SVProgressHUDAnimationType.flat)
//        SVProgressHUD .show(withStatus: "加载中")
//        SVProgressHUD .setMinimumDismissTimeInterval(20.0)
        
    case .ended:
        print("结束")
//        SVProgressHUD .dismiss()
    }
}


//网络请求的设置
private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do{
        var request = try endpoint.urlRequest()
        //设置请求时长
        request.timeoutInterval = requestTimeOut
        //打印请求参数
        if let requestData = request.httpBody{
            print("\(request.url!)" + "\n" + "\(request.httpMethod ?? "")" + "发送参数" + "\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
            let parmeterStr = String(data: request.httpBody!, encoding: String.Encoding.utf8)!
            print(parmeterStr)
        }else{
            print("\(request.url!) + \(String(describing: request.httpMethod))")
        }
        done(.success(request))
    }catch{
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

// isCarch: Bool = false , carchID: NSString = "",
func newWorkTool(_ target: TargetType, completion: @escaping successCallback, failed: failedCallback?, errorResult: errorCallback?) -> Cancellable?{
    return moYaProvider.request(MultiTarget(target)){ result in
        switch result {
        case let .success(response):
            do{
//                let jsonData = try JSON(data: response.data)
//                print(jsonData)
//
//                if isCarch == true {
//                    // 缓存
//                    let jsonStr = String(data: response.data, encoding: String.Encoding.utf8) ?? ""
//                    DispatchQueue.global().async {
//                        do {
//                            try jsonStr .write(toFile: disPath, atomically: true, encoding: String.Encoding.utf8)
//                        } catch {
//                            print(error)
//                        }
//                    }
//                }
//                /// 这里的completion和failed判断条件依据不同项目来做，为演示demo我把判断条件注释了，直接返回completion。
//
//                completion(response.data as NSData)
//
//                print("flag不为1000 HUD显示后台返回message" + "\(jsonData[RESULT_MESSAGE].stringValue)")
//
//                if jsonData[RESULT_CODE].stringValue == "1000"{
//                    completion(response.data as NSData)
//                }else{
////                    failed?(String(data: try! response.mapJSON() as! Data, encoding: String.Encoding.utf8)!)
//                }
                
            }catch{
            }
        case let .failure(error):
            print("网络连接失败\(error)")
            errorResult?()
        }
    }
}
