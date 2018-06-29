//
//  Venue.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/26/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

////////////////////////////////////////////////////////////////
/// Mark: - Venue Struct
////////////////////////////////////////////////////////////////

struct Venue: Codable {
    let venueID: String
    let name: String
    let contact: Contact
    let location: Location
    let venueCategories: [Category]
    let verified: Bool
    let stats: Stats
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case venueID = "id"
        case name = "name"
        case contact = "contact"
        case location = "location"
        case venueCategories = "categories"
        case verified = "verified"
        case stats = "stats"
        case url = "url"
    }
}

////////////////////////////////////////////////////////////////
/// Mark: - Venue Location Data
////////////////////////////////////////////////////////////////

struct Location: Codable {
    let address: String?
    let crossStreet: String?
    let lat: Double?
    let lng: Double?
    let labeledLatLngs: [LabeledLatLng]?
    let distance: Int?
    let postalCode: String?
    let cc: String?
    let city: String?
    let state: String?
    let country: String?
    let formattedAddress: [String]?
    let neighborhood: String?
}


// Venue Coordinates
struct LabeledLatLng: Codable {
    let label: String
    let lat: Double
    let lng: Double
}


////////////////////////////////////////////////////////////////
/// Mark: - Venue Events
////////////////////////////////////////////////////////////////

//struct Event {
//    let name: String
//    let id: String
//    let url: String
//    let categories: [Category]
//    let hereNow: Int
//
//}
////////////////////////////////////////////////////////////////
/// Mark: - Venue Categories
////////////////////////////////////////////////////////////////

struct Category: Codable {
    let id: String
    let name: String
    let pluralName: String
    let shortName: String
    let icon: CategoryIcon
    let primary: Bool?
}

struct CategoryIcon: Codable {
    let prefix: String
    let suffix: String
}

// image extension enum
enum Suffix: String, Codable {
    case png = ".png"
}

////////////////////////////////////////////////////////////////
/// Mark: - Venue Contact Info
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
/// Mark: - Venue Current Visitor Count
////////////////////////////////////////////////////////////////

// Queries number of people currently at venue
struct HereNow: Codable {
    let count: Int
    let summary: Summary
}

enum Summary: String, Codable {
    case nobodyHere = "Nobody here"
    case oneOtherPersonIsHere = "One other person is here"
    case the2PeopleAreHere = "2 people are here"
}


////////////////////////////////////////////////////////////////
/// Mark: - Venue User Stats
////////////////////////////////////////////////////////////////

struct Stats: Codable {
    let tipCount: Int?
    let usersCount: Int?
    let checkinsCount: Int?
    let visitsCount: Int?
}


struct VenuePageID: Codable {
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
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
