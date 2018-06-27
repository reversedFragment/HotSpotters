//
//  Post.swift
//  EventBrite
//
//  Created by CELLFiY on 6/27/18.
//  Copyright © 2018 Matt Schweppe. All rights reserved.
//

import UIKit

struct Post {
    
    let user: String
    let platform: Platform
    let image: UIImage?
    let text: String
    let date: NSDate
    
}

enum Platform: String {
    
    case Twitter
    case EventBrite
    case FourSquare
    
}


