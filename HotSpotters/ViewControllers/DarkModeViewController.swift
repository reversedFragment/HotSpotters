//
//  DarkModeViewController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/13/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class DarkModeViewController: UIViewController {

    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if SettingsController.shared.mode == Mode.light{
            self.view.backgroundColor = .white
            darkModeLabel.text = "Initiate Dark Mode"
            darkModeLabel.textColor = .black
            darkModeSwitch.isOn = false
        } else {
            self.view.backgroundColor = .black
            darkModeLabel.text = "Initiate Light Mode"
            darkModeLabel.textColor = .white
            darkModeSwitch.isOn = true
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func lightSwitchFlipped(_ sender: UISwitch) {
        
        if SettingsController.shared.mode == Mode.light{
            self.view.backgroundColor = .black
            SettingsController.shared.mode = Mode.dark
            darkModeLabel.text = "Initiate Light Mode"
            darkModeLabel.textColor = .white
        } else {
            self.view.backgroundColor = .white
            SettingsController.shared.mode = Mode.light
            darkModeLabel.text = "Initiate Dark Mode"
            darkModeLabel.textColor = .black
        }
    }
}
