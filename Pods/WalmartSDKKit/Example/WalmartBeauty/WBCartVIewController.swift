//
//  WBCartVIewController.swift
//  WalmartBeauty
//
//  Created by Siddhant Goyal
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

import UIKit
import WalmartSDKKit

class WBCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var walmartbuyNowView: UIView!
    @IBOutlet var cartTable: UITableView!
    
    /// Static Instance of WalmartBuyNow Button managed by WBCartManager.
    static let walmartBuyNowButton = WMTBuyNowControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if WBCartManager.sharedCart.uniqueProductDictionary.count == 0 {
            cartTable.hidden = true
            let emptyCartLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 30))
            emptyCartLabel.text = "Your Shopping Cart is Empty !"
            emptyCartLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 20.0)!
            emptyCartLabel.center = self.view.center
            self.view.addSubview(emptyCartLabel)
        } else {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            WBCartViewController.walmartBuyNowButton.center = self.walmartbuyNowView.center
            self.view.addSubview(WBCartViewController.walmartBuyNowButton)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WBCartManager.sharedCart.uniqueProductDictionary.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cart product tableview cell", forIndexPath: indexPath) as!
        WBCartTableViewCell
        let sortedCartProducts = WBCartManager.sharedCart.productQuantityDictionary.sort {$0.0 < $1.0}
        let id = sortedCartProducts[indexPath.row].0
        let quantity = sortedCartProducts[indexPath.row].1
        if let walmartProduct = WBCartManager.sharedCart.uniqueProductDictionary[id] {
            cell.productImageView.image = nil
            cell.productImageView.setImageWithURL(WBHelper.getURLWithHttpsProtocol(walmartProduct.largeImage))
            cell.productNameLabel.text = walmartProduct.name
            cell.quantityPickerTextField.text = String(quantity)
            cell.productTotalCostLabel.text = "$" + (NSString(format: "%.2f", Double(quantity) * Double(walmartProduct.salePrice)) as String)
            cell.walmartItem = walmartProduct
        }
        return cell
        
    }
    
    @IBAction func dismissCart(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func removeFromCartButtonDidPressed(sender: UIButton) {
        let buttonPosition = sender.convertPoint(CGPointZero, toView: cartTable)
        if let indexPath = cartTable.indexPathForRowAtPoint(buttonPosition) {
            let sortedCartProducts = WBCartManager.sharedCart.productQuantityDictionary.sort {$0.0 < $1.0}
            let id = sortedCartProducts[indexPath.row].0
            let walmartProduct = WBCartManager.sharedCart.uniqueProductDictionary[id]
            if let product = walmartProduct {
                WBCartManager.sharedCart.removeProduct(product)
            }
            cartTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
}
