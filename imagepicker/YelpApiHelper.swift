//
//  YelpApiHelper.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/19/17.
//  Copyright © 2017 Sara Robinson. All rights reserved.
//  This is magic, do not touch

import Foundation
import UIKit
import YelpAPI

struct YelpApiHelper {
    static let appId = "7pUDx3Dj4zW2w9LbcErk2w"
    static let appSecret = "QSuOjLjha7ad4BafegjHJXuQQmISTNCmOmnBzt65ue1aRCBxuezdaICzjuRPPUdy"
    static let query = YLPQuery(location: "Los Angeles, CA")
    static var businesses: [YLPBusiness] = []
    //    static var business = ImagePickerHelper().labelResult
    //    static func getBusinesses(completion: @escaping (Bool) -> ()) {
    
    static func getBusinesses(completion: @escaping (Bool) -> ()) {
        //print("See me in YelpHelper: \(ImagePickerHelper.labelResult)")
        guard let result = ImagePickerHelper.labelResult else {
            return
        }
        print(result)
        query.term = result
        query.limit = 50
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
                        for business in topBusiness! {
                            print(business)
                            self.businesses.append(business)
                        }
                        //self.businessTableView.reloadData()
                        //self.dismiss(animated: true, completion: nil)
//                        print("Business Loading finished!")
                        print(businesses[0].name)
                        completion(true)
                    }
                })
            }
        }
        
    }
    
}
