//
//  CategoryTableViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/30/21.
//

import UIKit
import Firebase
class CategoryTableViewController: UITableViewController {
    
    
    let items = Constants.categories
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        categoryCell.categoryLabel.text = items[indexPath.row]
        categoryCell.categoryLabel.font = categoryCell.categoryLabel.font.withSize(28)
        return categoryCell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    // call out category tapped, to category detail table view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.navigationBar.backgroundColor = .white
        UserDefaults.standard.setValue(items[indexPath.row], forKey: "categoryChoice")
    }
}
