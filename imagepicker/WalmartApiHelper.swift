//
//  WalmartApiHelper.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/19/17.
//  Copyright © 2017 Sara Robinson. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class WalmartApiHelper {
    let apiToContact = "http://api.walmartlabs.com/v1/search?apiKey=4te2df4q9m5r37f5det99nsm&query=ipod"
    static var businesses: [String] = []
    func getWalmartBusiness() {
        guard let business = ImagePickerHelper.labelResult else {
            return
        }
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json);
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                }
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
}
