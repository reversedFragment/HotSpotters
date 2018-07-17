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
//        updateViews()
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
    
    var priceStringHolder: String = ""
    
    func createPriceString(priceTier: Int) {
        var priceString = ""
        for num in 1...priceTier {
            priceString.append("$")
        }
        priceStringHolder = priceString
    }
        
    
    
    
    ////////////////////////////////////////////////////////////////
    // Mark: - Properties
    ////////////////////////////////////////////////////////////////
    
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityStateLable: UILabel!

    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var formattedPhoneLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    
    /// MARK: Private
    
    private func updateViews() {
        guard let fetchedVenueDetail = fetchedVenueDetail else { return }
        
        nameLabel.text = fetchedVenueDetail.name
        
        
        ratingLabel.layer.masksToBounds = true
        ratingLabel.layer.cornerRadius = 5
        
        categoryLabel.text = fetchedVenueDetail.venueCategories?.first?.name
        
        hoursLabel.text = fetchedVenueDetail.hours?.status ?? "Open"
        hoursLabel.textColor = UIColor.green
        addressLabel.text = fetchedVenueDetail.locationDetails?.address
        
        postalCodeLabel.text = fetchedVenueDetail.locationDetails?.postalCode
        formattedPhoneLabel.text = fetchedVenueDetail.contact?.formattedPhone
        urlLabel.text = fetchedVenueDetail.url
        
        
        guard let city = fetchedVenueDetail.locationDetails?.city,
            let state = fetchedVenueDetail.locationDetails?.state else {
                cityStateLable.text = ""
                return
        }
        cityStateLable.text = city + ", " + state
        
        ratingLabel.text = "\(fetchedVenueDetail.rating ?? 0.0)"
        guard let ratingColor = fetchedVenueDetail.ratingColor else {
            ratingLabel.backgroundColor = UIColor.blue
            return
        }
        ratingLabel.backgroundColor = UIColor(hexString: "#\(ratingColor.lowercased())FF")
        
        guard let priceTier = fetchedVenueDetail.price?.tier else {
            priceLabel.text = ""
            return
        }
        
        createPriceString(priceTier: priceTier)
        priceLabel.text = priceStringHolder
        if priceLabel.text?.count == 1 || priceLabel.text?.count == 2 {
            priceLabel.textColor = UIColor.green
        }
        else if priceLabel.text?.count == 3 {
            priceLabel.textColor = UIColor.orange
        }
        
        else if priceLabel.text?.count == 4 {
            priceLabel.textColor = UIColor.red
        }
        
        
        
    }
}
