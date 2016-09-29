//
//  HourTableViewController.swift
//  Prepare-For-Rain
//
//  Created by Henry Dinhofer on 8/31/16.
//  Copyright © 2016 Henry Dinhofer. All rights reserved.
//

import UIKit

class HourTableViewController: UITableViewController {

    let store = DataStore.sharedDataStore
    
    var hours = Array<Hour>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        getTodaysHourlyWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.hourly.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourCell", for: indexPath)
        
        
        
        let precipitationProbability = self.store.hourly[indexPath.row].precipProbability
        let precipitationProbabilityAsFloat = precipitationProbability as! Float
        let precipitationProbabilityAsPercentage = Int(precipitationProbabilityAsFloat * 100)
        
        let precipitationIntensity = self.store.hourly[indexPath.row].precipIntensity
        let precipitationIntensityAsFloat = precipitationIntensity as! Float
        let precipitationIntensityPerInch = precipitationIntensityAsFloat * 100 // totally made up the inches part
        
        guard let time = self.store.hourly[indexPath.row].time else { fatalError("Couldn't unwrap hourly time") }
        let currentHour = self.store.hourly[indexPath.row]
        let displayText = "\(time.date()) w/ chance of rain \(precipitationProbabilityAsPercentage)% & intensity of rain \(precipitationIntensityPerInch)"
        
        cell.textLabel?.text = displayText
        cell.detailTextLabel?.text = currentHour.forecast?.time?.bestDate()
        
        return cell
    }
    
    func getTodaysHourlyWeather() {
        guard let hourly : Set<Hour> = self.store.forecasts.first?.hourly else { print("Couldn't get Set<Hour> from DataStore"); return }
        let hoursArray = Array(hourly)
        
        // Take only today's hourly weather
        let filteredHours = hoursArray.filter { (hour) -> Bool in
            let today = Date().date()
            guard let hoursTime = hour.time else { fatalError("Couldn't unrwap hours time") }
            let hoursDay = hoursTime.date()
            return today == hoursDay
        }
        
        // Then display from current hour ---> to end of day
        let sortedHours = filteredHours.sorted(by: { (first, second) -> Bool in
            guard let firstTime = first.time else { fatalError("Unable to unwrap first time") }
            guard let secondTime = second.time else { fatalError("Unable to unwrap second time") }
            return firstTime < secondTime
        })
        
        
        
        self.hours = sortedHours
        for hour in self.hours {
            print("Sorted hours \(hour.time?.date()) at \(hour.time?.dateHMapm()) AND chance of rain \(hour.precipProbability)")
        }
        
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
