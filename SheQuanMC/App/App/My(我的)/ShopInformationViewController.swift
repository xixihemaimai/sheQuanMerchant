//
//  ShopInformationViewController.swift
//  App
//
//  Created by mac on 2022/6/28.
//

import UIKit
import Util
import JFPopup
import HXPhotoPicker
import SwiftyJSON

class ShopInformationViewController: BaseViewController {
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "店铺信息"
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        tableview.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#f8f8f8")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(shopInfomationCell.self, forCellReuseIdentifier: "shopInfomationCell")
    }
}


extension ShopInformationViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 4
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return scale(0)
        }else{
            return scale(8)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopInfomationCell") as! shopInfomationCell
        
        if indexPath.section == 0{
            cell.shopInfoName.isHidden = true
            cell.shopAvavr.sd_setImage(with: URL(string: StoreService.shared.currentUser?.shopAvatar ?? ""), placeholderImage: UIImage(named: "Group 2784"))
        }else{
            if indexPath.row == 0{
                cell.shopTypeName.text = "店铺名称"
                cell.shopInfoName.text = StoreService.shared.currentUser?.shopName
            }else if indexPath.row == 1{
                cell.shopTypeName.text = "店铺ID"
                cell.shopInfoName.text = String(StoreService.shared.currentUser?.shopId ?? 0)
            }else if indexPath.row == 2{
                cell.shopTypeName.text = "主营类目"
                cell.shopInfoName.text = StoreService.shared.currentUser?.categoryName
            }else{
                cell.shopTypeName.text = "店铺二维码"
                cell.shopInfoName.isHidden = true
            }
            cell.shopAvavr.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0{
            // 获取相册和拍照
            manager.type = .photo
            manager.clearSelectedList()
            self.popup.actionSheet {
                [
                    JFPopupAction(with: "从手机相册选择", subTitle: nil, clickActionCallBack: { [weak self] in
                        self?.hx_presentSelectPhotoController(with: self?.manager, didDone: { allList, photoList, videoList, isOriginal, viewController, manager in
                            LXFLog(photoList?.count)
                            if let photoModel:HXPhotoModel = photoList?.first{
                                //对图片进行
                                //网络请求的部分
                                let Parameters = ["fileType":20]
                                JFPopupView.popup.loading(hit: "上传图片中....")
                                guard let imageData = photoModel.thumbPhoto?.jpegData(compressionQuality: 0.3) else { return }//把图片转换成data
                                NetWorkResultRequest(StoreAppleApi.uploadFile(parameters: Parameters, imageDate: imageData), needShowFailAlert: true) { result, data in
                                    do{
                                        LXFLog(data)
                                        let json = try JSON(data: data)
                                        //去掉\
                                        let str = (json["data"]["cloudUrl"].string ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                        LXFLog(str)
                                        
                                        let cell = tableView.cellForRow(at: indexPath) as! shopInfomationCell
                                        cell.shopAvavr.sd_setImage(with: URL(string: str), placeholderImage: UIImage(named: "Group 2784"))
                                        StoreService.shared.updateShopAvatar(str)
                                        
                                        //这边要发送通知和回调
                                        NotificationCenter.default.post(name: NSNotification.Name("modifyShopAvater"), object: nil)
                                        
                                        
                                        
                                        
                                    }catch{}
                                    JFPopupView.popup.hideLoading()
                                } failureCallback: { error,code in
                                    JFPopupView.popup.hideLoading()
                                }
                            }
                        })
                    }),
                    JFPopupAction(with: "拍照", subTitle: nil, clickActionCallBack: {[weak self] in
                        self?.hx_presentCustomCameraViewController(with: self?.manager) { photoList, viewController in
                            LXFLog(photoList)
                            if let photoModel:HXPhotoModel = photoList{
                                //网络请求的部分
                                let Parameters = ["fileType":20]
                                JFPopupView.popup.loading(hit: "上传图片中....")
                                guard let imageData = photoModel.thumbPhoto?.jpegData(compressionQuality: 0.3) else { return }//把图片转换成data
                                NetWorkResultRequest(StoreAppleApi.uploadFile(parameters: Parameters, imageDate: imageData), needShowFailAlert: true) { result, data in
                                    do{
                                        LXFLog(data)
                                        let json = try JSON(data: data)
                                        let str = (json["data"]["cloudUrl"].string ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                                          LXFLog(str)
                                        
                                        let cell = tableView.cellForRow(at: indexPath) as! shopInfomationCell
                                        cell.shopAvavr.sd_setImage(with: URL(string: str), placeholderImage: UIImage(named: "Group 2784"))
                                        StoreService.shared.updateShopAvatar(str)
                                        
                                        //这边要发送通知和回调
                                        NotificationCenter.default.post(name: NSNotification.Name("modifyShopAvater"), object: nil)
                                        
                                        
                                        
                                    }catch{}
                                    JFPopupView.popup.hideLoading()
                                } failureCallback: { error,code in
                                    JFPopupView.popup.hideLoading()
                                }
                            }
                        } cancel: { viewController in
                        }
                    })
                ]
            }
        }else{
            
            if indexPath.row == 0{
                //店铺名称
                let modifyShopNameVc = ModifyShopNameViewController()
                Coordinator.shared?.pushViewController(self, modifyShopNameVc, animated: true)
                
                
                
                
            }else if indexPath.row == 2{
                //主营类目
                let businessTypeVc = BusinessTypeViewController()
                Coordinator.shared?.pushViewController(self, businessTypeVc, animated: true)
                //这边是返回选择是哪个经营种类
                businessTypeVc.sureSelectBusinessType = { businessTypeModel in
                    //这边要获取这个模型
//                    self?.categoryId = businessTypeModel.categoryId
                    let cell = tableView.cellForRow(at: indexPath) as! shopInfomationCell
                    cell.shopInfoName.text = businessTypeModel.categoryName
                    StoreService.shared.updateCategoryName(businessTypeModel.categoryName ?? "", businessTypeModel.categoryId ?? 0)
                }
            }else if indexPath.row == 3{
                //店铺二维码
              let myQRVc = MyQRCodeViewController()
              Coordinator.shared?.pushViewController(self, myQRVc, animated: true)
                  
            }
        }
    }
    
}
