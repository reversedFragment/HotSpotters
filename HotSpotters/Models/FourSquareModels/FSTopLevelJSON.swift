//
//  FourSquareModel.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/27/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

////////////////////////////////////////////////////////////////
// Mark: - TopLevelData
////////////////////////////////////////////////////////////////

struct TopLevelData: Codable {
    let response: Response
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}

////////////////////////////////////////////////////////////////
// Mark: - Response Layer
////////////////////////////////////////////////////////////////


/// Mark: - All possible fields for Response depending on fetch func called

struct Response: Codable {
  // Specific to calls made 'fetchTrendingVenues' and 'fetchVenues'
    let venues: [Venue]?
    
  // Specific to calls made using 'near' as a parameter instead of 'll'
    let geocode: Geocode?
    let confident: Bool?
    
  // Specific to hours that are pulled by the fetchHours request
    let hours: Hours?
  // Specfic to categories pulled in the 'VenueCategoriesMasterList' file
    let categories: [MainCategories]?
  // Specific to 'venue' pulled by 'fetchVenueDetails()', not 'venues' for general
    let venueDetails: VenueDetails?
    
    
    enum CodingKeys: String, CodingKey {
        case venues = "venues"
        case geocode = "geocode"
        case confident = "confident"
        case hours = "hours"
        case categories = "categories"
        case venueDetails = "venue"
    }
}


////////////////////////////////////////////////////////////////
// Mark: - Geocode data from general venue search function when
//        passed in 'near' query instead of coordinates
////////////////////////////////////////////////////////////////

struct Geocode: Codable {
    let what: String?
    let geocodeWhere: String?
    let feature: Feature?

    enum CodingKeys: String, CodingKey {
        case what = "what"
        case geocodeWhere = "where"
        case feature = "feature"

    }
}

struct Feature: Codable {
    let cc: String?
    let name: String?
    let displayName: String?
    let matchedName: String?
    let highlightedName: String?
    let woeType: Int?
    let slug: String?
    let id: String?
    let longID: String?
    let geometry: Geometry?

    enum CodingKeys: String, CodingKey {
        case cc = "cc"
        case name = "name"
        case displayName = "displayName"
        case matchedName = "matchedName"
        case highlightedName = "highlightedName"
        case woeType = "woeType"
        case slug = "slug"
        case id = "id"
        case longID = "longId"
        case geometry = "geometry"
    }
}

struct Geometry: Codable {
    let center: Center?
    let bounds: Bounds?

    enum CodingKeys: String, CodingKey {
        case center = "center"
        case bounds = "bounds"
    }
}

struct Bounds: Codable {
    let ne: Center
    let sw: Center

    enum CodingKeys: String, CodingKey {
        case ne = "ne"
        case sw = "sw"
    }
}

struct Center: Codable {
    let lat: Double
    let lng: Double

    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
}
