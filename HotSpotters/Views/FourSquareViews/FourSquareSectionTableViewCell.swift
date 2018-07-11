//
//  FourSquareSectionTableViewCell.swift
//  HotSpotters
//
//  Created by Ben Adams on 7/9/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class FourSquareSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var sectionImage: CustomCellImageView!
    @IBOutlet weak var sectionLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
}
