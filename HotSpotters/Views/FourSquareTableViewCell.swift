
//  FourSquareTableViewCell.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/29/18.
//  Copyright © 2018 Ben Adams. All rights reserved.


import UIKit

class FourSquareTableViewCell: UITableViewCell {
    
    var fetchedVenue: Venue? {
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
        guard let fetchedVenue = fetchedVenue else { return }
        venueNameLabel.text = fetchedVenue.name
        venueCategoryLabel.text = fetchedVenue.venueCategories?.first?.name
        venueAddressLabel.text = fetchedVenue.location.address
        venueDistanceLabel.text = "It's \(String(describing: fetchedVenue.location.distance)) far away"
        venueVerifiedLabel.text = String(describing: fetchedVenue.verified)
        
    }
}

