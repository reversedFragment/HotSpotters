//
//  SettingsController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/13/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

class SettingsController{
    
    static let shared = SettingsController()
    
    //Settings
    var mode: Mode = Mode.light
    
    //Notifications
    static let darkMode = Notification.Name("Initiate Dark Mode")
    static let lightMode = Notification.Name("Wow... Boring Ass Light Mode")
}
