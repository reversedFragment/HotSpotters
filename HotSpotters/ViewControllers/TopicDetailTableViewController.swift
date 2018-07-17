//
//  TopicDetailTableViewController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/6/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class TopicDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var trendLabel: UILabel!
    @IBOutlet weak var trendImageView: CustomCellImageView!
    
    var trend: Trend?{
        didSet{
            guard let trend = trend else {return}
            TweetController.shared.searchTweetsBy(topic: trend.name, geocode: nil, resultType: ResultType.mixed, count: 25) { (tweets) in
                guard let tweets = tweets else {return}
                TweetController.shared.fetchedTweets = tweets
                DispatchQueue.main.async {
                    self.updateView()
                    self.tableView.reloadData()
                }
            }
        }
    }

    var trendImage: UIImage?{
        didSet{
            self.updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        NotificationCenter.default.post(name: TogglerViewController.hideTypeTogglerNotification, object: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TweetController.shared.fetchedTweets?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as? TopicDetailTableViewCell
            guard let fetchedTweets = TweetController.shared.fetchedTweets else {return UITableViewCell()}
            let tweet = fetchedTweets[indexPath.row]
            TweetController.shared.fetchProfilePictureFor(user: tweet.user) { (image) in
                if let image = image{
                    print(image)
                    cell?.profilePicture = image
                }
            }
            cell?.tweet = tweet
            return cell ?? UITableViewCell()
    }

    func updateView(){
        guard let trend = trend else {return}
        trendLabel.text = trend.name
        if let trendImage = trendImage {
            trendImageView.image = trendImage
        }
    }

}
