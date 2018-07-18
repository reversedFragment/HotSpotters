//
//  EventBrite-ModelController.swift
//  EventBrite
//
//  Created by CELLFiY on 6/26/18.
//  Copyright © 2018 Matt Schweppe. All rights reserved.
//

import UIKit

class EventBriteController {
    
    static let shared = EventBriteController()
    var myEvents: [EventElement]?
    
    static let baseURL = URL(string: "https://www.eventbriteapi.com/v3/")
    static let apiToken = "ATPVKSO23CXMDQ5GYZWB"
    
    static func search(term: String?, sortDescriptor: SortDescriptors, radius: Int, location: String, categories: Category, completion: @escaping(([EventElement]?) -> Void)) {
        
        guard var url = baseURL else { completion(nil) ; return }
        url.appendPathComponent("events")
        url.appendPathComponent("search/")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let searchQuery = URLQueryItem(name: "q", value: "\(term ?? "")")
        let sortQuery = URLQueryItem(name: "sort_by", value: "\(sortDescriptor)")
        let locationQuery = URLQueryItem(name: "location.address", value: "\(location)")
        let distanceQuery = URLQueryItem(name: "location.within", value: "\(radius)mi")
        let categoryQuery = URLQueryItem(name: "categories", value: "\(categories.id)")
        let apiTokenQuery = URLQueryItem(name: "token", value: apiToken)
        components?.queryItems = [searchQuery, sortQuery, locationQuery, distanceQuery, categoryQuery, apiTokenQuery]
        guard let urlWithQuery = components?.url else { completion(nil) ; return }
        
        print("\(urlWithQuery.absoluteString)")
        
        var request = URLRequest(url: urlWithQuery)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error decoding Data with dataTask: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil) ; return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let events = try jsonDecoder.decode(Event.self, from: data).events
                completion(events)
            } catch let error {
                print("There was an error decoding Events: \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            }.resume()
    }
    
    static func fetchEventsAround(longitude: Double, latitude: Double, completion: @escaping(([EventElement]?) -> Void)) {
        
        guard var url = baseURL else { completion(nil) ; return }
        url.appendPathComponent("events")
        url.appendPathComponent("search/")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let queryItems = [URLQueryItem(name: "token", value: apiToken), URLQueryItem(name: "location.longitude", value: "\(longitude)"), URLQueryItem(name: "location.latitude", value: "\(latitude)")]
        components?.queryItems = queryItems
        guard let urlWithQuery = components?.url else { completion(nil) ; return }
        
        print("\(urlWithQuery.absoluteString)")
        
        var request = URLRequest(url: urlWithQuery)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error decoding Data with dataTask: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil) ; return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let events = try jsonDecoder.decode(Event.self, from: data)
                let eventsArray = events.events
                completion(eventsArray)
            } catch let error {
                print("There was an error decoding Events: \(#function) \(error.localizedDescription)")
                completion(nil)
                return
            }
            }.resume()
    }
    
    static func fetchImage(withUrlString: String, completion: @escaping((UIImage?) -> Void)) {
        guard let url = URL(string: withUrlString) else { completion(nil); return }
        print("\(url.absoluteString)")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil


        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("There was an error fetching Image: \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data,
                let image = UIImage(data: data) else  { completion(nil) ; return }
            completion(image)
        }.resume()

    }
    
    static func getVenue(from id: String, completion: @escaping((EventBriteVenue?) -> Void)) {
        guard var url = baseURL else { return }
        url.appendPathComponent("venues")
        url.appendPathComponent("\(id)")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let query = URLQueryItem(name: "token", value: apiToken)
        components?.queryItems = [query]
        
        guard let request = components?.url else { completion(nil) ; return }

        print("\(url.absoluteString)")
        
        var requestID = URLRequest(url: url)
        requestID.httpMethod = "GET"
        requestID.httpBody = nil
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("There was an error fetching Image: \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil) ; return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let venue = try jsonDecoder.decode(EventBriteVenue.self, from: data)
                completion(venue)
            } catch let error {
                print("There was an error decoding Events: \(#function) \(error.localizedDescription)")
                completion(nil)
                return
            }
            }.resume()
    }
    
    
    enum SortDescriptors: String {
        case date
        case distance
        case best
        case reverseDate
        case reverseDistance
        case reverseBest
    }
    
    static func nullToNil(value: Any?) -> Any? {
        if value is NSNull {
            return nil
        } else { return value }
    }
}


extension EventBriteController{
    
    static var categories: [Category] {
        let music = Category(name: "Music", image: #imageLiteral(resourceName: "malte-wingen-381988-unsplash"), id: "103")
        let business = Category(name: "Business and Productivity", image: #imageLiteral(resourceName: "rawpixel-594848-unsplash"),  id: "101")
        let community = Category(name: "Community & Culture", image: #imageLiteral(resourceName: "toa-heftiba-195458-unsplash"), id: "113")
        let entertainment = Category(name: "Arts & Entertainment", image: #imageLiteral(resourceName: "peter-lewicki-411606-unsplash"), id: "104,105")
        let tech = Category(name: "Technology & Science", image: #imageLiteral(resourceName: "nasa-53884-unsplash"), id: "114")
        let food = Category(name: "Food & Drink", image: #imageLiteral(resourceName: "eaters-collective-132772-unsplash"), id: "110")
        let health = Category(name: "Health & Wellness", image: #imageLiteral(resourceName: "curtis-macnewton-12711-unsplash"), id: "103,108")
        return [music, business, community, entertainment, tech, food, health]
    }
    
}
