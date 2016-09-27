//
//  Hour+CoreDataProperties.swift
//  Prepare-For-Rain
//
//  Created by Henry Dinhofer on 8/29/16.
//  Copyright © 2016 Henry Dinhofer. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Hour {

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
    @NSManaged var forecast: Forecast?

}
