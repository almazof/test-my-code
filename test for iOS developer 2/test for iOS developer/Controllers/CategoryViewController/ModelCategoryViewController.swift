//
//  ModelCategoryViewController.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import Foundation

class ModelCategoryViewController {
    
    var searchText = "" {
        didSet {
            sort()
            update()
        }
    }
    private var arrayCategories = [Category]()
    var categoties = [Category]()
    
    var update: (() -> ())!
    init(_ updateModel: @escaping () -> ()) {
        update = updateModel
    }
    
    func updateData(completion:@escaping (Network.ErrorCode?) -> ()) {
        Network().downloadCategories { (error, data) in
            guard let data = data else {self.sort(); return completion(error) }
            self.arrayCategories = data.data
            self.sort()
            completion(nil)
        }
    }
    
    private func sort() {
        if searchText.isEmpty {categoties = arrayCategories; return }
        categoties = arrayCategories.compactMap {$0.name?.contains(searchText) ?? false ? $0 : nil}
    }
}
