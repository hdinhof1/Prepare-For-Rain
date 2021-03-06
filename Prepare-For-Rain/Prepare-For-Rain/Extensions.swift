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
        let timeInterval = TimeInterval(self)
        let timeAsDate = Date(timeIntervalSince1970: timeInterval)
        
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.full
        formatter.timeStyle = .short
        let dateString = formatter.string(from: timeAsDate)
        
        return dateString
    }
    /**
     Converts time to shorthand day format.
     
     - Returns: String e.g. "8/28/16, 10:00 PM"
     
     */
    func shortDate() -> String {
        let timeInterval = TimeInterval(self)
        let timeAsDate = Date(timeIntervalSince1970: timeInterval)
        
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        formatter.timeStyle = .short
        let dateString = formatter.string(from: timeAsDate)
        
        return dateString
    }
    
    /**
     Converts time to the hour with minutes.
     
     - Returns: String e.g. "6:00 AM"
     
     */
    func hour() -> String {
        let timeInterval = TimeInterval(self)
        let timeAsDate = Date(timeIntervalSince1970: timeInterval)
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let dateString = formatter.string(from: timeAsDate)
        
        return dateString
    }
    /**
     Converts time to day of week and shortest 12-hour format.
     
     - Returns: String e.g. "Sunday, 7 AM"
     
     */
    func bestDate() -> String {
        let timeInterval = TimeInterval(self)
        let timeAsDate = Date(timeIntervalSince1970: timeInterval)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, h a"
        let dateString = formatter.string(from: timeAsDate)
        
        //let elements = dateString.componentsSeparatedByString(",")
        //print (elements)
        
        return dateString
    }
    
    /**
     Converts Double to NSDate.
     
     - Returns: NSDate e.g. "1472479258"
     
     */
    func asNSDate() -> Date {
        let timeInterval = TimeInterval(self)
        let timeAsDate = Date(timeIntervalSince1970: timeInterval)
        
        return timeAsDate
    }
}

extension Date {
    
    // To show future Henry the dateByAddingTimeInterval method
    func addInterval(_ inSeconds: Int) {
        Date().addingTimeInterval(30 * 60) // 30 minutes from current time
    }
    
    // MARK: - Date
    /**
    Converts date to shorthand day format.
    
    - Returns: String e.g. "8/28/16"
    
    */
    func date() -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        formatter.timeStyle = .none
        let dateString = formatter.string(from: self)
        
        return dateString
    }
    /**
     Converts NSDate to just the day.
     
     - Returns: String e.g. "Monday"
     
     */
    
    func dayOfTheWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let dateString = formatter.string(from: self)
        
        return dateString
        
    }
    /**
     Converts NSDate to just the 3-letter abbreviation day.
     
     - Returns: String e.g. "Tue"
     
     */
    
    func shortDayOfTheWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        let dateString = formatter.string(from: self)
        
        return dateString
        
    }

    
    
    // MARK: Time
    /**
     Converts NSDate to the hour with minutes.
     
     - Returns: String e.g. "12:01 PM"
     
     */
    
    // The user gets scheduled for push notification an hour before the event and at the time of the event
    // If user cancels, increase the UserDefaults value for ticket id by one
    // If user schedules new, increase the UserDefaults value for ticket id by one
    // Have to access array of all the local notifications
    
    func dateHMapm() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let dateString = formatter.string(from: self)
        
        return dateString
    }

    //MARK: - Day + Time
    /**
     Converts NSDate and returns a formatted string with day and time.
     
     - Returns: String e.g. "Sunday, 7:01 AM"
     
     */
    func bestDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, h:mm a"
        let dateString = formatter.string(from: self)
        
        return dateString
    }
    /**
     Converts NSDate and returns an abbreviated string with day and time.
     
     - Returns: String e.g. "Tue, 7:01 AM"
     
     */
    func shortenedBestDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, h:mm a"
        let dateString = formatter.string(from: self)
        
        return dateString
    }

    func hourTo24() -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "k"
        let dateString = formatter.string(from: self)
        
        let hourAsInteger = Int(dateString)
        return hourAsInteger
        
    }
    
    /// Converts a Date to an integer describing the weekday
    ///
    /// - Returns: an integer from 1 - 7, with 1 being Sunday and 7 being Saturday
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    
    /// Gets tomorrow's weekday as an integer
    ///
    /// - Returns: an integer from 1 - 7, with 1 being Sunday and 7 being Saturday
    func tomorrowsNumberOfTheWeek() -> Int {
        guard let numberOfToday = Date().dayNumberOfWeek() else { print("Error getting today's number");  return 0 }
        
        var tomorrow = 0
        tomorrow = numberOfToday == 7 ?  1 : numberOfToday + 1
        return tomorrow
    }
}
