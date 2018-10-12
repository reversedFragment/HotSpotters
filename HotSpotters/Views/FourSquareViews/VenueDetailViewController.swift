//
//  VenueDetailViewController.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/30/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class VenueDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    var fetchedVenueDetail: VenueDetails? {
        didSet{
            if isViewLoaded {
                DispatchQueue.main.async {
                    self.updateViews()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }
        
    
    
    
    ////////////////////////////////////////////////////////////////
    // Mark: - Properties
    ////////////////////////////////////////////////////////////////
    
    
// Overview
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var isOpen: UILabel!
    @IBOutlet weak var verifiedLabel: UILabel!
    
    // Location:
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var postalLabel: UILabel!
    @IBOutlet weak var latlngLabel: UILabel!
    
    //Ratings
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var ratingSignalsLabel: UILabel!
    @IBOutlet weak var listedCount: UILabel!
    @IBOutlet weak var topList1: UILabel!
    @IBOutlet weak var topList2: UILabel!
    
    //Popularity
    @IBOutlet weak var checkinsCount: UILabel!
    @IBOutlet weak var visitsCount: UILabel!
    @IBOutlet weak var venueLikes: UILabel!
    @IBOutlet weak var venueDislikes: UILabel!
    @IBOutlet weak var tipCount: UILabel!
    
    //Media
    @IBOutlet weak var photosCountLabel: UILabel!
    @IBOutlet weak var bestPhotoLabel: UILabel!

    
    //Contact
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var instagramLabel: UILabel!
    @IBOutlet weak var facebookUsername: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    

    /// MARK: Private
    
    private func updateViews() {
        guard let fetchedVenueDetail = fetchedVenueDetail else { return }
        categoryLabel.text = fetchedVenueDetail.venueCategories?.first?.name
        descriptionLabel.text = fetchedVenueDetail.page?.pageInfo?.description
        priceLabel.text = "\(fetchedVenueDetail.price?.tier ?? 1)"
        isOpen.text = "\(fetchedVenueDetail.hours?.isOpen)"
        addressLabel.text = fetchedVenueDetail.locationDetails?.address
        cityLabel.text = fetchedVenueDetail.locationDetails?.city
        stateLabel.text = fetchedVenueDetail.locationDetails?.state
        postalLabel.text = fetchedVenueDetail.locationDetails?.postalCode
        latlngLabel.text = "\(String(describing: fetchedVenueDetail.locationDetails?.lat))" + ", " + "\(fetchedVenueDetail.locationDetails?.lng ?? 0,0)"
        ratingsLabel.text = "\(fetchedVenueDetail.rating ?? 0)"
        ratingSignalsLabel.text = "\(fetchedVenueDetail.ratingSignals ?? 0)"
        listedCount.text = "\(fetchedVenueDetail.listed?.count ?? 0)"
        venueLikes.text = "\(fetchedVenueDetail.likes?.count ?? 0)"
        tipCount.text = "\(fetchedVenueDetail.tips?.count ?? 0)"
        photosCountLabel.text = "\(fetchedVenueDetail.photos?.count ?? 0)"
        bestPhotoLabel.text = fetchedVenueDetail.bestPhoto?.source?.url ?? "This venue doesn't have a good photo yet"
        phoneLabel.text = fetchedVenueDetail.contact?.formattedPhone
        twitterLabel.text = fetchedVenueDetail.contact?.twitter
        instagramLabel.text = fetchedVenueDetail.contact?.instagram
        facebookUsername.text = fetchedVenueDetail.contact?.facebookUsername
        urlLabel.text = fetchedVenueDetail.url
    }

}


