//
//  WalmartMapHelper.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/31/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import MapKit
import CoreLocation

struct WalmartMapHelper {
    static var locations = [Location]()
    
    static func getCoordinates(coordinate: CLLocationCoordinate2D, completion: @escaping ([Location]?) -> ()) {
  
         let apiKey = "http://api.walmartlabs.com/v1/stores?apiKey=m87a485tb3ccap99km9sr8he&lon=" + String(describing: coordinate.longitude) + "&lat=" + String(describing: coordinate.latitude) + "&format=json"
        Alamofire.request(apiKey).validate().responseJSON() {
            response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let locationData = JSON(value)
                    self.locations.removeAll()
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    let allocationsData = locationData.arrayValue
                    for location in allocationsData {
                        self.locations.append(Location(json: location))
                    }
                    completion(locations)
                }
            case .failure(let error):
                print(error)
                completion(nil)
            }
            
        }
        
    }
}
