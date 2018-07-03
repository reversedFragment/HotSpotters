//
//  BSAMapViewDynamicDataPractice.swift
//  HotSpotters
//
//  Created by Ben Adams on 7/2/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Mapbox

class BSAMapViewDynamicDataPractice: UIViewController, MGLMapViewDelegate {

override func viewDidLoad() {
    
    let mapView = MGLMapView(frame: view.bounds)
    mapView.styleURL = MGLStyle.lightStyleURL
    mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    mapView.setCenter(CLLocationCoordinate2D(latitude: 44.971, longitude: -93.261), zoomLevel: 10, animated: false)
    
    mapView.delegate = self
    view.addSubview(mapView)
    
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
        let source = MGLVectorTileSource(identifier: "historical-places", configurationURL: URL(string: "mapbox://examples.5zzwbooj")!)
        style.addSource(source)
        
        let layer = MGLCircleStyleLayer(identifier: "landmarks", source: source)
        layer.sourceLayerIdentifier = "HPC_landmarks-b60kqn"
        layer.circleRadius = NSExpression(format: "2018 - Constructi / 10")
        layer.circleColor = NSExpression(forConstantValue: #colorLiteral(red: 0.67, green: 0.28, blue: 0.13, alpha: 1))
        layer.circleOpacity = NSExpression(forConstantValue: 0.8)
        style.addLayer(layer)
        
    }
}

