//
//  MapViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/13/17.
//  Copyright © 2017 Sara Robinson. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import YelpAPI

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    var businesses: [YLPBusiness] = []
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        self.mapView.delegate = self
        let count = businesses.count
        print(count)
        for business in businesses {
            //            let business = businesses[i]
            //            guard let latitute = business.location.coordinate?.latitude else {
            //                businesses.remove(at: i)
            //
            //            }
            //            guard let latitude = business.location.coordinate?.longitude else {
            //
            //            }
            
            if business.location.coordinate != nil {
                //
                let coordinate = CLLocationCoordinate2DMake( (business.location.coordinate?.latitude)!, (business.location.coordinate?.longitude)!)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = business.name
                //            print(coordinates)
                //            print(business.name)
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
        //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //        let identifier = "customAnnotationView"
        //
        //        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        //        if (annotationView == nil) {
        //            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        //        }
        //        else {
        //            annotationView!.annotation = annotation
        //        }
        //        annotationView?.canShowCallout = true
        //        return annotationView
        //    }
        
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == CLAuthorizationStatus.authorizedWhenInUse {
                locationManager.startUpdatingLocation()
            }
        }
        
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                let span = MKCoordinateSpanMake(0.03, 0.03)
                let region = MKCoordinateRegionMake(location.coordinate, span)
                mapView.setRegion(region, animated: false)
            }
        }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        
        // MARK: - Navigation
        
        private func prepareForSegue(of coordinate: CLLocationCoordinate2D) {
            let annotation:MKPointAnnotation = MKPointAnnotation()
            annotation.coordinate = coordinate
     
            addUserLocation(annotation: annotation)
            
        }
        
        private func addUserLocation(annotation: MKPointAnnotation) {
            for annotation in mapView.annotations {
                mapView.removeAnnotation(annotation)
            }
            mapView.addAnnotation(annotation)
        }
}
