//
//  Day+CoreDataProperties.swift
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

extension Day {

    @NSManaged var apparentTemperatureMax: NSNumber?
    @NSManaged var apparentTemperatureMaxTime: Date?
    @NSManaged var apparentTemperatureMin: NSNumber?
    @NSManaged var apparentTemperatureMinTime: Date?
    @NSManaged var humidity: NSNumber?
    @NSManaged var icon: String?
    @NSManaged var ozone: NSNumber?
    @NSManaged var precipIntensity: NSNumber?
    @NSManaged var precipIntensityMax: NSNumber?
    @NSManaged var precipIntensityMaxTime: Date?
    @NSManaged var precipProbability: NSNumber?
    @NSManaged var precipType: String?
    @NSManaged var summary: String?
    @NSManaged var sunriseTime: Date?
    @NSManaged var sunsetTime: Date?
    @NSManaged var temperatureMax: NSNumber?
    @NSManaged var temperatureMaxTime: Date?
    @NSManaged var temperatureMin: NSNumber?
    @NSManaged var temperatureMinTime: Date?
    @NSManaged var time: Date?
    @NSManaged var windSpeed: NSNumber?
    @NSManaged var forecast: Forecast?

}
