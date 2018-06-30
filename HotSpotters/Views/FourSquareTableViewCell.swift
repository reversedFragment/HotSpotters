//
//  FourSquareTableViewCell.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/29/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class FourSquareTableViewCell: UITableViewCell {
    
    var venueListing: Venue? {
        didSet {
            updateViews()
        }
    }


    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueCategoryLabel: UILabel!
    @IBOutlet weak var venueAddressLabel: UILabel!
    @IBOutlet weak var venueDistanceLabel: UILabel!
    @IBOutlet weak var venueVerifiedLabel: UILabel!
    

    func updateViews() {
        guard let venueListing = venueListing else { return }
        venueNameLabel.text = venueListing.name
        venueCategoryLabel.text = venueListing.venueCategories.first?.name
        venueAddressLabel.text = venueListing.location.address
        venueDistanceLabel.text = "It's \(String(describing: venueListing.location.distance)) far away"
        venueVerifiedLabel.text = String(venueListing.verified)
        
    }
}

