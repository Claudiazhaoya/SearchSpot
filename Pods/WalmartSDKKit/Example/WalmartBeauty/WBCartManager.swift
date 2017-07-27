//
//  WBCart.swift
//  WalmartBeauty
//
//  Created by Siddhant Goyal
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

import UIKit
import WalmartSDKKit

/// WBCartManager manages the cart instance as well as the WalmartBuyNow Button instance.
class WBCartManager: NSObject {
    
    static let sharedCart = WBCartManager()
    var productQuantityDictionary = [String: UInt]()
    var uniqueProductDictionary = [String: WMTOAItem]()
    
    /**
     This function adds WalmartOpenAPI item to the cart.
     It also adds the WMTItem to the Walmart BuyNow Button.
     
     - parameter product: Walmart Open Api Item
     */
    
    func addProduct(product: WMTOAItem) {
        
        let walmartItem = WMTItem(WMTOAItem: product)
        WBCartViewController.walmartBuyNowButton.addWMTItem(walmartItem, withQuantity: 1)

        let id = String(product.itemId)
        if let quantity = productQuantityDictionary[id] {
            productQuantityDictionary[id] = quantity + 1
        } else {
            productQuantityDictionary[id] = 1
            uniqueProductDictionary[id] = product
        }

    }
    
    
    /**
     This function updates WMTOAItem in the cart with the specified quantity
     It also updates the WMTItem to the Walmart BuyNow Button instance.
     
     - parameter product:  Walmart Open API Item
     - parameter quantity: Quantiy to which WMTOAItem has to be updated
     */
    
    func updateProduct(product: WMTOAItem, quantity: UInt) {
        
        let walmartItem = WMTItem(WMTOAItem: product)
        WBCartViewController.walmartBuyNowButton.setWMTItem(walmartItem, withQuantity: quantity)

        let id = String(product.itemId)
        productQuantityDictionary[id] = quantity
    }

    
    /**
     This function removes WalmartOpenAPI item from the cart.
     It also removes the WMTItem from the Walmart BuyNow Button instance
     
     - parameter product: Walmart Open API item
     */
    func removeProduct(product: WMTOAItem) {
        
        let walmartItem = WMTItem(WMTOAItem: product)
        WBCartViewController.walmartBuyNowButton.removeWMTItem(walmartItem)

        let id = String(product.itemId)
        productQuantityDictionary[id] = nil
        uniqueProductDictionary[id] = nil
    }
}
