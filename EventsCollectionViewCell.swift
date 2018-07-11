//
//  EventCollectionViewCell.swift
//  EventBrite
//
//  Created by CELLFiY on 7/5/18.
//  Copyright © 2018 Matt Schweppe. All rights reserved.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    
    var event: Events? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        eventTitle.text = event?.name
        eventImage.image = event?.image
    }
}
