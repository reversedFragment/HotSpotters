//
//  Venue.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/26/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

////////////////////////////////////////////////////////////////
// Mark: - Venue Struct
////////////////////////////////////////////////////////////////

// MARK: - A single Venue from 'venues' in the 'fetchVenues' JSON.
  // Do not confuse this with the codingKey 'venue' in VenueDetails.
struct Venue: Codable {
	let venueID: String /// A unique identifier, used to fetch the venue details
	let name: String? /// The best known name for this venue.
	let location: Location?
	let venueCategories: [VenueCagtegory]?
	
	enum CodingKeys: String, CodingKey {
		case venueID
		case name
		case location
		case venueCategories = "categories"
	}
}

////////////////////////////////////////////////////////////////
// Mark: - Venue Location Data
////////////////////////////////////////////////////////////////


/// An object containing none, some, or all of address (street address),
/// crossStreet, city, state, postalCode, country, lat, lng, and distance.
/// All fields are strings, except for lat, lng, and distance.
/// Distance is measured in meters.

struct Location: Codable {
	let address: String?
	let crossStreet: String?
	let lat: Double?
	let lng: Double?
	let distance: Int?
	let postalCode: String?
	let cc: String?
	let city: String?
	let state: String?
	let country: String?
	let formattedAddress: [String]?
}

////////////////////////////////////////////////////////////////
// Mark: - Venue Events -- Specific to fetchEvents()
////////////////////////////////////////////////////////////////

//struct Event {
//  let name: String
//  let id: String
//  let url: String
//  let categories: [Category]
//  let hereNow: Int
//}

////////////////////////////////////////////////////////////////
// Mark: - Venue Categories
////////////////////////////////////////////////////////////////

/// An array, possibly empty, of categories that have been applied to this venue.
/// One of the categories will have a primary field indicating that it is the
/// primary category for the venue.

struct VenueCagtegory: Codable {
	let id: String? /// A unique identifier for this category.
	let name: String?
}

struct CategoryIcon: Codable {
	let prefix: String?
	let suffix: String?
}

/// Image extension enum. All files are .png, as far as I can tell.
/// This is different from the 'suffix' property above
enum Suffix: String, Codable {
	case png = ".png"
}

////////////////////////////////////////////////////////////////
// Mark: - Venue Contact Info
////////////////////////////////////////////////////////////////

struct Contact: Codable {
	let phone: String?
	let formattedPhone: String?
	let twitter: String?
	let instagram: String?
	let facebook: String?
	let facebookUsername: String?
	let facebookName: String?
}


////////////////////////////////////////////////////////////////
// Mark: - Venue User Stats
////////////////////////////////////////////////////////////////

/// Contains:
// 1. checkinsCount (total checkins ever here),
// 2. usersCount (total users who have ever checked in here),
// 3. and tipCount (number of tips here).

struct Stats: Codable {
	let tipCount: Int?
}
