//
//  CollegeAnnotation.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/5/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation
import Mapbox

class CollegeAnnotation: NSObject, MGLAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage?
    var reuseIdentifier: String?
    var college: College?
    
    init(college: College){
        let coordinate = CLLocationCoordinate2D(latitude: college.locationLat, longitude: college.locationLon)
        let size = "\(college.size) Students"
        if let image = college.logo {
           let logo = ImageHelper.resizeImage(image, targetSize: CGSize(width: 45, height: 45))
            self.image = logo
        }
        
        self.coordinate = coordinate
        self.title = college.schoolName
        self.subtitle = size
        self.reuseIdentifier = "\(college.id)"
        self.college = college
    }
}
