//
//  PrepareViewController.swift
//  Prepare-For-Rain
//
//  Created by Henry Dinhofer on 9/29/16.
//  Copyright © 2016 Henry Dinhofer. All rights reserved.
//

import UIKit

class PrepareViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var yesNoRainLabel: UILabel!
    @IBOutlet weak var youShouldOrNtPrepareForRain: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    
    let store = DataStore.sharedDataStore
    var hours = Array<Hour>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getThreeDaysOfHourlyWeather()
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Gets the forecast hour by hour for 3 days 
    // Returns set of all Forecastss 
    func getThreeDaysOfHourlyWeather() {
        guard let hourly : Set<Hour> = self.store.forecasts.first?.hourly else { print("Couldn't get Set<Hour> from DataStore"); return }
        let hoursArray = Array(hourly)
        
        let sortedHours = hoursArray.sorted(by: { (first, second) -> Bool in
            guard let firstTime = first.time else { fatalError("Unable to unwrap first time") }
            guard let secondTime = second.time else { fatalError("Unable to unwrap second time") }
            return firstTime < secondTime
        })
        
        self.hours = sortedHours
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard let precipitationProbability = self.hours[indexPath.row].precipProbability else { fatalError("Couldn't unwrap hourly precipitation probability") }
        let precipitationProbabilityAsFloat = precipitationProbability as Float
        let precipitationProbabilityAsPercentage = Int(precipitationProbabilityAsFloat * 100)
        var isGonnaRain : Bool = false
        let MINIMUM_PROBABILITY = 50
        if precipitationProbabilityAsPercentage > MINIMUM_PROBABILITY { isGonnaRain = true }
        
        guard let precipitationIntensity = self.hours[indexPath.row].precipIntensity else { fatalError("Unable to unwrap hourly precipitation intensity") }
        let precipitationIntensityAsFloat = precipitationIntensity as Float
        let precipitationIntensityPerInch = precipitationIntensityAsFloat * 100 // totally made up the inches part
        
        guard let time = self.hours[indexPath.row].time else { fatalError("Couldn't unwrap hourly time") }
        let currentHour = self.hours[indexPath.row]
        
        let displayText = "\(time.dateHMapm()) w/ chance of rain \(precipitationProbabilityAsPercentage)% & intensity of rain \(precipitationIntensityPerInch)"
        
        cell.textLabel?.text = displayText
        //cell.imageView?.image = UIImage(named: "rain")
        cell.detailTextLabel?.text = currentHour.forecast?.time?.bestDate()
        
        if isGonnaRain {
            cell.textLabel?.textColor = UIColor.blue
            yesNoRainLabel.text = "YES"
            youShouldOrNtPrepareForRain.text = "You should prepare for rain"
        }
        cell.textLabel?.font = UIFont(name: "Arial", size: 14.0)
        
        return cell
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
