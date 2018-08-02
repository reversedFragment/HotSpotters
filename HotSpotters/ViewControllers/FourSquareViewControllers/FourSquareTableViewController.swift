//
//  FourSquareTableViewController.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/29/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation
import UIKit

class FourSquareTableViewController: UIViewController {
    
    // Notification Center Info
    static let venueSectionSelectedNotification = Notification.Name("Venue Topic Selected")
    static let removeAnnotationsNotification = Notification.Name("Please remove all Venue Annotations")
    static let venueCellSelectedNotification = Notification.Name("Venue was selected in the TableView")
    
////////////////////////////////////////////////////////////////
// Mark: - Properties
////////////////////////////////////////////////////////////////

    // Outlets
    @IBOutlet weak var fourSquareTableView: UITableView!
    @IBOutlet weak var categoryLabel: UILabel!
    var spinner: UIView!
    
    // Mark: - Sources of Truth
    var sectionSelected: String = ""
    var fetchedVenues: [GroupItem] = []
    
    
////////////////////////////////////////////////////////////////
// Mark: - ViewLifecycles
////////////////////////////////////////////////////////////////
    
    ///
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fourSquareTableView.delegate = self
        fourSquareTableView.dataSource = self
        
        // Notification Observers
        NotificationCenter.default.addObserver(self, selector: #selector(venueAnnotationSelected), name: CollegeMapViewController.venueAnnotationSelected, object: nil)
        
    }
    
    ///
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchWithSectionSelected()
        updateView()
        navigationController?.navigationBar.isHidden = false
        NotificationCenter.default.post(name: TogglerViewController.hideTypeTogglerNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
////////////////////////////////////////////////////////////////
// Mark: - Fetch venues by section selected by user on screen
////////////////////////////////////////////////////////////////
    
    func fetchWithSectionSelected() {
        spinner = UIViewController.displaySpinner(onView: self.view)
        
        guard let selectedCollege = CollegeController.shared.selectedCollege else {UIViewController.removeSpinner(spinner: spinner) ; return}
        
        VenueController.exploreVenues(
                                location:(selectedCollege.locationLat,
                                          selectedCollege.locationLon),
                                  radius: 10000,
                                 section: self.sectionSelected,
                                   limit: 20,
                                   price: "1,2,3,4")
        { [unowned self] (groupItems) in
            
            guard let groupItems = groupItems else { UIViewController.removeSpinner(spinner: self.spinner) ;  return }
            
            self.fetchedVenues = groupItems /// groupItems are fetched venues
            
            if self.fetchedVenues.isEmpty { /// Alert if no results found
                UIViewController.removeSpinner(spinner: self.spinner)
                let alert = UIAlertController(title: "No Results Found",
                                              message: "Try Widening Your Search",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Okay",
                                              style: .cancel,
                                              handler: nil))
                self.present(alert, animated: true)
                
            } else {
                DispatchQueue.main.async {
                    self.fourSquareTableView.reloadData()
                    NotificationCenter.default.post(name: FourSquareTableViewController.venueSectionSelectedNotification,
                                                    object: nil)
                    UIViewController.removeSpinner(spinner: self.spinner)
                }
            }
            
        }
        
    }

    
    // Segue's from map annotation to venueDetail
    @objc func venueAnnotationSelected(){
        self.performSegue(withIdentifier: "mapSegue", sender: self)
    }

    func updateView(){
        categoryLabel.text = sectionSelected
    }

    
    
////////////////////////////////////////////////////////////////
// Mark: - Navigation Paths to VenueDetailViewController
////////////////////////////////////////////////////////////////

    // Segue to venueDetail from venueTableView OR segue from map annotation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toVenueDetailVC" {

            if let venueDetailVC = segue.destination as? VenueDetailViewController,
                let selectedRow = fourSquareTableView.indexPathForSelectedRow?.row {
                VenueController.shared.selectedVenue = fetchedVenues[selectedRow]
                NotificationCenter.default.post(name: FourSquareTableViewController.venueCellSelectedNotification, object: nil)
                let venueDetailID = self.fetchedVenues[selectedRow].fetchedRecommendedVenue?.venueId
                
                VenueController.fetchVenueDetails(with: venueDetailID!) { (venuedetails) in
                    
                    guard let venueDetails = venuedetails else { return }
                    
                    venueDetailVC.fetchedVenueDetail = venueDetails
                }
            }
            
        } else if segue.identifier == "mapSegue" {
            
            if let venueDetailVC = segue.destination as? VenueDetailViewController,
                let venueDetailID = VenueController.shared.selectedVenue?.fetchedRecommendedVenue?.venueId {
                VenueController.fetchVenueDetails(with: venueDetailID) { (venuedetails) in
                    guard let venueDetails = venuedetails else { return }
                    venueDetailVC.fetchedVenueDetail = venueDetails
                }
            }
        }
    }
}


////////////////////////////////////////////////////////////////
// Extension: - UITableViewDataSource
////////////////////////////////////////////////////////////////

extension FourSquareTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedVenues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "venueCellID",
                                                 for: indexPath) as! FourSquareTableViewCell
        let recommendedVenues = fetchedVenues[indexPath.row]
        cell.fetchedVenue = recommendedVenues.fetchedRecommendedVenue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
}
