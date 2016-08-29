//
//  Minute+CoreDataProperties.swift
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

extension Minute {

    @NSManaged var time: NSDate?
    @NSManaged var precipIntensity: NSNumber?
    @NSManaged var precipProbability: NSNumber?
    @NSManaged var forecast: Forecast?

}