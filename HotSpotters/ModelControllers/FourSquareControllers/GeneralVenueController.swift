//
//  GeneralVenueController.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/29/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation
import UIKit
import Mapbox


/// This class contains all of the worthwhile fetches the API supports
class VenueController {
	
	static let baseUrl = URL(string: "https://api.foursquare.com/v2/")
	static let shared = VenueController()
	
	// My Personal, Userless Authorization Keys
	static let myClientID = "PF3WA3B11VANKXDEQECTSUAMHUWROKWC2G5HKCMY0PUGRIKW"
	static let myClientSecret = "KULKA0VOZFYP4NIXKQZ2CHWFRMZRG03J1J3N0X4HTVXG3QPZ"
	static let version = "20180702" /// FourSquare systems version we are using
	
	var selectedVenues: [GroupItem]?
	var selectedVenue: GroupItem?
	
	////////////////////////////////////////////////////////////////
	// Mark: - fetchVenues() by 'll' geolocation or by 'near' search.
	////////////////////////////////////////////////////////////////
	
	static func fetchVenues(searchTerm: String?,
													location: (Int, Int)?,
													near: String?,
													radius: Int = 10000,
													limit: Int = 10,
													categories: String?,
													completion: @escaping (([Venue]?)->Void)) {
		
		/// Mark: - Conversion of Ints to Strings and logic to parse 'll' and 'near'
		
		// TODO: - I deleted the logic checks for 'near' or 'll' checks. Either can
		// be taken, but this function is unused in this version of the app
		
		let stringLimit = "\(String(describing: limit))"
		let stringRadius = "\(String(describing: radius))"
		
		// URL Creation
		guard var url = baseUrl else { completion(nil) ; return }
		url.appendPathComponent("venues")
		url.appendPathComponent("search")
		
		
		/// MARK: - QUERIES
		
		var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
		
		////////////////////////////////////////////////////////////////
		// Mark: - Parameters and their Descriptions
		////////////////////////////////////////////////////////////////
		
		/// "ll": Latitude and longitude of the user’s location.
		/// Required unless 'near' is provided
		//        let locationQuery = URLQueryItem.init(name: "ll", value: stringLocation) /// Required unless "near" is provied.
		
		/// "near": A string naming a place in the world.
		/// Required unless 'll' is provided.
		// If the near string is not geocodable, returns a failed_geocode error.
		// Otherwise, searches within the bounds of the geocode and adds a geocode object to the response.
		let nearQuery = URLQueryItem.init(name: "near", value: near)
		
		/// "query": A term to be searched against a venue’s tips, category, etc.
		// Has no effect when a section is specified.
		let searchTermQuery = URLQueryItem.init(name: "query", value: searchTerm)
		
		/// "radius": Radius to search within, in meters. Maximum radius is 10000.
		// If not queried, a default radius based the area's venue density is used.
		let radiusQuery = URLQueryItem.init(name: "radius", value: stringRadius)
		
		/// "limit": Number of results to return, up to 50.
		let limitQuery = URLQueryItem.init(name: "limit", value: stringLimit)
		
		/// Array of categories applied to venue. One category will have a primary field to mark it as the primary category.
		//  let category = URLQueryItem.init(name: "categoryId", value: categories) /// Possibly an empty array
		
		/// Auth Keys and Version queries
		let clientID = URLQueryItem.init(name: "client_id", value: myClientID) /// Be aware of limitations
		let clientSecret = URLQueryItem.init(name: "client_secret", value: myClientSecret) /// Check for restrictions
		let FSversionNumber = URLQueryItem.init(name: "v", value: version) /// Version of FourSquare Systems
		
		let queryArray = [searchTermQuery, radiusQuery, limitQuery, clientID, clientSecret, FSversionNumber, nearQuery]
		
		// Final Components Summing
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
	// Mark: - fetchVenueDetails()
	////////////////////////////////////////////////////////////////
	
	// Userless authenticators (THAT MEANS US), cannot receive hereNow information.
	// Paramter 'VENUE_ID' from venueID at indexpath for selected row
	static func fetchVenueDetails(with VENUE_ID: String,
																completion: @escaping ((VenueDetails?)->Void)) {
		
		// URL
		guard var url = baseUrl else { completion(nil) ; return }
		url.appendPathComponent("venues")
		url.appendPathComponent(VENUE_ID)
		
		// QUERIES
		
		var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
		
		let clientID = URLQueryItem.init(name: "client_id", value: myClientID)
		let clientSecret = URLQueryItem.init(name: "client_secret", value: myClientSecret)
		let FSversionNumber = URLQueryItem.init(name: "v", value: version)
		
		let queryArray = [clientID, clientSecret, FSversionNumber]
		
		components?.queryItems = queryArray
		
		// Fully constructed URL
		guard let finalUrl = components?.url else { completion(nil) ; return }
		print("📡📡📡  \(finalUrl.absoluteString)   📡📡📡")
		
		// Request
		var request = URLRequest(url: finalUrl)
		request.httpMethod = "GET"
		request.httpBody = nil
		
		
		/// Mark: - fetchVenueDetails DataTask
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
	// Mark: - exploreVenues()
	////////////////////////////////////////////////////////////////
	
	// Users can use this enum to filter by 'section'
	enum venueSectionMarker: String {
		case food = "food"
		case drinks = "drinks"
		case coffee = "coffee"
		case shops = "shops"
		case arts = "arts"
		case outdoors = "outdoors"
		case sights = "sights"
		case trending = "trending"
		case topPicks = "topPicks"
	}
	
	// Users can use this to filter by price point
	enum pricePoint: String {
		case price1 = "1"
		case price2 = "2"
		case price3 = "3"
		case price4 = "4"
	}
	
	static func exploreVenues(location: (Double, Double),
														radius: Int,
														section: String,
														limit: Int,
														price: String, // separate digits by commas to get a range of prices
		completion: @escaping (([GroupItem]?)->Void)) {
		
		// Conversion of Ints to Strings for clarity
		let stringLocation = "\(location.0)" + "," + "\(location.1)"
		let stringLimit = "\(limit) "
		let stringRadius = "\(radius)"
		let stringSection = "\(section)"
		
		// URL
		guard var url = baseUrl else { completion(nil) ; return }
		url.appendPathComponent("venues")
		url.appendPathComponent("explore")
		
		var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
		
		/// QUERIES
		
		/// Required from pinned location coordinates
		let locationQuery = URLQueryItem.init(name: "ll", value: stringLocation)
		let radiusQuery = URLQueryItem.init(name: "radius", value: stringRadius)
		/// limits results to specified category or property.
		let sectionQuery = URLQueryItem.init(name: "section", value: stringSection)
		
		/// Limits number of venues per call and offsets results for pagination
		let limitQuery = URLQueryItem.init(name: "limit", value: stringLimit)
		let offSetQuery = URLQueryItem.init(name: "offset", value: "20") // Max: 50
		
		/// Boolean flag: only include venues open now - '0' disables filter
		// This prefers official hours, but falls back to popular check-in hours.
		let openNowQuery = URLQueryItem.init(name: "openNow", value: "1")
		
		/// Boolean flag: sort venues by proximity as the dominant filter.
		let sortByDistanceQuery = URLQueryItem.init(name: "sortByDistance", value: "1")
		
		/// For the complete category tree, see categories: https://developer.foursquare.com/docs/resources/categories
		//		let categoryQuery = URLQueryItem.init(name: "categoryId", value: category)
		
		/// Auth Keys Queries
		let clientID = URLQueryItem.init(name: "client_id", value: myClientID)
		let clientSecret = URLQueryItem.init(name: "client_secret", value: myClientSecret)
		let FSversionNumber = URLQueryItem.init(name: "v", value: version)
		
		let queryArray = [locationQuery, radiusQuery, sectionQuery, limitQuery, offSetQuery, openNowQuery, sortByDistanceQuery, clientID, clientSecret, FSversionNumber]
		
		components?.queryItems = queryArray
		
		// Fully constructed URL
		guard let finalUrl = components?.url else { completion(nil) ; return }
		print("📡📡📡  \(finalUrl.absoluteString)   📡📡📡")
		
		// Request
		var request = URLRequest(url: finalUrl)
		request.httpMethod = "GET"
		request.httpBody = nil
		
		
		/// Mark: - exploreVenues() DataTask
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
				
				let recommendedTopLevelData = topLevelData.response
				let recommendedGroups = recommendedTopLevelData.groups
				let recommendedVenueItems = recommendedGroups?.compactMap({$0.items})
				
				let venuesArray = recommendedVenueItems?.reduce([], +)
				
				VenueController.shared.selectedVenues = venuesArray
				
				completion(venuesArray)
				
			} catch {
				print("Error decoding fetched Venues: \(error.localizedDescription) \(error)")
				
				completion(nil)
				
				return
			}
			
		}.resume()
		
	}
	
}
