//
//  FavoriteViewController.swift
//  Hackathon2018
//
//  Created by Marian Prisacariu on 9/9/18.
//  Copyright © 2018 Marian Prisacariu. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataSource: [String] = ["WishlistTabCell", "FavoriteBannerCell", "FinderTVCell", "FriendsCell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 40
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(UINib(nibName: "FavoriteBannerCell", bundle: nil), forCellReuseIdentifier: "FavoriteBannerCell")
        self.tableView.register(UINib(nibName: "FinderTVCell", bundle: nil), forCellReuseIdentifier: "FinderTVCell")
        self.tableView.register(UINib(nibName: "WishlistTabCell", bundle: nil), forCellReuseIdentifier: "WishlistTabCell")
        self.tableView.register(UINib(nibName: "FriendsCell", bundle: nil), forCellReuseIdentifier: "FriendsCell")
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataSource[indexPath.row] == "FavoriteBannerCell" {
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "FavoriteBannerCell", for: indexPath) as? FavoriteBannerCell {
                return cell
            } else {
                return UITableViewCell()
            }
        } else if dataSource[indexPath.row] == "FinderTVCell" {
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "FinderTVCell", for: indexPath) as? FinderTVCell {
                cell.setupWithFinders(mockFinders())
                cell.delegate = self
                return cell
            } else {
                return UITableViewCell()
            }
        } else if dataSource[indexPath.row] == "WishlistTabCell" {
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "WishlistTabCell", for: indexPath) as? WishlistTabCell {
                return cell
            } else {
                return UITableViewCell()
            }
        } else if dataSource[indexPath.row] == "FriendsCell" {
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsCell {
                return cell
            } else {
                return UITableViewCell()
            }
        }
        
        return UITableViewCell()
    }
}

extension FavoriteViewController: FinderTVCellDelegate {
    func finderTVCellDelegateDidSelectFinder(_ finder: Finder) {
        self.performSegue(withIdentifier: "showGiftFinderSegue", sender: true)
    }
}
