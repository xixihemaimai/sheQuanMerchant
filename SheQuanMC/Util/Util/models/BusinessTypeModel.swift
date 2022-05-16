//
//  BusinessTypeModel.swift
//  Util
//
//  Created by mac on 2022/5/16.
//

import Foundation


public struct BusinessTypeModel: Codable {
    public let categoryId: Int?
    public let categoryName: String?
    public let subCategorys:[BussinessSecondTypeModel]?
    
    enum CodingKeys:String,CodingKey {
       case categoryId = "categoryId"
        case categoryName = "categoryName"
        case subCategorys = "subCategorys"
    }
    
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try? values.decodeIfPresent(Int.self, forKey: .categoryId)
        categoryName = try? values.decodeIfPresent(String.self, forKey: .categoryName)
        subCategorys = try? values.decodeIfPresent([BusinessTypeModel].self, forKey: .subCategorys) as? [BussinessSecondTypeModel]
    }
    
}

public struct BussinessSecondTypeModel: Codable {
   public let categoryId: Int?
   public let categoryName: String?
    
    enum Codingkeys:String,CodingKey {
       case categoryId = "categoryId"
        case categoryName = "categoryName"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try? values.decodeIfPresent(Int.self, forKey: .categoryId)
        categoryName = try? values.decodeIfPresent(String.self, forKey: .categoryName)
        
    }
    
}
