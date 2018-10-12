//
//  CustomVenueAnnotationModel.swift
//  MapPopulationTest
//
//  Created by Ben Adams on 7/5/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Mapbox

class CustomVenueAnnotation: NSObject, MGLAnnotation {
    
    // As a reimplementation of the MGLAnnotation protocol, we have to add mutable coordinate and (sub)title properties ourselves.
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var address: String?
    
    // Custom properties that we will use to customize the annotation's image.
    var image: UIImage?
    var reuseIdentifier: String?
    var venue: GroupItem?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, address: String?, venue: GroupItem) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.address = address
        self.venue = venue
    }
}
