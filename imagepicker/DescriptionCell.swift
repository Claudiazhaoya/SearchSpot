//
//  DescriptionCell.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/25/17.
//  Copyright © 2017 Sara Robinson. All rights reserved.
//

import Foundation
import UIKit

class DescriptionCell: UITableViewCell {
    static let height: CGFloat = 220
    
    
    @IBOutlet weak var shortDescriptionTextField: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
}
