//
//  EventBriteVenueModel.swift
//  HotSpotters
//
//  Created by CELLFiY on 7/18/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

struct EventBriteVenue: Codable {
    let address: Address
    let resourceURI, id: String
    let name, latitude, longitude: String?
    
    enum CodingKeys: String, CodingKey {
        case address
        case resourceURI = "resource_uri"
        case id
        case name, latitude, longitude
    }
}

struct Address: Codable {
    let address1: String?
    let city, region, country: String?
    let latitude, longitude, localizedAddressDisplay, localizedAreaDisplay: String?
    let localizedMultiLineAddressDisplay: [String]?
    
    enum CodingKeys: String, CodingKey {
        case address1 = "address_1"
        case city, region
        case country, latitude, longitude
        case localizedAddressDisplay = "localized_address_display"
        case localizedAreaDisplay = "localized_area_display"
        case localizedMultiLineAddressDisplay = "localized_multi_line_address_display"
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
