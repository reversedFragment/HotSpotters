//
//  TweetController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 6/26/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class TweetController{
    
    static let shared = TweetController()
    static let baseSearchTweetsUrl = URL(string: "https://api.twitter.com/1.1/search/tweets.json")
    var fetchedTweets: [Tweet]?
    
    
    private struct ApiKeys{
        static let consumerKey = "lLlE47J42uVzJrwl0uD8NUyUr"
        static let consumerSecret = "t1Zdj7ewtFEYK14p82MKU8pha5LPeQ3Z7EMyvmUosMWzQCXco0"
        static let appOnlyAuth = "https://api.twitter.com/oauth2/token"
        static let requestTokenUrl = "https://api.twitter.com/oauth/request_token"
        static let authorizeUrl = " https://api.twitter.com/oauth/authorize"
        static let accessTokenUrl = "https://api.twitter.com/oauth/access_token"
        
        static let accessToken = "2227304690-hfCPUibWxDEsC9ocBdaSGG9xxxain3aMnTRh1J"
        static let accessTokenSecret = "Mu5QBEKGXUTO1ckksRxZrt02trDifw9SBUNXQrarivFK2"
        static let bearerTokenCredentialsString = "\(TweetController.ApiKeys.consumerKey):\(TweetController.ApiKeys.consumerSecret)"
        static let utf8str = TweetController.ApiKeys.bearerTokenCredentialsString.data(using: String.Encoding.utf8)
        static let bearerTokenCredentialsBase64 = TweetController.ApiKeys.utf8str?.base64EncodedData()
    }
    
    func getBase64EncodeString() -> String {
        let consumerKeyRFC1738 = ApiKeys.consumerKey.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let consumerSecretRFC1738 = ApiKeys.consumerSecret.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let concatenateKeyAndSecret = consumerKeyRFC1738! + ":" + consumerSecretRFC1738!
        let secretAndKeyData = concatenateKeyAndSecret.data(using: String.Encoding.ascii, allowLossyConversion: true)
        let base64EncodeKeyAndSecret = secretAndKeyData?.base64EncodedString(options: NSData.Base64EncodingOptions())
        return base64EncodeKeyAndSecret!
    }
    
    
    func getTwitterClientBearerToken(completion: @escaping (_ bearerToken: String?) -> Void){
        
        guard let url = URL(string: ApiKeys.appOnlyAuth) else {return}
        let bearerToken =  getBase64EncodeString()
        print("Basic \(bearerToken)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic bExsRTQ3SjQydVZ6SnJ3bDB1RDhOVXlVcjp0MVpkajdld3RGRVlLMTRwODJNS1U4cGhhNUxQZVEzWjdFTXl2bVVvc01XelFDWGNvMA==", forHTTPHeaderField: "Authorization")
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                return
            }
            if let data = data{
                do{
                    guard let resultsDictionary: [String : String] = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : String] else {
                        completion(nil)
                        return
                    }
                    guard let token = resultsDictionary["access_token"] else {
                        completion(nil)
                        return
                    }
                    print(token)
                    completion(token)
                } catch{
                    print("\(error.localizedDescription) \(error) in function: \(#function)")
                    completion(nil)
                    return
                }
            }
            }.resume()
    }
    
    func searchTweetsBy(topic: String, geocode: String?, resultType: ResultType?, count: Int? ,completion: @escaping ([Tweet]?) -> Void){
        
        getTwitterClientBearerToken { (token) in
            if let token = token {
                let bearerToken = "Bearer \(token)"
                
                guard let baseUrl = TweetController.baseSearchTweetsUrl else {return}
                var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
                let queryItems = [URLQueryItem(name: "q", value: topic), URLQueryItem(name: "geocode", value: geocode), URLQueryItem(name: "result_type", value: resultType.map { $0.rawValue }), URLQueryItem(name: "count", value: "\(count ?? 25)")]
                components?.queryItems = queryItems
                guard let url = components?.url else {return}
                
                print(url)
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue(bearerToken, forHTTPHeaderField: "Authorization")
                
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let error = error{
                        print("\(error.localizedDescription) \(error) in function: \(#function)")
                        return
                    }
                    
                    if let data = data{
                        let decoder = JSONDecoder()
                        do{
                            let tweets = try decoder.decode(TweetsDictionary.self, from: data).tweets
                            completion(tweets)
                        } catch {
                            print("\(error.localizedDescription) \(error) in function: \(#function)")
                            return
                        }
                    }
                }).resume()
            }
        }
    }
    
    func fetchProfilePictureFor(user: TwitterUser, completion: @escaping (UIImage?) -> Void){
        guard let url = URL(string: user.profileImageURL) else {completion(nil) ; return}
        
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil) ; return}
            do{
                let image = UIImage(data: data)
                completion(image)
            }
        }.resume()
    }
    
    func fetchImageForTweet(imageURLString: String, completion: @escaping (UIImage?) -> Void){
        guard let url = URL(string: imageURLString) else {completion(nil) ; return}
        
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil) ; return}
            do{
                let image = UIImage(data: data)
                completion(image)
            }
            }.resume()
    }
    
}
