//
//  PersonView.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 29.07.2021.
//

import UIKit

protocol UIPersonViewDelegate:NSObjectProtocol {
    func personView(_ personView: UIPersonView, data:Person)
}

class UIPersonView: UIView {
    weak var delegate:UIPersonViewDelegate?
    private var stackView:UIStackView!
    private var surnameTextView:UICustomTextView!
    private var nameTextView:UICustomTextView!
    private var patronumicTextView:UICustomTextView!
    private var ageTextView:UICustomTextView!
    
    var personData:Person! {
        Person(surname: surnameTextView.text,
         name: nameTextView.text,
         patronumic: patronumicTextView.text,
         age: Int(ageTextView.text ?? ""))
    }
    
    
    
    var spasing:CGFloat {
        get {stackView.spacing} set {stackView.spacing = newValue}
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        self.backgroundColor = .clear
        self.clipsToBounds = true
        stackView = UIStackView()
        surnameTextView = UICustomTextView()
        nameTextView = UICustomTextView()
        patronumicTextView = UICustomTextView()
        nameTextView.textContentType = .givenName
        surnameTextView.textContentType = .familyName
        ageTextView = UICustomTextView()
        ageTextView.keyboardType = .numberPad
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.clipsToBounds = true
        surnameTextView.placholder = "Фамилия"
        nameTextView.placholder = "Имя"
        patronumicTextView.placholder = "Отчество"
        ageTextView.placholder = "Возраст"

        [surnameTextView!, nameTextView!, patronumicTextView!, ageTextView!]
            .forEach {
                stackView.addArrangedSubview($0)
                $0.delegate = self
            }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    
}

//MARK: - Delegate

extension UIPersonView: UICustomTextViewDelegate{
    func customTextView(_ customTextView: UICustomTextView, text: String?) {
        delegate?.personView(self, data: personData)
    }
    
    
}
