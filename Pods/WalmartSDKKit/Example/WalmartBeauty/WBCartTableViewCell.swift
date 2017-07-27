//
//  WBCartTableViewCell.swift
//  WalmartBeauty
//
//  Created by Siddhant Goyal
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

import UIKit
import WalmartSDKKit
import DownPicker

class WBCartTableViewCell: UITableViewCell {
    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productTotalCostLabel: UILabel!
    @IBOutlet var quantityPickerTextField: UITextField!
    @IBOutlet var removeProductFromCartButton: UIButton!
    
    var walmartItem: WMTOAItem?
    var quantityPicker: DownPicker?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubViews()
    }
    
    func quantityPickerSelected() {
        if let product = walmartItem, quantity = UInt(quantityPickerTextField.text!) {
            productTotalCostLabel.text = "$" + (NSString(format: "%.2f", Double(quantity) * Double(product.salePrice)) as String)
            WBCartManager.sharedCart.updateProduct(product, quantity: quantity)
        }
    }
    
    func configureSubViews() {
        quantityPicker = DownPicker(textField: quantityPickerTextField, withData: ["1", "2", "3", "4", "5"])
        let img = UIImage(named: "downArrow.png")
        quantityPicker?.setArrowImage(img)
        quantityPicker?.addTarget(self, action: Selector("quantityPickerSelected"), forControlEvents: .ValueChanged)
    }
    
}
