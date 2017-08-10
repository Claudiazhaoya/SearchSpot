//
//  Location.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/31/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

struct Location {
    let name: String
    let latitude: Double
    let longitude: Double
    let streetAddress: String
    let city: String
    let stateProvCode: String
    let zip: String
    let phoneNumber: String
    let sundayOpen: Bool
    let timezone: String
   
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.longitude = json["coordinates"][0].doubleValue
        self.latitude = json["coordinates"][1].doubleValue
        self.streetAddress = json["streetAddress"].stringValue
        self.city = json["city"].stringValue
        self.stateProvCode = json["stateProvCode"].stringValue
        self.zip = json["zip"].stringValue
        self.phoneNumber = json["phoneNumber"].stringValue
        self.sundayOpen = json["sundayOpen"].boolValue
        self.timezone = json["timezone"].stringValue
    }

}
