//
//  ReviewCell.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/28/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//
import Foundation
import UIKit
import WalmartSDKKit

protocol ReviewCellProtocol: AnyObject {
    var reviewer: String { get }
    var reviewText: String { get }
    var submissionTime: String { get }
    var title: String { get }
    var upVotes: Int { get }
    var downVotes: Int { get }
    var totalReviewCount: Int { get }
    var count: Int { get }
    var ratingValue: Int { get }
}

final class ReviewCellViewModel: ReviewCellProtocol {
    
    private let review: Review
    
    var reviewer: String {
        return review.reviewer
    }
    
    var reviewText: String {
        return review.reviewText
    }
    
    var submissionTime: String {
        return review.submissionTime
    }
    
    var title: String {
        return review.title
    }
    
    var upVotes: Int {
        return review.upVotes
    }
    
    var downVotes: Int {
        return review.downVotes
    }
    
    var totalReviewCount: Int {
        return review.totalReviewCount
    }
    
    var count: Int {
        return review.count
    }
    
    var ratingValue: Int {
        return review.ratingValue
    }
    
    
    init(withItem ReviewItem: Review) {
        self.review = ReviewItem
    }
    
}

final class ReviewCell: UITableViewCell {
    static let height: CGFloat = 530
    weak var viewModel: ReviewCellViewModel? {
        didSet {
            guard viewModel != nil else {
                return
            }
            
        }
    }
    
    var review:Review?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
}


