//
//  Location.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 6/28/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

struct TwitterLocation: Codable {
    let name: String
    let country: String
    let woeid: Int
    let countryCode: String
}
