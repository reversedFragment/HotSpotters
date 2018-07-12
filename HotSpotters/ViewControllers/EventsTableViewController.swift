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
    
    @IBOutlet weak var categoryImageView: CustomCellImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var category: Category?
    
    var nearbyEvents: [EventElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        setNearbyEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nearbyEvents.count
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell
//        let event = nearbyEvents[indexPath.row]
//        cell?.event = event
//
//        return cell ?? UITableViewCell()
//    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        let event = nearbyEvents[indexPath.row]
        
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
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func setNearbyEvents(){
        guard let selectedCollege = CollegeController.shared.selectedCollege else {return}
        getAddressForCollege(selectedCollege) { (address) in
            guard let address = address else {return}
            EventBriteController.search(term: nil, sortDescriptor: .best, radius: 10, location: address, categories: self.category!, completion: { (events) in
                guard let events = events else {return}
                self.nearbyEvents = events
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    func updateView(){
        guard let category = category else {return}
        categoryLabel.text = category.name
        categoryImageView.image = category.image
    }
    
//    func fetchImagesForEvents(_ events: [EventElement], completion: @escaping () -> Void){
//        for event in events{
//            var event = event
//            if event.logo?.url == nil {
////                let nilLogo = event.logo?.url
////                let logoURL = EventBriteController.nullToNil(value: nilLogo)
//            } else {
//                let nilLogo = event.logo?.url
//                let logoURL = EventBriteController.nullToNil(value: nilLogo) as! String
//                EventBriteController.fetchImage(withUrlString: logoURL ?? "") { (image) in
//                    guard let image = image else {return}
//                    event.setImage(image)
//                }
//            }
//        }
//    }
    
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
