//
//  VenueControllerUPDATE.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/29/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation
import UIKit

class VenueControllerUpdate {
    
    
    struct Constants {
        static let baseUrl = URL(string: "https://api.foursquare.com/v2/")
        
        
    }
    
////////////////////////////////////////////////////////////////
/// Mark: - fetchVenues() by geolocation or by 'near' search.
////////////////////////////////////////////////////////////////
    
    static func fetchVenues(searchTerm: String?,
                            location: (Int, Int)?,
                            near: String?,
                            radius: Int?,
                            limit: Int?,
                            categories: String?,
                            completion: @escaping (([Venue]?)->Void)) {
        
        
    // Conversion of Ints to Strings
        
        var stringLocation = String()
        
        if location == nil && near == nil {
            return print("You need to allow access to Location Services or you can enter the name of an area to search!")
        }
        
        else if near == nil  {
            guard let unwrappedLocation = location else {
                return print("Something went wrong, please try again")
            }
            stringLocation = "\(unwrappedLocation.0)" + "," + "\(unwrappedLocation.1)"
        }
        
        
        guard let limit = limit else {
            print("limit failed to be converted to String in: \(#function)")
            return
        }
        let stringLimit = "\(limit)"
        
        
        guard let radius = radius else {
            print("radius failed to be converted to String in: \(#function)")
            return
        }
        let stringRadius = "\(radius)"
        
        
    // My Personal, Userless Authorization Keys
        let myClientID = "PF3WA3B11VANKXDEQECTSUAMHUWROKWC2G5HKCMY0PUGRIKW"
        let myClientSecret = "KULKA0VOZFYP4NIXKQZ2CHWFRMZRG03J1J3N0X4HTVXG3QPZ"
        let version = "20171010" /// Version of FourSquare Systems
        
    // URL Creation
        guard var url = VenueControllerUpdate.Constants.baseUrl else { completion(nil) ; return }
        url.appendPathComponent("venues")
        url.appendPathComponent("search")
        
    
    /// MARK: - QUERIES
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)

    /// Parameters and their Descriptions
    
        
    // "ll": Latitude and longitude of the user’s location.
        let locationQuery = URLQueryItem.init(name: "ll", value: stringLocation) /// Required unless "near" is provied.
        
    //"near": A string naming a place in the world. If the near string is not geocodable, returns a failed_geocode error.
        // Otherwise, searches within the bounds of the geocode and adds a geocode object to the response.
        let nearQuery = URLQueryItem.init(name: "near", value: near)  /// Required unless "ll" is provided.
        
    // "query": A term to be searched against a venue’s tips, category, etc.
        let searchTermQuery = URLQueryItem.init(name: "query", value: searchTerm) /// Has no effect when a section is specified.
        
    // "radius": Radius to search within, in meters.
        // If not specified, a suggested radius will be used based on the density of venues in the area.
        let radiusQuery = URLQueryItem.init(name: "radius", value: stringRadius) /// The maximum radius is 100,000 meters.
        
    // "limit": Number of results to return, up to 50.
        let limitQuery = URLQueryItem.init(name: "limit", value: stringLimit)
        
    // Array of categories applied to venue. One category will have a primary field to mark it as the primary category.
//        let category = URLQueryItem.init(name: "categoryId", value: categories) /// Possibly an empty array
        
    // My Personal, Userless Authorization Keys, they can be used to get all the data that matters
        let clientID = URLQueryItem.init(name: "client_id", value: myClientID) /// Be aware of limitations
        let clientSecret = URLQueryItem.init(name: "client_secret", value: myClientSecret) /// Check for restrictions
        let FSversionNumber = URLQueryItem.init(name: "v", value: version) /// Version of FourSquare Systems
        
    
        
        
        let queryArray = [searchTermQuery, radiusQuery, limitQuery, clientID, clientSecret, FSversionNumber, nearQuery]
        
//    // If "near" is nil, ignore nearQuery and only use locationQuery
//        if near == nil {
//            queryArray.removeLast()
//
//        }
//
//        if location == nil {
//            queryArray.removeFirst()
//
//        }
        
        components?.queryItems = queryArray
        
        
    // Fully constructed URL
        guard let finalUrl = components?.url else { completion(nil) ; return }
        print("📡📡📡  \(finalUrl.absoluteString)   📡📡📡")
        
    // Request
        var request = URLRequest(url: finalUrl)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
    /// Mark: - fetchVenues() dataTask
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error with dataTask at \(#function): \(error.localizedDescription) \(error)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil) ; return }
            do {
                let jsonDecoder = JSONDecoder()
                let topLevelData = try jsonDecoder.decode(TopLevelData.self, from: data)
                let venueTopLevelData = topLevelData.response
                let fetchedVenues = venueTopLevelData.venues
                completion(fetchedVenues)
                return
                
            } catch {
                print("Error decoding fetched Venues: \(error.localizedDescription) \(error)")
                completion(nil)
                return
            }
        }.resume()
        
    }
    
    
    
    
    
    
    
    
////////////////////////////////////////////////////////////////
/// Mark: - fetchVenueDetails()
////////////////////////////////////////////////////////////////
    
// Userless authenticators, (THAT MEANS US) will not receive hereNow information
    static func fetchVenueDetails(with VENUE_ID: String, completion: @escaping ((VenueDetails?)->Void)) {
        
    // My Personal, Userless Authorization Keys
        let myClientID = "PF3WA3B11VANKXDEQECTSUAMHUWROKWC2G5HKCMY0PUGRIKW"
        let myClientSecret = "KULKA0VOZFYP4NIXKQZ2CHWFRMZRG03J1J3N0X4HTVXG3QPZ"
        let version = "20171010" /// Version of FourSquare Systems
        
    // URL
        guard var url = VenueControllerUpdate.Constants.baseUrl else { completion(nil) ; return }
        url.appendPathComponent("venues")
        url.appendPathComponent(VENUE_ID)
    
        
    /// QUERIES
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let clientID = URLQueryItem.init(name: "client_id", value: myClientID) /// Be aware of limitations
        let clientSecret = URLQueryItem.init(name: "client_secret", value: myClientSecret) /// Check for restrictions
        let FSversionNumber = URLQueryItem.init(name: "v", value: version) /// Version of FourSquare Systems
        
        let queryArray = [clientID, clientSecret, FSversionNumber]
        
        components?.queryItems = queryArray
        
        
    // Fully constructed URL
        guard let finalUrl = components?.url else { completion(nil) ; return }
        print("📡📡📡  \(finalUrl.absoluteString)   📡📡📡")
        
    // Request
        var request = URLRequest(url: finalUrl)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
    /// DataTask
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error with dataTask at \(#function): \(error.localizedDescription) \(error)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil) ; return }
             let jsonDecoder = JSONDecoder()
            do {
                let topLevelData = try jsonDecoder.decode(TopLevelData.self, from: data)
                let venueTopLevelData = topLevelData.response
                let fetchedVenueDetails = venueTopLevelData.venueDetails
                completion(fetchedVenueDetails)
                return
                
            } catch {
                print("Error decoding fetched Details for Venue: \(error.localizedDescription) \(error)")
                completion(nil)
                return
            }
        } .resume()
        
    }
    
    

    
    

    
    
    
    
    
    
    
////////////////////////////////////////////////////////////////
/// Mark: - exploreRecommendedVenues()
////////////////////////////////////////////////////////////////

    enum venueSectionMarker: String {
        case food = "food"
        case drinks = "drinks"
        case coffee = "coffee"
        case shops = "shops"
        case arts = "arts"
        case outdoors = "outdoors"
        case sights = "sights"
        case trending = "trending"
        case nextVenues = "nextVenues"
    }
    
    enum pricePoint: String {
        case price1 = "1"
        case price2 = "2"
        case price3 = "3"
        case price4 = "4"
    }
    
    static func exploreRecommendedVenues(searchTerm: String?,
                                       location: (Int, Int)?,
                                       near: String?,
                                       radius: String?,
                                       section: venueSectionMarker?,
                                       limit: Int?,
                                       sortByDistance: Int?,
                                       price: pricePoint?, // price items can be comma separated to find venues in range of prices
                                       category: String?,
                                       completion: @escaping (([Venue]?)->Void)) {
    // Nil Checks on required params
        if location == nil && near == nil {
            return print("You need to allow access to Location Services or you can enter the name of an area to search!")
        }
        guard let unwrappedLocation = location else {
            return
        }
        
        
        // Conversion of Ints to Strings
        let stringLocation = String(unwrappedLocation.0) + "," + String(unwrappedLocation.1)
        let stringLimit = "\(String(describing: limit))"
        let stringRadius = "\(String(describing: radius))"
        let stringSection = "\(String(describing: section))"
        
        
    // My Personal, Userless Authorization Keys
        let myClientID = "PF3WA3B11VANKXDEQECTSUAMHUWROKWC2G5HKCMY0PUGRIKW"
        let myClientSecret = "KULKA0VOZFYP4NIXKQZ2CHWFRMZRG03J1J3N0X4HTVXG3QPZ"
        let version = "20171010" /// Version of FourSquare Systems
        
        
    // URL
        guard var url = VenueControllerUpdate.Constants.baseUrl else { completion(nil) ; return }
        url.appendPathComponent("venues")
        url.appendPathComponent("explore")
        
        
    /// QUERIES
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
    
    // Location and main filter
        let nearQuery = URLQueryItem.init(name: "near", value: near)  /// Required unless "ll" is provided.
        let locationQuery = URLQueryItem.init(name: "ll", value: stringLocation) /// Required unless "near" is provied.
        let searchTermQuery = URLQueryItem.init(name: "query", value: searchTerm) // Has no effect when a section is specified.
        let radiusQuery = URLQueryItem.init(name: "radius", value: stringRadius) // Geo Radius in meters
    
    // One of the venueSectionMarker enum cases
        let sectionQuery = URLQueryItem.init(name: "section", value: stringSection) /// limits results to specified category or property.
        
    // Pagination and data per call
        let limitQuery = URLQueryItem.init(name: "limit", value: stringLimit) // Limiting number of results
        let offSetQuery = URLQueryItem.init(name: "offset", value: "20") // Used to page through results, up to 50.
        
    // Boolean flag to only include venues that are open now.
        //This prefers official provider hours but falls back to popular check-in hours.
        let openNowQuery = URLQueryItem.init(name: "openNow", value: "1") /// Only show open venues
        
    // Boolean flag to only include venues that are open now.
        //This prefers official provider hours but falls back to popular check-in hours.
        let sortByDistanceQuery = URLQueryItem.init(name: "sortByDistance", value: "1") // Sort by distance
        
    // For the complete category tree, see categories: https://developer.foursquare.com/docs/resources/categories
        let categoryQuery = URLQueryItem.init(name: "categoryId", value: category)
        
    // Auth Keys
        let clientID = URLQueryItem.init(name: "client_id", value: myClientID)
        let clientSecret = URLQueryItem.init(name: "client_secret", value: myClientSecret)
        let FSversionNumber = URLQueryItem.init(name: "v", value: version) /// Version of FourSquare Systems
        
        var queryArray = [nearQuery, locationQuery, searchTermQuery, radiusQuery, sectionQuery, limitQuery, offSetQuery, openNowQuery, sortByDistanceQuery, categoryQuery, clientID, clientSecret, FSversionNumber]
        
    // If 'near' nil, use 'll' location instead
        if near == nil {
            queryArray.removeFirst()
        }
        
        components?.queryItems = queryArray
        
    // Fully constructed URL
        guard let finalUrl = components?.url else { completion(nil) ; return }
        print("📡📡📡  \(finalUrl.absoluteString)   📡📡📡")
        
    // Request
        var request = URLRequest(url: finalUrl)
        request.httpMethod = "GET"
        request.httpBody = nil
        
    
    /// DataTask
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error with dataTask at \(#function): \(error.localizedDescription) \(error)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil) ; return }
            do {
                let jsonDecoder = JSONDecoder()
                let topLevelData = try jsonDecoder.decode(TopLevelData.self, from: data)
                let venueTopLevelData = topLevelData.response
                let recommendedVenues = venueTopLevelData.venues
                completion(recommendedVenues)
                return
                
            } catch {
                print("Error decoding fetched Venues: \(error.localizedDescription) \(error)")
                completion(nil)
                return
            }
        }.resume()
        
    }
}
