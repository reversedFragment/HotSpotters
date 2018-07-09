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
    
    static let shared = FourSquareTableViewController()

    @IBOutlet weak var FourSquareTableView: UITableView!
    
    /// Mark: - Source of Truth
    var sectionSelected: String = ""
    var fetchedVenues: [GroupItem] = []


    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        FourSquareTableView.delegate = self
        FourSquareTableView.dataSource = self
    }
    
    // MARK: Navigation to VenueDetailViewController

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toVenueDetailVC" {

            if let venueDetailVC = segue.destination as? VenueDetailViewController,
                let selectedRow = FourSquareTableView.indexPathForSelectedRow?.row {
                
                
                
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
        let fetchedVenue = fetchedVenues[indexPath.row]
        cell.fetchedVenue = fetchedVenue.fetchedRecommendedVenue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
}

// MARK: - UISearchBarDelegate

//extension FourSquareTableViewController

    
    
/// Search bar and function for exploreVenues()
    /// Need separate search bar or a way to toggle which func is called by searchBar Text
    
    //    func exploreBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        searchBar.resignFirstResponder()
//
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        guard let searchTerm = searchBar.text?.lowercased() else { return }
//
//        GeneralVenueController.exploreVenues(searchTerm: searchTerm,
//                                               location: nil,
//                                                   near: "Los Angeles",
//                                                 radius: 10000,
//                                                section: GeneralVenueController.venueSectionMarker.arts,
//                                                  limit: 10,
//                                         sortByDistance: 1,
//                                                  price: GeneralVenueController.pricePoint.price2 ,
//                                                  category: nil)
//        { (recommendedVenues) in
//
//            guard let fetchedRecommends = recommendedVenues else { return }
//            self.fetchedVenues = fetchedRecommends
//
//            DispatchQueue.main.async {
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                self.FourSquareTableView.reloadData()
//            }
//        }
//    }
//
//
//
