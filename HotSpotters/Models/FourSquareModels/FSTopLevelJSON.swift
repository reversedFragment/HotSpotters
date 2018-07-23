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
	let warning: Warning? /// Specific to exploreVenue() calls which return 0 venues
}

////////////////////////////////////////////////////////////////
// Mark: - SecondLevelData
////////////////////////////////////////////////////////////////

/// All possible fields for 'response' regardless of fetch func used
	// All fetches have a response struct
struct Response: Codable {
	
	let venues: [Venue]? /// Specific to calls made w/ 'fetchVenues' and 'exploreVenues()
	let geocode: Geocode? /// Specific to calls w/ 'near' as a parameter instead of 'll'
	let hours: Hours?
	let venueDetails: VenueDetails? /// Specific to fetchVenueDetails()
	let headerLocation: String? /// Name for searched location, e.g. “SoHo”.
	let headerFullLocation: String? /// location full name, e.g. “SoHo, New York”.
	let totalResults: Int?
	let groups: [Group]? /// Array of objects representing groups of recommendations.
											 /// Each group contains:
												// 1. a type such as “recommended”,
												// 2. a human-readable name such as “Recommended Places,”
												// 3. an array items of recommendation objects.
	
	enum CodingKeys: String, CodingKey {
		case venues
		case geocode
		case hours
		case venueDetails = "venue"
		case headerLocation
		case headerFullLocation
		case totalResults
		case groups
	}
}

// Specific to exploreVenues() fetches lacking filter criteria
struct Warning: Codable {
	let text: String
}

////////////////////////////////////////////////////////////////
// Mark: - Geodata from fetchVenues() when passed 'near' query, not 'll' coordinate
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
}

struct Geometry: Codable {
	let center: Center?
	let bounds: Bounds?
}

struct Bounds: Codable {
	let ne: Center
	let sw: Center
}

struct Center: Codable {
	let lat: Double
	let lng: Double
}

////////////////////////////////////////////////////////////////
// Mark: - exploreVenues() specific data within 'response' JSON
////////////////////////////////////////////////////////////////

struct Group: Codable {
	let items: [GroupItem]?
}

struct GroupItem: Codable {
	let fetchedRecommendedVenue: RecommendedVenue?
	
	enum CodingKeys: String, CodingKey {
		case fetchedRecommendedVenue = "venue"
	}
}

////////////////////////////////////////////////////////////////
// Mark: - Venue Hours
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
