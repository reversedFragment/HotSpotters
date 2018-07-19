//
//  SettingsViewController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/18/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var backgroudMode: UILabel!
    @IBOutlet weak var notificationsEnabledSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func notificationSwitchTogged(_ sender: UISwitch) {
        SettingsController.shared.notificationsEnabled = !SettingsController.shared.notificationsEnabled
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    func updateView(){
        backgroudMode.text = SettingsController.shared.mode.rawValue
        notificationsEnabledSwitch.isOn = SettingsController.shared.notificationsEnabled
    }
    
}
