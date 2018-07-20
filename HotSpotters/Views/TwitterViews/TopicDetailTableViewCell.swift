//
//  TopicDetailTableViewCell.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/6/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class TopicDetailTableViewCell: UITableViewCell {
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetBodyLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    
    var tweet: Tweet?{
        didSet{
                DispatchQueue.main.async {
                    self.updateCell()
                }
        }
    }

    var profilePicture: UIImage?{
        didSet{
            DispatchQueue.main.async {
                self.profilePictureView.image = self.profilePicture
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateCell(){
        guard let tweet = tweet else {return}
        usernameLabel.text = tweet.user.screenName
        tweetBodyLabel.text = tweet.body
        favoritesLabel.text = "\(tweet.favoriteCount)"
        retweetsLabel.text = "\(tweet.retweetCount)"
    }
}
