//
//  Extensions.swift
//  Prepare-For-Rain
//
//  Created by Henry Dinhofer on 8/28/16.
//  Copyright © 2016 Henry Dinhofer. All rights reserved.
//

import Foundation

extension Double {
    
    /**
     Converts time to longer date.
     
     - Returns: String e.g. "Tuesday, August 30, 2016 at 7:00 AM"

    */
    func extendedDate() -> String {
        let timeInterval = NSTimeInterval(self)
        let timeAsDate = NSDate(timeIntervalSince1970: timeInterval)
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.FullStyle
        formatter.timeStyle = .ShortStyle
        let dateString = formatter.stringFromDate(timeAsDate)
        
        return dateString
    }
    /**
     Converts time to shorthand day format.
     
     - Returns: String e.g. "8/28/16, 10:00 PM"
     
     */
    func shortDate() -> String {
        let timeInterval = NSTimeInterval(self)
        let timeAsDate = NSDate(timeIntervalSince1970: timeInterval)
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        formatter.timeStyle = .ShortStyle
        let dateString = formatter.stringFromDate(timeAsDate)
        
        return dateString
    }
    
    /**
     Converts time to the hour with minutes.
     
     - Returns: String e.g. "6:00 AM"
     
     */
    func hour() -> String {
        let timeInterval = NSTimeInterval(self)
        let timeAsDate = NSDate(timeIntervalSince1970: timeInterval)
        
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let dateString = formatter.stringFromDate(timeAsDate)
        
        return dateString
    }
    /**
     Converts time to day of week and shortest 12-hour format.
     
     - Returns: String e.g. "Sunday, 7 AM"
     
     */
    func bestDate() -> String {
        let timeInterval = NSTimeInterval(self)
        let timeAsDate = NSDate(timeIntervalSince1970: timeInterval)
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE, h a"
        let dateString = formatter.stringFromDate(timeAsDate)
        
        //let elements = dateString.componentsSeparatedByString(",")
        //print (elements)
        
        return dateString
    }
    
    /**
     Converts Double to NSDate.
     
     - Returns: NSDate e.g. "1472479258"
     
     */
    func asNSDate() -> NSDate {
        let timeInterval = NSTimeInterval(self)
        let timeAsDate = NSDate(timeIntervalSince1970: timeInterval)
        
        return timeAsDate
    }
}

extension NSDate {
    
    /**
     Converts NSDate and returns a formatted string.
     
     - Returns: String e.g. "Sunday, 7 AM"
     
     */
    func bestDate() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE, h a"
        let dateString = formatter.stringFromDate(self)
        
        return dateString
    }
    /**
     Converts NSDate to the hour with minutes.
     
     - Returns: String e.g. "6:00 AM"
     
     */
    func fullDate() -> String {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let dateString = formatter.stringFromDate(self)
        
        return dateString
    }
//    /**
//     Converts time to day of week and shortest 12-hour format.
//     
//     - Returns: String e.g. "Sunday, 7:00 AM"
//     
//     */
//    func minutesAndSecondsDate() -> String {
//        let timeInterval = NSTimeInterval(self)
//        let timeAsDate = NSDate(timeIntervalSince1970: timeInterval)
//        
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = "EEEE, h m a"
//        let dateString = formatter.stringFromDate(timeAsDate)
//        
//        //let elements = dateString.componentsSeparatedByString(",")
//        //print (elements)
//        
//        return dateString
//    }


}