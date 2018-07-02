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
    let warning: Warning?
    
}

////////////////////////////////////////////////////////////////
// Mark: - Response Layer
////////////////////////////////////////////////////////////////


// Mark: - All possible fields for Response depending on fetch func called

// All fetches have a response struct
struct Response: Codable {
 
    let venues: [Venue]? /// Specific to calls made with 'fetchVenues' and 'exploreVenues()
    let geocode: Geocode? /// Specific to calls made using 'near' as a parameter instead of 'll'
    let hours: Hours?
    let categories: [MainCategories]? /// Specfic to categories pulled in the 'VenueCategoriesMasterList' file
    let venueDetails: VenueDetails? /// Specific to 'venue' pulled by 'fetchVenueDetails()', not 'venues' for general
    let headerLocation: String? /// Text name for location the user searched, e.g. “SoHo”.
    let headerFullLocation: String? /// Full name for the location the user searched, e.g. “SoHo, New York”.
    let totalResults: Int?
    let groups: [ResponseGroup]? /// An array of objects representing groups of recommendations. Each group contains a type such as “recommended” a human-readable (eventually localized) name such as “Recommended Places,” and an array items of recommendation objects.

    
    enum CodingKeys: String, CodingKey {
        case venues = "venues"
        case geocode = "geocode"
        case hours = "hours"
        case categories = "categories"
        case venueDetails = "venue"
        case headerLocation = "headerLocation"
        case headerFullLocation = "headerFullLocation"
        case totalResults = "totalResults"
        case groups = "groups"
    }
}

/// Specific to exploreVenues() fetches lacking venues given filter criteria
struct Warning: Codable {
    let text: String
}


////////////////////////////////////////////////////////////////
// Mark: - Geocode data from general venue search function when
//        passed in 'near' query instead of coordinates
////////////////////////////////////////////////////////////////

struct Geocode: Codable {
    let what: String?
    let geocodeWhere: String?
    let feature: Feature?
    let center: Center?
    let displayString: String?
    let cc: String?
    let geometry: Geometry?
    let slug: String?
    let longID: String?
    
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

////////////////////////////////////////////////////////////////
/// Mark: - exploreVenues() data that comes back inside 'response' JSON
////////////////////////////////////////////////////////////////

struct ResponseGroup: Codable {
    let type: String?
    let name: String?
    let items: [GroupItem]?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case name = "name"
        case items = "items"
    }
}

struct GroupItem: Codable {
    let venue: RecommendedVenue?
    
}

////////////////////////////////////////////////////////////////
/// Mark: - Venue Hours
////////////////////////////////////////////////////////////////

struct Hours: Codable {
    let timeframes: [HoursTimeframe]?
    let status: String?
    let isOpen: Bool?
    let isLocalHoliday: Bool?
}

struct HoursTimeframe: Codable {
    let includesToday: Bool?
    let timeframeOpen: [Open]?
}

struct Open: Codable {
    let start: String?
    let end: String?
    let renderedTime: String?
}
