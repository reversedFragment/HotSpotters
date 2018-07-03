//
//  GraphViewController.swift
//  HotSpotters
//
//  Created by CELLFiY on 6/28/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit
import Charts

class GraphTableViewController: UITableViewController {
    
    @IBOutlet weak var popularTopicsBarChart: BarChartView!
    @IBOutlet weak var popularVenuesBarChart: BarChartView!
    @IBOutlet weak var upcomingEventsBarChart: BarChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TrendController.shared.getTrendingTopicsFor(latitude: 40.7608, longitude: -111.8910) { (trends) in
            if trends != nil {
                print("successfully fetched trends")
                DispatchQueue.main.async {
                    self.updatePopularTopics()
                }
            }
        }
        
        EventBriteController.fetchEventsAround(longitude: -122.5078119, latitude: 37.7576792) { (events) in
            print(events?.compactMap{ $0.name })
            print(events?.compactMap{ $0.name })
        }
        
        EventBriteController.search(term: "swift", sortDescriptor: .best, radius: 20, location: "341 Main St, Salt Lake City, UT 84101") { (events) in
            print(events?.compactMap{$0.name} as Any)
            print(events?.compactMap{$0.categoryID} as Any)
        }
    }
    
    
    
    func updatePopularTopics(){
        var barChartEntries = [ChartDataEntry]()
        var trendAxisLabels: [String] = []
        
        
        let trends = TrendController.shared.currentTrends
        var i = 0
        
        
        for trend in trends{
            if i >= 5 { break }
            if let tweetVolume = trend.tweetVolumeInLastTwentyFourHours {
                let value: ChartDataEntry = BarChartDataEntry(x: Double(i), y: Double(tweetVolume))
                barChartEntries.append(value)
                trendAxisLabels.append(trend.name)
                i += 1
            }
        }
        
        let formatter: ChartsAxisValueFormatter = ChartsAxisValueFormatter(labels: trendAxisLabels)
        let xAxis: XAxis = popularTopicsBarChart.xAxis
        xAxis.valueFormatter = formatter
        xAxis.labelTextColor = UIColor.gray
        xAxis.granularity = 1
        xAxis.labelRotationAngle = 45
        let barsDataSet = BarChartDataSet(values: barChartEntries, label: "Trends")
        barsDataSet.colors = [UIColor.cyan]
        let data = BarChartData()
        data.addDataSet(barsDataSet)
        
        
        
        
        popularTopicsBarChart.xAxis.labelPosition = .bottom
        popularTopicsBarChart.xAxis.drawGridLinesEnabled = false
        
        popularTopicsBarChart.chartDescription?.enabled = false
        popularTopicsBarChart.rightAxis.enabled = false
        popularTopicsBarChart.leftAxis.drawGridLinesEnabled = false
        popularTopicsBarChart.leftAxis.drawLabelsEnabled = true
        popularTopicsBarChart.xAxis.axisLineColor = UIColor.cyan
        popularTopicsBarChart.leftAxis.axisLineColor = UIColor.cyan
        
        popularTopicsBarChart.data = data
    }
    
    
}
