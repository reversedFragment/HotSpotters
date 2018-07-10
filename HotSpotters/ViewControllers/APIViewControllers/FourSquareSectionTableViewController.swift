//
//  FourSquareSectionTableViewController.swift
//  HotSpotters
//
//  Created by Ben Adams on 7/9/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit
import Foundation

class FourSquareSectionTableViewController: UITableViewController {
    
    // Fetch parameter selected by user
    var sectionSelected = ""
    
    // Users can use this enum to filter by 'section'
    enum venueSectionMarker {
        static var all = ["Trending", "TopPicks", "Food", "Drinks", "Coffee",
                          "Shops", "Arts", "Outdoors", "Sights"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! FourSquareSectionTableViewCell
        
        let section = venueSectionMarker.all[indexPath.row]
        cell.sectionLabel.text = section
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FourSquareTableView" {
            if let fourSquareTableVC = segue.destination as? FourSquareTableViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    selectedItem(indexPath: indexPath)
                    fourSquareTableVC.sectionSelected = sectionSelected
                }
            }
            
        }
    }
    
    func selectedItem(indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            sectionSelected = "trending"
        case 1:
            sectionSelected = "topPicks"
        case 2:
            sectionSelected = "food"
        case 3:
            sectionSelected = "drinks"
        case 4:
            sectionSelected = "coffee"
        case 5:
            sectionSelected = "shops"
        case 6:
            sectionSelected = "arts"
        case 7:
            sectionSelected = "outdoors"
        case 8:
            sectionSelected = "sights"
        default:
            break
        }
    }
    
    
}
