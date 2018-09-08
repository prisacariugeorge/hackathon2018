//
//  RecommendationCell.swift
//  Hackathon2018
//
//  Created by Marian Prisacariu on 9/8/18.
//  Copyright © 2018 Marian Prisacariu. All rights reserved.
//

import UIKit

class RecommendationCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var ratingImageView: UIImageView!
    @IBOutlet var oldPrice: UILabel!
    @IBOutlet var currentPrice: UILabel!
    @IBOutlet var deliveryEstimate: UILabel!
    
    public func setupWithProduct(_ product: Product) {
        self.titleLabel.text = product.productName
        self.productImageView.image = UIImage(data: product.imageData)
        self.ratingImageView.image = self.getRatingImage(product.rating)
        self.oldPrice.text = String(product.oldPrice)
        
        self.currentPrice.text = String(product.currentPrice)
        self.deliveryEstimate.text = product.deliveryEstimate
    }
    
    func getRatingImage(_ rating: Int) -> UIImage? {
        switch rating {
        case 1:
            return UIImage(named: "1Star")
        case 2:
            return UIImage(named: "2Star")
        case 3:
            return UIImage(named: "3Star")
        case 4:
            return UIImage(named: "4Star")
        case 5:
            return UIImage(named: "5Star")
        default:
            return nil
        }
    }
}
