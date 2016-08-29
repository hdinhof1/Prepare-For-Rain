//
//  ForecastAPIClient.swift
//  Prepare-For-Rain
//
//  Created by Henry Dinhofer on 8/28/16.
//  Copyright © 2016 Henry Dinhofer. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ForecastAPIClient {
    
    class func getForecastWithCompletion(completion: (JSON) -> ()) {
        let url = Secrets.url
        
        Alamofire.request(.GET, url)
            .responseJSON { (response) in
                switch response.result {
                case .Success:
                    print("Got forecast ")
                    let json = JSON(response.result.value!)
                    let currently = json["currently"].dictionaryValue // entire "currently" dictionary
                    let minutely = json["minutely"]["data"].arrayValue // array of minute objects
                    for minute in minutely {
                        //print (minute)
                    }
                    let hourly = json["hourly"]["data"].arrayValue
                    for hour in json["hourly"]["data"].arrayValue {
                        print(hour)
                    }
                    let daily = json["daily"]["data"].arrayValue
                    
                    completion(json)
                    
                case .Failure(let error):
                    print("Something went wrong getting repos \(error)")
                }
        }
    }
    
    
    
    // AlamoFire Request With HTTP Status Codes
    class func getRequestWithStatusCodes(completion:(Bool) -> ()) {
        let url = Secrets.url
        //let authHeaders = ["Authorization": "\(Secrets.personal_access_token)"]
        
        Alamofire.request(.GET,
            url,
            parameters: nil,
            encoding: ParameterEncoding.JSON,
            headers: nil).validate()
            .responseJSON { (data) in
                if let httpStatusCode = data.response?.statusCode {
                    switch httpStatusCode {
                    case 204:
                        completion(true)
                    case 404:
                        completion(false)
                    default:
                        print("Other status code \(httpStatusCode) with error \(data.result.error) ")
                    }
                }
                
        }
    }
}
