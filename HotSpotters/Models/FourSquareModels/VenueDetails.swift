//
//  VenueDetails.swift
//  HotSpot
//
//  Created by Ben Adams on 6/28/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

////////////////////////////////////////////////////////////////
/// Mark: - Venue Details
////////////////////////////////////////////////////////////////

struct VenueDetails: Codable {
    let id: String?
    let name: String?
    let contact: VenueContact?
    let locationDetails: Location?
    let canonicalURL: String?
    let categories: [Category]?
    let stats: Stats?
    let url: String?
    let price: Price?
    let likes: VenueLikes?
    let rating: Double?
    let ratingSignals: Int?
    let page: Page?
    let createdAt: Int?
    let tips: VenueTips?
    let shortURL: String?
    let listed: Listed?
    let hours: Hours?
    let bestPhoto: BestPhoto?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case contact = "contact"
        case locationDetails = "location"
        case canonicalURL = "canonicalUrl"
        case categories = "categories"
        case stats = "stats"
        case url = "url"
        case price = "price"
        case likes = "likes"
        case rating = "rating"
        case ratingSignals = "ratingSignals"
        case page = "page"
        case createdAt = "createdAt"
        case tips = "tips"
        case shortURL = "shortUrl"
        case listed = "listed"
        case hours = "hours"
        case bestPhoto = "bestPhoto"
    }
}

////////////////////////////////////////////////////////////////
/// Mark: - Venue's best photo
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
/// Mark: - Venue Contact Detail
////////////////////////////////////////////////////////////////

struct VenueContact: Codable {
    let phone: String?
    let formattedPhone: String?
    let twitter: String?
    let facebook: String?
    let facebookUsername: String?
    let facebookName: String?
    
    enum CodingKeys: String, CodingKey {
        case phone = "phone"
        case formattedPhone = "formattedPhone"
        case twitter = "twitter"
        case facebook = "facebook"
        case facebookUsername = "facebookUsername"
        case facebookName = "facebookName"
    }
}


////////////////////////////////////////////////////////////////
/// Mark: - Venue Likes Data
////////////////////////////////////////////////////////////////

struct VenueLikes: Codable {
    let count: Int?
    let groups: [LikesGroup]?
    let summary: String?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case groups = "groups"
        case summary = "summary"
    }
}

struct LikesGroup: Codable {
    let type: String?
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case count = "count"
    }
}

////////////////////////////////////////////////////////////////
/// Mark: - Curated lists that the venue is included in
////////////////////////////////////////////////////////////////

struct Listed: Codable {
    let count: Int?
    let groups: [ListedGroup]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case groups = "groups"
    }
}

struct ListedGroup: Codable {
    let type: String?
    let name: String?
    let count: Int?
    let items: [VenueListMembership]?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case name = "name"
        case count = "count"
        case items = "items"
    }
}

struct VenueListMembership: Codable {
    let id: String?
    let name: String?
    let description: String?
    let type: String?
    let url: String?
    let photo: ListDetailPhoto
    let canonicalURL: String?
    let followers: FollowersCount?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case type = "type"
        case url = "url"
        case canonicalURL = "canonicalUrl"
        case photo = "photo"
        case followers = "followers"
    }
}

struct FollowersCount: Codable {
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
    }
}

struct ListDetailPhoto: Codable {
    let id: String?
    let createdAt: Int?
    let prefix: String?
    let suffix: String?
    let width: Int?
    let height: Int?
    let visibility: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "createdAt"
        case prefix = "prefix"
        case suffix = "suffix"
        case width = "width"
        case height = "height"
        case visibility = "visibility"
    }
}

////////////////////////////////////////////////////////////////
/// Mark: - Venue Page Info
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
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case banner = "banner"
        case links = "links"
    }
}

struct Links: Codable {
    let count: Int?
    let items: [LinksItem]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case items = "items"
    }
}

struct LinksItem: Codable {
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}


////////////////////////////////////////////////////////////////
/// Mark: - Venue Pricing
////////////////////////////////////////////////////////////////

struct Price: Codable {
    let tier: Int?
    let message: String?
    let currency: String?
    
    enum CodingKeys: String, CodingKey {
        case tier = "tier"
        case message = "message"
        case currency = "currency"
    }
}

////////////////////////////////////////////////////////////////
/// Mark: - Venue Tips and Tip Likes
////////////////////////////////////////////////////////////////

struct VenueTips: Codable {
    let count: Int?
    let groups: [TipsGroup]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case groups = "groups"
    }
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

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case text = "text"
        case canonicalURL = "canonicalUrl"
        case likes = "likes"
    }
}

struct ItemLikes: Codable {
    let likeCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case likeCount = "count"
    }
}
