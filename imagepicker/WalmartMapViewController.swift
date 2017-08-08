//
//  WalmartMapViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/31/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class WalmartMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {
    let locationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?
    //    var coordinate: CLLocationCoordinate2D?
    var locations = [Location]()
    
    @IBOutlet weak var WalmartMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //        locationManager.startUpdatingLocation()
        self.WalmartMapView.delegate = self
        let count = locations.count
        print("locations number + \(count)")

    
        for location in locations {
            
            let coordinate = CLLocationCoordinate2DMake( location.latitude, location.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = location.name
            //            print(coordinates)
            //            print(business.name)
            self.WalmartMapView.addAnnotation(annotation)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
 
//        prepareForRepresentation(of: coordinate)
        if let location = locations.first {
            let span = MKCoordinateSpanMake(1.7, 1.7)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            WalmartMapView.setRegion(region, animated: false)
        }

//        self.setUpRepresentRegionOnMap(withLatitude: lattitude, longitude: longitude)

        //        displayLocation(coordinate: currentLocation!)
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
//    func setUpRepresentRegionOnMap(withLatitude latitude: CLLocationDegrees, longitude: CLLocationDegrees, latitudeDelta: CLLocationDegrees = 0.01, longitudeDelta: CLLocationDegrees = 0.01) {
//        
//        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
//
//        prepareForRepresentation(of: coordinate)
//    }
    
    private func prepareForRepresentation (of coordinate: CLLocationCoordinate2D) {
        let annotation:MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Your Location"
        addUserLocation(annotation: annotation)
    }
    
    private func addUserLocation(annotation: MKPointAnnotation) {
        for annotation in WalmartMapView.annotations {
            WalmartMapView.removeAnnotation(annotation)
        }
        WalmartMapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "Identifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            
            annotationView.canShowCallout = true
            let pinImage = UIImage(named: "walmartPin.png")!
            
            let size = CGSize(width: 50, height: 50)
            UIGraphicsBeginImageContext(size)
            pinImage.draw(in: CGRect(x:0, y:0, width:39, height:39))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            annotationView.image = resizedImage
        }
        return annotationView
    }
    
    
}

