//
//  ItemCell.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/21/17.
//  Copyright © 2017 Sara Robinson. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

protocol ItemProtocol: AnyObject {
    var name: String { get }
    var salePrice: String { get }
    var shortDescription: String { get }
    var productUrl: String { get }
    var availableOnline: Bool { get }
    var imageUrl: String { get }
    var customerRatingImageUrl: String { get }
    var isTwoDayShippingEligible: Bool { get }
    var numReviews: Int { get }
}

final class ItemCellViewModel: ItemProtocol {
    private let item: Item
    
    var name: String {
        return item.name
    }
    
    var salePrice: String {
        return "$\(item.salePrice)"
    }
    
    var shortDescription: String {
        return "About: \(item.shortDescription)"
    }
    
    var productUrl: String {
        return item.productUrl
    }
    
    var availableOnline: Bool {
        return item.availableOnline ? true : false
    }
    
    var imageUrl: String {
        return item.imageUrl
    }
    
    var customerRatingImageUrl: String {
        return item.customerRatingImageUrl
    }
    
    var isTwoDayShippingEligible: Bool {
        return item.isTwoDayShippingEligible
    }
    
    var numReviews: Int {
        return item.numReviews
    }
    
    init(withItem item: Item) {
        self.item = item
    }
}

final class ItemCell: UITableViewCell {
    static let height: CGFloat = 150
    weak var viewModel: ItemCellViewModel? {
        didSet {
            guard let vm = viewModel else {
                return
            }
            self.nameLabel.text = vm.name
            self.salePriceLabel.text = String(vm.salePrice)
            if vm.isTwoDayShippingEligible == true {
                self.twoDayFreeShippingLabel.text = "2-Day Shipping"
            } else {
                self.twoDayFreeShippingLabel.text = "Free Ship over $50"
            }
            
            if vm.availableOnline == true {
                self.availableLabel.text = "Available Online"
            } else {
                self.availableLabel.text = "Not Available Online"
            }
            
            self.loadImage(urlString: vm.imageUrl, usePostView: true)
            //                self.imageView?.backgroundColor = UIColor.lightGray
            
            self.loadImage(urlString: vm.customerRatingImageUrl, usePostView: false)
            //                self.imageView?.backgroundColor = UIColor.lightGray
            
            
            self.numReviews.text = "(\(String(vm.numReviews)))"
            
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var customerRatingImageView: UIImageView!
    @IBOutlet weak var salePriceLabel: UILabel!
    
    
    @IBOutlet weak var twoDayFreeShippingLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    
    @IBOutlet weak var numReviews: UILabel!
    // Updates the image view when passed a url string
    func loadImage(urlString: String, usePostView: Bool)  {
        guard let url = URL(string: urlString) else {
            return
        }
        if usePostView {
            posterView.af_setImage(withURL: url)
            
        } else {
            customerRatingImageView.af_setImage(withURL: url)
        }
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
