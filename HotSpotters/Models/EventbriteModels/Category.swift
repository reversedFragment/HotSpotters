//
//  Category.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/10/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class Category{
    let name: String
    let image: UIImage
    let id: String
    
    init(name: String, image: UIImage, id: String){
        self.name = name
        self.image = image
        self.id = id
    }
}
