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
    var visibleColleges: [College] = []
    var filteredColleges: [College] = []
    var selectedCollege: College?
    let minimumStudentCount = 1000
    
    let baseURL = URL(string: "https://api.data.gov/ed/collegescorecard/v1/schools?")
    let apiToken = "HFVcWfJM6FxkueG2OzSz3ztoH48nm9BcVuyU5EMl"
    
    func search(by zipcode: String, distance: Int, completion: @escaping (CollegeService?) -> Void) {
        guard let url = baseURL else { completion(nil) ; return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let fieldsQuery = URLQueryItem(name: "_fields", value: "id,school.name,school.state,location.lat,location.lon,2015.student.size,school.degrees_awarded.predominant,school.school_url")
        let predominantDegreeQuery = URLQueryItem(name: "school.degrees_awarded.predominant", value: "3")
        let zipcodeQuery = URLQueryItem(name: "_zip", value: "\(zipcode)")
        let distanceQuery = URLQueryItem(name: "distance", value: "\(distance)mi")
        let apiTokenQuery = URLQueryItem(name: "api_key", value: "\(apiToken)")
        components?.queryItems = [fieldsQuery, zipcodeQuery, distanceQuery, apiTokenQuery, predominantDegreeQuery]
        guard let urlWithQuery = components?.url else { completion(nil) ; return }
        
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
//                let colleges = collegeService.results.filter{ $0.size >= self.minimumStudentCount}
                completion(collegeService)
            } catch let error {
                print("There was an errord decoding colleges: \(#function) \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            }.resume()
    }
    
    func fetchCollegesBy(schoolName: String, completion: @escaping ([College]?) -> Void){
        guard let url = baseURL else { completion(nil) ; return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let fieldsQuery = URLQueryItem(name: "_fields", value: "id,school.name,school.state,location.lat,location.lon,2015.student.size,school.degrees_awarded.predominant,school.school_url")
        let predominantDegreeQuery = URLQueryItem(name: "school.degrees_awarded.predominant", value: "3")
        let nameQuery = URLQueryItem(name: "school.name", value: schoolName)
        let apiTokenQuery = URLQueryItem(name: "api_key", value: "\(apiToken)")
        
        components?.queryItems = [fieldsQuery, nameQuery, predominantDegreeQuery, apiTokenQuery]
        guard let urlWithQuery = components?.url else { completion(nil) ; return }
        
        URLSession.shared.dataTask(with: urlWithQuery) { (data, _, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil) ; return }
            do{
                let decoder = JSONDecoder()
                let collegeService = try decoder.decode(CollegeService.self, from: data)
                let colleges = collegeService.results.filter{ $0.size ?? 0 >= self.minimumStudentCount }
                completion(colleges)
            }catch{
                    print("\(error.localizedDescription) \(error) in function: \(#function)")
                    completion(nil)
            }
        }.resume()
    }
    
    func fetchImageFor(college: College, completion: @escaping (Bool) -> Void){
        
        guard let logoURL = URL(string: "https://logo.clearbit.com/\(college.urlString ?? "")") else {return}
        
        URLSession.shared.dataTask(with: logoURL) { (data, response, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
            }
            var logo: UIImage?
            if let data = data{
                logo = UIImage(data: data)
            }
                college.logo = logo ?? #imageLiteral(resourceName: "locationIcon")
                completion(true)
        }.resume()
    }
}
