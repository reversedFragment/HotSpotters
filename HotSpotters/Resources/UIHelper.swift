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
    
}
