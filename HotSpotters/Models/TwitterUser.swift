//
//  TwitterUser.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 6/28/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

struct TwitterUser: Codable {
    let id: Int
    let name: String
    let screenName: String
    let location: String?
    let description: String?
    let protected: Bool
    let profileImageURL: String
    let profileImageURLHTTPS: String
    let followersCount: Int
    let friendsCount: Int
    let listedCount: Int
    let createdAt: String
    let favoritesCount: Int
    let geoEnabled: Bool
    let verified: Bool
    let statusesCount: Int
    let lang: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case location
        case description
        case protected
        case profileImageURL = "profile_image_url"
        case profileImageURLHTTPS = "profile_image_url_https"
        case followersCount = "followers_count"
        case friendsCount = "friends_count"
        case listedCount = "listed_count"
        case createdAt = "created_at"
        case favoritesCount = "favourites_count"
        case geoEnabled = "geo_enabled"
        case verified
        case statusesCount = "statuses_count"
        case lang
    }
}
