//
//  WalmartReviewApiHelper.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/28/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import Foundation
import SwiftyJSON
import WalmartSDKKit
import Alamofire

struct WalmartReviewApiHelper {
    static let apiKey1 = "http://api.walmartlabs.com/v1/reviews/"
    static var itemId: Int?
    static let apiKey2 = "?apiKey=m87a485tb3ccap99km9sr8he&format=json"
    static var reviews: [Review] = []
//    var apiToConnect = self.apiKey1 + self.itemId + self.apiKey2
    
    static func getReviews(completion: @escaping (Bool) -> ()) {
        let apiToConnect = self.apiKey1 + "\(String(describing: self.itemId))" + self.apiKey2
        Alamofire.request(apiToConnect).validate().responseJSON() {
            response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let reviewData = JSON(value)
                    print(reviewData)
                    self.reviews.removeAll()
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    let allReviewsData = reviewData["items"].arrayValue
                    
                    for review in allReviewsData {
                        self.reviews.append(Review(json: review))
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
