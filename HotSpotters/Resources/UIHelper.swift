//
//  UIHelper.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/10/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class UIHelper{
    
    static let storyBoard: UIStoryboard = UIStoryboard(name: "trevorsStoryboard", bundle: nil)
    static let trendingTopicsTableViewController = UIHelper.storyBoard.instantiateViewController(withIdentifier: "trendingTVC")
    
    static let stockPhotos: [UIImage] = [#imageLiteral(resourceName: "rawpixel-594848-unsplash"),#imageLiteral(resourceName: "nasa-53884-unsplash"),#imageLiteral(resourceName: "topPicks"),#imageLiteral(resourceName: "sights"),#imageLiteral(resourceName: "shops"),#imageLiteral(resourceName: "outdoors"),#imageLiteral(resourceName: "eaters-collective-132772-unsplash"),#imageLiteral(resourceName: "drinks"),#imageLiteral(resourceName: "adrian-korte-76051-unsplash")]
}
