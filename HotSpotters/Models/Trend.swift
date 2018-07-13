//
//  Trend.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 6/28/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

struct TrendDictionary: Codable{
    let trends: [Trend]
}

class Trend: Codable{
    let name: String
    let url: String
    let query: String
    let tweetVolumeInLastTwentyFourHours: Int?
    var photo: UIImage? = UIImage(named: "twitterBackDrop")
    
    enum CodingKeys: String, CodingKey{
        case name, url, query
        case tweetVolumeInLastTwentyFourHours = "tweet_volume"
    }
}
