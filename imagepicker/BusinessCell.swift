//
//  BusinessCell.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/12/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import Foundation
import UIKit
import YelpAPI

protocol BusinessProtocol: AnyObject {
    var name: String { get }
    var opened: String { get }
    var rating: String { get }
    var address: String { get }
    var types: String { get }
    var reviewCount: String { get }
    var image: UIImage? { get }
}

final class BusinessCellViewModel: BusinessProtocol {
    private let business: YLPBusiness
    
    var name: String {
        return business.name
    }
    
    var opened: String {
        return business.isClosed ? "Closed" : "Open"
    }
    
    var rating: String {
        return "Rating: \(business.rating)"
    }
    
    var address: String {
        if let value = business.location.address.first {
            return value
        }
        return ""
    }
    
    var types: String {
        if let value = business.categories.first?.name {
            return value
        }
        return ""
    }
    
    var reviewCount: String {
        return "Reviews: \(String(business.reviewCount))"
    }
    
    var image: UIImage? {
        if let url = business.imageURL {
            let data = try? Data(contentsOf: url)
            if let data = data {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    init(withBusiness business: YLPBusiness) {
        self.business = business
    }
}

final class BusinessCell: UITableViewCell {
    
    weak var viewModel: BusinessCellViewModel? {
        didSet {
            guard let vm = viewModel else {
                return
            }
            nameLabel.text = vm.name
            priceLabel.text = vm.opened
            ratingLabel.text = vm.rating
            typesLabel.text = vm.types
            distanceLabel.text = vm.reviewCount
            addressLabel.text = vm.address
            businessView.image = vm.image
        }
    }
    
    @IBOutlet weak var businessView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
