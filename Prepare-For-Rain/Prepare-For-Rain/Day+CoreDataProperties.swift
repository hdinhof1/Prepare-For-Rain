//
//  Day+CoreDataProperties.swift
//  Prepare-For-Rain
//
//  Created by Henry Dinhofer on 8/28/16.
//  Copyright © 2016 Henry Dinhofer. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Day {

    @NSManaged var apparentTemperatureMax: NSNumber?
    @NSManaged var apparentTemperatureMaxTime: NSDate?
    @NSManaged var apparentTemperatureMin: NSNumber?
    @NSManaged var apparentTemperatureMinTime: NSDate?
    @NSManaged var humidity: NSNumber?
    @NSManaged var ozone: NSNumber?
    @NSManaged var precipIntensity: NSNumber?
    @NSManaged var precipIntensityMax: NSNumber?
    @NSManaged var precipProbability: NSNumber?
    @NSManaged var sunriseTime: NSDate?
    @NSManaged var sunsetTime: NSDate?
    @NSManaged var temperatureMax: NSNumber?
    @NSManaged var temperatureMaxTime: NSDate?
    @NSManaged var temperatureMin: NSNumber?
    @NSManaged var temperatureMinTime: NSDate?
    @NSManaged var time: NSDate?
    @NSManaged var windSpeed: NSNumber?
    @NSManaged var forecast: Forecast?

}
