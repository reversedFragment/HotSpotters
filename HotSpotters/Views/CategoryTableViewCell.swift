//
//  CategoryTableViewCell.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/10/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImageView: CustomCellImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var category: Category?{
        didSet{
            updateCell()
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
        guard let category = category else {return}
        categoryImageView.image = category.image
        categoryLabel.text = category.name
    }

}
