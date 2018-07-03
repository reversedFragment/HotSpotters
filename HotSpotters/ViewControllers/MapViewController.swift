////
////  MapViewController.swift
////  Taking A Stand
////
////  Created by Matt Schweppe on 6/27/18.
////  Copyright © 2018 Matt Schweppe. All rights reserved.
////
//
//import UIKit
//import MapKit
//import CoreLocation
//
//class MapViewController: UIViewController, CLLocationManagerDelegate {
//    
//    
//    typealias JSONDictionary = [String : Any]
//    var locationManager = CLLocationManager()
//
//    @IBOutlet weak var mapView: MKMapView!
//    
//    let geoCoder = CLGeocoder()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        
//        guard let currentLocation = locationManager.location?.coordinate else { return }
//        let span = MKCoordinateSpanMake(0.1, 0.1)
//        let region = MKCoordinateRegion(center: currentLocation, span: span)
//        mapView.setRegion(region, animated: true)
//        print(currentLocation)
//        
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        //gpsAlert()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        
//        switch status {
//        case .authorizedWhenInUse:
//            print("Good to go.")
//        case .authorizedAlways:
//            print("Good to go.")
//        case .denied:
//            print("Access unavailable.")
//        case .notDetermined:
//            print("Hmmm... need some introspection.")
//        case .restricted:
//            print("Locked down like area 51.")
//        }
//        
//    }
//    
//    func getAddress(completion: @escaping(_ address: JSONDictionary?,_ error: Error?) -> ()) {
//        
//        var currentLocation: CLLocation!
//        
//        geoCoder.reverseGeocodeLocation(currentLocation, preferredLocale: nil) { (placemarks, error) in
//            if let error = error {
//                print("There was an error finding placemark: \(#function) \(error) \(error.localizedDescription)")
//            } else {
//                let placeArray = placemarks
//                var placeMark: CLPlacemark!
//                placeMark = placeArray?[0]
//                
//                guard let address = placeMark.addressDictionary as? JSONDictionary else { return }
//                completion(address, nil)
//            }
//        }
//    }
//
//    
//    func gpsAlert() {
//        let alert = UIAlertController(title: "Location Services Disabled.", message: "Enable location services to see events.", preferredStyle: .alert)
//        let settingsAction = UIAlertAction(title: "Enable", style: .default) { (alert) in
//            if let url = URL(string: UIApplicationOpenSettingsURLString) {
//                // If general location settings are enabled then open location settings for the app
//                UIApplication.shared.openURL(url)
//            }
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
//            print("cancel")
//        }
//        
//        alert.addAction(settingsAction)
//        alert.addAction(cancelAction)
//        
//        self.present(alert, animated: true, completion: nil)
//        
//    }
//    
//    
//    
//    /*
//     // MARK: - Navigation
//     
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destinationViewController.
//     // Pass the selected object to the new view controller.
//     }
//     */
//    
//}
