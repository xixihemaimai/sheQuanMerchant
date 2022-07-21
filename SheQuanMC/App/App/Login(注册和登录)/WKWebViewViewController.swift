//
//  WKWebViewViewController.swift
//  App
//
//  Created by mac on 2022/6/21.
//

import UIKit
import WebKit
import Util
class WKWebViewViewController: BaseViewController {

    lazy var wkWebView:WKWebView = {
       let wkWebView = WKWebView()
        wkWebView.navigationDelegate = self
       return wkWebView
    }()
    
    lazy var progressView:UIProgressView = {
       let progressView = UIProgressView()
        progressView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        progressView.trackTintColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        progressView.progressTintColor = UIColor.colorWithDyColorChangObject(lightColor: "#3385ff")
        progressView.transform = CGAffineTransform(scaleX: 1, y: 3)
        progressView.progress = 0.05
        return progressView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(scale(3))
        }
        view.addSubview(wkWebView)
        wkWebView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(progressView.snp.bottom)
        }
        var url:String = ""
        if title == "用户协议"{
            url = "http://27.154.225.198:5600/agreements/#/static?type=399301591522f66fbbca7d0aa42c008e"
        }else if title == "隐私政策"{
            url = "http://27.154.225.198:5600/agreements/#/static?type=6be44947f004161ff927efeed76d5bce"
        }
        let newUrl = URL(string: url)!
        let urlRequest = URLRequest(url: newUrl)
        wkWebView.load(urlRequest)
        wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.isHidden = false
            progressView.setProgress(Float(wkWebView.estimatedProgress), animated: true)
            if wkWebView.estimatedProgress >= 1.0{
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut) {
                    self.progressView.isHidden = true
                } completion: { finished in
                    self.progressView.progress = 0
                }
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if title == "用户协议" || title == "隐私政策"{
            if (!UserDefaults.standard.bool(forKey: isFristLaunchScreen)){
                NotificationCenter.default.post(name: ShowUserPrivacy, object: nil)
            }
        }
    }
    
}



extension WKWebViewViewController:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        progressView.isHidden = true
    }
}

