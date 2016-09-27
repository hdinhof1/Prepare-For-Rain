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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if store.isFirstTimeFetchingWeatherToday() {
            
            store.getForecastWithCompletion {
                self.store.fetchData()
                self.tableView.reloadData()
            }
        }
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func manuallyGetForecastTapped(_ sender: AnyObject) {
        self.store.getForecastWithCompletion { 
            self.tableView.reloadData()

        }
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return store.forecasts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath)

        cell.textLabel?.text = store.forecasts[(indexPath as NSIndexPath).row].time?.bestDate()
        cell.detailTextLabel?.text = "\(store.forecasts[(indexPath as NSIndexPath).row].currentPrecipProbability!)"
        
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the row's number we just tapped
        guard let currentRow = (tableView.indexPathForSelectedRow as NSIndexPath?)?.row else { print("Couldn't unwrap cell's row in ForecastTableView \(tableView.indexPathForSelectedRow)"); return }
        
        if segue.destination.isKind(of: MinuteTableViewController.self) {
            let destinationMinutesTableViewController = segue.destination as! MinuteTableViewController
            
            // Weather minute-by-minute for the next hour
            guard let minuteSet = self.store.forecasts[currentRow].minutely else { print("Couldn't get Set<Minute> from DataStore"); return }
            let minutesArray = Array(minuteSet)
            destinationMinutesTableViewController.minutes = minutesArray
        }
        
    }
    

}
