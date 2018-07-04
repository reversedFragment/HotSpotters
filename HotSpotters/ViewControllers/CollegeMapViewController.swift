//
//  CollegeMapViewController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/3/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit
import Mapbox

class CollegeMapViewController: UIViewController, MGLMapViewDelegate {
    
    var collegeMap: MGLMapView!
    var collegeAnnotation: MGLPointAnnotation!
    let schoolCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.7649, longitude: -111.8421)
    let radius = 1500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collegeMap = MGLMapView(frame: view.bounds, styleURL: URL(string: "mapbox://styles/mapbox/streets-v9"))
        collegeMap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        view.addSubview(collegeMap)
        
        collegeMap.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Draw the polygon after the map has initialized
        drawShape()
        collegeMap.setCenter(schoolCoordinates, zoomLevel: 11, animated: true)
        addAnnotation()
    }
    
    func drawShape() {
        // Create a coordinates array to hold all of the coordinates for our shape.
        let coordinates = [
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude + 0.02, longitude: schoolCoordinates.longitude - 0.02),
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude + 0.02, longitude: schoolCoordinates.longitude + 0.02),
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude - 0.02, longitude: schoolCoordinates.longitude + 0.02),
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude - 0.02, longitude: schoolCoordinates.longitude - 0.02)
        ]
        
        
        let shape = MGLPolygon(coordinates: coordinates, count: UInt(coordinates.count))
        collegeMap.add(shape)
        
        
        
    }
    
    func addAnnotation(){
        
        collegeAnnotation = MGLPointAnnotation()
        collegeAnnotation.coordinate = schoolCoordinates
        collegeAnnotation.title = "University of Utah"
        collegeAnnotation.subtitle = "Fuck BYU"
        
        // Add marker `hello` to the map.
        collegeMap.addAnnotation(collegeAnnotation)
        
    }
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 0.5
    }
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        return .white
    }
    
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        return UIColor.black
    }
    
    // Use the default marker. See also: our view annotation or custom marker examples.
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return nil
    }
    
    // Allow callout view to appear when an annotation is tapped.
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, rightCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        return UIButton(type: .infoDark)
    }
    
    func mapView(_ mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
        // Hide the callout view.
        mapView.deselectAnnotation(annotation, animated: false)
        
        // Show an alert containing the annotation's details
        let alert = UIAlertController(title: annotation.title!!, message: "Welcome to the University of Utah", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        
        // Pop-up the callout view.
        collegeMap.selectAnnotation(collegeAnnotation, animated: true)
        // Center the map on the annotation.
        collegeMap.setCenter(collegeAnnotation.coordinate, zoomLevel: 12.5, animated: true)
    }
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        var annotationImage = collegeMap.dequeueReusableAnnotationImage(withIdentifier: "utesLogo")
        
        if annotationImage == nil{
            let image = #imageLiteral(resourceName: "utesLogo")
            guard var collegeImage = resizeImage(image, targetSize: CGSize(width: 100, height: 100)) else {return nil}
            
            collegeImage = collegeImage.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: image.size.height/2, right: 0))
            annotationImage = MGLAnnotationImage(image: collegeImage, reuseIdentifier: "utesLogo")
        }
        return annotationImage
    }
    
    func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

}
