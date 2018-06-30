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
    
    @IBOutlet var fourSquareTableView: UITableView!
    @IBOutlet weak var fourSquareSearchBar: UISearchBar!

    
    /// Shared Instance
    static let shared = FourSquareTableViewController()
    
    /// Mark: - Source of Truth
    var fetchedVenueList: [Venue] = []
    
    /// Mark: - Search Parameters
    
    var generalVenueSearchParameters: [String: String] = [
        // Can also take geocoordinates of user location or selected location as query
        // parameter instead of "near", but not both.
        "near": "Los Angeles",
        "limit": "30",
        //    "radius": "10000",
        //    "query": "DevMountain"
    ];

    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fourSquareTableView.delegate = self
        fourSquareTableView.dataSource = self
        fourSquareSearchBar.delegate = self
    
//    // MARK: Navigation
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "toShowEntry" {
//
//            if let detailViewController = segue.destination as? EntryDetailViewController,
//                let selectedRow = tableView.indexPathForSelectedRow?.row {
//
//                let entry = EntryController.shared.entries[selectedRow]
//                detailViewController.entry = entry
//            }
//        }
//    }
//
    }
}

//MARK: UITableViewDataSource

extension FourSquareTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedVenueList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "venueCell", for: indexPath) as! FourSquareTableViewCell
        let venue = fetchedVenueList[indexPath.row]
        cell.venueListing = venue
        return cell
    }
    
}

// To get access to the searchButtonClicked, we need to set the search bar delegate and call it's function
extension FourSquareTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        self.generalVenueSearchParameters["query"] = searchTerm
        VenueController.fetchVenues(parameter: generalVenueSearchParameters)
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.fourSquareTableView.reloadData()
            }
        }
    }

