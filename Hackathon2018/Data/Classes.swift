//
//  Classes.swift
//  Hackathon2018
//
//  Created by Marian Prisacariu on 9/8/18.
//  Copyright © 2018 Marian Prisacariu. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Product: Object {
    var category: ProductCategory?
    
    @objc dynamic var itemId: String = UUID().uuidString
    @objc dynamic var productName: String = ""
    @objc dynamic var rating: Int = 1
    @objc dynamic var timestamp: Date = Date()
    @objc dynamic var imageData: Data = Data()
    @objc dynamic var currentPrice: Int = 0
    @objc dynamic var oldPrice: Int = 0
    
    
    override static func primaryKey() -> String? {
        return "itemId"
    }
}

class ProductCategory: Object {
    @objc dynamic var itemId: String = UUID().uuidString
    @objc dynamic var categoryName: String = ""
    @objc dynamic var type: Int = 1
    
    override static func primaryKey() -> String? {
        return "itemId"
    }
}

class Recommendation: NSObject {
    var products: [Product]?
}

class Finder: NSObject {
    var name: String?
    var image: UIImage?
    var enlarge: Bool = false
}
