//
//  MockData.swift
//  Hackathon2018
//
//  Created by Marian Prisacariu on 9/8/18.
//  Copyright © 2018 Marian Prisacariu. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

    func mockProducts(_ products: Results<Product>?) -> [Product] {
        var returnProducts = [Product]()
        var productsRec = [Product]()
        if let products = products {
            for value in products {
                returnProducts.append(value)
            }
        }
        
        return returnProducts
    }
    
    func mockFinders() -> [Finder] {
        var returnFinders = [Finder]()
        
        let finder1 = Finder()
        finder1.name = "Men"
        finder1.image = #imageLiteral(resourceName: "menFinder")
        returnFinders.append(finder1)
        
        let finder2 = Finder()
        finder2.name = "Women"
        finder2.image = #imageLiteral(resourceName: "womanFinder")
        returnFinders.append(finder2)
        
        let finder3 = Finder()
        finder3.name = "Teenagers"
        finder3.image = #imageLiteral(resourceName: "youthFinder")
        returnFinders.append(finder3)
        
        let finder4 = Finder()
        finder4.name = "Kids 8-12"
        finder4.image = #imageLiteral(resourceName: "copii")
        returnFinders.append(finder4)
        
        let finder5 = Finder()
        finder5.name = "Kids 4-7"
        finder5.image = #imageLiteral(resourceName: "children47")
        returnFinders.append(finder5)
        
        let finder7 = Finder()
        finder7.name = "Babies"
        finder7.image = #imageLiteral(resourceName: "bebelusi")
        returnFinders.append(finder7)
        
        return returnFinders
    }

func mockCategory() -> [FilterItem] {
//    Barbati: 1 - Watches, 2 - Shoes, 3 - Fragrance, 4 - Wallets
//    Femei: 1 - Jewellery, 2 - Shoes, 3 - Purses, 4 - Fragrance
    var returnCategories = [FilterItem]()
    
    let categoryWatches = FilterItem()
    categoryWatches.name = "Watches"
    categoryWatches.type = 1
    returnCategories.append(categoryWatches)
    
    let categoryShoes = FilterItem()
    categoryShoes.name = "Shoes"
    categoryShoes.type = 2
    returnCategories.append(categoryShoes)
    
    let categoryFragrance = FilterItem()
    categoryFragrance.name = "Fragrance"
    categoryFragrance.type = 3
    returnCategories.append(categoryFragrance)
    
    let categoryWallets = FilterItem()
    categoryWallets.name = "Wallets"
    categoryWallets.type = 4
    returnCategories.append(categoryWallets)
    
    let categoryJewellery = FilterItem()
    categoryJewellery.name = "Jewellery"
    categoryJewellery.type = 1
    returnCategories.append(categoryJewellery)
    
    let categoryPurses = FilterItem()
    categoryPurses.name = "Purses"
    categoryPurses.type = 3
    returnCategories.append(categoryPurses)
    
    return returnCategories
}

func mockPrices() -> [FilterItem] {
    var returnPrices = [FilterItem]()
    
    let price0 = FilterItem()
    price0.name = "0 Lei - 100 Lei"
    price0.type = 7
    returnPrices.append(price0)
    
    let price100 = FilterItem()
    price100.name = "100 Lei - 200 Lei"
    price100.type = 8
    returnPrices.append(price100)
    
    let price200 = FilterItem()
    price200.name = "200 Lei +"
    price200.type = 9
    returnPrices.append(price200)
    
    return returnPrices
}
