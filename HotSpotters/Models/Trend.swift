//
//  Trend.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 6/28/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

struct TrendDictionary: Codable{
    let trends: [Trend]
}

struct Trend: Codable{
    let name: String
    let url: String
    let query: String
    let tweetVolumeInLastTwentyFourHours: Int?
    
    enum CodingKeys: String, CodingKey{
        case name, url, query
        case tweetVolumeInLastTwentyFourHours = "tweet_volume"
    }
}
