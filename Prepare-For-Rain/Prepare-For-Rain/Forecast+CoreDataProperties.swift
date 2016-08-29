//
//  Forecast+CoreDataProperties.swift
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

extension Forecast {

    @NSManaged var summary: String?
    @NSManaged var time: NSDate?
    @NSManaged var currentTemp: NSNumber?
    @NSManaged var currentApparentTemp: NSNumber?
    @NSManaged var currentHumidity: NSNumber?
    @NSManaged var currentPressure: NSNumber?
    @NSManaged var currentOzone: NSNumber?
    @NSManaged var currentNearestStormDistance: NSNumber?
    @NSManaged var summaryDaily: String?
    @NSManaged var daily: Set<Day>?
    @NSManaged var hourly: Set<Hour>?
    @NSManaged var minutely: Set<Minute>?

}
