//
//  EventCategoriesTableViewController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/10/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class EventCategoriesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventBriteController.categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryTableViewCell
        let category = EventBriteController.categories[indexPath.row]
        cell?.category = category
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventsVC"{
            guard let destinationVC = segue.destination as? EventsTableViewController,
            let indexPath = tableView.indexPathForSelectedRow else {return}
            let category = EventBriteController.categories[indexPath.row]
            destinationVC.category = category
        }
    }
}
