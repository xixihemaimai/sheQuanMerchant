//
//  ViewController.swift
//  SheQuanMC
//
//  Created by mac on 2022/4/22.
//

import UIKit
import LDStreaming


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let reuqest = LDStreamingRequest()
        LDClient.request(reuqest)
        
    }
    


}

