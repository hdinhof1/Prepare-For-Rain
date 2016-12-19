//
//  Hour+CoreDataProperties.swift
//  Prepare-For-Rain
//
//  Created by Henry Dinhofer on 12/18/16.
//  Copyright © 2016 Henry Dinhofer. All rights reserved.
//

import Foundation
import CoreData


extension Hour {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hour> {
        return NSFetchRequest<Hour>(entityName: "Hour");
    }

    @NSManaged var apparentTemperature: NSNumber?
    @NSManaged var cloudCover: NSNumber?
    @NSManaged var dewPoint: NSNumber?
    @NSManaged var humidity: NSNumber?
    @NSManaged var icon: String?
    @NSManaged var ozone: NSNumber?
    @NSManaged var precipIntensity: NSNumber?
    @NSManaged var precipProbability: NSNumber?
    @NSManaged var pressure: NSNumber?
    @NSManaged var summary: String?
    @NSManaged var temperature: NSNumber?
    @NSManaged var time: Date?
    @NSManaged var visibility: NSNumber?
    @NSManaged var windSpeed: NSNumber?
    @NSManaged var precipType: String?
    @NSManaged var forecast: Forecast?

}
