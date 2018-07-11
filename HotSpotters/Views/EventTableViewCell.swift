//
//  EventTableViewCell.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/10/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventImageView: CustomCellImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ticketPriceLabel: UILabel!
    
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
            dateLabel.text = eventDate.utc
            timeLabel.text = eventDate.utc
        } else {
            dateLabel.text = ""
            timeLabel.text = ""
        }
        
        if let isFree = event.isFree{
            if isFree{
                ticketPriceLabel.text = "Free"
            } else {
                ticketPriceLabel.text = "💸 💸 💸"
            }
        }
        
        if let image = eventImage{
            eventImageView.image = image
        }
    }
}
