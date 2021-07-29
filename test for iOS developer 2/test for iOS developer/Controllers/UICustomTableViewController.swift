//
//  UICustomTableViewController.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import UIKit

class UICustomTableViewController: UIViewController, UIGestureRecognizerDelegate {
    var tableView:UITableView!
    private var indicatorView:UICustomActiveIndicatorView!
    var infomationLabel: UILabel!
    private var searchBar: UISearchBar!
    var searchBarActivety:Bool {
        get {searchBar != nil}
        set {
            if newValue {
                searchBar = UISearchBar()
                searchBar.placeholder = "enter category name"
                searchBar.backgroundColor = .systemGray6
                searchBar.backgroundColor = .clear
                
                let toolBar = UIToolbar()
                toolBar.sizeToFit()
                let buttonDone = UIBarButtonItem(title:  "Done", style: .done, target: self, action: #selector(searchDoneAction))
                let flexSpase = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                toolBar.setItems([flexSpase, buttonDone], animated: false)
                searchBar.inputAccessoryView = toolBar
                toolBar.updateConstraintsIfNeeded()
                searchBar.delegate = self
                navigationController?.navigationBar.isHidden = false
                navigationItem.titleView = searchBar
            } else {
                searchBar?.delegate = nil
                searchBar = nil
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    private func initialize() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        infomationLabel = UILabel()
        indicatorView = UICustomActiveIndicatorView()
        [infomationLabel!, tableView!, indicatorView!].forEach{$0.translatesAutoresizingMaskIntoConstraints = false; view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            infomationLabel.topAnchor.constraint(equalTo: view.topAnchor),
            infomationLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            infomationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infomationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            indicatorView.topAnchor.constraint(equalTo: view.topAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            indicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupView() {
        
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Update...")
        refresh.tintColor = .systemGray
        refresh.addTarget(self, action: #selector(refreshAction(_:)), for: .valueChanged)
        tableView.refreshControl = refresh
        
        indicatorView.color = .systemGray
        infomationLabel.backgroundColor = .clear
        infomationLabel.textColor = .systemGray
        infomationLabel.font = .systemFont(ofSize: 12, weight: .regular)
        infomationLabel.numberOfLines = 0
        infomationLabel.textAlignment = .center
        infomationLabel.text = "no data"
    }
    
    @objc func searchDoneAction() {
        searchBar?.endEditing(true)
    }
    
    func stopAnimating() { indicatorView.stopAnimating()}
    
    func startAnimating() {self.indicatorView.startAnimating()}

    func startAnimating(_ text:String) { self.indicatorView.startAnimating(text)}
    
    
    
}

extension UICustomTableViewController: UISearchBarDelegate {
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

extension UICustomTableViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    @objc func refreshAction(_ refreshController: UIRefreshControl) {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return nil
    }
    
    
    
}
