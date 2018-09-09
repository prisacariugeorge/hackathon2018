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
