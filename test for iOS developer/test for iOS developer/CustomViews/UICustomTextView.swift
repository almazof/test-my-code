//
//  UICustomTextView.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 29.07.2021.
//

import UIKit

protocol UICustomTextViewDelegate:NSObjectProtocol {
    func customTextView(_ customTextView: UICustomTextView, text:String?)
}

class UICustomTextView: UIView, UITextFieldDelegate {
    weak var delegate:UICustomTextViewDelegate?
    private var textField:UITextField!
    private var label:UILabel!
    private var line:UIView!
    
    var text:String? {
        get {textField.text} set {textField.text = newValue}
    }
    
    var placholder:String? {
        get {label.text} set {label.text = newValue; textField.placeholder = newValue}
    }
    
    var autocapitalizationType:UITextAutocapitalizationType  {
        get {textField.autocapitalizationType} set {textField.autocapitalizationType = newValue}
    }
    
    var textContentType:UITextContentType!  {
        get {textField.textContentType} set {textField.textContentType = newValue}
    }
    
    var keyboardType:UIKeyboardType {
        get {textField.keyboardType} set {textField.keyboardType = newValue}
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        textField = UITextField()
        label = UILabel()
        line = UIView()
        [textField!, label!, line!]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview($0)
                $0.backgroundColor = .clear
            }
        
        // self
        textField.delegate = self
        self.backgroundColor = #colorLiteral(red: 0.7636442348, green: 0.9309337438, blue: 1, alpha: 0.3572018046)
        self.clipsToBounds = true
        
        //textField
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .medium)
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .yes
        textField.contentVerticalAlignment = .bottom
        textField.returnKeyType = .done
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneActionTolBar(_:)))
        let flexSpase = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexSpase, doneButton], animated: true)
        textField.inputAccessoryView = toolBar
        toolBar.updateConstraintsIfNeeded()
        textField.addTarget(self, action: #selector(editingTextField(_:)), for: .editingChanged)
        
        //label
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        
        //line
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .systemGray2
        
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            label.heightAnchor.constraint(equalToConstant: 15),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            line.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
        ])
        
    }
    
    // done button action for text field
    @objc private func doneActionTolBar(_ sender: UIButton) {
        self.endEditing(true)
        self.superview?.endEditing(true)
    }

    // delegate action for text field
    @objc private func editingTextField(_ textField: UITextField) {
        delegate?.customTextView(self, text: textField.text)
    }

}
