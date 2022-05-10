//
//  BHJPickerView.swift
//  BHJPickerView
//
//  Created by 白华君 on 2018/5/21.
//  Copyright © 2018年 baihuajun. All rights reserved.
//

import UIKit
import Util


/// pickerView类型
///
/// - address//地址:
/// - date//时间:
/// - gender//性别:
public enum BHJPickerViewStyle {
     case address  // 地址
     case date     // 时间
     case gender   // 性别
}

/// PickerDelegate
protocol PickerDelegate {
     
     func selectedAddress(_ pickerView : BHJPickerView,_ procince : AddressModel,_ city : AddressModel,_ area : AddressModel)
     func selectedDate(_ pickerView : BHJPickerView,_ dateStr : Date)
     func selectedGender(_ pickerView : BHJPickerView,_ genderStr : String)
}


class BHJPickerView: UIView , UIPickerViewDelegate, UIPickerViewDataSource{
     
     
     var pickerDelegate : PickerDelegate?
     private var pickerStyle: BHJPickerViewStyle?
     private let pickerH : CGFloat! = scale(260)
     private var addressPicker : UIPickerView = UIPickerView()
     private var datePicker : UIDatePicker = UIDatePicker()
     private var genderPicker : UIPickerView = UIPickerView()
     private var backgroundButton : UIButton = UIButton()
     private var dataArray : NSMutableArray = NSMutableArray()
     private var cityArray : NSMutableArray = NSMutableArray()
     private var districtArray : NSMutableArray = NSMutableArray()
     private var selectedProvince : AddressModel = AddressModel()
     private var selectedCity : AddressModel = AddressModel()
     private var selectedDistrict : AddressModel = AddressModel()
     private var selectedGender : String = String()
     var isAddress : Bool?
     
     // MARK: - 初始化UI
     init(_ delegate : PickerDelegate,_ style : BHJPickerViewStyle){
          
          dataArray.removeAllObjects()
          pickerDelegate = delegate
          pickerStyle = style
          self.pickerStyle = style
          let frame = CGRect.init(x: 0, y: SCH, width: SCW, height: SCH)
          super.init(frame: frame)
          let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCW, height: SCH))
         view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#e6e6e6")
         
         
         
          self.addSubview(view)
          
          // 取消按钮
         let cancelButton = UIButton.init(type: .custom)
          cancelButton.frame = CGRect.init(x: 0, y: 0, width: 60, height: 44)
          cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
          cancelButton.setTitle("取 消", for: .normal)
         cancelButton.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#125dff"), for: .normal)
          cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
          self.addSubview(cancelButton)
          
          // 确定按钮
          let doneButton = UIButton.init(type: .custom)
          doneButton.frame = CGRect.init(x: SCW - 60, y: 0, width: 60, height: 44)
          doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
          doneButton.setTitle("确 定", for: .normal)
          doneButton.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#125dff"), for: .normal)
          doneButton.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
          self.addSubview(doneButton)
          
          backgroundButton = UIButton.init(type: .system)
          backgroundButton.frame = CGRect.init(x: 0, y: 0, width: SCW, height: SCH)
          backgroundButton.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#000000")
          backgroundButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
          switch style {
          case .address:
               addressPicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: SCW, height: pickerH - 44))
               addressPicker.delegate = self
               addressPicker.dataSource = self
               addressPicker.backgroundColor = UIColor.white
               isAddress = true
               self.addSubview(addressPicker)
          case .date:
               datePicker = UIDatePicker.init(frame: CGRect.init(x: 0, y: 44, width: SCW, height: pickerH - 44))
               datePicker.datePickerMode = .date
               datePicker.locale = Locale.init(identifier: "zh_CN")
               datePicker.backgroundColor = UIColor.white
               datePicker.addTarget(self, action: #selector(BHJPickerView.dateSelected(_:)), for: .valueChanged)
               datePicker.setDate(Date(), animated: true)
               self.addSubview(datePicker)
          case .gender:
               genderPicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: SCW, height: pickerH - 44))
               genderPicker.delegate = self
               genderPicker.dataSource = self
               genderPicker.backgroundColor = UIColor.white
               isAddress = false
               self.addSubview(genderPicker)
          }
          if pickerStyle != BHJPickerViewStyle.date{
               switch isAddress {
               case true:
                    self.getAddressData()
               default:
                    dataArray = NSMutableArray.init(array: ["男","女"])
                    self.pickerView(genderPicker, didSelectRow: 0, inComponent: 0)
               }
          }
     }
     required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
     }
     // MARK: - Method
     
     /// 取消按钮点击方法
     @objc func cancelButtonClick(){
          
          self.pickerViewHidden()
     }
     
     /// 确定按钮点击方法
     @objc func doneButtonClick(){
          
          if pickerStyle == .address {
               pickerDelegate?.selectedAddress(self, selectedProvince, selectedCity, selectedDistrict)
          }else if pickerStyle == .date{
               pickerDelegate?.selectedDate(self, datePicker.date)
          }else{
               pickerDelegate?.selectedGender(self, selectedGender)
          }
          self.pickerViewHidden()
     }
     /// 时间选择
     ///
     /// - Parameter datePicker: 时间选择器
     @objc func dateSelected(_ datePicker: UIDatePicker) {
          
          
     }
     
     /// 读取省市区数据
     func getAddressData() {
          
          dataArray.removeAllObjects()
         //同一个包情况
         //let path = Bundle.main.path(forResource:"city", ofType: "json")
         //不同一个包的情况
         let path = Bundle(for: type(of: self)).url(forResource: "city", withExtension: "json")
         do{
             //let url = URL(fileURLWithPath: path!)
             let addressData = try NSData.init(contentsOf: path!)
             let addressDic = try JSONSerialization.jsonObject(with: addressData as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
             let dic = addressDic.object(at: 0) as! NSDictionary
             let provinceArray = dic["childs"] as! NSArray
             for i in 0..<provinceArray.count {
                  let provinceDic = provinceArray.object(at: i) as! NSDictionary
                  let provinceM = AddressModel.init()
                  provinceM.region_name = (provinceDic["region_name"] as? String)
                  provinceM.region_id = (provinceDic["region_id"] as! String)
                  provinceM.agency_id = (provinceDic["agency_id"] as? String)
                  provinceM.parent_id = (provinceDic["parent_id"] as! String)
                  provinceM.region_type = (provinceDic["region_type"] as! String)
                  provinceM.childs = (provinceDic["childs"] as! [NSDictionary])
                  self.dataArray.add(provinceM)
             }
             self.pickerView(addressPicker, didSelectRow: 0, inComponent: 0)
         }catch{
             print("读取本地数据出现错误!",error as Any)
         }
     }
     /// 展示pickerView
     public func pickerViewShow() {
          
          let keyWindow = UIApplication.shared.keyWindow
          keyWindow?.addSubview(self.backgroundButton)
          keyWindow?.addSubview(self)
         self.backgroundButton.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#000000", darkColor: "#ffffff", alpha: 0.4)
          UIView.animate(withDuration: 0.4, animations: {
//              self.backgroundButton.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#000000", darkColor: "#ffffff", alpha: 0.3)
               self.frame.origin.y = SCH - self.pickerH
          }) { (complete: Bool) in
               
          }
     }
     /// 隐藏pickerView
     public func pickerViewHidden() {
          UIView.animate(withDuration: 0.4, animations: {
//               self.backgroundButton.backgroundColor = kRGBColor(0, 0, 0, 0)
              self.backgroundButton.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#000000", darkColor: "#ffffff", alpha: 0)
               self.frame.origin.y = SCH
          }) { (complete:Bool) in
               self.removeFromSuperview()
               self.backgroundButton.removeFromSuperview()
          }
     }
     
     // MARK: - UIPickerViewDelegate, UIPickerViewDataSource
     
     /// 返回列
     ///
     /// - Parameter pickerView: pickerView
     /// - Returns: 列
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
          switch isAddress {
          case true:
               return 3
          default:
               return 1
          }
     }
     
     /// 返回对应列的行数
     ///
     /// - Parameters:
     ///   - pickerView: pickerView
     ///   - component: 列
     /// - Returns: 行
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          
          switch isAddress {
          case true:
               if component == 0{
                    return dataArray.count
               }else if component == 1{
                    return cityArray.count
               }else{
                    return districtArray.count
               }
          default:
               return dataArray.count
          }
     }
     
     /// 返回对应行的title
     ///
     /// - Parameters:
     ///   - pickerView: pickerView
     ///   - row: 行
     ///   - component: 列
     /// - Returns: title
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          var title = ""
          switch isAddress {
          case true:
               if component == 0{
                    let provinceM = dataArray[row] as! AddressModel
                    title = provinceM.region_name ?? "未知"
                    return title
               }else if component == 1{
                    let cityModel = cityArray[row] as! AddressModel
                    title = cityModel.region_name ?? "未知"
                    return title
               }else{
                    let areaModel = districtArray[row] as! AddressModel
                    title = areaModel.region_name ?? "未知"
                    return title
               }
          default:
               title = dataArray[row] as! String
               return title
          }
     }
     
     /// 选择列、行
     ///
     /// - Parameters:
     ///   - pickerView: pickerView
     ///   - row: 行
     ///   - component: 列
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          
          switch isAddress {
          case true:
               if component == 0 {
                    let provinceM = dataArray[row] as! AddressModel
                    let cityDicArray = provinceM.childs!
                    cityArray.removeAllObjects()
                    for j in 0..<cityDicArray.count {
                         let cityDic = cityDicArray[j]
                         let cityM = AddressModel.init()
                         cityM.region_name = (cityDic["region_name"] as? String)
                         cityM.region_id = (cityDic["region_id"] as! String)
                         cityM.agency_id = (cityDic["agency_id"] as? String)
                         cityM.parent_id = (cityDic["parent_id"] as! String)
                         cityM.region_type = (cityDic["region_type"] as! String)
                         cityM.childs = (cityDic["childs"] as! [NSDictionary])
                         cityArray.add(cityM)
                    }
                    // 默认选择当前省的第一个城市对应的区县
                    self.pickerView(pickerView, didSelectRow: 0, inComponent: 1)
                    selectedProvince = provinceM
               }else if component == 1 {
                    let cityModel = cityArray[row] as! AddressModel
                    let areaArray = cityModel.childs!
                    districtArray.removeAllObjects()
                    for j in 0..<areaArray.count {
                         let areaDic = areaArray[j]
                         let areaModel = AddressModel.init()
                         areaModel.region_name = (areaDic["region_name"] as? String)
                         areaModel.region_id = (areaDic["region_id"] as! String)
                         areaModel.agency_id = (areaDic["agency_id"] as? String)
                         areaModel.parent_id = (areaDic["parent_id"] as! String)
                         areaModel.region_type = (areaDic["region_type"] as! String)
                         districtArray.add(areaModel)
                    }
                    selectedCity = cityModel
                    self.pickerView(pickerView, didSelectRow: 0, inComponent: 2)
               }else{
                    let areaModel = districtArray[row] as! AddressModel
                    selectedDistrict = areaModel
               }
               pickerView.reloadAllComponents()
          default:
               selectedGender = dataArray[row] as! String
          }
     }
}







