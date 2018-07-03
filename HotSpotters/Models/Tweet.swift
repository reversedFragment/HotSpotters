//
//  Tweet.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 6/26/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

struct TweetsDictionary: Codable {
    let tweets: [Tweet]
    
    enum CodingKeys: String, CodingKey {
        case tweets = "statuses"
    }
}

struct Tweet: Codable {
    let createdAt: String
    let tweetID: Int
    let body: String
    let truncated: Bool
    //    let entities: StatusEntities
    //    let metadata: Metadata
    //    let user: User
    //    let coordinates: Coordinates?
    //    let place: Place?
    //    let retweetedStatus: RetweetedStatus?
    let isQuoteStatus: Bool
    let retweetCount, favoriteCount: Int
    let lang: String
    let quotedStatusID: Int?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case tweetID = "id"
        case body = "text"
        case truncated //, entities, metadata, user, coordinates, place
        //        case retweetedStatus = "retweeted_status"
        case isQuoteStatus = "is_quote_status"
        case retweetCount = "retweet_count"
        case favoriteCount = "favorite_count"
        case lang
        case quotedStatusID = "quoted_status_id"
    }
}
//
//struct StatusEntities: Codable {
//    let hashtags: [Hashtag]
//    let userMentions: [UserMention]
//    let urls: [URL]
//    let media: [EntitiesMedia]?
//
//    struct Hashtag: Codable {
//        let text: String
//    }
//
//    struct UserMention: Codable {
//        let screenName, name: String
//        let id: Int
//        let idStr: String
//        let indices: [Int]
//
//        enum CodingKeys: String, CodingKey {
//            case screenName = "screen_name"
//            case name, id
//            case idStr = "id_str"
//            case indices
//        }
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case hashtags
//        case userMentions = "user_mentions"
//        case urls, media
//    }
//}
//
//struct Coordinates: Codable {
//    let coordinates: [Double]
//}
//
//struct Place: Codable {
//
//    let boudingBox: BoundingBox
//    let country: String
//    let fullName: String
//    let placeType: String
//
//    enum CodingKeys: String, CodingKey {
//        case boudingBox = "bounding_box"
//        case country = "country"
//        case fullName = "full_name"
//        case placeType = "place_type"
//
//    }
//
//    struct BoundingBox: Codable {
//        let coordinates: [[[Double]]]
//    }
//}
//
//struct EntitiesMedia: Codable {
//    let id: Int
//    let idStr: String
//    let indices: [Int]
//    let mediaURL, mediaURLHTTPS, url, displayURL: String
//    let expandedURL, type: String
//    let sizes: Sizes
//    let sourceStatusID: Int?
//    let sourceStatusIDStr: String?
//    let sourceUserID: Int?
//    let sourceUserIDStr: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case idStr = "id_str"
//        case indices
//        case mediaURL = "media_url"
//        case mediaURLHTTPS = "media_url_https"
//        case url
//        case displayURL = "display_url"
//        case expandedURL = "expanded_url"
//        case type, sizes
//        case sourceStatusID = "source_status_id"
//        case sourceStatusIDStr = "source_status_id_str"
//        case sourceUserID = "source_user_id"
//        case sourceUserIDStr = "source_user_id_str"
//    }
//}
//
//struct Sizes: Codable {
//    let thumb, medium, small, large: Large
//}
//
//struct Large: Codable {
//    let w, h: Int
//    let resize: Resize
//}
//
//enum Resize: String, Codable {
//    case crop = "crop"
//    case fit = "fit"
//}
//
//struct URL: Codable {
//    let url, expandedURL, displayURL: String
//    let indices: [Int]
//
//    enum CodingKeys: String, CodingKey {
//        case url
//        case expandedURL = "expanded_url"
//        case displayURL = "display_url"
//        case indices
//    }
//}
//
//
//
//struct Metadata: Codable {
//    let isoLanguageCode: String
//    let resultType: ResultType
//
//    enum CodingKeys: String, CodingKey {
//        case isoLanguageCode = "iso_language_code"
//        case resultType = "result_type"
//    }
//}
//
enum ResultType: String, Codable {
    case recent = "recent"
    case popular = "popular"
}
//
//struct RetweetedStatus: Codable {
//    let createdAt: String
//    let id: Int
//    let idStr, text: String
//    let truncated: Bool
//    let entities: StatusEntities
//    let metadata: Metadata
//    let source: String
//    let inReplyToStatusID: Int?
//    let inReplyToStatusIDStr: String?
//    let inReplyToUserID: Int?
//    let inReplyToUserIDStr, inReplyToScreenName: String?
//    let user: User
//    let isQuoteStatus: Bool
//    let retweetCount, favoriteCount: Int
//    let favorited, retweeted: Bool
//    let lang: String
//    let extendedEntities: RetweetedStatusExtendedEntities?
//    let possiblySensitive: Bool?
//    let quotedStatusID: Int?
//    let quotedStatusIDStr: String?
//    let quotedStatus: QuotedStatus?
//
//    enum CodingKeys: String, CodingKey {
//        case createdAt = "created_at"
//        case id
//        case idStr = "id_str"
//        case text, truncated, entities, metadata, source
//        case inReplyToStatusID = "in_reply_to_status_id"
//        case inReplyToStatusIDStr = "in_reply_to_status_id_str"
//        case inReplyToUserID = "in_reply_to_user_id"
//        case inReplyToUserIDStr = "in_reply_to_user_id_str"
//        case inReplyToScreenName = "in_reply_to_screen_name"
//        case isQuoteStatus = "is_quote_status"
//        case retweetCount = "retweet_count"
//        case favoriteCount = "favorite_count"
//        case favorited, retweeted, lang
//        case extendedEntities = "extended_entities"
//        case possiblySensitive = "possibly_sensitive"
//        case quotedStatusID = "quoted_status_id"
//        case quotedStatusIDStr = "quoted_status_id_str"
//        case quotedStatus = "quoted_status"
//    }
//}
//
//struct RetweetedStatusExtendedEntities: Codable {
//    let media: [PurpleMedia]
//}
//
//struct PurpleMedia: Codable {
//    let id: Int
//    let indices: [Int]
//    let mediaURL, mediaURLHTTPS, url, displayURL: String
//    let expandedURL, type: String
//    let sizes: Sizes
//    let sourceStatusID: Int
//    let sourceStatusIDStr: String
//    let sourceUserID: Int
//    let sourceUserIDStr: String
//    let videoInfo: VideoInfo?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case indices
//        case mediaURL = "media_url"
//        case mediaURLHTTPS = "media_url_https"
//        case url
//        case displayURL = "display_url"
//        case expandedURL = "expanded_url"
//        case type, sizes
//        case sourceStatusID = "source_status_id"
//        case sourceStatusIDStr = "source_status_id_str"
//        case sourceUserID = "source_user_id"
//        case sourceUserIDStr = "source_user_id_str"
//        case videoInfo = "video_info"
//    }
//
//    struct VideoInfo: Codable {
//        let aspectRatio: [Int]
//        let durationMillis: Int
//        let variants: [Variant]
//
//        enum CodingKeys: String, CodingKey {
//            case aspectRatio = "aspect_ratio"
//            case durationMillis = "duration_millis"
//            case variants
//        }
//
//        struct Variant: Codable {
//            let bitrate: Int?
//            let contentType, url: String
//
//            enum CodingKeys: String, CodingKey {
//                case bitrate
//                case contentType = "content_type"
//                case url
//            }
//        }
//    }
//}
//
//struct QuotedStatus: Codable {
//    let createdAt: String
//    let id: Int
//    let idStr, text: String
//    let truncated: Bool
//    let entities: StatusEntities
//    let metadata: Metadata
//    let source: String
//    let inReplyToStatusID, inReplyToStatusIDStr, inReplyToUserID, inReplyToUserIDStr: JSONNull?
//    let inReplyToScreenName: JSONNull?
//    let user: User
//    let geo, coordinates, place, contributors: JSONNull?
//    let isQuoteStatus: Bool
//    let retweetCount, favoriteCount: Int
//    let favorited, retweeted: Bool
//    let lang: String
//    let extendedEntities: QuotedStatusExtendedEntities?
//    let possiblySensitive: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case createdAt = "created_at"
//        case id
//        case idStr = "id_str"
//        case text, truncated, entities, metadata, source
//        case inReplyToStatusID = "in_reply_to_status_id"
//        case inReplyToStatusIDStr = "in_reply_to_status_id_str"
//        case inReplyToUserID = "in_reply_to_user_id"
//        case inReplyToUserIDStr = "in_reply_to_user_id_str"
//        case inReplyToScreenName = "in_reply_to_screen_name"
//        case user, geo, coordinates, place, contributors
//        case isQuoteStatus = "is_quote_status"
//        case retweetCount = "retweet_count"
//        case favoriteCount = "favorite_count"
//        case favorited, retweeted, lang
//        case extendedEntities = "extended_entities"
//        case possiblySensitive = "possibly_sensitive"
//    }
//}
//
//struct QuotedStatusExtendedEntities: Codable {
//    let media: [FluffyMedia]
//}
//
//struct FluffyMedia: Codable {
//    let id: Int
//    let idStr: String
//    let indices: [Int]
//    let mediaURL, mediaURLHTTPS, url, displayURL: String
//    let expandedURL, type: String
//    let sizes: Sizes
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case idStr = "id_str"
//        case indices
//        case mediaURL = "media_url"
//        case mediaURLHTTPS = "media_url_https"
//        case url
//        case displayURL = "display_url"
//        case expandedURL = "expanded_url"
//        case type, sizes
//    }
//}



