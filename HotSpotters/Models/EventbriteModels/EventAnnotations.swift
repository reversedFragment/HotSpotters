//
//  EventAnnotations.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/18/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit
import Mapbox

class EventAnnotation: NSObject, MGLAnnotation {
    
    // As a reimplementation of the MGLAnnotation protocol, we have to add mutable coordinate and (sub)title properties ourselves.
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var venueName: String?
    var address: String?
    
    // Custom properties that we will use to customize the annotation's image.
    var image: UIImage?
    var reuseIdentifier: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, venueName: String?, address: String?) {
        self.coordinate = coordinate
        self.title = title
        self.venueName = venueName
        self.address = address
    }
}
