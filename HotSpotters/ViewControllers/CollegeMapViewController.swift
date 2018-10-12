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
    var eventAnnotations: [EventAnnotation] = []
    var selectedCollegeAnnotation: CollegeAnnotation?
    var selectedVenueAnnotation: CustomVenueAnnotation?
    
    
    @IBOutlet weak var dropDownContainerView: UIView!
    @IBOutlet weak var drawerContainerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var settingsFloater: TopicBackgroundView!
    
    static let searchBarUpdated = Notification.Name(rawValue: "Search Bar Updated")
    static let collegeAnnotationSelected = Notification.Name(rawValue: "College Sected")
    static let venueAnnotationSelected = Notification.Name(rawValue: "Venue Selected")
    static let removeEventAnnotations = Notification.Name(rawValue: "Remove Venue Annotations Please")
    
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
    
    let radius = 1500
    var currentCollege: College?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        addEventListeners()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Draw the polygon after the map has initialized
        super.viewDidAppear(animated)
        updateUserLocation()
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
//        // Create a coordinates array to hold all of the coordinates for our shape.
//        let coordinates = [
//            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude + 0.015, longitude: schoolCoordinates.longitude - 0.015),
//            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude + 0.02, longitude: schoolCoordinates.longitude),
//            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude + 0.015, longitude: schoolCoordinates.longitude + 0.015),
//            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude, longitude: schoolCoordinates.longitude + 0.02),
//            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude - 0.015, longitude: schoolCoordinates.longitude + 0.015),
//            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude - 0.02, longitude: schoolCoordinates.longitude),
//            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude - 0.015, longitude: schoolCoordinates.longitude - 0.015),
//            CLLocationCoordinate2D(latitude: schoolCoordinates.latitude, longitude: schoolCoordinates.longitude - 0.02)
//        ]
//
//
//        collegeBoundry = MGLPolygon(coordinates: coordinates, count: UInt(coordinates.count))
//        collegeMap.add(collegeBoundry!)
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
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        if let collegeAnnotation = annotation as? CollegeAnnotation {
            selectedCollegeAnnotation = collegeAnnotation
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
        } else if let venueAnnotation = annotation as? CustomVenueAnnotation {
            guard VenueController.shared.annotationSelectedByUser == true else {VenueController.shared.annotationSelectedByUser = true ; return}
            selectedVenueAnnotation = venueAnnotation
            VenueController.shared.selectedVenue = venueAnnotation.venue
            NotificationCenter.default.post(name: CollegeMapViewController.venueAnnotationSelected, object: nil)
        }
        
    }
    
    func mapView(_ mapView: MGLMapView, didDeselect annotation: MGLAnnotation) {
        if annotation is CollegeAnnotation {
            searchBar.isHidden = false
//            collegeMap.remove(collegeBoundry!)
//            collegeBoundry = nil
        }
    }
    
    func deselectCollegeAnnotation(){
            collegeMap.deselectAnnotation(selectedCollegeAnnotation, animated: true)
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
                    colleges = colleges.filter{ $0.size ?? 0 >= 2000 }
                    for college in colleges {
                        if !CollegeController.shared.visibleColleges.contains(college) {
                            CollegeController.shared.visibleColleges.append(college)
                                CollegeController.shared.fetchImageFor(college: college, completion: { (success) in
                                    self.addAnnotationFor(college: college)
                            })
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
        return nil
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
        removeVenueAnnotations()
        guard let selectedVenues = VenueController.shared.selectedVenues else {return}
        for venue in selectedVenues {
            let subtitleArray = venue.fetchedRecommendedVenue?.categories?.compactMap({$0.name})
            guard let subtitle = subtitleArray?.first else { return }
            let annotation = (CustomVenueAnnotation.init(coordinate: CLLocationCoordinate2D(latitude: (venue.fetchedRecommendedVenue?.location.lat)!, longitude: (venue.fetchedRecommendedVenue?.location.lng)!), title: venue.fetchedRecommendedVenue?.name, subtitle: subtitle, address: venue.fetchedRecommendedVenue?.location.address, venue: venue))
            venueAnnotations.append(annotation)
            collegeMap.addAnnotations(venueAnnotations)
        }
    }
    
    @objc func dropEventAnnotations(){
        removeEventAnnotations()
        guard let events = EventBriteController.shared.myEvents else {return}
        for event in events {
            guard let venue = event.venue,
                let latitudeString = venue.latitude,
                let longitudeString = venue.longitude,
                let latitude = Double(latitudeString),
                let longitude = Double(longitudeString) else {return}
            let coordiantes = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let eventAnnotation = EventAnnotation(coordinate: coordiantes, title: event.name.text, venueName: venue.name, address: venue.address.address1)
            eventAnnotations.append(eventAnnotation)
            collegeMap.addAnnotation(eventAnnotation)
        }
    }
    
    func addAnnotationFor(college: College){
        let collegeAnnotation = CollegeAnnotation(college: college)
        self.collegeMap.addAnnotation(collegeAnnotation)
    }
    
    @objc func removeVenueAnnotations(){
        collegeMap.removeAnnotations(venueAnnotations)
        venueAnnotations.removeAll()
    }
    
    @objc func removeEventAnnotations(){
        collegeMap.removeAnnotations(eventAnnotations)
        eventAnnotations.removeAll()
    }
    
    @objc func selectVenueAnnotation(){
        VenueController.shared.annotationSelectedByUser = false
        let venue = VenueController.shared.selectedVenue
        for annotation in venueAnnotations{
            if annotation.venue == venue{
                self.collegeMap.selectAnnotation(annotation, animated: true)
                return
            }
        }
    }
    
    func addEventListeners(){
        NotificationCenter.default.addObserver(self, selector: #selector(flyToSelectedCollege), name: SearchResultsTableViewController.collegeSelected, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(resignKeyboard), name: SearchResultsTableViewController.collegeSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dropVenueAnnotaions), name: FourSquareTableViewController.venueSectionSelectedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeVenueAnnotations), name: FourSquareTableViewController.removeAnnotationsNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dropEventAnnotations), name: EventsTableViewController.dropEventAnnotationsNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeEventAnnotations), name: CollegeMapViewController.removeEventAnnotations, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(selectVenueAnnotation), name: FourSquareTableViewController.venueCellSelectedNotification, object: nil)
    }
    
    func setUpView(){
        togglerViewController = self.childViewControllers[1] as? TogglerViewController
        setUpMap()
        setUpSearchBar()
        dropDownContainerView.superview?.bringSubview(toFront: dropDownContainerView)
        drawerContainerView.superview?.bringSubview(toFront: drawerContainerView)
        settingsFloater.superview?.bringSubview(toFront: settingsFloater)
        dropDownContainerView.isHidden = true
        drawerContainerView.isHidden = true
    }
    
    @IBAction func locateButtonTapped(_ sender: UIButton) {
        
    }
    
    //Present Authorization for CLLocation
    func presentLocationAuthorization(){
        let ac = UIAlertController(title: "Invalid Location", message: "Cannot reset to location. User location is required", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Enable", style: .default) { (alert) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                // If general location settings are enabled then open location settings for the app
                UIApplication.shared.openURL(url)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(settingsAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
    
    //Center view to user location
    @IBAction func centerToUserLocation(_ sender: Any) {
        updateUserLocation()
    }
    
    func updateUserLocation(){
        guard let location = collegeMap.userLocation?.coordinate else { return }
        if CLLocationCoordinate2DIsValid(location) {
            DispatchQueue.main.async {
                self.collegeMap.setCenter(location, zoomLevel: 10, animated: true)
            }
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
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            self.resignKeyboard()
            searchBar.text = ""
        }
        
        @objc func resignKeyboard(){
            searchBar.resignFirstResponder()
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
