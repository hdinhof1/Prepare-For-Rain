//: Playground - noun: a place where people can play
//  ground -- a place where we wind up in


import UIKit

var str = "Hello, playground"


let rainTimes = [1, 2, 5, 7, 8, 9]
var overlappingTimes = [[Int]]()



// iterates over self.hours to check for rain

//      known issues: if the last element is a one hour/ one element rain, adds text 'and again between' at end
//      probable issues: checks at midnight
func makeNotificationString() -> String? {
    guard rainTimes.count > 0 else { return nil }
    var message : String?
    
    
    var overlappingInterval = [Int]()
    var lastHour = 0
    var startHour = -1
    for hour in rainTimes {
        
        print("Hour is \(hour) lastHour is \(lastHour) overlappingInterval.count= \(overlappingInterval.count)")
        
        if overlappingInterval.count == 0
        {
            overlappingInterval.append(hour)
            lastHour = hour
        }
        else if hour - 1 == lastHour
        {
            overlappingInterval.append(hour)
            lastHour = hour
        }
        else if hour - 1 != lastHour
        {
            //if overlappingInterval.count > 1 {  //TODO: comment this out if you want to include single-hour sets
            overlappingTimes.append(overlappingInterval)
            //}
            overlappingInterval.removeAll()
            overlappingInterval.append(hour)
            lastHour = hour
        }
        else {
            print("Something went wrong")
        }
    }
    if (overlappingInterval.count > 0) { // If we have one last interval at the end
        // TODO: make this > 1 if you want to not have last item be |S| = 1
        overlappingTimes.append(overlappingInterval)
    }
    
    // with array of overlapping sets make notification message
    if overlappingTimes.count == 0
    { // shouldn't get here!
        message = nil
    }
    else if overlappingTimes.count == 1
    {
        //TODO: write a blurb for one consecutive chunk of showers
        message = "RAIN today. Showers"
        for index in 0..<overlappingTimes.count {
            let hourSet = overlappingTimes[index]
            
            let startHour = hourSet.first ?? 1492
            var endHour = hourSet.last ?? 1492
            endHour += 1
            
            if index == 0 { message?.append(" from")    }
            
            if hourSet.count > 1 {
                
                message?.append(" \(startHour):00 PM - \(endHour):00 PM")
                
                let isNotLast = !(index == overlappingTimes.count - 1)
                if isNotLast {
                    message?.append(" and again between")
                }
                
            }
            else {   // rain one hour
                message?.append("lasting only an hour between \(startHour):00 PM and \(endHour):00 PM")
            }
        }
    }
    else {
        message = "RAIN today. Showers"
        for index in 0..<overlappingTimes.count {
            let hourSet = overlappingTimes[index]
            
            let startHour = hourSet.first ?? 1492
            var endHour = hourSet.last ?? 1492
            endHour += 1
            
            if index == 0 { message?.append(" from")    }
            
            if hourSet.count > 1 {
                
                message?.append(" \(startHour):00 PM - \(endHour):00 PM")
                
                let isNotLast = !(index == overlappingTimes.count - 1)
                if isNotLast {
                    message?.append(" and again between")
                }
                
            }
                
            else {  // rain one hour
                message?.appending(", \(startHour):00 PM - \(endHour):00 PM")
            }
        }
    }
    //    } else if overlappingTimes.count == 2
    //
    //
    //    else if overlappingTimes.count > 2 {
    //
    //    }
    
    return message
}


let finalMessage = "Rain today from 1 - 3pm, then again from 7 - 10pm"
print(makeNotificationString())
print("The final array is: ")

print(overlappingTimes)
