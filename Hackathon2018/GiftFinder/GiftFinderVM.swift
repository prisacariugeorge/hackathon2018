//
//  GiftFinderVM.swift
//  Hackathon2018
//
//  Created by Marian Prisacariu on 9/8/18.
//  Copyright © 2018 Marian Prisacariu. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class GiftFinderVM: NSObject {
    private let disposeBag = DisposeBag()
    
    var giftFinderDTO = Variable<GiftFinderDTO>(GiftFinderDTO())
    
    var products: [Product] = []
    
    var dataSource = Variable<[GiftFinderSection]>([])
    
    init(giftFinderDTO: GiftFinderDTO) {
        super.init()
        self.bindOutput()
        self.giftFinderDTO.value = giftFinderDTO
        self.giftFinderDTO.value.context = self
    }
    func bindOutput() {
        giftFinderDTO.asObservable()
            .subscribeOn(MainScheduler.instance)
            .map { (arg) -> [GiftFinderSection] in
                return self.getDataSourceForGiftFinderFor(self.giftFinderDTO.value)
            }
            .subscribe(onNext: { [weak self] dataSource in
                self?.dataSource.value = dataSource
            })
            .disposed(by: self.disposeBag)
    }
    
    func getDataSourceForGiftFinderFor(_ giftFinderDTO: GiftFinderDTO) -> [GiftFinderSection] {
        
        var returnDataSource = [GiftFinderSection]()
        
        
        if let finders = giftFinderDTO.finders {
            
            let giftFinderSection = GiftFinderSection(name: "Finders",
                                                      elements: self.findersItemsFor(finders))
            returnDataSource.append(giftFinderSection)
        }
        
        if let products = giftFinderDTO.products {
            let finderSection = GiftFinderSection(name: "Recommendation",
                                                  elements: self.recommendationItemsFor(products))
            returnDataSource.append(finderSection)
        }
        return  returnDataSource
    }
    
    func recommendationItemsFor(_ products: [Product]) -> [GiftFinderItem] {
        var recommendationItems = [GiftFinderItem]()
        for value in products {
            let gridCell = GiftFinderItem(type: .recommendationCell,
                                          data: value)
            recommendationItems.append(gridCell)
        }
        return recommendationItems
    }
    
    func findersItemsFor(_ finders: [Finder]) -> [GiftFinderItem] {
        return [GiftFinderItem(type: .finderCell,
                               data: finders)]
    }
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

