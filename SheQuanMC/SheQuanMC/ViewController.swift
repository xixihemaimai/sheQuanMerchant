//
//  ViewController.swift
//  SheQuanMC
//
//  Created by mac on 2022/4/22.
//

import UIKit
import LDStreaming
import LDMessage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let req = LDStreamingRequest()
        req.eventType = DLMEventType.pullOffLineInfo.rawValue
//        let body = DLMPullOffLineInfoReq()
        LDClient.request(req)
        
        
    }
    


}

