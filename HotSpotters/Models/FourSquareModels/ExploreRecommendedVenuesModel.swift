//
//  ExploreRecommendedVenuesModel.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/30/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

struct RecommendedVenue: Codable {
    let venueId: String
    let name: String?
    let location: Location
    let categories: [venueCategory]?

    
    enum CodingKeys: String, CodingKey {
        case venueId = "id"
        case name = "name"
        case location = "location"
        case categories = "categories"
    }
}

