//
//  WalmartViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/18/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import CoreLocation

class WalmartViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var itemTableView: UITableView!
    var searchKey: String = ""
    var items = [Item]()
    var filteredItems = [Item]()
    var locations = [Location]() {
        didSet {
            self.itemTableView.reloadData()
        }
    }
    var filterLocations = [Location]()
    let locationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?
    var coordinate = CLLocationCoordinate2D()
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        spinner.startAnimating()
        if searchKey == "" {
            searchKey = ImagePickerHelper.labelResult!
        }
        print("Search:\(searchKey)")
        DispatchQueue.global(qos: .userInitiated).async {
            WalmartApiHelper.getWalmartBusiness(searchKey: self.searchKey, completion: { didComplete in
                if didComplete {
                    self.items = WalmartApiHelper.items
                    print(self.items.count)
                    DispatchQueue.main.async {
                        self.itemTableView.reloadData()
                        self.spinner.stopAnimating()
                    }
                } else {
                    self.items = []
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error!", message: "Businesses Not Found", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.spinner.stopAnimating()
                    }
                }
            })
        }
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = UISearchBarStyle.minimal
        definesPresentationContext = true
        self.navigationItem.titleView = searchController.searchBar
        //        self.itemTableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true;
        
        searchController.searchBar.delegate = self
        
        // location manager setup
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
    }
    
    @IBAction func locateUserButtonTapped(_ sender: UIBarButtonItem) {
        // Ask for Authorisation from the User.
        
        self.performSegue(withIdentifier: "mapView", sender: self)
    }
    
    @IBAction func homeButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            let cell = sender as! ItemCell
            let vc = segue.destination as! DetailViewController
            let indexPath = itemTableView.indexPath(for: cell)
            if let indexPath = indexPath {
                if searchController.isActive && searchController.searchBar.text != "" {
                    vc.item = filteredItems[indexPath.row]
                } else {
                    vc.item = items[indexPath.row]
                }
            }
        } else if segue.identifier == "mapView" {
            let vc = segue.destination as! WalmartMapViewController
            vc.latitude = self.latitude
            vc.longitude = self.longitude
            if searchController.isActive && searchController.searchBar.text != "" {
                vc.locations = self.filterLocations
            } else {
                vc.locations = self.locations
            }
        } else if segue.identifier == "home" {
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //get user's current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        //        print(location!.coordinate)
        self.latitude = location!.coordinate.latitude
        self.longitude = location!.coordinate.longitude
        coordinate = location!.coordinate
        
        locationManager.stopUpdatingLocation()
        WalmartMapHelper.getCoordinates(coordinate: coordinate, completion: { locations in
            self.locations = WalmartMapHelper.locations
        })
        
    }
    //search bar helper functions
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredItems = items.filter { item in
            let nameMatch = (scope == "All") || (item.name == scope)
            return nameMatch && item.name.lowercased().contains(searchText.lowercased())
        }
        
        filterLocations = locations.filter { location in
            let nameMatch = (scope == "All") || (location.name == scope)
            return nameMatch && location.name.lowercased().contains(searchText.lowercased())
        }
        itemTableView.reloadData()
    }
}

extension WalmartViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

extension WalmartViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension WalmartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemTableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension WalmartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredItems.count
        } else {
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let item: Item
        if searchController.isActive && searchController.searchBar.text != "" {
            item = filteredItems[indexPath.row]
        } else {
            item = items[indexPath.row]
        }
        
        cell.viewModel = ItemCellViewModel(withItem: item)
        cell.nameLabel.numberOfLines = 0
        
        return cell
    }
    
    
    
}



