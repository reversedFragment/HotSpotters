//
//  VenueController.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/26/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

class VenueController {

    static var trendingVenueList: [Venue] = []
//    static var venueDetailsList
    static var venueHoursList: [HoursTimeframe] = []
    

    // Client Auth ID (Specific to our App)
    static let client = FoursquareAPIClient(clientId: "PF3WA3B11VANKXDEQECTSUAMHUWROKWC2G5HKCMY0PUGRIKW",
                                 clientSecret: "KULKA0VOZFYP4NIXKQZ2CHWFRMZRG03J1J3N0X4HTVXG3QPZ")

    // User Location parameters with Mock Data
    static var venueID = "49eeaf08f964a52078681fe3"
    
    static let basicLocationParameter: [String: String] = [
    // Can also take geocoordinates of user location or selected location as query
        // parameter instead of "near", but not both.
    "near": "SLC",
    "limit": "50",
//    "radius": "10000",
//    "query": "DevMountain"
        ];

    
    ////////////////////////////////////////////////////////////////
    /// Mark: - Fetch Functions
    ////////////////////////////////////////////////////////////////
    
    /// Mark: - General Venue Fetch

    static func fetchVenues(parameter: [String : String]) {
        client.request(path: "venues/search", parameter: parameter ) { result in
            switch result {
            case let .success(data):
                do {
                let jsonDecoder = JSONDecoder()
                let topLevelData = try jsonDecoder.decode(TopLevelData.self, from: data)
                let venueTopLevelData = topLevelData.response
                let fetchedVenues = venueTopLevelData.venues
                    guard let venueList = fetchedVenues else {
                        print("VenueList returned Nil in fetchVenues() function")
                        return
                    }
                FourSquareTableViewController.shared.fetchedVenueList = venueList
//                print(self.venueList.map{$0.name})
            
            } catch {
                print("Error decoding venueList: \(error.localizedDescription)")
            }
                
            case let .failure(error):
                // Error handling
                switch error {
                case let .connectionError(connectionError):
                    print(connectionError)
                case let .responseParseError(responseParseError):
                    print(responseParseError)   // e.g. JSON text did not start with array or object and option to allow fragments not set.
                case let .apiError(apiError):
                    print(apiError.errorType)   // e.g. endpoint_error
                    print(apiError.errorDetail) // e.g. The requested path does not exist.
                }
            }
        }
    }
    
    
     /// Mark: - Venue Hours Fetch
         // Needs to have a VENUE_ID from pulled venues
    
    static func fetchHours (for venueID: String) {
        client.request(path: "venues/\(venueID)/hours", parameter: basicLocationParameter) { result in
            switch result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
                do {
                    let topLevelData = try jsonDecoder.decode(TopLevelData.self, from: data)
                    let venueTopLevelData = topLevelData.response
                    let venueHours = venueTopLevelData.hours
                    guard let venueHoursList = venueHours?.timeframes else {
                        print("venueTimeFrames returned nil:")
                        return
                    }
                    self.venueHoursList = venueHoursList
                    print(self.venueHoursList)
                    
                } catch {
                    print("Error decoding venue hours: \(error.localizedDescription)")
                }

            case let .failure(error):
                // Error handling
                switch error {
                case let .connectionError(connectionError):
                    print(connectionError)
                case let .responseParseError(responseParseError):
                    print(responseParseError)   // e.g. JSON text did not start with array or object and option to allow fragments not set.
                case let .apiError(apiError):
                    print(apiError.errorType)   // e.g. endpoint_error
                    print(apiError.errorDetail) // e.g. The requested path does not exist.
                }
            }
        }
    }
    
    
    /// Mark: - Trending Venues Fetch
    
    static func fetchTrendingVenues() {
        client.request(path: "venues/trending", parameter: basicLocationParameter) { result in
            switch result {
            case let .success(data):
                // parse the JSON data with NSJSONSerialization or Lib like SwiftyJson
                // e.g. {"meta":{"code":200},"notifications":[{"...
                let jsonDecoder = JSONDecoder()
                do {
                    let topLevelData = try jsonDecoder.decode(TopLevelData.self, from: data)
                    let venueTopLevelData = topLevelData.response
                    let fetchedVenues = venueTopLevelData.venues
                    guard let trendingVenueList = fetchedVenues else {
                        print("TrendingVenueList returned nil from fetchTrendingVenues() func")
                        return
                    }
                    self.trendingVenueList = trendingVenueList
                    print(self.trendingVenueList.map{$0.name})
                } catch {
                    print("Error decoding venueList: \(error.localizedDescription)")
                }
                
            case let .failure(error):
                // Error handling
                switch error {
                case let .connectionError(connectionError):
                    print(connectionError)
                case let .responseParseError(responseParseError):
                    print(responseParseError)   // e.g. JSON text did not start with array or object and option to allow fragments not set.
                case let .apiError(apiError):
                    print(apiError.errorType)   // e.g. endpoint_error
                    print(apiError.errorDetail) // e.g. The requested path does not exist.
                }
            }
        }
    }
    
    /// Mark: - Fetch details for specific venue ID. 
    static func fetchVenueDetails() {
        client.request(path: "venues/\(venueID)", parameter: ["":""]) { result in
            switch result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
                do {
                    let topLevelData = try jsonDecoder.decode(TopLevelData.self, from: data)
                    let venueTopLevelData = topLevelData.response
                    let fetchedVenueDetails = venueTopLevelData.venueDetails
                    guard let venueDetails = fetchedVenueDetails else {
                        print(" returned nil from fetchTrendingVenues() func")
                        return
                    }
                    print(venueDetails.name as Any)
                    
                } catch {
                    print("Error decoding venue Details: \(error.localizedDescription)")
                }

            case let .failure(error):
                // Error handling
                switch error {
                case let .connectionError(connectionError):
                    print(connectionError)
                case let .responseParseError(responseParseError):
                    print(responseParseError)   // e.g. JSON text did not start with array or object and option to allow fragments not set.
                case let .apiError(apiError):
                    print(apiError.errorType)   // e.g. endpoint_error
                    print(apiError.errorDetail) // e.g. The requested path does not exist.
                }
            }
        }
    }

//
//    // Mark: - Venue Events Fetch
//        // Needs to have a VENUE_ID from pulled venues
//    /// TODO: - Figure out why we can't get events with valid codes
//    static func fetchVenueEvents(at venueID: String) {
//        client.request(path: "venues\(venueID)/events", parameter: basicLocationParameter) { result in
//            switch result {
//            case let .success(data):
//                // parse the JSON data with NSJSONSerialization or Lib like SwiftyJson
//                // e.g. {"meta":{"code":200},"notifications":[{"...
//                
//                let jsonDecoder = JSONDecoder()
//                do {
//                    let topLevelData = try jsonDecoder.decode(TopLevelData.self, from: data)
//                    let venueTopLevelData = topLevelData.response
//                    /// TODO: - Figure out why events won't return
//                    return
//                } catch {
//                    print("Error decoding itunesItems: \(error.localizedDescription)")
//                    return
//                }
//                
//            case let .failure(error):
//                // Error handling
//                switch error {
//                case let .connectionError(connectionError):
//                    print(connectionError)
//                case let .responseParseError(responseParseError):
//                    print(responseParseError)   // e.g. JSON text did not start with array or object and option to allow fragments not set.
//                case let .apiError(apiError):
//                    print(apiError.errorType)   // e.g. endpoint_error
//                    print(apiError.errorDetail) // e.g. The requested path does not exist.
//                }
//            }
//        }
//    }
}

