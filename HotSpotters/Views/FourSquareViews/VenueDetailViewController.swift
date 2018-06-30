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
    }
    
    var fetchedVenueDetail: VenueDetails? {
        didSet{
            if isViewLoaded {
                DispatchQueue.main.async {
                    self.updateViews()
                }
            }
        }
    }
        
    
    
    
    ////////////////////////////////////////////////////////////////
    /// Mark: - Properties
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
    @IBOutlet weak var topPhoto1: UILabel!
    @IBOutlet weak var topPhoto2: UILabel!
    @IBOutlet weak var topPhoto3: UILabel!
    
    //Contact
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var instagramLabel: UILabel!
    @IBOutlet weak var facebookUsername: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    

    
    // MARK: Private
    
    private func updateViews() {
        guard let fetchedVenueDetail = fetchedVenueDetail else { return }
//        categoryLabel.text = fetchedVenueDetail.categories?.first?.name
        descriptionLabel.text = fetchedVenueDetail.page?.pageInfo?.description
        priceLabel.text = "\(fetchedVenueDetail.price?.tier)"
//        isOpen.text = "Open Now: \(fetchedVenueDetail.hours?.isOpen)"
        verifiedLabel.text = "\(fetchedVenueDetail.verified)"
        addressLabel.text = fetchedVenueDetail.locationDetails?.address
        cityLabel.text = fetchedVenueDetail.locationDetails?.city
        stateLabel.text = fetchedVenueDetail.locationDetails?.state
        postalLabel.text = fetchedVenueDetail.locationDetails?.postalCode
        latlngLabel.text = "\(String(describing: fetchedVenueDetail.locationDetails?.lat))" + ", " + "\(fetchedVenueDetail.locationDetails?.lng)"
        ratingsLabel.text = "\(fetchedVenueDetail.rating)"
        ratingSignalsLabel.text = "\(fetchedVenueDetail.ratingSignals)"
        listedCount.text = "\(fetchedVenueDetail.listed?.count)"
//        topList1.text = fetchedVenueDetail.listed.groups.map{$0.items?.index(before: 2)} ?? "This venue is not on any trending lists"
//        topList2.text = fetchedVenueDetail.listed.groups.map{$0.} ?? "This venue is not on any trending lists"
        checkinsCount.text = "\(fetchedVenueDetail.stats?.checkinsCount)" ?? "This venue doesn't have any checkins"
        visitsCount.text = "\(fetchedVenueDetail.stats?.visitsCount)"
        venueLikes.text = "\(fetchedVenueDetail.likes?.count)"
//        venueDislikes.text = fetchedVenueDetail.
        tipCount.text = "\(fetchedVenueDetail.tips?.count)"
        photosCountLabel.text = "\(fetchedVenueDetail.photos?.count)"
        bestPhotoLabel.text = fetchedVenueDetail.bestPhoto?.source?.url ?? "This venue doesn't have a good photo yet"
//        topPhoto1.text = fetchedVenueDetail.
//        topPhoto2.text = fetchedVenueDetail
//        topPhoto3.text = fetchedVenueDetail
        phoneLabel.text = fetchedVenueDetail.contact?.formattedPhone
        twitterLabel.text = fetchedVenueDetail.contact?.twitter
        instagramLabel.text = fetchedVenueDetail.contact?.instagram
        facebookUsername.text = fetchedVenueDetail.contact?.facebookUsername
        urlLabel.text = fetchedVenueDetail.canonicalURL
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


