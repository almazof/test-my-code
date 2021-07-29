//
//  ModelViewController.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 29.07.2021.
//

import Foundation

class ModelViewController {
    var person:Person!
    
    func sort() {
        guard let person = person, !person.children.isEmpty else { return}
        self.person.children.sort { (one, two) -> Bool in
            one.age > two.age
        }
    }
}
