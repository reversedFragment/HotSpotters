//
//  profileImageView.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/6/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

@IBDesignable class ProfileImageView: UIImageView{
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
