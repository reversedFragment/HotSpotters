//
//  LocationController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 6/28/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

class TwitterLocationController{
    
    static let shared = TwitterLocationController()
    static let baseUrl = URL(string: "https://api.twitter.com/1.1/trends/closest.json")
    
    func fetchClosestLocationFor(longitude: Double, latitude: Double, completion: @escaping (TwitterLocation?) -> Void){
        
        guard let baseUrl = TwitterLocationController.baseUrl else {return}
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        let queryItems = [URLQueryItem(name: "lat", value: "\(latitude)"), URLQueryItem(name: "long", value: "\(longitude)")]
        components?.queryItems = queryItems
        guard let url = components?.url else {return}
        print(url)
        
        var request = URLRequest(url: url)
        TweetController.shared.getTwitterClientBearerToken { (token) in
            if let token = token {
                let bearerToken = "Bearer \(token)"
                request.addValue(bearerToken, forHTTPHeaderField: "Authorization")
                
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let error = error{
                        print("\(error.localizedDescription) \(error) in function: \(#function)")
                        completion(nil)
                        return
                    }
                    
                    if let data = data{
                        do{
                            let decoder = JSONDecoder()
                            let twitterLocation = try decoder.decode([TwitterLocation].self, from: data)[0]
                            completion(twitterLocation)
                        }catch{
                            print("\(error.localizedDescription) \(error) in function: \(#function)")
                            completion(nil)
                            return
                        }
                    }
                }).resume()
            }
        }
        
    }
}
