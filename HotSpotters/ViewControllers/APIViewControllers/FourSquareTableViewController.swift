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
    


    
    

    @IBOutlet weak var FourSquareTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    /// Mark: - Source of Truth
    var fetchedVenues: [Venue] = []

    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        FourSquareTableView.delegate = self
        FourSquareTableView.dataSource = self
        searchBar.delegate = self
    
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
        return fetchedVenues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "venueCellID", for: indexPath) as! FourSquareTableViewCell
        let fetchedVenue = fetchedVenues[indexPath.row]
        print(fetchedVenue.venueID)
        cell.fetchedVenue = fetchedVenue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

// To get access to the searchButtonClicked, we need to set the search bar delegate and call it's function
extension FourSquareTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        
        VenueControllerUpdate.fetchVenues(searchTerm: searchTerm ,
                                          location: nil,
                                          near: "Salt Lake City",
                                          radius: 10000,
                                          limit: 30) { (venues) in
                                            
            guard let venueList = venues else { return }
            self.fetchedVenues = venueList
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.FourSquareTableView.reloadData()
            }
        }
    }
    
    
}

