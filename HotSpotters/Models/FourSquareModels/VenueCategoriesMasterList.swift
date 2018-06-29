//
//  VenueCategoriesMasterList
//  HotSpotters
//
//  Created by Ben Adams on 6/27/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

struct MainCategories: Codable {
    let id: String
    let name: String
    let pluralName: String
    let shortName: String
    let icon: MainIcon
    let categories: [subCategory]
}

struct subCategory: Codable {
    let id: String
    let name: String
    let pluralName: String
    let shortName: String
    let icon: MainIcon
    let categories: [x2subCategory]
}

struct x2subCategory: Codable {
    let id: String
    let name: String
    let pluralName: String
    let shortName: String
    let icon: MainIcon
    let categories: [x3subCategory]
}

struct x3subCategory: Codable {
    let id: String
    let name: String
    let pluralName: String
    let shortName: String
    let icon: MainIcon
    let categories: [x4subCategory]
}

struct x4subCategory: Codable {
    let id: String
    let name: String
    let pluralName: String
    let shortName: String
    let icon: AltIcon
}

struct MainIcon: Codable {
    let iconPrefix: String
    let suffix: Suffix
}

struct AltIcon: Codable {
    let prefix: String
    let suffix: Suffix
}

