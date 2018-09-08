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

extension ViewControllerVC {
    func getProducts(_ products: Results<Product>?) -> [Product] {
        var returnProducts = [Product]()
        var productsRec = [Product]()
        if let products = products {
            for value in products {
                returnProducts.append(value)
            }
        }
        
        return returnProducts
    }
    
    func getFinders() -> [Finder] {
        var returnFinders = [Finder]()
        
        let finder1 = Finder()
        finder1.name = "Men"
        finder1.image = #imageLiteral(resourceName: "menFinder")
        returnFinders.append(finder1)
        
        let finder2 = Finder()
        finder2.name = "Woman"
        finder2.image = #imageLiteral(resourceName: "womanFinder")
        returnFinders.append(finder2)
        
        let finder3 = Finder()
        finder3.name = "Young people"
        finder3.image = #imageLiteral(resourceName: "youthFinder")
        returnFinders.append(finder3)
        
        let finder4 = Finder()
        finder4.name = "Children 8-12"
        finder4.image = #imageLiteral(resourceName: "copii")
        returnFinders.append(finder4)
        
        let finder5 = Finder()
        finder5.name = "Children 4-7"
        finder5.image = #imageLiteral(resourceName: "children47")
        returnFinders.append(finder5)
        
        let finder6 = Finder()
        finder6.name = "Small children"
        finder6.image = #imageLiteral(resourceName: "copiiMici")
        returnFinders.append(finder6)
        
        let finder7 = Finder()
        finder7.name = "Baby"
        finder7.image = #imageLiteral(resourceName: "bebelusi")
        returnFinders.append(finder7)
        
        return returnFinders
    }
}
