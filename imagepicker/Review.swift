//
//  Review.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/28/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Review {
    let reviewer: String
    let reviewText: String
    let submissionTime: String
    let title: String
    let upVotes: Int
    let downVotes: Int
    let totalReviewCount: Int
    let count: Int
    let ratingValue: Int
    
    init(json: JSON) {
        self.reviewer = json["reviews"]["reviewer"].stringValue
        self.reviewText = json["reviews"]["reviewText"].stringValue
        self.submissionTime = json["reviews"]["submissionTime"].stringValue
        self.title = json["reviews"]["title"].stringValue
        self.upVotes = json["reviews"]["upVotes"].intValue
        self.downVotes = json["reviews"]["downVotes"].intValue
        self.totalReviewCount = json["totalReviewCount"].intValue
        self.count = json["count"].intValue
        self.ratingValue = json["ratingValue"].intValue
    
    }
    
}
