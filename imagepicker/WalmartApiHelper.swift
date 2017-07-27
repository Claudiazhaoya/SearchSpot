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

struct WalmartApiHelper {
    static let apiKey1 = "http://api.walmartlabs.com/v1/search?apiKey=4te2df4q9m5r37f5det99nsm&query="
    static var items: [Item] = []
//    static let query = ImagePickerHelper.labelResult!
    
    
    static func getWalmartBusiness(completion: @escaping (Bool) -> ()) {
        guard let query = ImagePickerHelper.labelResult else {
            return
        }
        print("labelResult: \(query)")
        let apiKey = self.apiKey1 + query
        Alamofire.request(apiKey).validate().responseJSON() { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let itemData = JSON(value)
                    print(itemData)
                    self.items.removeAll()
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    let allItemsData = itemData["items"].arrayValue
                    
                    for item in allItemsData {
                        self.items.append(Item(json: item))
                    }
                    
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
