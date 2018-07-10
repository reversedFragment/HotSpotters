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
    
    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        FourSquareTableView.delegate = self
        FourSquareTableView.dataSource = self
        DispatchQueue.main.async {
            self.FourSquareTableView.reloadData()
        }
    }
    
    /// Mark: - Source of Truth
    var sectionSelected: String = ""
    var fetchedVenues: [GroupItem] = []{
        didSet {
            print("item was added")
           
        }
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
        let recommendedVenues = fetchedVenues[indexPath.row]
        cell.fetchedVenue = recommendedVenues.fetchedRecommendedVenue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
}
