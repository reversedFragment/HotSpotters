//
//  EventTableViewCell.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/10/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit
import Foundation

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventButton: UIButton!
    @IBOutlet weak var eventImageView: CustomCellImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ticketPriceLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    var websiteURL: String = ""
    
    var event: EventElement?{
        didSet{
            updateView()
        }
    }
    
    var eventImage: UIImage?{
        didSet{
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateView(){
    
        guard let event = event else {return}
        eventTitleLabel.text = event.name.text
        
        if let eventDate = event.start{
            
             let startTime = eventDate.utc.fromUTCToLocalTime()
            guard let endTime = event.end?.utc.fromUTCToLocalTime() else { return }
            let date = eventDate.utc.fromUTCToLocalDate()
           
            dateLabel.text = date
            timeLabel.text = "\(startTime) - \(endTime)"
        } else {
            dateLabel.text = ""
            timeLabel.text = ""
        }
        
        if let isFree = event.isFree{
            if isFree{
                ticketPriceLabel.text = "FREE"
            } else {
                ticketPriceLabel.text = "PAID"
            }
        }
        
        if let image = eventImage{
            eventImageView.image = image
        }
        
        
        if let website = event.vanityURL{
            eventButton.backgroundColor = buyButtonColor
            eventButton.titleLabel?.text = "Register"
            websiteURL = website

            
        } else {
            eventButton.backgroundColor = buyButtonColor
            eventButton.titleLabel?.text = "Registration Unavailable"
        }
    }
    
    @IBAction func goToWebsite(_ sender: Any) {
        if let url = NSURL(string: "\(websiteURL)") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    
}
