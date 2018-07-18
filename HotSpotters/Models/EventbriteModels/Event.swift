//
//  Event.swift
//  EventBrite
//
//  Created by CELLFiY on 6/27/18.
//  Copyright © 2018 Matt Schweppe. All rights reserved.
//

import UIKit
import CoreLocation

struct Events {
    
    let name: String
    let image: UIImage
    let description: String
    let location: CLLocationCoordinate2D
    let posts: [Post]
    let category: CategoryType
    let venue: EBVenue?
    
}

struct EBVenue {
    
}


enum CategoryType: String {
    
    case Music, Business, Dining, Community, Entertainment, Health, Technology
    
    func description() -> String {
        switch self {
        case .Music:
            return "Music"
        case .Business:
            return "Business & Professional"
        case .Dining:
            return "Food & Drink"
        case .Community:
            return "Community & Culture"
        case .Entertainment:
            return "Film, Performing Arts & Entertainment"
        case .Health:
            return "Health & Wellness"
        case .Technology:
            return "Science & Technology"
            
        }
    }
    
}
