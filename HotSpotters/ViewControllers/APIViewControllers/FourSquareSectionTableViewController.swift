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
    
    
    typealias section = (title: String, image: UIImage)
    // Fetch parameter selected by user
    var sectionSelected = ""
    
    // Users can use this enum to filter by 'section'
    enum venueSectionMarker {
        static var all = ["Trending", "TopPicks", "Food", "Drinks", "Coffee",
                          "Shops", "Arts", "Outdoors", "Sights"]
        static var all2: [section] = [("Trending", #imageLiteral(resourceName: "trending")), ("TopPicks", #imageLiteral(resourceName: "topPicks")), ("Food", #imageLiteral(resourceName: "food")), ("Drinks", #imageLiteral(resourceName: "drinks")), ("Coffee", #imageLiteral(resourceName: "coffee")), ("Shops", #imageLiteral(resourceName: "shops")), ("Arts", #imageLiteral(resourceName: "arts")), ("Outdoors", #imageLiteral(resourceName: "outdoors")), ("Sights", #imageLiteral(resourceName: "sights"))]
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
        
        let sectionLabel = venueSectionMarker.all[indexPath.row]
        let backgroundViewImage = venueSectionMarker.all2[indexPath.row].image
        cell.sectionLabel.text = sectionLabel
        cell.imageView?.image = backgroundViewImage
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
