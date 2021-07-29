//
//  Network.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import Foundation

class Network {
    
    func downloadCategories( completion:@escaping(Network.ErrorCode, CategoryData?) -> ()) {
        push(api: Api.categories, postData: nil, type: CategoryData.self) { (error, data) in
            completion(error, data)
        }
    }
    
    func downloadProducts(_ idCategory:Int, completion:@escaping(Network.ErrorCode, ProductsData?) -> ()) {
        let string = Api.products(idCategory)
        print(string.path)
        push(api: string, postData: nil, type: ProductsData.self) { (error, data) in
            completion(error, data)
        }
    }
    
    func downloadProduct(id product:Int, completion:@escaping(Network.ErrorCode, ProductsData?) -> ()) {
        let string = Api.product(product)
        print(string.path)
        push(api: string, postData: nil, type: ProductsData.self) { (error, data) in
            completion(error, data)
        }
    }
    
    
    
}



