//
//  TrendController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 6/28/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class TrendController{
    
    static let shared = TrendController()
    static let baseTrendUrl = URL(string: "https://api.twitter.com/1.1/trends/place.json")
    var tweets: [Tweet] = []
    var currentTrends: [Trend] = []
    
    func getTrendingTopicsFor(location: TwitterLocation, completion: @escaping ([Trend]?) -> Void){
        
        TweetController.shared.getTwitterClientBearerToken { (token) in
            if let token = token {
                let bearerToken = "Bearer \(token)"
                
                guard let baseUrl = TrendController.baseTrendUrl else {return}
                var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
                let queryItems = [URLQueryItem(name: "id", value: "\(location.woeid)")]
                components?.queryItems = queryItems
                guard let url = components?.url else {return}
                
                var request = URLRequest(url: url)
                request.addValue(bearerToken, forHTTPHeaderField: "Authorization")
                
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let error = error{
                        print("\(error.localizedDescription) \(error) in function: \(#function)")
                    }
                    if let data = data {
                        do{
                            let decoder = JSONDecoder()
                            let trends = try decoder.decode([TrendDictionary].self, from: data)[0].trends
                            completion(trends)
                            return
                        } catch {
                            print("\(error.localizedDescription) \(error) in function: \(#function)")
                            completion(nil)
                        }
                    }
                }).resume()
            }
        }
    }
    
    func getTrendingTopicsFor(latitude: Double, longitude: Double, completion: @escaping ([Trend]?) -> Void){
        
        TwitterLocationController.shared.fetchClosestLocationFor(longitude: longitude, latitude: latitude) { (location) in
            if let location = location{
                self.getTrendingTopicsFor(location: location, completion: { (trends) in
                    if let trends = trends {
                        self.currentTrends = trends
                        completion(trends)
                    }
                })
            } else {
                completion(nil)
                return
            }
        }
    }
    
    func fetchTrendImage(trend: Trend, completion: @escaping (UIImage?) -> Void){
        var image: UIImage?
        TweetController.shared.searchTweetsBy(topic: trend.name, geocode: nil, resultType: .mixed, count: 3) { (tweets) in
            guard let tweets = tweets else {completion(nil) ; return}
            for tweet in tweets{
                if image != nil {break}
                if let medias = tweet.entities.media{
                    for media in medias{
                        if media.type == "photo" {
                            TweetController.shared.fetchImageForTweet(imageURLString: media.mediaURLHTTPS, completion: { (trendPhoto) in
                                if let trendPhoto = trendPhoto {
                                    image = trendPhoto
                                    completion(image)
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
}
