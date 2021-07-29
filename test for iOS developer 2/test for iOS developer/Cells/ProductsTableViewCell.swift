//
//  ProductsTableViewCell.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    var dateLabel:UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        dateLabel = UILabel()
        textLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        detailTextLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.backgroundColor = .clear
        dateLabel.font = .systemFont(ofSize: 12, weight: .medium)
        dateLabel.textColor = .systemGray2
        dateLabel.textAlignment = .right
        textLabel?.textColor = .systemPink
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

