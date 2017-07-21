//
//  BusinessViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/12/17.
//  Copyright © 2017 Sara Robinson. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import YelpAPI
import MapKit

class BusinessViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var businessTableView: UITableView!
    //    let appId = "7pUDx3Dj4zW2w9LbcErk2w"
    //    let appSecret = "QSuOjLjha7ad4BafegjHJXuQQmISTNCmOmnBzt65ue1aRCBxuezdaICzjuRPPUdy"
    //    let query = YLPQuery(location: "Los Angeles, CA")
    var businesses = YelpApiHelper.businesses
    //    var business: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsView" {
            let cell = sender as! BusinessCell
            let vc = segue.destination as! PageViewController
            let indexPath = businessTableView.indexPath(for: cell)
            if let indexPath = indexPath {
                vc.info = businesses[indexPath.row]
            }
        } else if segue.identifier == "mapView" {
            let vc = segue.destination as! MapViewController
            vc.businesses = self.businesses
        }
    }
}

extension BusinessViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //   print(businesses.count)
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath)
        let businessInfo = businesses[indexPath.row]
        
        (cell as? BusinessCell)?.viewModel = BusinessCellViewModel(withBusiness: businessInfo)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        businessTableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension BusinessViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
