//
//  TrendTableViewCell.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/9/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class TrendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trendLabel: UILabel!
    @IBOutlet weak var trendImageView: UIImageView!
    
    var trend: Trend?{
        didSet{
            updateCell()
        }
    }
    
    var trendImage: UIImage?{
        didSet{
            DispatchQueue.main.async {
                self.updateCell()
            }

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

    func updateCell(){
        guard let trend = trend else {return}
        trendLabel.text = trend.name
        trendImageView.image = trend.photo
    }
}
