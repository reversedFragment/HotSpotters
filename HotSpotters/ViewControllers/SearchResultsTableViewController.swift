 //
//  TableViewController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/5/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    static let collegeSelected = Notification.Name(rawValue: "College Selected From Search")
    static let searchButtonTapped = Notification.Name(rawValue: "Search Button Tapped")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: CollegeMapViewController.searchBarUpdated, object: nil)
//        tableView.prefetchDataSource = self as! UITableViewDataSourcePrefetching
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CollegeController.shared.filteredColleges.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collegeCell", for: indexPath)
        if indexPath.row < CollegeController.shared.filteredColleges.count{
            let college = CollegeController.shared.filteredColleges[indexPath.row]
            cell.textLabel?.text = college.schoolName
            cell.imageView?.image = college.logo
        }
        return cell
    }
    
    @objc func reloadView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < CollegeController.shared.filteredColleges.count{
            CollegeController.shared.selectedCollege = CollegeController.shared.filteredColleges[indexPath.row]
            NotificationCenter.default.post(name: SearchResultsTableViewController.collegeSelected, object: nil)
        }
    }    
}
