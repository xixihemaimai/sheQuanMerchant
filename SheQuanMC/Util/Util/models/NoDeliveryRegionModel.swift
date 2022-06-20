//
//  NoDeliveryRegionModel.swift
//  Util
//
//  Created by mac on 2022/6/16.
//

import Foundation
//import SwiftyJSON


public struct RegionInfoModel:Codable,Hashable{
    
    public var checked:Bool?     //是否选中
    public var childNodes:[RegionInfoModel]? //子节点
    public var initials:String?   //首字母
    public var lat:Decimal?       //纬度
    /**
       1：国家
       2：省、自治区、直辖市
       3：地级市、地区、自治州、盟
       4：市辖区、县级市、县
     */
    public var level:Int32?       //地级级别
    public var lng:Decimal?       //经度
    public var regionId:Int32?    //行政地区编号，例如：110101
    public var regionName:String? //行政地区名称
    
//    public init(json: JSON) {
//        initials = json["initials"].string
//        lat = Decimal(string: String(format: "%.15f", json["lat"].double ?? 0.0))
//        lng = Decimal(string: String(format: "%.15f", json["lng"].double ?? 0.0))
////        LXFLog("============\(lat)--------\(lng)")
//        level = json["level"].int32
//        regionId = json["regionId"].int32
//        regionName = json["regionName"].string
//        isChoice = false
//    }
//    public override init(){
//        super.init()
//    }
    
    enum CodingKeys: String, CodingKey {
        case initials = "initials"
        case lat = "lat"
        case level = "level"
        case lng = "lng"
        case regionId = "regionId"
        case regionName = "regionName"
        case checked = "checked"
        case childNodes = "childNodes"
    }
    
    
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        initials = try? values.decodeIfPresent(String.self, forKey: .initials)
        lat = try? values.decodeIfPresent(Decimal.self, forKey: .lat)
        level = try? values.decodeIfPresent(Int32.self, forKey: .level)
        lng = try? values.decodeIfPresent(Decimal.self, forKey: .lng)
        regionId = try? values.decode(Int32.self, forKey: .regionId)
        regionName = try? values.decodeIfPresent(String.self, forKey: .regionName)
        checked = try? values.decodeIfPresent(Bool.self, forKey: .checked)
        childNodes = try? values.decodeIfPresent([RegionInfoModel].self, forKey: .childNodes)
    }
    
    
    public init(initials:String? = "",lat:Decimal? = 0,level:Int32? = 0,lng:Decimal? = 0,regionId:Int32? = 0,regionName:String? = "",checked:Bool? = false,childNodes:[RegionInfoModel]? = [RegionInfoModel]()){
        self.initials = initials
        self.lat = lat
        self.level = level
        self.lng = lng
        self.regionId = regionId
        self.regionName = regionName
        self.checked = checked
        self.childNodes = childNodes
    }
    
}




//public struct NoDeliveryRegionListModel:Codable{
//    public var province:String?
//    public var isAllChoice:Bool?
//    public var citys:[String]?
//    
//    enum CodingKeys: String, CodingKey {
//        case province = "province"
//        case isAllChoice = "isAllChoice"
//        case citys = "citys"
//    }
//    
//    public init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        province = try? values.decodeIfPresent(String.self, forKey: .province)
//        isAllChoice = try? values.decodeIfPresent(Bool.self, forKey: .isAllChoice)
//        citys = try? values.decodeIfPresent([String].self, forKey: .citys)
//    }
//    
//    public init(province:String? = "",isAllChoice:Bool? = false,citys:[String]? = [String]()){
//        self.province = province
//        self.isAllChoice = isAllChoice
//        self.citys = citys
//    }
//    
//}


