//
//  Structures.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import Foundation

struct Person {
    var surname: String?
    var name: String
    var patronumic:String?
    var age:Int
    var children:[Person]
    
    init(surname: String?, name: String?, patronumic:String?, age:Int?, children:[Person]) {
        self.surname = surname
        self.name = name ?? ""
        self.patronumic = patronumic
        self.age = age ?? 0
        self.children = children
    }
    
    init(surname: String?, name: String?, patronumic:String?, age:Int?) {
        self.surname = surname
        self.name = name ?? ""
        self.patronumic = patronumic
        self.age = age ?? 0
        self.children = []
    }
}


