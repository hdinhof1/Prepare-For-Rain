//
//  DataStore.swift
//  Prepare-For-Rain
//
//  Created by Henry Dinhofer on 8/28/16.
//  Copyright © 2016 Henry Dinhofer. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON


class DataStore {
    var forecasts:[Forecast] = []
    var minutes: [Minute] = []
    var hourly: [Hour] = []
    
    static let sharedDataStore = DataStore()
    fileprivate init() {}
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Could not save context \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func fetchData ()
    {
        
        self.forecasts = fetchDataByEntity("Forecast", key: "time", ascending: false) as! [Forecast]
        self.minutes = fetchDataByEntity("Minute", key: "time", ascending: false) as! [Minute]
        self.hourly = fetchDataByEntity("Hour", key: "time", ascending: false) as! [Hour]
    }
    
    func fetchDataByEntity(_ entityName: String, key: String?, ascending : Bool) -> [AnyObject] {
        var fetchArray : [AnyObject] = []
        var nserror: NSError?
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        // Swift 2.3        let fetchRequest = NSFetchRequest(entityName: entityName)
        // Swift 3.0        let fetchReqestForecast: NSFetchRequest<NSFetchRequestResult> = Forecast.fetchRequest()
        // Swift 3.0 fancy  let request = NSFetchRequest<Forecast>(entityName: "Forecast")

        
        if let sortKey = key {
            let createSort = NSSortDescriptor(key: sortKey, ascending: ascending)
            fetchRequest.sortDescriptors = [createSort]
        }
        
        do{
            fetchArray = try managedObjectContext.fetch(fetchRequest)
        }catch {
            nserror = error as NSError
            NSLog("Unable to fetch data by entity name.  \(nserror), \(nserror?.userInfo)")
            abort()
            
        }
        return fetchArray
    }
    
    
    // MARK: - Core Data stack
    
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "HLD.Prepare_For_Rain" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    // MARK: - Must change the URLForResource here to match project name
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "Prepare_For_Rain", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Creating new Classes insertNewObjectForEntityForName
    func makeForecast(_ currently: [String : JSON]) -> Forecast {
        let forecast : Forecast = NSEntityDescription.insertNewObject(forEntityName: "Forecast", into: managedObjectContext) as! Forecast
        
        forecast.summary = currently["summary"]?.stringValue
        forecast.time = currently["time"]?.doubleValue.asNSDate()
        forecast.currentTemp = currently["temperature"]?.floatValue as NSNumber?
        forecast.currentApparentTemp = currently["apparentTemperature"]?.floatValue as NSNumber?
        forecast.currentHumidity = currently["humidity"]?.floatValue as NSNumber?
        forecast.currentPressure =  currently["pressure"]?.floatValue as NSNumber?
        forecast.currentOzone = currently["ozone"]?.floatValue as NSNumber?
        forecast.currentNearestStormDistance = currently["nearestStormDistance"]?.floatValue as NSNumber?
        forecast.currentPrecipProbability = currently["precipProbability"]?.floatValue as NSNumber?
        forecast.currentPrecipIntensity = currently["precipIntensity"]?.floatValue as NSNumber?
        //forecast.timeZone = currently["timezone"]?.stringValue
        
        saveContext()
        fetchData()
        
        return forecast
    }
    
    
    // Creates Minute to be saved into managedObjectContext
    func addMinute(minute dictionary: [String : JSON], toForecast forecast: Forecast) {
        let minute : Minute = NSEntityDescription.insertNewObject(forEntityName: "Minute", into:managedObjectContext) as! Minute
        
        let doubleTime = dictionary["time"]?.doubleValue
        let timeInterval = TimeInterval(doubleTime!)
        let timeAsDate = Date(timeIntervalSince1970: timeInterval)
        
        minute.time = timeAsDate
        minute.precipIntensity = dictionary["precipIntensity"]?.floatValue as NSNumber?
        minute.precipProbability = dictionary["precipProbability"]?.floatValue as NSNumber?
        minute.forecast = forecast
        forecast.minutely?.insert(minute)
        
        saveContext()
        fetchData()
    }
    
    // Create Hour to be saved into managedObjectContext
    func addHour(hourly hourList: [JSON], toForecast forecast: Forecast) {
        for hour in hourList {
            let newHour : Hour = NSEntityDescription.insertNewObject(forEntityName: "Hour", into: managedObjectContext) as! Hour
            
            
            newHour.time = hour["time"].doubleValue.asNSDate()
            newHour.icon = hour["icon"].stringValue
            newHour.precipIntensity = hour["precipIntensity"].floatValue as NSNumber?
            newHour.precipProbability = hour["precipProbability"].floatValue as NSNumber?
            newHour.precipType = hour["precipType"].string
            newHour.temperature = hour["temperature"].floatValue as NSNumber?
            newHour.apparentTemperature = hour["apparentTemperature"].floatValue as NSNumber?
            newHour.dewPoint = hour["dewPoint"].floatValue as NSNumber?
            newHour.humidity = hour["humidity"].floatValue as NSNumber?
            newHour.windSpeed = hour["windSpeed"].floatValue as NSNumber?
            newHour.visibility = hour["visibility"].floatValue as NSNumber?
            newHour.cloudCover = hour["cloudCover"].floatValue as NSNumber?
            newHour.pressure = hour["pressure"].floatValue as NSNumber?
            newHour.ozone = hour["ozone"].floatValue as NSNumber?
//            newHour.summary = hour["summary"].stringValue
            forecast.hourly?.insert(newHour)
            

            print ("New time \(newHour.time?.bestDate()) with chance of rain \(newHour.precipProbability!) and intensity of rain \(newHour.precipIntensity!)")
        }
        
        saveContext()
        fetchData()
    }
    /**
     Calls Forecast.io and gets new weather data.
     
     - Completion: When the function has finished acquiring and setting up the data.
     
     */
    func getForecastWithCompletion(_ completion : @escaping () -> ()) {
        print ("Getting forecast for today")
        // All other times the user runs the app
        ForecastAPIClient.getForecastWithCompletion { (json) in
            /* How to calculate the size of JSON object --> 28 KB
             let data = try? json.rawData()
             let formatted = NSByteCountFormatter.stringFromByteCount(
             Int64(data!.length),
             countStyle: NSByteCountFormatterCountStyle.File)
             
             print (formatted)
             */
            
            print ("Inside view will appear")
            let currently = json["currently"].dictionaryValue // entire "currently" dictionary
            let forecast = self.makeForecast(currently)
            
            let minutely = json["minutely"]["data"].arrayValue // array of minute objects
            for minute in minutely {
                let minuteDict = minute.dictionaryValue
                self.addMinute(minute: minuteDict, toForecast: forecast)
            }
            
            let hourly = json["hourly"]["data"].arrayValue  // array of hour objects
            self.addHour(hourly: hourly, toForecast: forecast)
            
            let daily = json["daily"].dictionaryValue
            
            completion()
        }
        
    }
    func isFirstTimeFetchingWeatherToday() -> Bool {
        var isFirstTime : Bool = true
        
        // If this is the second time or more the user is using the app, checks if we have pulled forecast for today
        if self.forecasts.count > 0 {
            guard let mostRecentForecastDate = self.forecasts[0].time?.date() else { fatalError("Unable to unwrap most recent forecast") }
            let today = Date()
            let todaysDate = today.date()
            print ("Is \(mostRecentForecastDate) == \(todaysDate)? \(mostRecentForecastDate == todaysDate)")
            
            // If we have already gotten the weather for today, do nothing
            if mostRecentForecastDate == todaysDate { isFirstTime = false }
            
        }
        return isFirstTime
    }
    func getThreeDaysOfHourlyWeather() -> [Hour] {
        guard let hourly : Set<Hour> = self.forecasts.first?.hourly else { print("Couldn't get Set<Hour> from DataStore"); return [Hour]() }
        let hoursArray = Array(hourly)
        
        let sortedHours = hoursArray.sorted(by: { (first, second) -> Bool in
            guard let firstTime = first.time else { fatalError("Unable to unwrap first time") }
            guard let secondTime = second.time else { fatalError("Unable to unwrap second time") }
            return firstTime < secondTime
        })
        
        return sortedHours
    }
}

