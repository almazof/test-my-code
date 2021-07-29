//
//  Structures.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import Foundation

struct CategoryData:Codable {
    let data:[Category]
}

struct Category:Codable {
    let id: Int
    let name: String?
    let unit: String?
    let count: Int?
}


struct ProductsData:Codable {
    let data:[Product]
}

struct Product:Codable {
    let id: Int
    let name: String?
    let ccal: Int?
    var date: String?
    let categoryId: Int
    let createdAt: String?
    let updatedAt: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, ccal, date
        case categoryId = "category_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    var dictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
          guard let label = label else { return nil }
          return (label, value)
        }).compactMap { $0 })
        return dict
      }
}
