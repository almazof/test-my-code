//
//  CategoryTableViewCell.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        textLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        detailTextLabel?.font = .systemFont(ofSize: 13, weight: .regular)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
