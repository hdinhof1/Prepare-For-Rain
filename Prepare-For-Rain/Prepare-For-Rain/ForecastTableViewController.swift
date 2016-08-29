//
//  ForecastTableViewController.swift
//  Prepare-For-Rain
//
//  Created by Henry Dinhofer on 8/29/16.
//  Copyright © 2016 Henry Dinhofer. All rights reserved.
//

import UIKit

class ForecastTableViewController: UITableViewController {
    
    let store = DataStore.sharedDataStore
    
    override func viewDidLoad() {
        super.viewDidLoad()

        store.fetchData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(animated: Bool) {
        guard self.store.forecasts.count == 0  else { return }
        
        // Only if this isn't the first time the user is using the app
        if self.store.forecasts.count > 0 {
            let mostRecentForecastDay = self.store.forecasts[0].time?.dayOfTheWeek()
            let today = NSDate()
            let todaysDay = today.dayOfTheWeek()
            print ("Is \(mostRecentForecastDay) == \(todaysDay)?")
            
            // If we have already gotten the weather for today, do nothing
            if mostRecentForecastDay == todaysDay { return }
            
        } else { return }
        
        // All other times the user runs the app
        ForecastAPIClient.getForecastWithCompletion { (json) in
                    /* How to calculate the size of JSON object
                     let data = try? json.rawData()
                    let formatted = NSByteCountFormatter.stringFromByteCount(
                        Int64(data!.length),
                        countStyle: NSByteCountFormatterCountStyle.File)
                    
                    print (formatted)
                    */
            
            print ("Inside view will appear")
            let currently = json["currently"].dictionaryValue // entire "currently" dictionary
            let forecast = self.store.makeForecast(currently)
            
            let minutely = json["minutely"]["data"].arrayValue // array of minute objects
            for minute in minutely {
                let minuteDict = minute.dictionaryValue
                self.store.addMinute(minute: minuteDict, toForecast: forecast)
            }
            
            let hourly = json["hourly"]["data"].arrayValue
            self.store.addHour(hourly: hourly, toForecast: forecast)

            
            let daily = json["daily"].dictionaryValue
            
            
            self.store.fetchData()
            self.tableView.reloadData()
        }
 
        super.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func manuallyGetForecastTapped(sender: AnyObject) {
        ForecastAPIClient.getForecastWithCompletion { (json) in 
            
            let currently = json["currently"].dictionaryValue // entire "currently" dictionary
            let forecast = self.store.makeForecast(currently)
            
            let minutely = json["minutely"]["data"].arrayValue // array of minute objects
            for minute in minutely {
                let minuteDict = minute.dictionaryValue
                self.store.addMinute(minute: minuteDict, toForecast: forecast)
            }
            
            let hourly = json["hourly"]["data"].arrayValue
            self.store.addHour(hourly: hourly, toForecast: forecast)

            self.tableView.reloadData()
        }
    }
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return store.forecasts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("forecastCell", forIndexPath: indexPath)

        cell.textLabel?.text = store.forecasts[indexPath.row].time?.bestDate()
        cell.detailTextLabel?.text = "\(store.forecasts[indexPath.row].currentPrecipProbability!)"
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the row's number we just tapped
        guard let currentRow = tableView.indexPathForSelectedRow?.row else { print("Couldn't unwrap cell's row in ForecastTableView"); return }
        
        if segue.destinationViewController.isKindOfClass(MinuteTableViewController) {
            let destinationMinutesTableViewController = segue.destinationViewController as! MinuteTableViewController
            
            // Weather minute-by-minute for the next hour
            guard let minuteSet = self.store.forecasts[currentRow].minutely else { print("Couldn't get Set<Minute> from DataStore"); return }
            let minutesArray = Array(minuteSet)
            destinationMinutesTableViewController.minutes = minutesArray
        }
        
    }
    

}
