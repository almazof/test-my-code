//
//  UICustomActiveIndicatorView.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import UIKit

class UICustomActiveIndicatorView: UIView {
    
    private var view:UIView!
    private var indicator:UIActivityIndicatorView!
    private var label:UILabel!
    var color: UIColor = .gray {
        willSet {
            label.textColor = newValue
            indicator.color = newValue
            indicator.tintColor = newValue
        }
    }
    var text:String = "" {
        willSet {
            label.text = newValue
        }
    }
    
    var style:UIActivityIndicatorView.Style {
        get { return indicator.style }
        set {indicator.style = newValue}
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        
        label = UILabel()
        label.contentMode = .center
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        
        indicator = UIActivityIndicatorView()
        indicator.color = .systemGray
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        indicator.alpha = 1
        
        view = UIView()
        view.alpha = 0.2
        
        [view!, indicator!, label!].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
            $0.backgroundColor = .clear
            
        }
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.heightAnchor.constraint(equalTo: indicator.widthAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 50),

            label.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor)
        ])
        
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.isHidden = true
            self.text = ""
        }
    }
    
    func startAnimating() {
        DispatchQueue.main.async {
            self.indicator.startAnimating()
            self.isHidden = false
        }
        
    }

    func startAnimating(_ text:String) {
        DispatchQueue.main.async {
            self.text = text
            self.indicator.startAnimating()
            self.isHidden = false
        }
        
    }

}
