//
//  FreeShipCell.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/25/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import Foundation
import UIKit

class FreeShipCell: UITableViewCell {
    static let height: CGFloat = 72
    
    @IBOutlet weak var freeshipLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none

    }
    
}
