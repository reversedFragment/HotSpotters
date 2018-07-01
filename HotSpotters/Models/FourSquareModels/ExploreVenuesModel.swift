////
////  ExploreVenuesModel.swift
////  HotSpotters
////
////  Created by Ben Adams on 6/30/18.
////  Copyright © 2018 Ben Adams. All rights reserved.
////
//
//
//// Need to check for ways to make this private before I spend time merging structs
//
//import Foundation
//
//struct RecommendedTopLevelData: Codable {
//    let meta: Meta?
//    let notifications: [Notification]?
//    let response: Response?
//    
//    enum CodingKeys: String, CodingKey {
//        case meta = "meta"
//        case notifications = "notifications"
//        case response = "response"
//    }
//}
//
//struct Response: Codable {
//    let warning: Warning?
//    let suggestedRadius: Int?
//    let suggestedFilters: SuggestedFilters?
//    let geocode: Geocode?
//    let headerLocation: String?
//    let headerFullLocation: String?
//    let headerLocationGranularity: String?
//    let totalResults: Int?
//    let suggestedBounds: Bounds?
//    let groups: [ResponseGroup]?
//    
//    enum CodingKeys: String, CodingKey {
//        case warning = "warning"
//        case suggestedRadius = "suggestedRadius"
//        case suggestedFilters = "suggestedFilters"
//        case geocode = "geocode"
//        case headerLocation = "headerLocation"
//        case headerFullLocation = "headerFullLocation"
//        case headerLocationGranularity = "headerLocationGranularity"
//        case totalResults = "totalResults"
//        case suggestedBounds = "suggestedBounds"
//        case groups = "groups"
//    }
//}
//
//struct Geocode: Codable {
//    let what: String?
//    let geocodeWhere: String?
//    let center: Center?
//    let displayString: String?
//    let cc: String?
//    let geometry: Geometry?
//    let slug: String?
//    let longID: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case what = "what"
//        case geocodeWhere = "where"
//        case center = "center"
//        case displayString = "displayString"
//        case cc = "cc"
//        case geometry = "geometry"
//        case slug = "slug"
//        case longID = "longId"
//    }
//}
//
//struct Center: Codable {
//    let lat: Double?
//    let lng: Double?
//    
//    enum CodingKeys: String, CodingKey {
//        case lat = "lat"
//        case lng = "lng"
//    }
//}
//
//struct Geometry: Codable {
//    let bounds: Bounds?
//
//    enum CodingKeys: String, CodingKey {
//        case bounds = "bounds"
//    }
//}
//
//struct Bounds: Codable {
//    let ne: Center?
//    let sw: Center?
//
//    enum CodingKeys: String, CodingKey {
//        case ne = "ne"
//        case sw = "sw"
//    }
//}
//
//struct ResponseGroup: Codable {
//    let type: String?
//    let name: String?
//    let items: [GroupItem]?
//
//    enum CodingKeys: String, CodingKey {
//        case type = "type"
//        case name = "name"
//        case items = "items"
//    }
//}
//
//struct GroupItem: Codable {
//    let reasons: Reasons?
//    let venue: ItemVenue?
//    let tips: [Tip]?
//    let referralID: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case reasons = "reasons"
//        case venue = "venue"
//        case tips = "tips"
//        case referralID = "referralId"
//    }
//}
//
//struct Reasons: Codable {
//    let count: Int?
//    let items: [ReasonsItem]?
//    
//    enum CodingKeys: String, CodingKey {
//        case count = "count"
//        case items = "items"
//    }
//}
//
//struct ReasonsItem: Codable {
//    let summary: ItemSummary?
//    let type: ItemType?
//    let reasonName: ReasonName?
//    
//    enum CodingKeys: String, CodingKey {
//        case summary = "summary"
//        case type = "type"
//        case reasonName = "reasonName"
//    }
//}
//
//enum ReasonName: String, Codable {
//    case globalInteractionReason = "globalInteractionReason"
//}
//
//enum ItemSummary: String, Codable {
//    case thisSpotIsPopular = "This spot is popular"
//}
//
//enum ItemType: String, Codable {
//    case general = "general"
//}
//
//struct Tip: Codable {
//    let id: String?
//    let createdAt: Int?
//    let text: String?
//    let type: TipType?
//    let canonicalURL: String?
//    let photo: TipPhoto?
//    let photourl: String?
//    let likes: Likes?
//    let logView: Bool?
//    let agreeCount: Int?
//    let disagreeCount: Int?
//    let lastVoteText: String?
//    let lastUpvoteTimestamp: Int?
//    let todo: Todo?
//    let user: User?
//    let url: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case createdAt = "createdAt"
//        case text = "text"
//        case type = "type"
//        case canonicalURL = "canonicalUrl"
//        case photo = "photo"
//        case photourl = "photourl"
//        case likes = "likes"
//        case logView = "logView"
//        case agreeCount = "agreeCount"
//        case disagreeCount = "disagreeCount"
//        case lastVoteText = "lastVoteText"
//        case lastUpvoteTimestamp = "lastUpvoteTimestamp"
//        case todo = "todo"
//        case user = "user"
//        case url = "url"
//    }
//}
//
//struct Likes: Codable {
//    let count: Int?
//    let groups: [JSONAny]?
//    let summary: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case count = "count"
//        case groups = "groups"
//        case summary = "summary"
//    }
//}
//
//struct TipPhoto: Codable {
//    let id: String?
//    let createdAt: Int?
//    let source: Source?
//    let photoPrefix: String?
//    let suffix: String?
//    let width: Int?
//    let height: Int?
//    let visibility: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case createdAt = "createdAt"
//        case source = "source"
//        case photoPrefix = "prefix"
//        case suffix = "suffix"
//        case width = "width"
//        case height = "height"
//        case visibility = "visibility"
//    }
//}
//
//struct Source: Codable {
//    let name: String?
//    let url: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case url = "url"
//    }
//}
//
//struct Todo: Codable {
//    let count: Int?
//    
//    enum CodingKeys: String, CodingKey {
//        case count = "count"
//    }
//}
//
//enum TipType: String, Codable {
//    case user = "user"
//}
//
//struct User: Codable {
//    let id: String?
//    let firstName: String?
//    let gender: Gender?
//    let photo: UserPhoto?
//    let type: UserType?
//    let lastName: String?
//    let venue: VenuePageClass?
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case firstName = "firstName"
//        case gender = "gender"
//        case photo = "photo"
//        case type = "type"
//        case lastName = "lastName"
//        case venue = "venue"
//    }
//}
//
//enum Gender: String, Codable {
//    case female = "female"
//    case male = "male"
//    case none = "none"
//}
//
//struct UserPhoto: Codable {
//    let photoPrefix: Prefix?
//    let suffix: String?
//    let photoDefault: Bool?
//    
//    enum CodingKeys: String, CodingKey {
//        case photoPrefix = "prefix"
//        case suffix = "suffix"
//        case photoDefault = "default"
//    }
//}
//
//enum Prefix: String, Codable {
//    case httpsIgx4SqiNetImgUser = "https://igx.4sqi.net/img/user/"
//}
//
//enum UserType: String, Codable {
//    case chain = "chain"
//    case page = "page"
//    case venuePage = "venuePage"
//}
//
//struct VenuePageClass: Codable {
//    let id: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//    }
//}
//
//struct ItemVenue: Codable {
//    let id: String?
//    let name: String?
//    let contact: Contact?
//    let location: Location?
//    let categories: [Category]?
//    let verified: Bool?
//    let stats: Stats?
//    let url: String?
//    let rating: Double?
//    let ratingColor: RatingColor?
//    let ratingSignals: Int?
//    let beenHere: BeenHere?
//    let hours: Hours?
//    let photos: Photos?
//    let storeID: StoreID?
//    let hereNow: HereNow?
//    let price: Price?
//    let hasMenu: Bool?
//    let menu: Menu?
//    let allowMenuURLEdit: Bool?
//    let delivery: Delivery?
//    let venuePage: VenuePageClass?
//    let venueRatingBlacklisted: Bool?
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case contact = "contact"
//        case location = "location"
//        case categories = "categories"
//        case verified = "verified"
//        case stats = "stats"
//        case url = "url"
//        case rating = "rating"
//        case ratingColor = "ratingColor"
//        case ratingSignals = "ratingSignals"
//        case beenHere = "beenHere"
//        case hours = "hours"
//        case photos = "photos"
//        case storeID = "storeId"
//        case hereNow = "hereNow"
//        case price = "price"
//        case hasMenu = "hasMenu"
//        case menu = "menu"
//        case allowMenuURLEdit = "allowMenuUrlEdit"
//        case delivery = "delivery"
//        case venuePage = "venuePage"
//        case venueRatingBlacklisted = "venueRatingBlacklisted"
//    }
//}
//
//struct BeenHere: Codable {
//    let count: Int?
//    let marked: Bool?
//    let lastCheckinExpiredAt: Int?
//    
//    enum CodingKeys: String, CodingKey {
//        case count = "count"
//        case marked = "marked"
//        case lastCheckinExpiredAt = "lastCheckinExpiredAt"
//    }
//}
//
//struct Category: Codable {
//    let id: String?
//    let name: String?
//    let pluralName: String?
//    let shortName: String?
//    let icon: CategoryIcon?
//    let primary: Bool?
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case pluralName = "pluralName"
//        case shortName = "shortName"
//        case icon = "icon"
//        case primary = "primary"
//    }
//}
//
//struct CategoryIcon: Codable {
//    let iconPrefix: String?
//    let suffix: Suffix?
//
//    enum CodingKeys: String, CodingKey {
//        case iconPrefix = "prefix"
//        case suffix = "suffix"
//    }
//}
//
//enum Suffix: String, Codable {
//    case png = ".png"
//}
//
//struct Contact: Codable {
//    let phone: String?
//    let formattedPhone: String?
//    let twitter: String?
//    let instagram: String?
//    let facebook: String?
//    let facebookUsername: String?
//    let facebookName: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case phone = "phone"
//        case formattedPhone = "formattedPhone"
//        case twitter = "twitter"
//        case instagram = "instagram"
//        case facebook = "facebook"
//        case facebookUsername = "facebookUsername"
//        case facebookName = "facebookName"
//    }
//}
//
//struct Delivery: Codable {
//    let id: String?
//    let url: String?
//    let provider: Provider?
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case url = "url"
//        case provider = "provider"
//    }
//}
//
//struct Provider: Codable {
//    let name: String?
//    let icon: ProviderIcon?
//    
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case icon = "icon"
//    }
//}
//
//struct ProviderIcon: Codable {
//    let iconPrefix: String?
//    let sizes: [Int]?
//    let name: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case iconPrefix = "prefix"
//        case sizes = "sizes"
//        case name = "name"
//    }
//}
//
//struct HereNow: Codable {
//    let count: Int?
//    let summary: HereNowSummary?
//    let groups: [HereNowGroup]?
//
//    enum CodingKeys: String, CodingKey {
//        case count = "count"
//        case summary = "summary"
//        case groups = "groups"
//    }
//}
//
//struct HereNowGroup: Codable {
//    let type: String?
//    let name: String?
//    let count: Int?
//    let items: [JSONAny]?
//
//    enum CodingKeys: String, CodingKey {
//        case type = "type"
//        case name = "name"
//        case count = "count"
//        case items = "items"
//    }
//}
//
//enum HereNowSummary: String, Codable {
//    case nobodyHere = "Nobody here"
//    case oneOtherPersonIsHere = "One other person is here"
//    case the2PeopleAreHere = "2 people are here"
//}
//
//struct Hours: Codable {
//    let status: String?
//    let richStatus: RichStatus?
//    let isOpen: Bool?
//    let isLocalHoliday: Bool?
//    
//    enum CodingKeys: String, CodingKey {
//        case status = "status"
//        case richStatus = "richStatus"
//        case isOpen = "isOpen"
//        case isLocalHoliday = "isLocalHoliday"
//    }
//}
//
//struct RichStatus: Codable {
//    let entities: [JSONAny]?
//    let text: String?
//
//    enum CodingKeys: String, CodingKey {
//        case entities = "entities"
//        case text = "text"
//    }
//}
//
//struct Location: Codable {
//    let address: String?
//    let crossStreet: String?
//    let lat: Double?
//    let lng: Double?
//    let labeledLatLngs: [LabeledLatLng]?
//    let postalCode: String?
//    let cc: Cc?
//    let city: City?
//    let state: State?
//    let country: Country?
//    let formattedAddress: [String]?
//    let neighborhood: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case address = "address"
//        case crossStreet = "crossStreet"
//        case lat = "lat"
//        case lng = "lng"
//        case labeledLatLngs = "labeledLatLngs"
//        case postalCode = "postalCode"
//        case cc = "cc"
//        case city = "city"
//        case state = "state"
//        case country = "country"
//        case formattedAddress = "formattedAddress"
//        case neighborhood = "neighborhood"
//    }
//}
//
//enum Cc: String, Codable {
//    case us = "US"
//}
//
//enum City: String, Codable {
//    case brooklyn = "Brooklyn"
//    case newYork = "New York"
//    case queens = "Queens"
//}
//
//enum Country: String, Codable {
//    case unitedStates = "United States"
//}
//
//struct LabeledLatLng: Codable {
//    let label: Label?
//    let lat: Double?
//    let lng: Double?
//    
//    enum CodingKeys: String, CodingKey {
//        case label = "label"
//        case lat = "lat"
//        case lng = "lng"
//    }
//}
//
//enum Label: String, Codable {
//    case display = "display"
//}
//
//enum State: String, Codable {
//    case ny = "NY"
//}
//
//struct Menu: Codable {
//    let type: String?
//    let label: String?
//    let anchor: String?
//    let url: String?
//    let mobileURL: String?
//    let externalURL: String?
//
//    enum CodingKeys: String, CodingKey {
//        case type = "type"
//        case label = "label"
//        case anchor = "anchor"
//        case url = "url"
//        case mobileURL = "mobileUrl"
//        case externalURL = "externalUrl"
//    }
//}
//
//struct Photos: Codable {
//    let count: Int?
//    let groups: [JSONAny]?
//
//    enum CodingKeys: String, CodingKey {
//        case count = "count"
//        case groups = "groups"
//    }
//}
//
//struct Price: Codable {
//    let tier: Int?
//    let message: String?
//    let currency: String?
//
//    enum CodingKeys: String, CodingKey {
//        case tier = "tier"
//        case message = "message"
//        case currency = "currency"
//    }
//}
//
//enum RatingColor: String, Codable {
//    case the00B551 = "00B551"
//}
//
//struct Stats: Codable {
//    let tipCount: Int?
//    let usersCount: Int?
//    let checkinsCount: Int?
//    
//    enum CodingKeys: String, CodingKey {
//        case tipCount = "tipCount"
//        case usersCount = "usersCount"
//        case checkinsCount = "checkinsCount"
//    }
//}
//
//enum StoreID: String, Codable {
//    case empty = ""
//    case sc = "SC"
//}
//
//struct SuggestedFilters: Codable {
//    let header: String?
//    let filters: [Filter]?
//    
//    enum CodingKeys: String, CodingKey {
//        case header = "header"
//        case filters = "filters"
//    }
//}
//
//struct Filter: Codable {
//    let name: String?
//    let key: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case key = "key"
//    }
//}
