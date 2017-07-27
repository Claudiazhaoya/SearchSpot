//
//  Item.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/21/17.
//  Copyright © 2017 Sara Robinson. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Item {
    let name: String
    let salePrice: Double
    let shortDescription: String
    let productUrl: String
    let availableOnline: Bool
    let imageUrl: String
    let largeImageUrl: String
    let customerRatingImageUrl: String
    let addToCartUrl: String
    let freeShipping: Bool
    let isTwoDayShippingEligible: Bool
    let numReviews: Int
    let itemId: Int
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.imageUrl = json["imageEntities"][0]["mediumImage"].stringValue
        self.salePrice = json["salePrice"].doubleValue
        self.shortDescription = json["shortDescription"].stringValue
        self.productUrl = json["productUrl"].stringValue
        self.availableOnline = json["availableOnline"].boolValue
        self.customerRatingImageUrl = json["customerRatingImage"].stringValue
        self.addToCartUrl = json["addToCartUrl"].stringValue
        self.freeShipping = json["freeShippingOver50Dollars"].boolValue
        self.largeImageUrl = json["imageEntities"][0]["largeImage"].stringValue
        self.isTwoDayShippingEligible = json["isTwoDayShippingEligible"].boolValue
        self.numReviews = json["numReviews"].intValue
        self.itemId = json["itemId"].intValue
    }

}
