//
//  College.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/3/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

struct CollegeService: Codable {
    let metadata: Metadata
    let results: [College]
}

struct Metadata: Codable {
    let total, page, perPage: Int
    
    enum CodingKeys: String, CodingKey {
        case total, page
        case perPage = "per_page"
    }
}

class College: Codable, Equatable {
    let locationLat: Double
    let locationLon: Double
    let schoolName: String
    let predominantDegree: Int
    let schoolState: String
    let size: Int
    let id: Int
    let urlString: String
    var logo: UIImage? = UIImage()
    
    enum CodingKeys: String, CodingKey {
        case locationLat = "location.lat"
        case locationLon = "location.lon"
        case schoolName = "school.name"
        case predominantDegree = "school.degrees_awarded.predominant"
        case schoolState = "school.state"
        case size = "2015.student.size"
        case id
        case urlString = "school.school_url"

    }
}


func ==(lhs: College, rhs: College) -> Bool{
    return lhs.id == rhs.id
}
