//
//  Classes.swift
//  Hackathon2018
//
//  Created by Marian Prisacariu on 9/8/18.
//  Copyright © 2018 Marian Prisacariu. All rights reserved.
//

import Foundation
import UIKit

class Product: NSObject {
    var category: ProductCategory?
    var productName: String?
    var image: UIImage?
    var rating: Int?
}

class ProductCategory: NSObject {
    var categoryName: String?
}

class Recommendation: NSObject {
    var products: [Product]?
}

class Finder: NSObject {
    var name: String?
    var image: UIImage?
    var enlarge: Bool = false
}
