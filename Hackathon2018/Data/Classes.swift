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
import RxSwift
import RxDataSources

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

class Finder: NSObject {
    var name: String?
    var image: UIImage?
    var enlarge: Bool = false
}

@objcMembers public class GiftFinderDTO: NSObject, NSCopying {
    var products: [Product]?
    var finders: [Finder]?
    var context: AnyObject?
    
    public override init() {}
    
    convenience init(products: [Product], finders: [Finder]) {
        self.init()
        self.products = products
        self.finders = finders
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = GiftFinderDTO()
        copy.products = products
        copy.finders = finders
        return copy
    }
}

struct GiftFinderSection {
    var name: String
    var elements: [GiftFinderItem]
    var headerData: Any?
    var footer: String?
    
    init(name: String, headerData: Any? = nil, elements: [GiftFinderItem], footer: String? = nil) {
        self.name = name
        self.elements = elements
        self.headerData = headerData
        self.footer = footer
    }
}

extension GiftFinderSection: AnimatableSectionModelType {
    typealias Item = GiftFinderItem
    typealias Identity = String
    
    var identity: String {
        return name
    }
    
    var items: [GiftFinderItem] {
        return elements
    }
    
    init(original: GiftFinderSection, items: [Item]) {
        self = original
        self.elements = items
    }
}

enum GiftFinderItemType {
    case none
    case recommendationCell
    case finderCell
    
    var description: String {
        switch self {
        case .recommendationCell:
            return "recommendationCell"
        case .finderCell:
            return "finderCell"
        case .none:
            return "none"
        }
    }
}

struct GiftFinderItem: IdentifiableType, Equatable {
    var data: Any?
    var type: GiftFinderItemType
    
    init(type: GiftFinderItemType = .none, data: Any? = nil) {
        self.type = type
        self.data = data
    }
    
    var identity: String {
        return "\(arc4random_uniform(999)) \(arc4random_uniform(999)) \(arc4random_uniform(999))"
    }
    
    static func == (lhs: GiftFinderItem, rhs: GiftFinderItem) -> Bool {
        return lhs.identity == rhs.identity
    }
}
