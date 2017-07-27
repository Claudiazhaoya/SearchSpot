//
//  WBProductAddToCartViewCell.swift
//  WalmartBeauty
//
//  Created by Siddhant Goyal
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

import UIKit
import WalmartSDKKit

class WBProductAddToCartViewCell: UITableViewCell {
    
    @IBOutlet var addToCartButton: UIButton!
    
    var walmartProduct: WMTOAItem?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addToCartButton.layer.cornerRadius = CGFloat(3.0)
        addToCartButton.clipsToBounds = true;
        addToCartButton.setTitle("Add To Cart", forState: .Normal)
    }
    
    @IBAction func addToCartButtonDidPressed(sender: UIButton) {
        if let walmartProduct = self.walmartProduct {
            WBCartManager.sharedCart.addProduct(walmartProduct)
            addToCartButton.enabled = false
            addToCartButton.setTitle("Adding...", forState: .Normal)
            WBHelper.delay(1.0) {
                self.addToCartButton.backgroundColor = UIColor(red:0.46, green:0.76, blue:0.26, alpha:1.0)
                self.addToCartButton.setTitle("Added", forState: .Normal)
                
                WBHelper.delay(1.0) {
                    self.addToCartButton.backgroundColor = UIColor(red:0.96, green:0.45, blue:0.13, alpha:1.0)
                    self.addToCartButton.setTitle("Add Another", forState: .Normal)
                    self.addToCartButton.enabled = true
                }
            }
        }
    }
    
}
