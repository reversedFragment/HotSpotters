//
//  TrendingTopicsTableViewController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/9/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class TrendingTopicsTableViewController: UITableViewController {
    
    var tweetsDictionary: [String : [Tweet]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchTrends), name: CollegeMapViewController.collegeAnnotationSelected, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
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
        
        guard let currentCollege =  CollegeController.shared.selectedCollege else {return}
        
        TrendController.shared.getTrendingTopicsFor(latitude: currentCollege.locationLat, longitude: currentCollege.locationLon) { (trends) in
            guard let trends = trends else {return}
            TrendController.shared.currentTrends = trends
            
            for trend in trends {
                if trend.photo == UIImage(named: "topPicks"){
                    TweetController.shared.searchTweetsBy(topic: trend.name, geocode: nil, resultType: .mixed, count: 3, completion: { (tweets) in
                        if let tweets = tweets{
                            self.tweetsDictionary[trend.name] = tweets
                        }
                    })
                    
                    TrendController.shared.fetchTrendImage(trend: trend, completion: { (image) in
                        if let image = image{
                            print("POST FETCHING Image for \(trend.name)")
                            trend.photo = image
                        } else {
                            trend.photo = #imageLiteral(resourceName: "twitterBackDrop")
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
            let trend = TrendController.shared.currentTrends[indexPath.row]
        
            print("Prefetching \(trend.name)")
            guard let tweets = tweetsDictionary[trend.name] else { return }
            for tweet in tweets {
                guard let medias = tweet.entities.media else { return }
                for media in medias {
                    guard let url = URL(string: media.mediaURLHTTPS) else { return }
                    URLSession.shared.dataTask(with: url)
                }
            }
          
        }
    }
}

