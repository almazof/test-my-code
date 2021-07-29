//
//  ViewController.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 29.07.2021.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    private var tableView:UITableView!
    private var model:ModelViewController!
    private var personView:UIPersonView!
    private let identifier = String(describing: ChildrenTableViewCell.self)
    var haveChildren: Bool {
        return !(model?.person == nil || (model?.person?.children.count ?? 0) >= 5)
    }
    
    
    //MARK: Override
    override func loadView() {
        super.loadView()
        initialize()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = ModelViewController()
        setupView()
        setupHeaderView()
    }
   
   //MARK: Private functions
    private func initialize() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ChildrenTableViewCell.self, forCellReuseIdentifier: identifier)
        view.addSubview(tableView)
        personView = UIPersonView()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupView() {
        view.backgroundColor = .white
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.contentInset.top = 10
        personView.delegate = self
    }
    
    
    
    //MARK: Actions
    
    @objc private func addAction(_ sender:UIButton) {
        guard let person = model?.person, person.children.count < 5 else { return }
        
        var children:Person = Person(surname: person.surname, name: nil, patronumic: person.name, age: nil)
        let alert = UIAlertController(title: "Данные ребенка", message: "Введите данные ребенка", preferredStyle: .alert)
        let save = UIAlertAction(title: "Сохранить", style: .default) { (action) in
            self.view.endEditing(true)
            guard let textFields = alert.textFields else {return}
            textFields.forEach({ textField in
                switch textField.tag {
                case 0: children.name = textField.text ?? ""
                case 1: children.age = Int(textField.text ?? "") ?? 0
                default:break
                }
            })
            
            if children.name != "" {
                self.model.person.children.append(children)
                self.model.sort()
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (textField) in
            textField.tag = 0
            textField.placeholder = "Имя ребенка"
        }
        
        alert.addTextField { (textField) in
            textField.tag = 1
            textField.placeholder = "Возраст"
            textField.keyboardType = .numberPad
        }
        
        let cancel = UIAlertAction(title: "Закрыть",  style: .cancel) { _ in
            self.view.endEditing(true)
        }
        
        alert.addAction(save)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
}

//MARK: - Extension

//MARK: - Table View
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    private func setupHeaderView() {
        let heightHeaders:CGFloat = 220
        let heder = UIView()
        personView.backgroundColor = .systemGray6
        personView.layer.cornerRadius = 10
        
        heder.addSubview(personView)
        tableView.tableHeaderView = heder
        heder.backgroundColor = .clear
        [heder, personView!].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        tableView.tableHeaderView?.frame = CGRect(x: tableView.frame.minX,
                                                  y: tableView.frame.minY,
                                                  width: tableView.frame.width,
                                                  height: heightHeaders)
        
        NSLayoutConstraint.activate([
            heder.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 1),
            heder.heightAnchor.constraint(equalToConstant: heightHeaders),
            heder.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            
            personView.topAnchor.constraint(equalTo: heder.topAnchor, constant: 10),
            personView.bottomAnchor.constraint(equalTo: heder.bottomAnchor),
            personView.leadingAnchor.constraint(equalTo: heder.leadingAnchor, constant: 16),
            personView.trailingAnchor.constraint(equalTo: heder.trailingAnchor, constant: -16)
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.person?.children.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ChildrenTableViewCell
        let children = model.person.children[indexPath.row]
        cell.nameLabel.text = children.name
        cell.row = indexPath.row
        cell.ageLabel.text = convertAge(children.age)
        cell.addDeleteTarget(self, action: #selector(deleteAction(_:)))
        return cell
    }
    
    @objc private func deleteAction(_ sender:UIButton) {
        self.tableView.performBatchUpdates {
            model.person.children.remove(at: sender.tag)
            tableView.deleteRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
        } completion: { (_) in
            self.tableView.reloadData()
        }
    }
    
    private func convertAge(_ number:Int) -> String {
        var string:String!
        switch number {
        case 0: string = "меньше года"
        case 1: string = String(number) + " годик"
        case 2, 3, 4: string = String(number) + " годика"
        default: string = String(number) + " лет"
        }
        return string
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !haveChildren || model.person.children.isEmpty {return UIView()}
        let label = UILabel()
        let view = UIView()

        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        label.backgroundColor = .clear
        label.text = "Дети: "
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if !haveChildren {return UIView()}
        let button = UIButton()
        let view = UIView()
        let heightButton:CGFloat = 60

        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(pointSize: 35, weight: .light, scale: .medium)
        let image = UIImage(systemName: "plus.circle", withConfiguration: configuration)
        let select = UIImage(systemName: "plus.circle.fill", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.setImage(select, for: .highlighted)
        button.addTarget(self, action: #selector(addAction(_:)), for: .touchUpInside)
        button.tintColor = .black
        view.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1 / 2),
            button.heightAnchor.constraint(equalToConstant: heightButton),
        ])
        
        return view
    }
}


//MARK: - Delegate
extension ViewController:UIPersonViewDelegate {
    func personView(_ personView: UIPersonView, data: Person) {
        if data.name == "" && data.patronumic == "" && data.surname == "" && data.age == 0 {model.person = nil; tableView.reloadData(); return}
        if model.person == nil {model.person = data; tableView.reloadData(); return}
        model.person.surname = data.surname
        model.person.name = data.name
        model.person.patronumic = data.patronumic
        model.person.age = data.age
    }
}
