//
//  WBProductPageTableViewController.swift
//  WalmartBeauty
//
//  Created by Siddhant Goyal
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

import UIKit
import WalmartSDKKit


class WBProductPageTableViewController: UITableViewController {
    
    var walmartProduct: WMTOAItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.row) {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("product title tableview cell", forIndexPath: indexPath) as! WBProductTitleTableViewCell
            if let walmartProduct = self.walmartProduct {
                cell.productTitleLabel.text = walmartProduct.name
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("product image tableview cell", forIndexPath: indexPath) as! WBProductImageTableViewCell
            
            if let walmartProduct = self.walmartProduct {
                let imageEntities = walmartProduct.imageEntities as! [WMTOAImageEntity]
                
                cell.imageURLs = []
                for imageEntity in imageEntities {
                    if imageEntity.entityType == "PRIMARY" {
                        cell.imageURLs?.append(imageEntity.largeImage)
                    }
                }
                for imageEntity in imageEntities {
                    if imageEntity.entityType != "PRIMARY" {
                        cell.imageURLs?.append(imageEntity.largeImage)
                    }
                }
                cell.productImageCollectionView.dataSource = cell
                cell.productImageCollectionView.delegate = cell
                cell.productImageCollectionView.reloadData()
                
                cell.currentPage = 0;
                cell.productImagePageControl.numberOfPages = imageEntities.count
            }
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("product price tableview cell", forIndexPath: indexPath) as! WBProductPriceTableViewCell
            if let walmartProduct = self.walmartProduct {
                cell.productPriceLabel.text = "$" + String((Double(walmartProduct.salePrice)*100)/100.0)
            }
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("product add to cart tableview cell", forIndexPath: indexPath) as! WBProductAddToCartViewCell
            cell.walmartProduct = walmartProduct
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("product description tableview cell", forIndexPath: indexPath) as! WBProductDescriptionTableViewCell
            if let walmartProduct = self.walmartProduct {
                do {
                    let productDescription = walmartProduct.shortDescription ?? walmartProduct.longDescription ?? ""
                    let productDescriptionHtml = try NSAttributedString(data: productDescription.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                    let productDescriptionWithoutHtmlTags = productDescriptionHtml.string.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
                    cell.productDescriptionLabel.text = productDescriptionWithoutHtmlTags
                } catch {
                    print(error)
                }
            }
            return cell
            
        default:
            print("WARN! Indexpath row in product page table view found more than maximum value")
            return UITableViewCell()
        }
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: WBHelper.getNavigationBarCartUIButton(self))
    }
    
    func showCart() {
        self.navigationController?.performSegueWithIdentifier("modally present shopping cart", sender: self)
    }
    
}
