//
//  WBCategoryProductsTableViewController.swift
//  WalmartBeauty
//
//  Created by Siddhant Goyal
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

import UIKit
import MBProgressHUD
import WalmartSDKKit

class WBCategoryProductsTableViewController: UITableViewController {
    
    var clickedProductCategory: String?
    var searchedProducts: [WMTOAItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        refreshTable()
    }
    
    func refreshTable() {
        if let clickedProductsCategory = self.clickedProductCategory, searchedProducts = self.searchedProducts {
            
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.labelText = "Loading..."
            
            // The search endpoint of WalmartOpenApi is access with category id as chosen from the main view
            // The results are obtained in a paginated fashion in batches of size 10. The order is default which is
            // relevance.
            
            WMTOASearchApi.sharedAPI().getSearchResponseWithApiKey(WBApiManager.applicationKey, query: "*", lsPublisherId: WBApiManager.rakutenPublisherId, categoryId: self.getProductCategoryId(clickedProductsCategory), start: searchedProducts.count + 1, sort: nil, order: nil, numItems: 10, format: "json", responseGroup: nil, facet: nil, facetFilter: nil, facetRange: nil, completionHandler: { (data, error) -> Void in
                if data != nil {
                    let walmartProducts = data.items as! [WMTOAItem]
                    if self.searchedProducts == nil {
                        self.searchedProducts = []
                    }
                    self.searchedProducts?.appendContentsOf(walmartProducts)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        hud.hide(true)
                        self.tableView.reloadData()
                    })
                }
                if error != nil {
                    print(error)
                    hud.hide(true)
                }
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "push to product page" && sender is NSIndexPath {
            if let destinationViewController = segue.destinationViewController as? WBProductPageTableViewController, nsIndexPath = sender as? NSIndexPath, searchedProducts = self.searchedProducts {
                if nsIndexPath.row < searchedProducts.count {
                    destinationViewController.walmartProduct = searchedProducts[nsIndexPath.row]
                }
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let searchedProducts = self.searchedProducts {
            return searchedProducts.count > 0 ? searchedProducts.count : 10
        } else {
            return 10
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let searchedProducts = self.searchedProducts {
            if searchedProducts.count < 1000 && indexPath.row == searchedProducts.count - 1 {
                refreshTable()
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("walmartbeautyproduct-cell", forIndexPath: indexPath) as! WBProductTableViewCell
        if let searchedProducts = self.searchedProducts {
            guard indexPath.row < searchedProducts.count else {
                return cell
            }
            let walmartProduct = searchedProducts[indexPath.row]
            cell.productImage.image = nil
            cell.productImage.setImageWithURL(WBHelper.getURLWithHttpsProtocol(walmartProduct.largeImage))
            cell.productName.text = walmartProduct.name
            cell.productPrice.text = "$" + (NSString(format: "%.2f", Double(walmartProduct.salePrice)) as String)
            cell.walmartItem = walmartProduct
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.searchedProducts != nil && indexPath.row < self.searchedProducts?.count {
            performSegueWithIdentifier("push to product page", sender: indexPath)
        }
    }
    
    
    func configureNavigationBar() {
        self.navigationItem.title = clickedProductCategory
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: WBHelper.getNavigationBarCartUIButton(self))
    }
    
    func showCart() {
        self.navigationController?.performSegueWithIdentifier("modally present shopping cart", sender: self)
    }
    
    func getProductCategoryId(productCategory: String) -> String {
        switch(productCategory) {
        case "Eye Makeup":
            return "1085666_1007040_1001525"
        case "Hair Care":
            return "1085666_1007219_1007000"
        case "Skin Care":
            return "1085666_1007039_1024839"
        case "Nail Trends":
            return "1085666_1007040_1001529"
        default:
            return "1085666"
        }
    }
}
