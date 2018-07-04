//
//  CollegeController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/3/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class CollegeController{
    
    static let shared = CollegeController()
    
    let baseURL = URL(string: "https://api.data.gov/ed/collegescorecard/v1/schools?")
    let apiToken = "HFVcWfJM6FxkueG2OzSz3ztoH48nm9BcVuyU5EMl"
    
    func search(by zipcode: Int, distance: Int, completion: @escaping (CollegeService?) -> Void) {
        guard let url = baseURL else { completion(nil) ; return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let fieldsQuery = URLQueryItem(name: "_fields", value: "id,school.name,school.state,location.lat,location.lon,2015.student.size,school.degrees_awarded.predominant,school.school_url")
        let zipcodeQuery = URLQueryItem(name: "_zip", value: "\(zipcode)")
        let distanceQuery = URLQueryItem(name: "distance", value: "\(distance)mi")
        let apiTokenQuery = URLQueryItem(name: "api_key", value: "\(apiToken)")
        components?.queryItems = [fieldsQuery, zipcodeQuery, distanceQuery, apiTokenQuery]
        guard let urlWithQuery = components?.url else { completion(nil) ; return }
        
        print(urlWithQuery.absoluteString)
        
        
        var request = URLRequest(url: urlWithQuery)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let error = error {
                print("There was an error decoding data: \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil) ; return }
            let jsonDecoder = JSONDecoder()
            do {
                let collegeService = try jsonDecoder.decode(CollegeService.self, from: data)
                completion(collegeService)
                return
            } catch let error {
                print("There was an errord decoding colleges: \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            }.resume()
    }
    
    func fetchImageFor(college: College, completion: @escaping (UIImage?) -> Void){
        
        guard let logoURL = URL(string: "https://logo.clearbit.com/\(college.urlString)") else {return}
        
        print(logoURL)
        
        URLSession.shared.dataTask(with: logoURL) { (data, response, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            guard let data = data,
                let logo = UIImage(data: data) else {completion(nil) ; return}
            completion(logo)
        }.resume()
    }
}
