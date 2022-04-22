//
//  MainViewController.swift
//  App
//
//  Created by mac on 2022/4/22.
//

import UIKit
import SnapKit

 public class MainViewController: UIViewController {

     
     
     
   public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellow
       
       let view = UIView()
       view.snp.makeConstraints { make in
           make.left.right.top.bottom.equalTo(view)
       }
       
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
