//
//  BusinessViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/12/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import YelpAPI
import MapKit

class BusinessViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    let locationManager = CLLocationManager()
    @IBOutlet weak var businessTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var searchKey: String = ""
    var businesses = [YLPBusiness]()
    var filteredBusinesses = [YLPBusiness]()
    var location: CLPlacemark?
    var address: String?
    var coordinates: CLLocation?
    var firstUpdate = true
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBAction func homeButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        if searchKey == "" {
            searchKey = ImagePickerHelper.labelResult!
        }
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = UISearchBarStyle.minimal
        definesPresentationContext = true
        self.navigationItem.titleView = searchController.searchBar
        //        self.definesPresentationContext = true;
        
        
        //        lookUpCurrentLocation(completionHandler: {_ in
        //            self.address = "\(String(describing: (self.location?.locality)!)), \(String(describing: (self.location?.administrativeArea)!))"
        //        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsView" {
            let cell = sender as! BusinessCell
            let vc = segue.destination as! PageViewController
            let indexPath = businessTableView.indexPath(for: cell)
            if let indexPath = indexPath {
                if searchController.isActive && searchController.searchBar.text != "" {
                    vc.info  = filteredBusinesses[indexPath.row]
                } else {
                    print(businesses[indexPath.row])
                    vc.info = businesses[indexPath.row]
                }
            }
        } else if segue.identifier == "mapView" {
            let vc = segue.destination as! MapViewController
            if searchController.isActive && searchController.searchBar.text != "" {
                vc.businesses  = self.filteredBusinesses
            } else {
                vc.businesses = self.businesses
            }
        }
    }
    
    //    //get user's current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        coordinates = locations.first
        manager.stopUpdatingLocation()
        DispatchQueue.global(qos: .userInitiated).async {
            if self.firstUpdate {
                self.firstUpdate = false
                self.lookUpCurrentLocation(completionHandler: {_ in
                    self.address = "\(String(describing: (self.location?.locality)!)), \(String(describing: (self.location?.administrativeArea)!))"
                    YelpApiHelper.getBusinesses(location: self.address!, searchKey: self.searchKey, completion: { didComplete in
                        
                        if didComplete {
                        self.businesses = YelpApiHelper.businesses
                        DispatchQueue.main.async {
                            self.businessTableView.reloadData()
                            self.spinner.stopAnimating()
                        }
                        } else {
                            self.businesses = []
                            let alert = UIAlertController(title: "Error!", message: "Businesses Not Found", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            self.spinner.stopAnimating()
                            
                        }
                    })
                })
                
                
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    //Reverse geocoding a coordinate
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
        -> Void ) {
        // Use the last reported location
        if let lastLocation = self.coordinates {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                                                if error == nil {
                                                    let firstLocation = placemarks?[0]
                                                    self.location = firstLocation
                                                    
                                                    completionHandler(firstLocation)
                                                }
                                                else {
                                                    // An error occurred during geocoding.
                                                    completionHandler(nil)
                                                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    //search helper function
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredBusinesses = businesses.filter { business in
            let categoryMatch = (scope == "All") || (business.name == scope)
            return categoryMatch && business.name.lowercased().contains(searchText.lowercased())
        }
        
        businessTableView.reloadData()
    }
    
}

extension BusinessViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //        let searchBar = searchController.searchBar
        //        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

extension BusinessViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension BusinessViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        businessTableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension BusinessViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredBusinesses.count
        }
        return businesses.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath)
        let business: YLPBusiness
        if searchController.isActive && searchController.searchBar.text != "" {
            business = filteredBusinesses[indexPath.row]
        } else {
            business = businesses[indexPath.row]
        }
        (cell as? BusinessCell)?.viewModel = BusinessCellViewModel(withBusiness: business)
        
        return cell
    }
}
