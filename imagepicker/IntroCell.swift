//
//  IntroCell.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/25/17.
//  Copyright © 2017 Sara Robinson. All rights reserved.
//

import Foundation
import UIKit
import WalmartSDKKit

protocol IntroCellProtocol: AnyObject {
    var name: String { get }
    var imageUrl: String { get }
    var salePrice: String { get }
    var addToCartUrl: String { get }
    var itemId: Int { get }
    var ratingImageView: String { get }
    var numReviews: Int { get }
}

final class IntroCellViewModel: IntroCellProtocol {
    
    private let item: Item
    
    var name: String {
        return item.name
    }
    
    var imageUrl: String {
        return item.largeImageUrl
    }
    
    var salePrice: String {
        return "$\(item.salePrice)"
    }
    
    var addToCartUrl: String {
        return item.addToCartUrl
    }
    
    var itemId: Int {
        return item.itemId
    }
    
    var ratingImageView: String {
        return item.customerRatingImageUrl
    }
    
    var numReviews: Int {
        return item.numReviews
    }
    
    init(withItem introItem: Item) {
        self.item = introItem
    }
    
}

final class IntroCell: UITableViewCell {
    static let height: CGFloat = 503
    weak var viewModel: IntroCellViewModel? {
        didSet {
            guard let vm = viewModel else {
                return
            }
            self.nameLabel.text = vm.name
            self.nameLabel.numberOfLines = 2
            self.salePriceLabel.text = String(vm.salePrice)
            self.addToCartButton.setTitle("Add to cart", for: .normal)
            self.loadImage(urlString: vm.imageUrl.replacingOccurrences(of: "450", with:"1080"), usePostView: true)
            self.loadImage(urlString: vm.ratingImageView, usePostView: true)
            self.numReviewsLabel.text = "\(vm.numReviews)"
        }
    }
    
    var item:Item?
    
    
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var buyLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var numReviewsLabel: UILabel!
    
    func loadImage(urlString: String, usePostView: Bool) {
        guard let url = URL(string: urlString) else {
            return
        }
        if usePostView {
            posterView.af_setImage(withURL: url)
        } else {
            ratingImageView.af_setImage(withURL: url)
        }
        
    }
    var buyNowButton:WMTBuyNowControl?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let Item = WMTItem(itemId: "39665237", itemIdType: WMTItemIdType.walmartId)
        //        let iPadProItem = WMTItem(itemId: "888462517904", itemIdType: WMTItemIdType.UPC)
        
        let LineItem = WMTLineItem(wmtItem: Item, quantity: 1)
        //        let iPadProLineItem = WMTLineItem(wmtItem: iPadProItem, quantity: 1)
        
        let wmtLineItemsSet: Set<WMTLineItem> = [LineItem!]
        buyNowButton = WMTBuyNowControl(wmtLineItems: wmtLineItemsSet)
        
        buyNowButton?.center = self.buyLabel.center;
        // Change Size to Compact Scheme
        buyNowButton?.sizeScheme = WMTButtonSizeScheme.compact;
        
        self.contentsView.addSubview(buyNowButton!);
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
}


