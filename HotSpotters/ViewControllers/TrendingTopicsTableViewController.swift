//
//  TrendingTopicsTableViewController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/9/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class TrendingTopicsTableViewController: UITableViewController {
    
    var stockPhotoIndex = 0
    var spinner: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchTrends), name: CollegeMapViewController.collegeAnnotationSelected, object: nil)
        
        tableView.prefetchDataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.post(name: TogglerViewController.showTypeTogglerNotification, object: nil)
        NotificationCenter.default.post(name: FourSquareTableViewController.removeAnnotationsNotification, object: nil)
        NotificationCenter.default.post(name: CollegeMapViewController.removeEventAnnotations, object: nil)
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TrendController.shared.currentTrends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trendCell", for: indexPath) as? TrendTableViewCell
        let trend = TrendController.shared.currentTrends[indexPath.row]
        let image = trend.photo ?? UIImage(named: "twitterBackDrop")
        cell?.trendImage = image
        cell?.trend = trend
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTweetsTBVC" {
            let destinationVC = segue.destination as! TopicDetailTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let trend = TrendController.shared.currentTrends[indexPath.row]
            let image = trend.photo
            destinationVC.trendImage = image
            destinationVC.trend = trend
        }
    }
    
    @objc func fetchTrends(){
        spinner = UIViewController.displaySpinner(onView: self.view)
        guard let currentCollege =  CollegeController.shared.selectedCollege else {UIViewController.removeSpinner(spinner: self.spinner) ; return}
        
        TrendController.shared.getTrendingTopicsFor(latitude: currentCollege.locationLat, longitude: currentCollege.locationLon) { (trends) in
            guard let trends = trends else {UIViewController.removeSpinner(spinner: self.spinner) ; return}
            TrendController.shared.currentTrends = trends
            
            var i = 0
            for trend in trends {
                if trend.photo == UIImage(named: "twitterBackDrop"){
                    TrendController.shared.fetchTrendImage(trend: trend, completion: { (image) in
                        if let image = image{
                            i += 1
                            print("POST FETCHING Image for \(trend.name)")
                            trend.photo = image
                            if i == 3 {
                                DispatchQueue.main.async {
                                    UIViewController.removeSpinner(spinner: self.spinner)
                                }
                            }
                        }
                    })
            }
        }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension TrendingTopicsTableViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if stockPhotoIndex == 8 {
                stockPhotoIndex = 0
            }
            let trend = TrendController.shared.currentTrends[indexPath.row]
            print("Prefetching For \(trend.name)")
            if trend.photo == UIImage(named: "twitterBackDrop"){
                trend.photo = UIHelper.stockPhotos[stockPhotoIndex]
                stockPhotoIndex += 1
            }
        }
    }
}

