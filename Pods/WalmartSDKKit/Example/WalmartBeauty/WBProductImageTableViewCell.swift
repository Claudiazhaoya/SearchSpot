//
//  WBProductImageTableViewCell.swift
//  WalmartBeauty
//
//  Created by Siddhant Goyal
//  Copyright © 2016 @WalmartLabs. All rights reserved.
//

import UIKit

class WBProductImageTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    @IBOutlet var productImageCollectionView: UICollectionView!
    @IBOutlet var productImagePageControl: UIPageControl!
    
    var imageURLs: [String]?
    
    var currentPage: Int {
        get {
            return productImagePageControl.currentPage
        }
        set(newCurrentPage) {
            if newCurrentPage != currentPage {
                let scrollerWidth = productImageCollectionView.frame.size.width
                productImageCollectionView.contentOffset = CGPoint(x: scrollerWidth * CGFloat(currentPage), y: 0)
            }
            productImagePageControl.currentPage = newCurrentPage
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let imageURLs = self.imageURLs {
            return imageURLs.count > 0 ? imageURLs.count : 1;
        } else {
            return 1
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("product image collectionview cell", forIndexPath: indexPath) as! WBProductImageCollectionViewCell
        
        if let imageURLs = self.imageURLs {
            cell.productImageView.image = nil
            if indexPath.row < imageURLs.count {
                cell.productImageView.setImageWithURL(WBHelper.getURLWithHttpsProtocol(imageURLs[indexPath.row]))
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 200.0)
    }
    
    @IBAction func productImagePageControlValueDidChanged(sender: UIPageControl) {
        currentPage = productImagePageControl.currentPage
        productImageCollectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: currentPage, inSection: 0), atScrollPosition: .CenteredHorizontally, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollWidth = scrollView.frame.size.width
        let pageOffset = scrollView.contentOffset.x / scrollWidth
        let pageNumber = Int(pageOffset + 0.5)
        productImagePageControl.currentPage = pageNumber
    }

}
