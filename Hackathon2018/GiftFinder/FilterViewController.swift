//
//  FilterViewController.swift
//  Hackathon2018
//
//  Created by Marian Prisacariu on 9/9/18.
//  Copyright © 2018 Marian Prisacariu. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func filterViewControllerDelegateDidSelectItem(_ filterItem: FilterItem)
}

class FilterViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var filterTypeCategory: Bool = false
    var dataSource = [FilterItem]()
    
    var delegate: FilterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = filterTypeCategory ? "Gift category" : "Gift price"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.setupDataSource()
    }
    
    public func setupDataSource() {
        self.dataSource = []
        if filterTypeCategory {
            self.dataSource = mockCategory()
        } else {
            self.dataSource = mockPrices()
        }
        self.tableView.reloadData()
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = self.dataSource[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = self.dataSource[indexPath.row]
        
        self.delegate?.filterViewControllerDelegateDidSelectItem(selectedItem)
        
        self.navigationController?.popViewController(animated: true)
    }
}
