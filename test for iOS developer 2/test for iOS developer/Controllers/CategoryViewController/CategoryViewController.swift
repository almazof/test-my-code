//
//  CategoryViewController.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import UIKit

class CategoryViewController: UICustomTableViewController {
    private var model:ModelCategoryViewController!
    private var withIdentifier = String(describing: CategoryTableViewCell.self)
    
    override func loadView() {
        super.loadView()
        model = ModelCategoryViewController(updateTableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: withIdentifier)
        startAnimating("Loading...")
        searchBarActivety = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        downloadData()
    }

    private func downloadData() {
        model.updateData { (error) in
            DispatchQueue.main.async {
                self.infomationLabel.text = error?.message
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
                self.stopAnimating()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        stopAnimating()
    }
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
            self.stopAnimating()
        }
    }
}



//MARK: - Delegate end DataSource
extension CategoryViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = model.categoties.count
        infomationLabel.isHidden = count > 0
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: withIdentifier, for: indexPath) as! CategoryTableViewCell
        let data = model.categoties[indexPath.row]
        let name = (data.name ?? "No name") + " (\(data.count ?? 0))"
        let unit = data.unit
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = unit
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        startAnimating("Download...")
        let vc = ProductsViewController()
        vc.model.idCategory = model.categoties[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.searchText = searchBar.text ?? ""
    }
    
    @objc override func refreshAction(_ refreshController: UIRefreshControl) {
        downloadData()
    }
   
    
}
