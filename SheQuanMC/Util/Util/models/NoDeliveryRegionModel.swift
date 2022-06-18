//
//  NoDeliveryRegionModel.swift
//  Util
//
//  Created by mac on 2022/6/16.
//

import Foundation
//import SwiftyJSON


public struct NoDeliveryRegionModel:Codable,Hashable{
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
    public var isChoice:Bool?     //自己的添加的是否选中
    
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
        case isChoice = "isChoice"
    }
    
    
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        initials = try? values.decodeIfPresent(String.self, forKey: .initials)
        lat = try? values.decodeIfPresent(Decimal.self, forKey: .lat)
        level = try? values.decodeIfPresent(Int32.self, forKey: .level)
        lng = try? values.decodeIfPresent(Decimal.self, forKey: .lng)
        regionId = try? values.decode(Int32.self, forKey: .regionId)
        regionName = try? values.decodeIfPresent(String.self, forKey: .regionName)
        isChoice = try? values.decodeIfPresent(Bool.self, forKey: .isChoice)
    }
    
    
    public init(initials:String? = "",lat:Decimal? = 0,level:Int32? = 0,lng:Decimal? = 0,regionId:Int32? = 0,regionName:String? = "",isChoice:Bool = false){
        self.initials = initials
        self.lat = lat
        self.level = level
        self.lng = lng
        self.regionId = regionId
        self.regionName = regionName
        self.isChoice = isChoice
    }
    
}
