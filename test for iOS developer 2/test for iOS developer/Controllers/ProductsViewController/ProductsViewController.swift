//
//  ProductsViewController.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import UIKit

class ProductsViewController: UICustomTableViewController {
    let model = ModelProductsViewController()
    private var withIdentifier = String(describing: ProductsTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ProductsTableViewCell.self, forCellReuseIdentifier: withIdentifier)
        startAnimating("Loading...")
        title = "Products"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        get()
    }
    
    func get() {
        model.getSubCategory() { (error) in
            DispatchQueue.main.async {
                self.infomationLabel.text = error?.message
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
                self.stopAnimating()
            }
        }
    }

    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }

}

extension ProductsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = model.products.count
        infomationLabel.isHidden = count > 0
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: withIdentifier, for: indexPath) as! ProductsTableViewCell
        let data = model.products[indexPath.row]
        let name = (data.name ?? "No name")
        let date = data.date
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = "ccal: " + String(data.ccal ?? 0)
        cell.dateLabel.text = date
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductViewController()
        vc.product = model.products[indexPath.row]
        vc.modalPresentationStyle = .formSheet
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true)
    }
    
    @objc override func refreshAction(_ refreshController: UIRefreshControl) {
        get()
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "удалить") { [self] (_, _, completion) in
            self.tableView.performBatchUpdates {
                model.products.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                completion(true)
            } completion: { (_) in
                self.tableView.reloadData()
            }
        }
        delete.backgroundColor = .red
        delete.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}


