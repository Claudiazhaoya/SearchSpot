//
//  WBHelper.swift
//  WalmartBeauty
//
//  Created by Siddhant Goyal
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

import UIKit

class WBHelper: NSObject {
    
    static func getNavigationBarCartUIButton(buttonTarget: NSObject) -> UIButton {
        let cartButton = UIButton(type: .Custom)
        cartButton.frame = CGRectMake(0, 0, 18, 18)
        cartButton.setBackgroundImage(UIImage(named: "shoppingcart.png"), forState: .Normal)
        cartButton.addTarget(buttonTarget, action: Selector("showCart"), forControlEvents: .TouchUpInside)
        return cartButton
    }
    
    static func getURLWithHttpsProtocol(url: String) -> NSURL {
        let urlComponents = NSURLComponents(string: url)
        urlComponents?.scheme = "https"
        if let httpsUrl = urlComponents?.URL {
            return httpsUrl
        } else {
            return NSURL(string: url)!
        }
    }
    
    static func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
}
