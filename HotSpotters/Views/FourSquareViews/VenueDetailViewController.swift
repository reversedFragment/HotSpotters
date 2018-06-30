//
//  VenueDetailViewController.swift
//  HotSpotters
//
//  Created by Ben Adams on 6/30/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class VenueDetailViewController: UIViewController {
    
    ////////////////////////////////////////////////////////////////
    /// Mark: - Properties
    ////////////////////////////////////////////////////////////////
    
    var venueDetail: Venue? {
        didSet{
            if isViewLoaded {
                updateViews()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    
    }

    
    // MARK: Private
    
    private func updateViews() {
        guard let venueDetail = venueDetail else { return }
//        titleTextField.text = entry.title
//        bodyTextView.text = entry.text
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
