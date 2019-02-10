//
//  WeatherHandler.swift
//  uToday
//
//  Created by Matthew Jagiela on 7/8/18.
//  Copyright © 2018 Matthew Jagiela. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
class WeatherHandler: NSObject, CLLocationManagerDelegate {
    var currentLocation:CLLocation!
    var temperature = 0
    let locationManager = CLLocationManager()
    var userLocation = CLLocation()
    //API Key: 603692cb177160a63d1eeeb0d2125bfd
    override init() {
        print("init")
        let locationManager = CLLocationManager()
        if (CLLocationManager.authorizationStatus() == .authorizedAlways) {
            userLocation = locationManager.location!
            print("The latitude of the current location is: \(userLocation.coordinate.latitude)")
            print("The longitude of the current location is \(userLocation.coordinate.longitude)")
            let weatherURL = URL(string: "https://api.darksky.net/forecast/603692cb177160a63d1eeeb0d2125bfd/\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)")
            print("WeatherURL:  \(String(describing: weatherURL))")
            Alamofire.request(weatherURL!).responseJSON { (response) in
                let jsonDict = response.result.value as! [String: Any]
                let currentConditions = jsonDict["currently"] as! [String: Any]
                let dailyWeatherDict = jsonDict["daily"] as! [String: Any]
                let dailyWeather = dailyWeatherDict["data"] as! NSArray
                let todaysWeather = dailyWeather.object(at: 0) as! [String: Any]
                print("High: \(todaysWeather["apparentTemperatureHigh"] as! Double)")
                print("Summary: \(todaysWeather["summary"]as! String)")
                print("the current temp is: \(currentConditions["apparentTemperature"] as! Double)")
                print("Weather grabbed from the URL: \(String(describing: weatherURL))")
            }
            
        }
        else{
            locationManager.requestAlwaysAuthorization()
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Updated")
        if let location = locations.first{
            print(location.coordinate)
        }
    }
}
