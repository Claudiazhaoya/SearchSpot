//
//  StoreOptionViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/18/17.
//  Copyright © 2017 Sara Robinson. All rights reserved.
//

import Foundation
import UIKit

class StoreOptionViewController: UIViewController {
    var image: UIImage?
    
    
    @IBOutlet weak var YelpButton: UIButton!
    @IBOutlet weak var WalmartButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.center = view.center;
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func YelpButtonTapped(_ sender: UIButton) {
        self.activityIndicator.startAnimating()
        YelpApiHelper.getBusinesses(completion: {_ in
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "Yelp", sender: self)
        })
    }
    
    @IBAction func WalmartButtonTapped(_ sender: UIButton) {
        self.activityIndicator.startAnimating()
        WalmartApiHelper.getWalmartBusiness(completion: {_ in
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "Walmart", sender: self)
        })
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "Yelp" {
    //            //            present(BusinessViewController, animated: true, completion: nil)
    //            let destination = segue.destination as? BusinessViewController
    //            //                let binaryImageData = ImagePickerHelper().base64EncodeImage(image!)
    //            //                ImagePickerHelper().createRequest(with: binaryImageData)
    //            //                destination?.business =
    //
    //            //            destination?.image = image
    //        } else if segue.identifier == "Walmart" {
    //            let destination = segue.destination as? WalmartViewController
    //            //            destination?.image = image
    //        }
    //    }
}
