//
//  ExploreRecommendedVenuesModel.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/30/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

struct RecommendedVenue: Codable {
    let venueId: String?
    let name: String?
    let contact: Contact?
    let location: Location?
    let categories: [venueCategory]?
    let stats: Stats?
    let url: String?
    let rating: Double?
    let ratingColor: RatingColor?
    let ratingSignals: Int?
    let hours: Hours?
    let photos: Photos?
    let price: Price?
    let venuePage: Page?
    
    enum CodingKeys: String, CodingKey {
        case venueId = "id"
        case name = "name"
        case contact = "contact"
        case location = "location"
        case categories = "categories"
        case stats = "stats"
        case url = "url"
        case rating = "rating"
        case ratingColor = "ratingColor"
        case ratingSignals = "ratingSignals"
        case hours = "hours"
        case photos = "photos"
        case price = "price"
        case venuePage = "venuePage"
    }
}

// Color of the rating score in hex
struct RatingColor: Codable {
    let ratingColor: String?
    
}
