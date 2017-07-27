//
//  DetailViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/24/17.
//  Copyright © 2017 Sara Robinson. All rights reserved.
//

import Foundation
import UIKit
import WalmartSDKKit
import Kingfisher

class DetailViewController: UIViewController {
    var item: Item?
    
    @IBOutlet weak var uitableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let iPhone6Item = WMTItem(itemId: "39665237", itemIdType: WMTItemIdType.walmartId)
//        let iPadProItem = WMTItem(itemId: "888462517904", itemIdType: WMTItemIdType.UPC)
//        
//        let iPhone6LineItem = WMTLineItem(wmtItem: iPhone6Item, quantity: 1)
//        let iPadProLineItem = WMTLineItem(wmtItem: iPadProItem, quantity: 1)
//        
//        let wmtLineItemsSet: Set<WMTLineItem> = [iPhone6LineItem!, iPadProLineItem!]
//        let buyNowButton = WMTBuyNowControl(wmtLineItems: wmtLineItemsSet)
//        
//        buyNowButton?.center = self.uitableView.center;
//        buyNowButton?.frame = CGRectMake(UIScreen.main.bounds.width - 110, 0, 90, 30)
//        self.uitableView.addSubview(buyNowButton!);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: (item?.addToCartUrl)!)!)
        
    }
    
}

extension DetailViewController: UITableViewDataSource {
 
    func setItemForWMButton(_ item:Item) -> Set<WMTLineItem> {
        let Item = WMTItem(itemId: "39665237", itemIdType: WMTItemIdType.walmartId)
        //        let iPadProItem = WMTItem(itemId: "888462517904", itemIdType: WMTItemIdType.UPC)
        
        let LineItem = WMTLineItem(wmtItem: Item, quantity: 1)
        //        let iPadProLineItem = WMTLineItem(wmtItem: iPadProItem, quantity: 1)
        
        let wmtLineItemsSet: Set<WMTLineItem> = [LineItem!]
        return wmtLineItemsSet
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell: IntroCell = tableView.dequeueReusableCell(withIdentifier: "IntroCell", for: indexPath) as! IntroCell
            cell.item = item
            cell.nameLabel.text = item?.name
            let imageURL = URL(string: (item?.imageUrl.replacingOccurrences(of: "450", with:"1080"))!)
            cell.posterView.kf.setImage(with: imageURL)
            cell.salePriceLabel.text = "$\(String(describing: (item?.salePrice)!))"
            cell.addToCartButton.setTitle("Add to cart", for: .normal)
            cell.buyNowButton?.setWMTLineItems(setItemForWMButton(item!))
            cell.numReviewsLabel.text = "\(String(describing: (item?.numReviews)!))"
            let ratingUrl = URL(string: (item?.customerRatingImageUrl)!)
            cell.ratingImageView.kf.setImage(with: ratingUrl)
            return cell
            
        case 1:
            let cell: FreeShipCell = tableView.dequeueReusableCell(withIdentifier: "freeship", for: indexPath) as! FreeShipCell
            if item?.freeShipping == true {
                cell.freeshipLabel.text = "Free shipping on orders over $50"
            } else {
                cell.freeshipLabel.text = "Do not have free shipping"
            }
            return cell
            
        case 2:
            let cell: DescriptionCell = tableView.dequeueReusableCell(withIdentifier: "description", for: indexPath) as! DescriptionCell
            if item?.shortDescription == "" {
                cell.shortDescriptionTextField.text = "No Description for this item"
            } else {
                cell.shortDescriptionTextField.text = item?.shortDescription
            }
            return cell
            
        default:
            //            fatalError("Error: unexpected indexPath.")
            print(indexPath)
            return UITableViewCell()
        }
    }
    
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return IntroCell.height
            
        case 1:
            return FreeShipCell.height
        case 2:
            return DescriptionCell.height
            
        default:
            fatalError()
            
        }
    }
}
