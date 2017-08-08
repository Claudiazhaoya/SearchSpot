//
//  YelpApiHelper.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/19/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//  This is magic, do not touch

import Foundation
import UIKit
import YelpAPI

struct YelpApiHelper {
    static let appId = "7pUDx3Dj4zW2w9LbcErk2w"
    static let appSecret = "QSuOjLjha7ad4BafegjHJXuQQmISTNCmOmnBzt65ue1aRCBxuezdaICzjuRPPUdy"
    //    static var location: String = ""
    //    static let query = YLPQuery(location: YelpApiHelper.location)
    static var businesses: [YLPBusiness] = []
    //    static var business = ImagePickerHelper().labelResult
    //    static func getBusinesses(completion: @escaping (Bool) -> ()) {
    static func getBusinesses(location: String, searchKey: String, completion: @escaping (Bool) -> ()) {
        let query = YLPQuery(location: location)
        print("searchKey in Yelper: \(searchKey)")
        query.term = searchKey
        //        query.limit = 50
        YLPClient.authorize(withAppId: appId, secret: appSecret) { (client, error) in
            if error != nil {
                print(error.debugDescription)
                
            } else {
                
                client?.search(with: query, completionHandler: { (search, error) in
                    if error != nil {
                        print(error.debugDescription)
                        completion(false)
                    } else {
                        let topBusiness = search?.businesses
                        self.businesses.removeAll()
                        if !topBusiness!.isEmpty {
                            for business in topBusiness! {
                                print(business)
                                self.businesses.append(business)
                            }
                            completion(true)
                        } else {
                            completion(false)
                        }
                    }
                })
            }
        }
        
    }
    
}
