//
//  CommodityParametersViewController.swift
//  App
//
//  Created by mac on 2022/5/5.
//

import UIKit
import Util
import JFPopup
import HXPhotoPicker

class CommodityParametersViewController: BaseViewController {
    
    
    var parametersList:[String] = [String]()
    
    
    lazy var manager:HXPhotoManager = {
       let manager = HXPhotoManager()
        manager.configuration.openCamera = true
        manager.configuration.photoMaxNum = 1
        //是否可以单选模式下选择图片跳转到编辑界面
        manager.configuration.singleJumpEdit = true
        //是否可以裁剪
        manager.configuration.movableCropBox = true
        //是否可以移动裁剪编辑大小
        manager.configuration.movableCropBoxEditSize = true
        //是否可以保存到媒体库
        manager.configuration.saveSystemAblum = true
        manager.configuration.hideOriginalBtn = false
        return manager
    }()
    
   // 确认按键
    lazy var sureBtn:UIButton = {
       let sureBtn = UIButton()
        sureBtn.setTitle("确认", for: .normal)
        sureBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#FFFFFF"), for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        sureBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        return sureBtn
    }()
    
    
    //增加一个UIView
    lazy var bottomView:UIView = {
       let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return bottomView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "商品参数"
        
        view.addSubview(tableview)
        
        tableview.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(CommodityParametersCell.self, forCellReuseIdentifier: "CommodityParametersCell")
        
        parametersList = ["正品证书","品牌","参数一","参数二","参数三"]
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(Height_TabBar)
        }
        
        bottomView.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.top.equalTo(iPhoneX ? scale(14) : scale(2.5))
        }
        sureBtn.layer.cornerRadius = scale(4)
        sureBtn.addTarget(self, action: #selector(sureAction), for: .touchUpInside)
        
        
        
        
    }
    
    //确认的按键
    @objc func sureAction(sureBtn:UIButton){
        LXFLog("确认")
    }

   

}

extension CommodityParametersViewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parametersList.count
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommodityParametersCell") as! CommodityParametersCell
        cell.parametersLabel.text = parametersList[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LXFLog(indexPath.row)
        
        switch indexPath.row{
            
        case 0:
            //去获取图片和拍照
                manager.type = .photo
                manager.clearSelectedList()
                self.popup.actionSheet {
                    [
                        JFPopupAction(with: "从手机相册选择", subTitle: nil, clickActionCallBack: { [weak self] in
                            self?.hx_presentSelectPhotoController(with: self?.manager, didDone: { allList, photoList, videoList, isOriginal, viewController, manager in
                                photoList?.forEach({ HXPhotoModel in
                                    //对图片进行
                                    guard let image = HXPhotoModel.thumbPhoto else {
                                        return
                                    }
                                    
                                    //网络请求
                                   
                                })
                            })
                        }),
                        JFPopupAction(with: "拍照", subTitle: nil, clickActionCallBack: {[weak self] in
                            self?.hx_presentCustomCameraViewController(with: self?.manager) { photoList, viewController in
                                LXFLog(photoList)
                                if let photoModel:HXPhotoModel = photoList{
                                    //对图片进行
                                    guard let image = photoModel.thumbPhoto else {
                                        return
                                    }
                                    //网络请求
                                    
                                }
                            } cancel: { viewController in
                            }
                        })
                    ]
                }
        break
        case 1,2,3,4:
            
            //这边是弹起输入的view
            self.popup.bottomSheet {
                let commodityParametersView = CommodityParameterView(frame: CGRect(x: 0, y: 0, width: SCW, height: scale(144)))
                return commodityParametersView
            }
            break
        default:
            break
        }
        
        
        
    }
    

}
