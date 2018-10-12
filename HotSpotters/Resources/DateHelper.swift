//
//  DateHelper.swift
//  HotSpotters
//
//  Created by CELLFiY on 7/12/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import Foundation

extension Date {
    
    // Convert local time to UTC (or GMT)
    public func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    // Convert UTC (or GMT) to local time
   public func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
}

extension String {
    public func fromUTCToLocalTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = self.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }
        
        guard let date = dateFormatter.date(from: formattedString) else {
            return self
        }
        
        //dateFormatter.dateFormat = "EEE, MMM d, yyyy - h:mm a"
        dateFormatter.dateFormat = "h:mm a"
        //dateFormatter.dateStyle = .medium
        dateFormatter.date
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    
    public func fromUTCToLocalDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = self.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }
        
        guard let date = dateFormatter.date(from: formattedString) else {
            return self
        }
        
        //dateFormatter.dateFormat = "EEE, MMM d, yyyy - h:mm a"
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        //dateFormatter.dateStyle = .medium
        dateFormatter.date
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
}
