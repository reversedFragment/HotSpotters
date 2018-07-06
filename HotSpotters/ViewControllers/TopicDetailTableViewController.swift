//
//  TopicDetailTableViewController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/6/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class TopicDetailTableViewController: UITableViewController {

    @IBAction func refeshButtonTapped(_ sender: UIBarButtonItem) {
        tableView.reloadData()
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
        return TweetController.shared.fetchedTweets?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as? TopicDetailTableViewCell
            guard let tweet = TweetController.shared.fetchedTweets?[indexPath.row] else {return UITableViewCell()}
            TweetController.shared.fetchProfilePictureFor(user: tweet.user) { (image) in
                if let image = image{
                    print(image)
                    cell?.profilePicture = image
                }
            }
            cell?.tweet = tweet
            return cell ?? UITableViewCell()
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
