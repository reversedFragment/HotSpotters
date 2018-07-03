////
////  BSAMapBoxViewController.swift
////  HotSpotters
////
////  Created by Ben Adams on 7/2/18.
////  Copyright © 2018 Ben Adams. All rights reserved.
////
//
//import Mapbox
//
//// Enable the view controller to conform to the MGLMapViewDelegate protocol
//class BSAMapBoxViewController: UIViewController, MGLMapViewDelegate {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.satelliteStreetsStyleURL)
//        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        mapView.setCenter(CLLocationCoordinate2D(latitude: 40.74699, longitude: -73.98742), zoomLevel: 9, animated: false)
//        view.addSubview(mapView)
//        
//        // Add a point annotation
//        let annotation = MGLPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 40.77014, longitude: -73.97480)
//        annotation.title = "Central Park"
//        annotation.subtitle = "The biggest park in New York City!"
//        mapView.addAnnotation(annotation)
//        
//        // Set the map view's delegate to the view controller
//        mapView.delegate = self
//        
//        
//        // Allow the map view to display the user's location
//        mapView.showsUserLocation = true
//        
//    }
//    
//    // Implement the delegate method that allows annotations to show callouts when tapped
//    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
//        return true
//    }
//    
//    // Zoom to the annotation when it is selected
//    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
//        let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 4000, pitch: 0, heading: 0)
//        mapView.fly(to: camera, completionHandler: nil)
//    }
//}
