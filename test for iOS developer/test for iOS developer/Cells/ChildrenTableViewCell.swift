//
//  NewCildrenTableViewCell.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 29.07.2021.
//

import UIKit

class ChildrenTableViewCell: UITableViewCell {
    private lazy var button:UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.setTitle("Удалить", for: .normal)
        return button
    }()
    
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
        
    }()
    
    lazy var ageLabel:UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    var row: Int {
        get {button.tag} set {button.tag = newValue}
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        textLabel?.textColor = .systemGreen
        detailTextLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        detailTextLabel?.textColor = .systemGray
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        button.tag = self.tag
        [nameLabel, ageLabel, button].forEach {
            contentView.addSubview($0)
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            ageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            ageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            ageLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            button.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 10),
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
    
    func addDeleteTarget(_ target: Any, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
}
