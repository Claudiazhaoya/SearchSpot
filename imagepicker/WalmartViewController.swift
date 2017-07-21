//
//  WalmartViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/18/17.
//  Copyright © 2017 Sara Robinson. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class WalmartViewController: UIViewController {
    let apiToContact = "http://api.walmartlabs.com/v1/search?apiKey=4te2df4q9m5r37f5det99nsm&query=ipod"
    var business: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json);
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    
                }
            case .failure(let error):
                print(error)
            }
        }
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
