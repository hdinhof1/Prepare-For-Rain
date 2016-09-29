//
//  Secrets.swift
//  Prepare-For-Rain
//
//  Created by Henry Dinhofer on 8/24/16.
//  Copyright © 2016 Henry Dinhofer. All rights reserved.
//

import Foundation

struct Secrets {
    static let forecastAPI_Key = "ff601732d8248da92bf6af2782a70953"
    static let home_latitude = 40.737640
    static let home_longitude = -73.993814
    
    static let url_for_home = "https://api.darksky.net/forecast/\(forecastAPI_Key)/\(home_latitude),\(home_longitude)"
    static let url = "https://api.darksky.net/forecast/ff601732d8248da92bf6af2782a70953/40.737640,-73.993814" //Same as weather_for_home
    
}
