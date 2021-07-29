//
//  UICustomStackView.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//
import UIKit


protocol UIInformationStackViewDataSourse:NSObjectProtocol {
    func countElements(infomation stackView: UIInformationStackView) -> Int
    func infomationForRow(infomation stackView: UIInformationStackView, row:Int) -> (name:String, text: String?)
}


class UIInformationStackView: UIView {
    weak var dataSource:UIInformationStackViewDataSourse? {
        willSet {
            reloadData()
        }
    }
    var text:String {
        get {return infomationLabel.text ?? ""}
        set {infomationLabel.text = newValue}
    }
    
    var spacing: CGFloat = 0 {
        willSet {
            reloadData()
        }
    }
    
    var colorNameLabel:UIColor = .systemGray
    var colorTextLabel:UIColor = .black
    
    var distribution: UIStackView.Distribution  {
        get {return stackView.distribution}
        set { stackView.distribution = newValue }
    }
    
    private lazy var infomationLabel:UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.contentMode = .center
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(infomationLabel)
        self.addSubview(stackView)
        self.backgroundColor = .white
        NSLayoutConstraint.activate([
            infomationLabel.topAnchor.constraint(equalTo: self.topAnchor),
            infomationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            infomationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            infomationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        reloadData()
    }
    
    func reloadData() {
        stackView.spacing = spacing
        /// если никто под делегат не подписан
        guard let count = dataSource?.countElements(infomation: self), count > 0 else { return text = "Нет данных"}
        text = ""
        
        /// если stackView пустой
        if stackView.arrangedSubviews.isEmpty { return setupStackView(count: count) }
        
        /// если stack view уже заполнен нужным кол-вом элеменетов
        if stackView.arrangedSubviews.count == count {return updateStackView()}
        
        /// если количество не совпадает с нужным
        removeAllStackView()
        setupStackView(count: count)
    }
    
    // заполняем stack view первый раз
    private func setupStackView(count:Int) {
        (0...count - 1).forEach({
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear
            
            let nameLabel = UILabel()
            nameLabel.tag = 0
            
            let textLabel = UILabel()
            textLabel.tag = 1
            
            [nameLabel, textLabel].forEach({
                view.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.textColor = colorNameLabel
            })
            
            nameLabel.font = .systemFont(ofSize: 14, weight: .regular)
            textLabel.font = .systemFont(ofSize: 15, weight: .regular)
            textLabel.numberOfLines = 0
            let data = dataSource?.infomationForRow(infomation: self, row: $0)
            let width = (data?.name ?? "").widhtText(font: nameLabel.font)
            
            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: view.topAnchor),
                nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
                nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
                nameLabel.widthAnchor.constraint(equalToConstant: width),
                
                textLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
                textLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
                textLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5),
                textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            ])
            
            nameLabel.text = data?.name
            textLabel.text = data?.text ?? "информация отсутсвует"
            stackView.addArrangedSubview(view)
        })
    }
    
    // если уже stack view имеет нужное количество ячеек
    private func updateStackView() {
        stackView.arrangedSubviews.enumerated().forEach({
            let row = $0
            var nameLabel:UILabel!
            var textLabel:UILabel!
            $1.subviews.forEach({
                if let label = $0 as? UILabel {
                    if label.tag == 0 {nameLabel = label}
                    if label.tag == 1 {textLabel = label}
                }
            })
            let data = dataSource?.infomationForRow(infomation: self, row: row)
            nameLabel.text = data?.name
            textLabel.text = data?.text ?? "информация отсутсвует"
            nameLabel.textColor = colorNameLabel
            textLabel.textColor = colorTextLabel
        })
    }
    
    //MARK: - Remove Stack View
    private func removeAllStackView() {
        stackView.arrangedSubviews.forEach({views in
            views.subviews.forEach({$0.removeFromSuperview()})
            views.removeFromSuperview()
        })
    }
    
}



