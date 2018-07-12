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
    var searchBar = UISearchBar()
    
    @IBOutlet weak var dropDownContainerView: UIView!

    static let searchBarUpdated = Notification.Name(rawValue: "SearchBarUpdated")
    
    let utahCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.7649, longitude: -111.8421)
    let radius = 1500
    var currentCollege: College?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMap()
        setUpSearchBar()
        dropDownContainerView.superview?.bringSubview(toFront: dropDownContainerView)
        dropDownContainerView.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(flyToSelectedCollege), name: SearchResultsTableViewController.collegeSelected, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Draw the polygon after the map has initialized
        super.viewDidAppear(animated)
        collegeMap.setCenter(utahCoordinates, zoomLevel: 11, animated: true)
    }
    
    func setUpMap(){
        collegeMap = MGLMapView(frame: view.bounds)
        collegeMap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collegeMap)
        collegeMap.delegate = self
        collegeMap.showsUserLocation = true
        collegeMap.allowsRotating = true
    }
    
    func setUpSearchBar(){
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.placeholder = "Search a College"
        navigationItem.titleView = searchBar
    }
    
    func drawShape(schoolCoordinates: CLLocationCoordinate2D) {
        // Create a coordinates array to hold all of the coordinates for our shape.
        let coordinates = [
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude + 0.015, longitude: schoolCoordinates.longitude - 0.015),
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude + 0.015, longitude: schoolCoordinates.longitude + 0.015),
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude - 0.015, longitude: schoolCoordinates.longitude + 0.015),
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude - 0.015, longitude: schoolCoordinates.longitude - 0.015)
        ]
        
        
        let shape = MGLPolygon(coordinates: coordinates, count: UInt(coordinates.count))
        collegeMap.add(shape)
    }
    
    func addAnnotation(college: College){
        DispatchQueue.main.async {
            let collegeAnnotation = CollegeAnnotation(college: college)
            self.collegeMap.addAnnotation(collegeAnnotation)
        }
    }
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 0.3
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
        
        if let collegeAnnotation = annotation as? CollegeAnnotation {
            CollegeController.shared.selectedCollege = collegeAnnotation.college

            guard let toggleViewController = UIHelper.storyBoard.instantiateViewController(withIdentifier: "toggleViewController") as? TogglerViewController else {return}
            //navigationController?.present(toggleViewController, animated: true, completion: presentView)

            self.navigationController?.pushViewController(toggleViewController, animated: true)
            
            
            
        }
//        // Pop-up the callout view.
//        collegeMap.selectAnnotation(annotation, animated: true)
//        // Center the map on the annotation.
//        collegeMap.setCenter(annotation.coordinate, zoomLevel: 12.5, animated: true)
    }
 
    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { (placemark, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                return
            }
            if let placemark = placemark{
                guard let zipCode =  placemark[0].postalCode else {return}
                CollegeController.shared.search(by: zipCode, distance: 20, completion: { (colleges) in
                    guard var colleges = colleges?.results else {return}
                    colleges = colleges.filter{ $0.size >= 2000 }
                    for college in colleges {
                        if CollegeController.shared.visibleColleges.contains(college) {
                            return
                        } else {
                            CollegeController.shared.visibleColleges.append(college)
                            for college in colleges {
                                CollegeController.shared.fetchImageFor(college: college, completion: { (success) in
                                    self.addAnnotation(college: college)
                                    let location = CLLocationCoordinate2D(latitude: college.locationLat, longitude: college.locationLon)
                                    self.drawShape(schoolCoordinates: location)
                                })
                            }
                        }
                    }
                })
            }
        }
    }

    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        guard let point = annotation as? CollegeAnnotation,
        let reuseIdentifier = point.reuseIdentifier,
        let image = point.image else {return nil}
        
        if let annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier){
            return annotationImage
        } else {
            return MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
        }
    }
    
    @objc func flyToSelectedCollege(){
        guard let college = CollegeController.shared.selectedCollege else {return}
        let center = CLLocationCoordinate2D(latitude: college.locationLat, longitude: college.locationLon)
        let camera = MGLMapCamera(lookingAtCenter: center, fromDistance: 10000, pitch: 0, heading: 0)
        searchBar.text = ""
        dropDownContainerView.isHidden = true
        self.collegeMap.fly(to: camera) {
            self.mapView(self.collegeMap, regionDidChangeAnimated: true)
        }
        
    }

}


extension CollegeMapViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            dropDownContainerView.isHidden = true
            searchBar.placeholder = "Search a College"
        } else {
            dropDownContainerView.isHidden = false
            CollegeController.shared.fetchCollegesBy(schoolName: searchText) { (colleges) in
                guard let colleges = colleges else {return}
                CollegeController.shared.filteredColleges = colleges
                NotificationCenter.default.post(name: CollegeMapViewController.searchBarUpdated, object: nil)
                DispatchQueue.main.async {
                    self.dropDownContainerView.isHidden = false
                }
            }
        }
    }
    
}

