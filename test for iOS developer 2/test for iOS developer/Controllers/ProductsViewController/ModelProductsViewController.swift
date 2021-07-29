//
//  ModelProductsViewController.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import Foundation
class ModelProductsViewController {
    
    var products = [Product]()
    var idCategory:Int!
    
    func getSubCategory(completion:@escaping (Network.ErrorCode?) -> ()) {
        guard let id = idCategory else {return completion(Network.ErrorCode(100))}
        Network().downloadProducts(id) { (error, data) in
            guard let data = data else {return completion(error) }
            self.converter(data.data)
            completion(nil)
        }
    }
    
    
    func converter(_ array:[Product]) {
        products = array.map{
            var data = $0
            data.date = data.date?.convertToDate(at: "yyyy-MM-dd", to: "dd MMM yyyy")
            return data
        }
    }
}
