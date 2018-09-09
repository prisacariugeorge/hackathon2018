//
//  FilterViewController.swift
//  Hackathon2018
//
//  Created by Marian Prisacariu on 9/9/18.
//  Copyright © 2018 Marian Prisacariu. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var filterTypeCategory: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = filterTypeCategory ? "Gift category" : "Gift price"
    }

}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
