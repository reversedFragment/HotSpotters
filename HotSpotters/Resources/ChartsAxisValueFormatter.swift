//
//  ChartsAxisValueFormatter.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/1/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation
import Charts

class ChartsAxisValueFormatter: IAxisValueFormatter {
    
    let axisLabels: [String]
    
    init(labels: [String]){
        self.axisLabels = labels
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        return axisLabels[index]
    }
}
