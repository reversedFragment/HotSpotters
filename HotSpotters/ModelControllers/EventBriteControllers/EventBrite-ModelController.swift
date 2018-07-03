//
//  EventBrite-ModelController.swift
//  EventBrite
//
//  Created by CELLFiY on 6/26/18.
//  Copyright © 2018 Matt Schweppe. All rights reserved.
//

import UIKit

class EventBriteController {
    
    static let baseURL = URL(string: "https://www.eventbriteapi.com/v3/")
    static let apiToken = "ATPVKSO23CXMDQ5GYZWB"
    
    static func search(term: String, sortDescriptor: SortDescriptors, radius: Int, location: String, completion: @escaping(([EventElement]?) -> Void)) {
        
        guard var url = baseURL else { completion(nil) ; return }
        url.appendPathComponent("events")
        url.appendPathComponent("search/")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let searchQuery = URLQueryItem(name: "q", value: "\(term)")
        let sortQuery = URLQueryItem(name: "sort_by", value: "\(sortDescriptor)")
        let locationQuery = URLQueryItem(name: "location.address", value: "\(location)")
        let distanceQuery = URLQueryItem(name: "location.within", value: "\(radius)mi")
        let apiTokenQuery = URLQueryItem(name: "token", value: apiToken)
        components?.queryItems = [searchQuery, sortQuery, locationQuery, distanceQuery, apiTokenQuery]
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
    
    enum SortDescriptors: String {
        case date
        case distance
        case best
        case reverseDate
        case reverseDistance
        case reverseBest
    }
}
