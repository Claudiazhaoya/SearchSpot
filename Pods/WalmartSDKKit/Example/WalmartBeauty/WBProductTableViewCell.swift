//
//  WBProductTableViewCell.swift
//  WalmartBeauty
//
//  Created by Siddhant Goyal
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

import UIKit
import WalmartOpenApi

class WBProductTableViewCell: UITableViewCell {
    
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    
    var walmartItem: WMTOAItem?
    
}




