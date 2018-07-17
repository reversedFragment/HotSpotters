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
    var collegeBoundry: MGLOverlay?
    var venueAnnotations: [CustomVenueAnnotation] = []
    
    @IBOutlet weak var dropDownContainerView: UIView!
    @IBOutlet weak var drawerContainerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    static let searchBarUpdated = Notification.Name(rawValue: "Search Bar Updated")
    static let collegeAnnotationSelected = Notification.Name(rawValue: "College Sected")
    static let venueAnnotationSelected = Notification.Name(rawValue: "Venue Selected")
    
    var togglerViewController: TogglerViewController!
    
    var mapStyleURL: URL {
        let mode = SettingsController.shared.mode
        switch mode{
        case Mode.light: return MGLStyle.streetsStyleURL
        case Mode.dark: return MGLStyle.darkStyleURL
        }
        
    }
    var drawerFrame: CGRect{
        return togglerViewController.getDrawerFrameWithPosition(togglerViewController.drawerPosition)
    }
    
    let utahCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.7649, longitude: -111.8421)
    let radius = 1500
    var currentCollege: College?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        togglerViewController = self.childViewControllers[1] as! TogglerViewController
        setUpMap()
        setUpSearchBar()
        dropDownContainerView.superview?.bringSubview(toFront: dropDownContainerView)
        drawerContainerView.superview?.bringSubview(toFront: drawerContainerView)
        dropDownContainerView.isHidden = true
        drawerContainerView.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(flyToSelectedCollege), name: SearchResultsTableViewController.collegeSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dropVenueAnnotaions), name: FourSquareTableViewController.venueTopicSelectedNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Draw the polygon after the map has initialized
        super.viewDidAppear(animated)
        collegeMap.setCenter(utahCoordinates, zoomLevel: 11, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collegeMap.styleURL = mapStyleURL
    }
    
    func setUpMap(){
        collegeMap = MGLMapView(frame: view.bounds)
        collegeMap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collegeMap.styleURL = mapStyleURL
        view.addSubview(collegeMap)
        collegeMap.delegate = self
        collegeMap.showsUserLocation = true
        collegeMap.allowsRotating = true
    }
    
    func setUpSearchBar(){
        searchBar.delegate = self
        searchBar.placeholder = "Search a College"
        searchBar.superview?.bringSubview(toFront: searchBar)
    }
    
    func drawShape(schoolCoordinates: CLLocationCoordinate2D) {
        // Create a coordinates array to hold all of the coordinates for our shape.
        let coordinates = [
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude + 0.015, longitude: schoolCoordinates.longitude - 0.015),
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude + 0.02, longitude: schoolCoordinates.longitude),
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude + 0.015, longitude: schoolCoordinates.longitude + 0.015),
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude, longitude: schoolCoordinates.longitude + 0.02),
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude - 0.015, longitude: schoolCoordinates.longitude + 0.015),
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude - 0.02, longitude: schoolCoordinates.longitude),
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude - 0.015, longitude: schoolCoordinates.longitude - 0.015),
            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude, longitude: schoolCoordinates.longitude - 0.02)
        ]
        
        
        collegeBoundry = MGLPolygon(coordinates: coordinates, count: UInt(coordinates.count))
        collegeMap.add(collegeBoundry!)
    }
    
    func addAnnotation(college: College){
        DispatchQueue.main.async {
            let collegeAnnotation = CollegeAnnotation(college: college)
            self.collegeMap.addAnnotation(collegeAnnotation)
        }
    }
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 0.6
    }
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        return UIColor.darkGray
    }
    
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        return UIColor.white
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
            guard let college = collegeAnnotation.college else {return}
            CollegeController.shared.selectedCollege = collegeAnnotation.college
            mapView.zoomLevel = 11.5
            mapView.setCenter(CLLocationCoordinate2D(latitude: (college.locationLat - 0.03), longitude: college.locationLon), animated: true)
            self.drawerContainerView.isHidden = false
            searchBar.isHidden = true
            NotificationCenter.default.post(name: CollegeMapViewController.collegeAnnotationSelected, object: nil)
            moveDrawer(to: drawerFrame) {
                self.togglerViewController.drawerPosition = Position.middle
                self.moveDrawer(to: self.drawerFrame, completion: nil)
                self.drawShape(schoolCoordinates: CLLocationCoordinate2D(latitude: college.locationLat, longitude: college.locationLon))
            }
        } else if let venueAnnotation = annotation as? CustomVenueAnnotation{
            GeneralVenueController.shared.selectedVenue = venueAnnotation.venue
            NotificationCenter.default.post(name: CollegeMapViewController.venueAnnotationSelected, object: nil)
        }
        
        //        // Pop-up the callout view.
        //        collegeMap.selectAnnotation(annotation, animated: true)
        //        // Center the map on the annotation.
        //        collegeMap.setCenter(annotation.coordinate, zoomLevel: 12.5, animated: true)
    }
    
    func mapView(_ mapView: MGLMapView, didDeselect annotation: MGLAnnotation) {
        if let collegeAnnotation = annotation as? CollegeAnnotation {
            searchBar.isHidden = false
            collegeMap.remove(collegeBoundry!)
            collegeBoundry = nil
        }
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
                                })
                            }
                        }
                    }
                })
            }
        }
    }
    
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        if let point = annotation as? CollegeAnnotation,
            let reuseIdentifier = point.reuseIdentifier,
            let image = point.image {
            
            if let annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier){
                return annotationImage
            } else {
                let collegeAnnotationImage = MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
                return collegeAnnotationImage
            }
            
        }
        
//        if let venueAnnotation = annotation as? CustomVenueAnnotation,
//            let category = venueAnnotation.venue?.fetchedRecommendedVenue?.categories?[0],
//            let reuseIdentifier =  category.name {
//            if let annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier){
//                return annotationImage
//            } else {
//                let image = UIImage(named: "\(category.name ?? "default")")
//                let venueAnnotationImage = MGLAnnotationImage(image: image!, reuseIdentifier: category.name ?? "default")
//                return venueAnnotationImage
//            }
//        }
        
        return nil
    }
    
    //     This delegate method is where you tell the map to load a view for a specific annotation. To load a static MGLAnnotationImage, you would use `-mapView:imageForAnnotation:`.
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        
        guard let annotation = annotation as? SelectedCollegeAnnotation,
            let college = annotation.college else { return nil }
        
        // For better performance, always try to reuse existing annotations. To use multiple different annotation views, change the reuse identifier for each.
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "\(college.id)RadiusView" ) {
            return annotationView
        } else {
            let size = mapView.zoomLevel/10
            print("🧐")
            print(mapView.zoomLevel)
            return CollegeRadiusAnnotationView(reuseIdentifier: "\(college.id)RadiusView", size: CGFloat(size))
            
        }
    }
    
    @objc func flyToSelectedCollege(){
        guard let college = CollegeController.shared.selectedCollege else {return}
        let center = CLLocationCoordinate2D(latitude: college.locationLat, longitude: college.locationLon)
        let camera = MGLMapCamera(lookingAtCenter: center, fromDistance: 20000, pitch: 0, heading: 0)
        searchBar.text = ""
        dropDownContainerView.isHidden = true
        self.collegeMap.fly(to: camera) {
            self.mapView(self.collegeMap, regionDidChangeAnimated: true)
        }
    }
    
    @objc func dropVenueAnnotaions(){
        collegeMap.removeAnnotations(venueAnnotations)
        venueAnnotations = []
        guard let selectedVenues = GeneralVenueController.shared.selectedVenues else {return}
        for venue in selectedVenues {
            let subtitleArray = venue.fetchedRecommendedVenue?.categories?.compactMap({$0.name})
            guard let subtitle = subtitleArray?.first else { return }
            let annotation = (CustomVenueAnnotation.init(coordinate: CLLocationCoordinate2D(latitude: (venue.fetchedRecommendedVenue?.location.lat)!, longitude: (venue.fetchedRecommendedVenue?.location.lng)!), title: venue.fetchedRecommendedVenue?.name, subtitle: subtitle, address: venue.fetchedRecommendedVenue?.location.address, venue: venue))
            venueAnnotations.append(annotation)
            collegeMap.addAnnotations(venueAnnotations)
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

//Drawer Controlls
extension CollegeMapViewController: TogglerViewControllerDelegate{
    
    func moveDrawer(to frame: CGRect, completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.3) {
            self.drawerContainerView.frame = frame
            self.drawerContainerView.needsUpdateConstraints()
            self.drawerContainerView.setNeedsLayout()
            self.drawerContainerView.setNeedsDisplay()
            if let completion = completion {
                completion()
            }
        }
    }
}




































