//
//  NoDeliveryViewController.swift
//  App
//
//  Created by mac on 2022/5/12.
//

import UIKit
import Util
import JFPopup

class NoDeliveryViewController: BaseViewController {
    
    
    var addressList:[AddressModel] = [AddressModel]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "不配送区域"
        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(-scale(92))
        }
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(NoDeliveryCell.self, forCellReuseIdentifier: "NoDeliveryCell")
        
        
        let addRegionBtn = UIButton()
        addRegionBtn.setTitle("添加区域", for: .normal)
        addRegionBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        addRegionBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addRegionBtn.setImage(UIImage(named: "Group 2688"), for: .normal)
        addRegionBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        addRegionBtn.addTarget(self, action: #selector(addRegionNoDeliveryAction), for: .touchUpInside)
        view.addSubview(addRegionBtn)
        
        addRegionBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(-scale(34))
        }
        
        addRegionBtn.layer.cornerRadius = scale(4)
        
    }
    

    
    //添加区域不配送
    @objc func addRegionNoDeliveryAction(addRegionBtn:UIButton){
        LXFLog("添加不配送区域")
        
        self.popup.bottomSheet {
            
            let nodeliveryRegionView = NoDeliveryRegionView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(442)), addressList: addressList)
            
            nodeliveryRegionView.cancelBlock = {[weak self] in
                self?.popup.dismissPopup()
                
            }
            
            
            nodeliveryRegionView.sureChoiceAddress = {[weak self] list in
                self?.popup.dismissPopup()
                
            }
            
            
            return nodeliveryRegionView
        }
       
    }
    
    
    //这边设置图片为空
    override func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage()
    }
   
    //并设置文字
    override func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "暂无不配送区域"
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: scale(14), weight: .regular),NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor: "#999999")]
        return NSAttributedString(string: text, attributes: attributes)
    }

}

extension NoDeliveryViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoDeliveryCell") as! NoDeliveryCell
        return cell
    }
    
    
    
}
