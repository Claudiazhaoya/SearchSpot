//
//  PageViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/13/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import Foundation
import UIKit
import YelpAPI
import MapKit

class PageViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var info: YLPBusiness?
    var locationManager: CLLocationManager!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UIButton!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    @IBOutlet weak var websiteButton: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let info = info else {
            print("error")
            return
        }
        nameLabel.text = info.name
        if info.location.address.first != nil {
            addressLabel.text = "Address: \(info.location.address.first!)"
        } else {
            addressLabel.text = "Address is not available"
        }
        if info.phone != nil {
            phoneNumberLabel.setTitle("Contact: \(info.phone!)", for: .normal)
        } else {
            phoneNumberLabel.setTitle("No Contact info", for: .normal)
        }
        reviewCountLabel.text = "Rating: \(String(info.rating))"
        let data = try! Data(contentsOf: info.imageURL!)
        let image = UIImage(data: data)
        imageView.image = image!
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        self.mapView.delegate = self
        if info.location.coordinate != nil {
            let coordinate = CLLocationCoordinate2DMake( (info.location.coordinate?.latitude)!, (info.location.coordinate?.longitude)!)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = info.name
            self.mapView.addAnnotation(annotation)
        }
    }
    
    
    @IBAction func websiteButtonTapped(_ sender: Any) {
        UIApplication.shared.openURL((info?.url)!)
    }
    
    @IBAction func phoneNumberTapped(_ sender: UIButton) {
        
        guard let info = info else {
            print("error")
            return
        }
        if info.phone != nil {
            if let url = URL(string: "tel://\(info.phone!)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url)
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    
    private func prepareForSegue(of coordinate: CLLocationCoordinate2D) {
        let annotation:MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = info?.name
        if (info?.location.address)! != [] {
            annotation.subtitle = info?.location.address[0]
        } else {
            annotation.subtitle = info?.name
        }
        addUserLocation(annotation: annotation)
    }
    
    
    // MARK:-MapView Region & Annotations Helper Methods
    
    private func setUpRepresentRegionOnMap(withLatitude latitude: CLLocationDegrees, longitude: CLLocationDegrees, lattitudeDelta: CLLocationDegrees = 0.01, longitudeDelta: CLLocationDegrees = 0.01) {
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateSpan(latitudeDelta: lattitudeDelta, longitudeDelta: longitudeDelta)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        prepareForSegue(of: coordinate)
    }
    
    
    
    private func addUserLocation(annotation: MKPointAnnotation) {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
        mapView.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latitude = info?.location.coordinate?.latitude
        print(latitude!)
        let longitude = info?.location.coordinate?.longitude
        print(longitude!)
        self.setUpRepresentRegionOnMap(withLatitude: latitude!, longitude: longitude!)

        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
               print(error.localizedDescription)
    }
}

