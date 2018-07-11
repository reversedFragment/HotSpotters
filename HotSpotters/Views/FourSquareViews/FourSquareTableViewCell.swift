
//  FourSquareTableViewCell.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/29/18.
//  Copyright © 2018 Ben Adams. All rights reserved.


import UIKit

class FourSquareTableViewCell: UITableViewCell {
    
    var fetchedVenue: RecommendedVenue? {
        didSet {
            updateViews()
        }
    }


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesName: UILabel!
    

    func updateViews() {
        guard let fetchedVenue = fetchedVenue else { return }
        nameLabel.text = fetchedVenue.name ?? "haha"
        addressLabel.text = fetchedVenue.location?.address ?? "No Address Listed"
        categoriesName.text = fetchedVenue.categories?.first?.name ?? "No Category Listed"
//        venueCategoryLabel.text = fetchedVenue.venueCategories?.first?.name ?? "haha"
//        venueAddressLabel.text = fetchedVenue.location?.address ?? "haha"
//        venueDistanceLabel.text = "It's \(fetchedVenue.contact?.phone ?? "haha")"
//        venueVerifiedLabel.text = String(describing: fetchedVenue.verified)
        
    }
}

