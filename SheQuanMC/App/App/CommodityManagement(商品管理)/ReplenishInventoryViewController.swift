//
//  ReplenishInventoryViewController.swift
//  App
//
//  Created by mac on 2022/4/28.
//

import UIKit
import Util
import SDWebImage

class ReplenishInventoryViewController: BaseViewController {

    
    
    //底部增加一个发布按键
    lazy var saveBtn:UIButton = {
       let saveBtn = UIButton()
        saveBtn.setTitle("保存", for: .normal)
        saveBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF"), for: .normal)
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        saveBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        
        return saveBtn
    }()
    
    
    //增加一个UIView
    lazy var bottomView:UIView = {
       let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return bottomView
    }()
    
    
    var goodsImageViews:UIImageView!
    var goodsLabels:UILabel!
    
    
    var productId:Int64 = 0
    
    
    var model:soldOutSkuListModel?
    
    //补仓成功之后的回调
    var successBlock:(()->Void)?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "商品管理"
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(scale(0.5))
        }
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(ReplenishInventoryCell.self, forCellReuseIdentifier: "ReplenishInventoryCell")
        customTableviewHeaderView()
        
        tableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Height_TabBar, right: 0)
        
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
//            make.height.equalTo(Height_TabBar)
            make.height.equalTo(iPhoneX ? scale(92) : scale(58))
        }
        
        bottomView.addSubview(saveBtn)
        saveBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        saveBtn.layer.cornerRadius = scale(4)
        
        saveBtn.addTarget(self, action: #selector(saveReplenishAction), for: .touchUpInside)
    }
    
    func customTableviewHeaderView(){
        let HeaderView = UIView()
        HeaderView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        tableview.tableHeaderView = HeaderView
        HeaderView.snp.makeConstraints { make in
            make.left.equalTo(tableview.snp.left)
            make.width.equalTo(SCW)
            make.top.equalToSuperview()
            make.height.equalTo(scale(157))
        }
        
        let goodsImageView = UIImageView()
        goodsImageView.image = UIImage(named: "Rectangle 2363")
        HeaderView.addSubview(goodsImageView)
        
        goodsImageView.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(15))
            make.width.height.equalTo(scale(78))
        }
        goodsImageView.layer.cornerRadius = scale(2)
        goodsImageView.layer.borderWidth = scale(0.5)
        goodsImageView.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#E0E0E0").cgColor
        goodsImageView.contentMode = .scaleAspectFill
        goodsImageView.layer.masksToBounds = true
        goodsImageViews = goodsImageView
        
        let goodsLabel = UILabel()
        goodsLabel.text = "商品名称Nike耐克官方AIR MONARCHIV男子训练鞋运懂老爹鞋休闲鞋"
        goodsLabel.numberOfLines = 2
        goodsLabel.lineBreakMode = .byCharWrapping
        goodsLabel.textAlignment = .left
        goodsLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        goodsLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        HeaderView.addSubview(goodsLabel)
        goodsLabel.snp.makeConstraints { make in
            make.left.equalTo(goodsImageView.snp.right).offset(scale(12))
            make.right.equalTo(-scale(16))
            make.top.equalTo(scale(32))
            make.height.equalTo(scale(40))
        }
        goodsLabels = goodsLabel
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        HeaderView.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(goodsImageView.snp.bottom).offset(scale(12))
            make.height.equalTo(scale(8))
        }
        
        let stockLabel = UILabel()
        stockLabel.text = "以下规格库存为0，请补充"
        stockLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        stockLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .regular)
        HeaderView.addSubview(stockLabel)
        stockLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.top.equalTo(bottomView.snp.bottom).offset(scale(10))
            make.height.equalTo(scale(22))
        }
        let diviver = UIView()
        diviver.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        HeaderView.addSubview(diviver)
        diviver.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(scale(1))
        }
        
        loadSoldOutSkuList()
        
        tableview.layoutIfNeeded()
        
    }
    
    
    func loadSoldOutSkuList(){
        let parameter = ["productId":productId as Any] as [String:Any]
        NetWorkResultRequest(OrderApi.getSoldOutSkuList(parameters: parameter), needShowFailAlert: true) { result, data in
            guard let model = try? JSONDecoder().decode(GenericResponse<soldOutSkuListModel>.self, from: data) else { return }
            if let data1 = model.data{
               self.model = data1
                LXFLog("+========================\(String(describing: self.model))")
               self.goodsImageViews.sd_setImage(with: URL(string: (self.model?.productPic ?? "")), placeholderImage: UIImage(named: "Rectangle 2363"))
               self.goodsLabels.text = data1.productName
               self.tableview.reloadData()
            }
        } failureCallback: { error, code in
            code.loginOut()
        }
    }
    
    
    //补库存
    @objc func saveReplenishAction(saveBtn:UIButton){
        var stockList:[SkuStockInfoModel] = [SkuStockInfoModel]()
        for i in 0..<(model?.skus?.count ?? 0) {
            let skus = model?.skus?[i]
            let cell = tableview.cellForRow(at: IndexPath(row: i, section: 0)) as! ReplenishInventoryCell
            LXFLog(cell.addTextField.text)
            let skuStcokInfoModel = SkuStockInfoModel(skuId: skus?.skuId, stock: Int32(cell.addTextField.text ?? "0"))
            stockList.append(skuStcokInfoModel)
        }
        var specsLists:String = "["
        for n in 0..<stockList.count{
            let skuStcokInfoModel = stockList[n]
            let specsDict = ["skuId":skuStcokInfoModel.skuId as Any,"stock":skuStcokInfoModel.stock as Any] as [String:Any]
            let jsonstring = getJSONStringFromData(obj: specsDict, isEscape: true)
            if n == 0{
                specsLists += jsonstring
            }else
            {
                specsLists += "," + jsonstring
            }
        }
        specsLists += "]"
        let parameters = ["productId":productId,"skuStocks":(specsLists.count > 0 ? specsLists : [SkuStockInfoModel]())] as [String:Any]
        NetWorkResultRequest(OrderApi.repairStock(parameters: parameters), needShowFailAlert: true) { result, data in
            Coordinator.shared?.popViewController(self, true)
            //这边还要做一个处理回调
            self.successBlock!()
        } failureCallback: { error, code in
            code.loginOut()
        }
    }
    
    
}


extension ReplenishInventoryViewController:UITableViewDelegate,UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.skus?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReplenishInventoryCell")
        as! ReplenishInventoryCell
        cell.model = model?.skus?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
}
