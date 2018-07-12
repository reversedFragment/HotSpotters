//
//  College Radius Annotation.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/11/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation
import Mapbox

class CollegeRadiusAnnotationView: MGLAnnotationView {
    init(reuseIdentifier: String, size: CGFloat) {
        super.init(reuseIdentifier: reuseIdentifier)
        scalesWithViewingDistance = false
        frame = CGRect(x: 0, y: 0, width: size, height: size)
        
        self.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        self.layer.cornerRadius = size / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
    }
    
    // These two initializers are forced upon us by Swift.
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
