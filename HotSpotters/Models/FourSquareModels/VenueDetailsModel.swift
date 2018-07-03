//
//  VenueDetails.swift
//  HotSpot
//
//  Created by Ben Adams on 6/28/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation


////////////////////////////////////////////////////////////////
// Mark: - Venue Details
////////////////////////////////////////////////////////////////

struct VenueDetails: Codable {
    let id: String?
    let name: String?
    let contact: VenueContact?
    let canonicalURL: String? /// FourSquare URL for Venue Listing
    let url: String? /// URL of the venue’s website, typically provided by the venue manager.
    let price: Price? /// Price rating of 1, 2, 3, or 4
    let likes: VenueLikes?
    let rating: Double?
    let ratingSignals: Int? /// Number of ratings given by users
    let page: Page? /// Page owner's information about their venue
    let tips: VenueTips? /// Tips left by users about venue
    let listed: Listed? /// Specification of curated lists that a venue is on
    let photos: Photos?
    let bestPhoto: BestPhoto?
    
    /// Structs shared with Venue Model, all others are VenueDetails specific
    let locationDetails: Location?
    let stats: Stats
    let venueCategories: [venueCategory]?
    let hours: Hours?

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case contact = "contact"
        case locationDetails = "location"
        case canonicalURL = "canonicalUrl"
        case venueCategories = "categories"
        case stats = "stats"
        case url = "url"
        case price = "price"
        case likes = "likes"
        case rating = "rating"
        case ratingSignals = "ratingSignals"
        case page = "page"
        case tips = "tips"
        case listed = "listed"
        case hours = "hours"
        case bestPhoto = "bestPhoto"
        case photos = "photos"
    }
}

////////////////////////////////////////////////////////////////
// Mark: - Venue Contact Detail
////////////////////////////////////////////////////////////////

struct VenueContact: Codable {
    let phone: String?
    let formattedPhone: String?
    let twitter: String?
    let instagram: String?
    let facebook: String?
    let facebookUsername: String?
    let facebookName: String?
    
}


////////////////////////////////////////////////////////////////
// Mark: - Venue Likes Data
////////////////////////////////////////////////////////////////

struct VenueLikes: Codable {
    let count: Int?
    let groups: [LikesGroup]?
    let summary: String?
    
}

struct LikesGroup: Codable {
    let type: String?
    let count: Int?
    
}


////////////////////////////////////////////////////////////////
// Mark: - Venue's best photo
////////////////////////////////////////////////////////////////

struct BestPhoto: Codable {
    let id: String?
    let createdAt: Int?
    let source: Source?
    let bestPhotoPrefix: String?
    let suffix: String?
    let width: Int?
    let height: Int?
    let visibility: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "createdAt"
        case source = "source"
        case bestPhotoPrefix = "prefix"
        case suffix = "suffix"
        case width = "width"
        case height = "height"
        case visibility = "visibility"
    }
}

struct Source: Codable {
    let name: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}

////////////////////////////////////////////////////////////////
// Mark: - Photos of venue from users and owners
////////////////////////////////////////////////////////////////

struct Photos: Codable {
    let count: Int?
    let groups: [PhotosGroup]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case groups = "groups"
    }
}

struct PhotosGroup: Codable {
    let type: String?
    let name: String?
    let count: Int?
    let items: [photoListItem]?
    
}

struct photoListItem: Codable {
    let id: String?
    let createdAt: Int?
    let source: Source?
    let itemPrefix: String?
    let suffix: String?
    let width: Int?
    let height: Int?
    let visibility: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "createdAt"
        case source = "source"
        case itemPrefix = "prefix"
        case suffix = "suffix"
        case width = "width"
        case height = "height"
        case visibility = "visibility"
    }
}


////////////////////////////////////////////////////////////////
// Mark: - Curated lists that the venue is included in by users or other sites
////////////////////////////////////////////////////////////////

struct Listed: Codable {
    let count: Int
    let groups: [ListedGroup]
    
}

struct ListedGroup: Codable {
    let type: String?
    let name: String?
    let count: Int?
    let items: [VenueListMembership]?
    
}

struct VenueListMembership: Codable {
    let id: String?
    let name: String?
    let description: String?
    let type: String?
    let url: String?
    let canonicalURL: String?
    let followers: FollowersCount?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case type = "type"
        case url = "url"
        case canonicalURL = "canonicalUrl"
        case followers = "followers"
    }
}

struct FollowersCount: Codable {
    let count: Int?
    
}

struct ListDetailPhoto: Codable {
    let id: String?
    let createdAt: Int?
    let prefix: String?
    let suffix: String?
    let width: Int?
    let height: Int?
    let visibility: String?
    
}

////////////////////////////////////////////////////////////////
// Mark: - Venue Page Info
////////////////////////////////////////////////////////////////

struct Page: Codable {
    let pageInfo: PageInfo?
    
    enum CodingKeys: String, CodingKey {
        case pageInfo = "pageInfo"
    }
}

struct PageInfo: Codable {
    let description: String?
    let banner: String?
    let links: Links?
    
}

struct Links: Codable {
    let count: Int?
    let items: [LinksItem]?
    
}

struct LinksItem: Codable {
    let url: String?
    
}


////////////////////////////////////////////////////////////////
// Mark: - Venue Pricing on scale of 1,2,3,4. Users can sort by these in func call
////////////////////////////////////////////////////////////////

struct Price: Codable {
    let tier: Int?
    let message: String?
    let currency: String
    
}

////////////////////////////////////////////////////////////////
// Mark: - Venue Tips and Tip Likes
////////////////////////////////////////////////////////////////

struct VenueTips: Codable {
    let count: Int?
    let groups: [TipsGroup]?
    
}

struct TipsGroup: Codable {
    let type: String?
    let name: String?
    let count: Int?
    let TipItems: [TipItem]?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case name = "name"
        case count = "count"
        case TipItems = "items"
    }
}

struct TipItem: Codable {
    let id: String?
    let text: String?
    let canonicalURL: String?
    let likes: ItemLikes?

}

struct ItemLikes: Codable {
    let likeCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case likeCount = "count"
    }
}
