//
//  ExploreRecommendedVenuesModel.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/30/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation


/// Mark: - This is a sub-struct of 'groupItem'
/// This is specific to venues pulled in exploreVenues()

struct RecommendedVenue: Codable, Equatable {
    let venueId: String
    let name: String?
    let location: Location
    let categories: [VenueCagtegory]?

    
    enum CodingKeys: String, CodingKey {
        case venueId = "id"
        case name
        case location
        case categories 
    }
    
    static func ==(lhs: RecommendedVenue, rhs: RecommendedVenue) -> Bool{
        return lhs.venueId == rhs.venueId
    }
}

