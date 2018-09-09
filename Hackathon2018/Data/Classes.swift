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

@objcMembers
class Product: Object {
    dynamic var itemId: String = UUID().uuidString
    dynamic var productName: String = ""
    dynamic var rating: Int = 1
    dynamic var timestamp: Date = Date()
    dynamic var imageData: Data = Data()
    dynamic var currentPrice: Int = 0
    dynamic var oldPrice: Int = 0
    dynamic var deliveryEstimate: String?
    dynamic var sectionType: Int = 0
    dynamic var categoryType: Int = 0
    
    override static func primaryKey() -> String? {
        return "itemId"
    }
}

class FilterItem: NSObject {
    var name: String = ""
    var type: Int = 0
}

class Recommendation: NSObject {
    var products: [Product]?
}

class Finder: NSObject {
    var name: String?
    var image: UIImage?
    var enlarge: Bool = false
}
