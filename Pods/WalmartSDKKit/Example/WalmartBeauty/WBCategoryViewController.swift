//
//  WBCategoryViewController.swift
//  WalmartBeauty
//
//  Created by Siddhant Goyal
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

import UIKit

class WBCategoryViewController: UIViewController {

    var clickedProductCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "push to product list page" {
            if let destination = segue.destinationViewController
                as? WBCategoryProductsTableViewController, clickedProductCategory = self.clickedProductCategory {
                    destination.clickedProductCategory = clickedProductCategory
                    destination.searchedProducts = []
            }
        }
    }

    
    @IBAction func productCategory(sender: UIButton) {
        clickedProductCategory = sender.currentTitle
        performSegueWithIdentifier("push to product list page", sender: self)
    }
    
        
    func configureNavigationBar() {
        navigationItem.title = "Walmart Beauty"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: WBHelper.getNavigationBarCartUIButton(self))
    }
    
    func showCart() {
        navigationController?.performSegueWithIdentifier("modally present shopping cart", sender: self)
    }

}

