//
//  WalmartApiHelper.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/19/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

struct WalmartApiHelper {
    static let apiKey1 = "http://api.walmartlabs.com/v1/search?apiKey=m87a485tb3ccap99km9sr8he&query="
    static var items: [Item] = []
    //    static let query = ImagePickerHelper.labelResult!
    var searchKey: String = ""
    
    static func getWalmartBusiness(searchKey: String, completion: @escaping (Bool) -> ()) {
        let query = searchKey
        let apiKey = self.apiKey1 + query
        Alamofire.request(apiKey).validate().responseJSON() { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let itemData = JSON(value)
                    self.items.removeAll()
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    let allItemsData = itemData["items"].arrayValue
                    if !(allItemsData.isEmpty) {
                        for item in allItemsData {
                            self.items.append(Item(json: item))
                        }
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
