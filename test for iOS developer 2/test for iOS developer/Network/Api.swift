//
//  Api.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import Foundation

extension Network {
    
    enum Api {
        private var url: String {"http://62.109.7.98/api/"}

        case categories
        case products(_ id:Int)
        case product(_ id:Int)
       
        var path:String {
            switch self {
            case .categories:       return url + "categories"
            case .products(let id): return url + "product/category/\((id))"
            case .product(let id):  return url + "product/\(id)"
            }
        }

        var method:String {
            switch self {
            default: return "GET"
            }
        }
        
    }
    
}
