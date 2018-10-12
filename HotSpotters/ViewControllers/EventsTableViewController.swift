//
//  EventsTableViewController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/10/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit
import Mapbox

class EventsTableViewController: UITableViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    var spinner: UIView!
    
    var category: Category?
    
    let dispatchGroup = DispatchGroup()
    
    let eventIndicator = UIActivityIndicatorView()
    var eventIndex = 0
    
    static let dropEventAnnotationsNotification = Notification.Name(rawValue: "Please Drop the Proper Event Annotations")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        NotificationCenter.default.post(name: TogglerViewController.hideTypeTogglerNotification, object: nil)
        NotificationCenter.default.post(name: FourSquareTableViewController.removeAnnotationsNotification, object: nil)
        setNearbyEvents()
        updateView()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let events = EventBriteController.shared.myEvents else {return 0}
        return events.count
    }
    
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell
    //        let event = nearbyEvents[indexPath.row]
    //        cell?.event = event
    //
    //        return cell ?? UITableViewCell()
    //    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell,
            let events = EventBriteController.shared.myEvents else { return UITableViewCell() }
        let event = events[indexPath.row]
        if events.count <= 0 {
            cell.eventTitleLabel.text = "No Events"
        } else {
            if event.logo?.url == nil {
                let nilLogo = event.logo?.url
                let logoURL = nullToNil(value: nilLogo)
            } else {
                let nilLogo = event.logo?.url
                let logoURL = nullToNil(value: nilLogo)
                EventBriteController.fetchImage(withUrlString: logoURL ?? "") { (image) in
                    DispatchQueue.main.async {
                        cell.event = event
                        if let currentIndexPath = self.tableView?.indexPath(for: cell),
                            currentIndexPath == indexPath {
                            cell.eventImage = image
                        } else {
                            print("Didn't get image")
                            return
                        }
                    }
                }
            }
        }
        cell.prepareForReuse()
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func setNearbyEvents(){
        spinner = UIViewController.displaySpinner(onView: self.view)
        guard let selectedCollege = CollegeController.shared.selectedCollege else {return}
        getAddressForCollege(selectedCollege) { (address) in
            guard let address = address else {return}
            
            //Fetch all Nearby events for a given category
            EventBriteController.search(term: nil, sortDescriptor: .date, radius: 10, location: address, categories: self.category!, completion: { (events) in
                guard let events = events else {return}
                self.fetchVenueDetails(for: events)
                
                self.dispatchGroup.notify(queue: .main, execute: {
                    EventBriteController.shared.myEvents = events
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        NotificationCenter.default.post(name: EventsTableViewController.dropEventAnnotationsNotification, object: nil)
                        UIViewController.removeSpinner(spinner: self.spinner)
                    }
                })
            })
        }
    }
    
    func updateView(){
        guard let category = category else {return}
        categoryLabel.text = category.name
    }
    
    func fetchVenueDetails(for events: [EventElement]){
        for event in events {
            dispatchGroup.enter()
            if let venueID = event.venueID{
                EventBriteController.getVenue(from: venueID) { (venueDetails) in
                    guard let venue = venueDetails else {return}
                    event.venue = venue
                    self.dispatchGroup.leave()
                }
            }
        }
    }
    
    func nullToNil(value: String?) -> String? {
        if value is NSNull {
            return nil
        } else { return value }
    }
    
    func getAddressForCollege(_ college: College, completion: @escaping (String?) -> Void){
        let location = CLLocation(latitude: college.locationLat, longitude: college.locationLon)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                return
            }
            guard let placemark = placemarks?.first else {completion(nil) ; return}
            let address = "\(placemark.name ?? ""), \(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? "") \(placemark.postalCode ?? "")"
            print(address)
            completion(address)
        }
    }
    
}


extension EventsTableViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        for indexPath in indexPaths {
            if eventIndex == 8 {
                eventIndex = 0
            }
            guard let events = EventBriteController.shared.myEvents else { return }
            let event = events[indexPath.row]
            print("Prefetching For \(event.name)")
        }
    }

}
