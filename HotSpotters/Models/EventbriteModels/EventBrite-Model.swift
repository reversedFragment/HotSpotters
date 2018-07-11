

import UIKit
    
    struct Event: Codable {
        let events: [EventElement]
    }
    
    struct EventElement: Codable {
        let name, description: Description
        let id, url: String?
        let vanityURL: String?
        let start, end: End?
        let isFree: Bool?
        let logoID, organizerID, venueID: String?
        let logo: Logo?
        let resourceURI: String?
        let categoryID, subcategoryID: String?
        var image: UIImage? = UIImage()
        
        enum CodingKeys: String, CodingKey {
            case name, description, id, url
            case vanityURL = "vanity_url"
            case start, end
            case isFree = "is_free"
            case logoID = "logo_id"
            case organizerID = "organizer_id"
            case venueID = "venue_id"
            case logo
            case resourceURI = "resource_uri"
            case categoryID = "category_id"
            case subcategoryID = "subcategory_id"
        }
        
        mutating func setImage(_ image: UIImage){
            self.image = image
        }
    }

    struct Description: Codable {
        let text, html: String?
    }
    
    struct End: Codable {
        let local, utc: String
    }

struct Logo: Codable {
    let cropMask: CropMask?
    let original: Original
    let id, url: String
    let aspectRatio, edgeColor: String?
    let edgeColorSet: Bool
    
    enum CodingKeys: String, CodingKey {
        case cropMask = "crop_mask"
        case original, id, url
        case aspectRatio = "aspect_ratio"
        case edgeColor = "edge_color"
        case edgeColorSet = "edge_color_set"
    }
}

struct CropMask: Codable {
    let topLeft: TopLeft
    let width, height: Int
    
    enum CodingKeys: String, CodingKey {
        case topLeft = "top_left"
        case width, height
    }
}

struct TopLeft: Codable {
    let x, y: Int
}

struct Original: Codable {
    let url: String
    let width, height: Int?
}

