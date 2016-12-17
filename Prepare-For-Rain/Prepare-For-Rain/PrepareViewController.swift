//
//  PrepareViewController.swift
//  Prepare-For-Rain
//
//  Created by Henry Dinhofer on 9/29/16.
//  Copyright © 2016 Henry Dinhofer. All rights reserved.
//

//TODO: Get weather for just twoDays() -- up until 4am next day
//TODO: Incorporate Bluetooth LE
//TODO: Update plist file for background proceses

import UIKit

class PrepareViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var yesNoRainLabel: UILabel!
    @IBOutlet weak var youShouldOrNtPrepareForRain: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    
    let store = DataStore.sharedDataStore
    var hours = Array<Hour>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getThreeDaysOfHourlyWeather()
        getJustTodaysHourlyWeather()
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
        guard self.store.forecasts.first?.hourly?.count != 0 else { return }
        guard let hourly : Set<Hour> = self.store.forecasts.first?.hourly else { print("Couldn't get Set<Hour> from DataStore"); return }
        let hoursArray = Array(hourly)
        
        let sortedHours = hoursArray.sorted(by: { (first, second) -> Bool in
            guard let firstTime = first.time else { fatalError("Unable to unwrap first time") }
            guard let secondTime = second.time else { fatalError("Unable to unwrap second time") }
            return firstTime < secondTime
        })
        
        self.hours = sortedHours
    }
    
    // Gets the forecast for today and for tomorrow -- until 4am
    func getJustTodaysHourlyWeather() {
        guard let hourly : Set<Hour> = self.store.forecasts.first?.hourly else { print("Couldn't get Set<Hour> from DataStore"); return }
        let hoursArray = Array(hourly)
        
        let tomorrowsNumberOfTheWeek = Date().tomorrowsNumberOfTheWeek()
        let todaysNumberOfTheWeek = Date().dayNumberOfWeek() ?? 0  // nil-coalescing operator!!
        
        // filter just today and tomorrow
        let filteredHours = hoursArray.filter {
            guard let time = $0.time else { fatalError("Unable tot unwrap hour's time") }
            guard let weekdayNumber = time.dayNumberOfWeek() else { fatalError("Unable to unwrap hour's weekday") }
            
            if todaysNumberOfTheWeek == 7
            {
                return (weekdayNumber == 7) || (weekdayNumber == 1)
            }
            else {
                return weekdayNumber <= tomorrowsNumberOfTheWeek
            }
        }
        
        // today and tomorrow from midnight - 4am
        var todayList = [Hour]()
        for hour in filteredHours
        {
            guard let hourIn24 = hour.time?.hourTo24() else { print("Unable to unwrap hour to 24 hour military time"); return }
            if hour.time?.date() == Date().date() {
                todayList.append(hour)
                checkIsGonnaRain(precipitationProbability: hour.precipProbability)
            }
            else if hourIn24 == 24
            {
                todayList.append(hour)
                checkIsGonnaRain(precipitationProbability: hour.precipProbability)
            }
            else if hourIn24 < 5
            {
                todayList.append(hour)
                checkIsGonnaRain(precipitationProbability: hour.precipProbability)
            }
        }
        
        let sortedHours = todayList.sorted(by: { (first, second) -> Bool in
            guard let firstTime = first.time else { fatalError("Unable to unwrap first time") }
            guard let secondTime = second.time else { fatalError("Unable to unwrap second time") }
            return firstTime < secondTime
        })
        for hour in sortedHours {
            print(hour.time?.shortenedBestDate() ?? "ERROR")
        }
        
        self.hours = sortedHours
    }
    
    func checkIsGonnaRain(precipitationProbability : NSNumber?) {
        guard let chanceOfRain = precipitationProbability else { fatalError("Unable to access % chance of rain") }
        let chanceOfRainAsFloat = chanceOfRain as Float
        let chanceOfRainAsPercentage = Int(chanceOfRainAsFloat * 100)
        let MINIMUM_PROBABILITY = 50
        let isGonnaRain = chanceOfRainAsPercentage > MINIMUM_PROBABILITY
        
        if isGonnaRain
        {
            view.backgroundColor = UIColor.blue
            yesNoRainLabel.text = "YES"
            youShouldOrNtPrepareForRain.text = "You should prepare for rain"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //let cell = UITableViewCell()
        
        guard let precipitationProbability = self.hours[indexPath.row].precipProbability else { fatalError("Couldn't unwrap hourly precipitation probability") }
        let precipitationProbabilityAsFloat = precipitationProbability as Float
        let precipitationProbabilityAsPercentage = Int(precipitationProbabilityAsFloat * 100)
        let MINIMUM_PROBABILITY = 50
        let isGonnaRain = precipitationProbabilityAsPercentage > MINIMUM_PROBABILITY
        
        guard let precipitationIntensity = self.hours[indexPath.row].precipIntensity else { fatalError("Unable to unwrap hourly precipitation intensity") }
        let precipitationIntensityAsFloat = precipitationIntensity as Float
        let precipitationIntensityPerInch = precipitationIntensityAsFloat * 100 // totally made up the inches part
        
        guard let time = self.hours[indexPath.row].time else { fatalError("Couldn't unwrap hourly time") }
        let currentHour = self.hours[indexPath.row]
        
        //let displayText = "\(time.dateHMapm()) w/ chance of rain \(precipitationProbabilityAsPercentage)% & intensity of rain \(precipitationIntensityPerInch)"
        /*
        cell.textLabel?.text = displayText
        //cell.imageView?.image = UIImage(named: "rain")
        cell.detailTextLabel?.text = currentHour.forecast?.time?.bestDate()
        
        if isGonnaRain {
            cell.textLabel?.textColor = UIColor.blue
            yesNoRainLabel.text = "YES"
            youShouldOrNtPrepareForRain.text = "You should prepare for rain"
        }
        cell.textLabel?.font = UIFont(name: "Arial", size: 14.0)
        */
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        cell.timeLabel.text = "\(time.shortenedBestDate())"
        cell.percentChanceLabel.text = "Pct chance: \(precipitationProbabilityAsPercentage)%"
        cell.intensityRainLabel.text = "Intensity of rain \(precipitationIntensityPerInch)in"
        print("\(cell.timeLabel.text ?? "NARF") \(cell.percentChanceLabel.text ?? "NARF") \(cell.intensityRainLabel.text ?? "NARF")")
        print("\(cell.timeLabel.text ?? "NARF") isGonnaRain: \(isGonnaRain) precipAsFloat: \(precipitationProbabilityAsFloat) precip as %: \(precipitationProbabilityAsPercentage)")
        
        if isGonnaRain {
            cell.backgroundColor = UIColor.blue
        }
        else {
            cell.backgroundColor = UIColor.clear
        }
 
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
