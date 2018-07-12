//
//  SelectedCollegeAnnotation.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/11/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Mapbox

class SelectedCollegeAnnotation: MGLPointAnnotation {
    
    var reuseIdentifier: String?
    var college: College?
    
    init(college: College){
        super.init()
        
        self.coordinate = CLLocationCoordinate2D(latitude: college.locationLat, longitude: college.locationLon)
        self.reuseIdentifier = "\(college.id)Radius"
        self.college = college
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
