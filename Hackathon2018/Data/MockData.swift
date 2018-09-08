//
//  MockData.swift
//  Hackathon2018
//
//  Created by Marian Prisacariu on 9/8/18.
//  Copyright © 2018 Marian Prisacariu. All rights reserved.
//

import Foundation
import UIKit

extension ViewControllerVC {
    func getRecommendation() -> [Recommendation] {
        var returnRecommendation = [Recommendation]()
        
        let product1 = Product()
        product1.productName = "test a"
        product1.rating = 4
        product1.image = #imageLiteral(resourceName: "copiiMici")
        
        let product2 = Product()
        product2.productName = "test second"
        product2.rating = 3
        product2.image = #imageLiteral(resourceName: "youthFinder")
        
        let product3 = Product()
        product3.productName = "test third"
        product3.rating = 5
        product3.image = #imageLiteral(resourceName: "womanFinder")
        
        let product4 = Product()
        product4.productName = "test new"
        product4.rating = 1
        product4.image = #imageLiteral(resourceName: "menFinder")
        
        let recommendation1 = Recommendation()
        recommendation1.products = [product1, product2, product3, product4]
        
        returnRecommendation.append(recommendation1)
        
        return returnRecommendation
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