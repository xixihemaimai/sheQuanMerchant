//
//  ModifyLogisticsViewController.swift
//  App
//
//  Created by mac on 2022/5/9.
//

import UIKit
import Util
import JFPopup




class ModifyLogisticsViewController: BaseViewController {

    //这边要判断是1进入还是2进入的，返回的时候要的事情是不同的
    enum jumpType:Int {
        case listJumpType = 0 //这个是列表进入
        case detailJumpType  //这个是详情进入
    }

    var jump:jumpType = .listJumpType
    
//    var orderInfoModel:OrederInfoModel?
//    var logisticsModel:LogisticsModel?
    var orderId:Int64 = 0
    
    
    
    var orderLogisticsModel:OrderLogisticsModel?
    
    var jumpSuccessBlockListType:(()->Void)?
    var jumpSuccessBlockDetailType:(()->Void)?

    
    lazy var newTableView:UITableView = {
        let newTabelView = UITableView(frame: .zero, style: .plain)
        newTabelView.separatorStyle = .none
        if #available(iOS 11.0, *){
            newTabelView.contentInsetAdjustmentBehavior = .never
        }
        if #available(iOS 15.0, *){
            newTabelView.sectionHeaderTopPadding = 0
        }
        return newTabelView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        let topView = UIView()
        topView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0")
        view.addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(scale(0.5))
        }
        
        view.addSubview(newTableView)
        newTableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
            make.top.equalTo(topView.snp.bottom)
        }
        newTableView.delegate = self
        newTableView.dataSource = self
        newTableView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        newTableView.register(OrderModifyLogisticsCell.self, forCellReuseIdentifier: "OrderModifyLogisticsCell")
        newTableView.register(ReturnGoodsAddressCell.self, forCellReuseIdentifier: "ReturnGoodsAddressCell")
        newTableView.register(LogisticsInformationCell.self, forCellReuseIdentifier: "LogisticsInformationCell")
        
        
        let suerModifyBtn = UIButton()
        if title == "订单发货"{
            suerModifyBtn.setTitle("确认发货", for: .normal)
        }else{
            suerModifyBtn.setTitle("确认修改", for: .normal)
        }
        suerModifyBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        suerModifyBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        suerModifyBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        view.addSubview(suerModifyBtn)
        
        suerModifyBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        suerModifyBtn.layer.cornerRadius = scale(4)
        suerModifyBtn.addTarget(self, action: #selector(sureModifyLogisticsAction), for: .touchUpInside)
        
        reloadOrderLogisticsNetData()
    }
    
    
    //获取订单物流
    func reloadOrderLogisticsNetData(){
        let parameters = ["orderId":orderId]
        NetWorkResultRequest(OrderApi.getOrderLogisticsInfo(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<OrderLogisticsModel>.self, from: data) else { return }
            if let _data = model.data{
                self?.orderLogisticsModel = _data
            }
            self?.newTableView.reloadData()
        } failureCallback: { error, code in
            code.loginOut()
        }
    }
    
    //goodsDetailLabel 选择物流
    @objc func choiceLogisticsAction(goodsDetailBtn:UIButton){
        let logisticsCompanyVc = LogisticsCompanyViewController()
        Coordinator.shared?.pushViewController(self, logisticsCompanyVc, animated: true)
        // 这边要返回选择的物流公司
        logisticsCompanyVc.selectLogisticsSuccessBlock = {[weak self] logisticsModel  in
            self?.orderLogisticsModel?.logistics?.logisticsName = logisticsModel.logisticsName
            self?.orderLogisticsModel?.logistics?.logisticsId = logisticsModel.logisticsId
//            let cell = self?.tableview.cellForRow(at: IndexPath(row: 1, section: 0)) as! LogisticsInformationCell
//            cell.goodsDetailLabel.text = logisticsModel.logisticsName
            self?.newTableView.reloadData()
        }
    }
    
    
    //修改退货地址
    @objc func modifyReturnAddressAction(modifyBtn:UIButton){
        let returnAddressVc = ModifyReturnAddressViewController()
        returnAddressVc.jumpType = 1
        returnAddressVc.title = "退货地址"
        Coordinator.shared?.pushViewController(self, returnAddressVc, animated: true)
        //进入退货地址页面
        returnAddressVc.choiceRetAddressSuccessBlock = {[weak self] retAddressInfoModel in
            self?.orderLogisticsModel?.retAddress = retAddressInfoModel
            self?.newTableView.reloadData()
        }
    }
    
    
    //确认修改物流
    @objc func sureModifyLogisticsAction(suerModifyBtn:UIButton){
        let cell = newTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! LogisticsInformationCell
        if (cell.expressTextField.text?.count ?? 0) < 1{
            JFPopup.toast(hit: "请填写快递单号")
            return
        }
        if cell.goodsDetailLabel.text == "请选择物流公司"{
            JFPopup.toast(hit: "请选择物流")
            return
        }
        let parameters = ["expressNo":cell.expressTextField.text as Any,"logisticsId":orderLogisticsModel?.logistics?.logisticsId as Any,"logisticsType":orderLogisticsModel?.logistics?.logisticsType as Any,"orderId":orderId as Any,"retAddressId":(self.orderLogisticsModel?.retAddress?.retAddressId != nil ? self.orderLogisticsModel?.retAddress?.retAddressId : 0)as Any] as [String:Any]
        if title == "订单发货"{
            NetWorkResultRequest(OrderApi.confirmShipment(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
                if self?.jump == .listJumpType{
                    self?.jumpSuccessBlockListType?()
                }else{
                    self?.jumpSuccessBlockDetailType?()
                }
                Coordinator.shared?.popViewController(self!, true)
                NotificationCenter.default.post(name: ChangeOrderCount, object: nil)
            } failureCallback: { error, code in
                code.loginOut()
            }
        }else{
            //修改物流
            NetWorkResultRequest(OrderApi.modiyLogistics(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
                if self?.jump == .listJumpType{
                    self?.jumpSuccessBlockListType?()
                }else{
                    self?.jumpSuccessBlockDetailType?()
                }
                Coordinator.shared?.popViewController(self!, true)
//                NotificationCenter.default.post(name: NSNotification.Name("changeOrderCount"), object: nil)
            } failureCallback: { error, code in
                code.loginOut()
            }
        }
    }
    
}


extension ModifyLogisticsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if orderLogisticsModel?.retAddress == nil{
//            return 2
//        }else{
            return 3
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderModifyLogisticsCell") as! OrderModifyLogisticsCell
            cell.orderLogisticsModel = orderLogisticsModel
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogisticsInformationCell") as! LogisticsInformationCell
            cell.goodsDetailBtn.addTarget(self, action: #selector(choiceLogisticsAction), for: .touchUpInside)
            cell.logistics = orderLogisticsModel?.logistics
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnGoodsAddressCell") as! ReturnGoodsAddressCell
            cell.modifyBtn.addTarget(self, action: #selector(modifyReturnAddressAction), for: .touchUpInside)
            cell.retAddress = orderLogisticsModel?.retAddress
            return cell
        }
    }
}

