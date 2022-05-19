//
//  BusinessTypeModel.swift
//  Util
//
//  Created by mac on 2022/5/16.
//

import Foundation
import HandyJSON



public struct BusinessTypeModel: Codable {
    public var categoryId: Int32?
    public var categoryName: String?
    public var subCategorys:[BussinessSecondTypeModel]?
    
    enum CodingKeys:String,CodingKey {
       case categoryId = "categoryId"
        case categoryName = "categoryName"
        case subCategorys = "subCategorys"
    }


    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try? values.decodeIfPresent(Int32.self, forKey: .categoryId)
        categoryName = try? values.decodeIfPresent(String.self, forKey: .categoryName)
        subCategorys = try? values.decodeIfPresent([BussinessSecondTypeModel].self, forKey: .subCategorys)
    }
    
   
}


public struct BussinessSecondTypeModel: Codable {
    
   public var categoryId: Int32?
   public var categoryName: String?
    
  
    enum Codingkeys:String,CodingKey {
       case categoryId = "categoryId"
        case categoryName = "categoryName"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try? values.decodeIfPresent(Int32.self, forKey: .categoryId)
        categoryName = try? values.decodeIfPresent(String.self, forKey: .categoryName)
    }

}


//public class BusinessTypeModel: HandyJSON {
//    public var categoryId: Int32?
//    public var categoryName: String?
//    public var subCategorys:[BussinessSecondTypeModel]?
//
////    enum CodingKeys:String,CodingKey {
////       case categoryId = "categoryId"
////        case categoryName = "categoryName"
////        case subCategorys = "subCategorys"
////    }
////
////
////    public init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        categoryId = try? values.decodeIfPresent(Int.self, forKey: .categoryId)
////        categoryName = try? values.decodeIfPresent(String.self, forKey: .categoryName)
////        subCategorys = try? values.decodeIfPresent([BusinessTypeModel].self, forKey: .subCategorys)
////    }
//
//    public required init() {
//     }
//}
//
//
//public class BussinessSecondTypeModel: HandyJSON {
//
//   public var categoryId: Int32?
//   public var categoryName: String?
//
//   public required init() {
//    }
//
////    enum Codingkeys:String,CodingKey {
////       case categoryId = "categoryId"
////        case categoryName = "categoryName"
////    }
////
////    public init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        categoryId = try? values.decodeIfPresent(Int.self, forKey: .categoryId)
////        categoryName = try? values.decodeIfPresent(String.self, forKey: .categoryName)
////    }
////
//}
