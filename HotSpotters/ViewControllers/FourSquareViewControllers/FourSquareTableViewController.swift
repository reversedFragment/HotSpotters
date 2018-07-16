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
    
    ////////////////////////////////////////////////////////////////
    /// Mark: - Properties
    ////////////////////////////////////////////////////////////////

    // Outlets
    @IBOutlet weak var fourSquareTableView: UITableView!
    
    // (Proper) Shared Instance
    static let shared = FourSquareTableViewController()
    
    // Mark: - Sources of Truth
    var sectionSelected: String = ""
    var fetchedVenues: [GroupItem] = []
    
    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fourSquareTableView.delegate = self
        fourSquareTableView.dataSource = self
        fetchWithSectionSelected()
    }
    
    // Fetch Venues by sectionSelected by user on previous menu
    func fetchWithSectionSelected() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        GeneralVenueController.exploreVenues(location: (40.761834,-111.89049069999999),
                                             radius: 1000,
                                             section: self.sectionSelected,
                                             limit: 20, price: "1,2,3,4")
        { (groupItems) in
            guard let groupItems = groupItems else { return }
            self.fetchedVenues = groupItems
            if self.fetchedVenues.isEmpty {
                
                let alert = UIAlertController(title: "No Results Found", message: "Try Widening Your Search", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
            }
            
            DispatchQueue.main.async {
                self.fourSquareTableView.reloadData()
            }
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }



    
    
    // MARK: Navigation to VenueDetailViewController

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toVenueDetailVC" {

            if let venueDetailVC = segue.destination as? VenueDetailViewController,
                let selectedRow = fourSquareTableView.indexPathForSelectedRow?.row {
                
                let venueDetailID = self.fetchedVenues[selectedRow].fetchedRecommendedVenue?.venueId
                
                GeneralVenueController.fetchVenueDetails(with: venueDetailID!) { (venuedetails) in
                    
                    guard let venueDetails = venuedetails else { return }
                    
                    venueDetailVC.fetchedVenueDetail = venueDetails
                }
            }
        }
    }
}


// MARK: - UITableViewDataSource

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
        return 120
    }
    
}
