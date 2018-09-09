//
//  FinderCVCell.swift
//  Hackathon2018
//
//  Created by Marian Prisacariu on 9/8/18.
//  Copyright © 2018 Marian Prisacariu. All rights reserved.
//

import UIKit

class FinderCVCell: UICollectionViewCell {

    @IBOutlet var finderImage: UIImageView!
    @IBOutlet var finderName: UILabel!
    @IBOutlet var imageConstraintHeight: NSLayoutConstraint!
    
    public func setupWithFinder(_ finder: Finder) {
        self.finderImage.image = finder.image
        self.finderName.text = finder.name
        self.imageConstraintHeight.constant = finder.enlarge ? 75 : 60
    }
}
