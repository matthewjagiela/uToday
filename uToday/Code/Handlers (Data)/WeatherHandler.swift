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
    //Location Variables:
    var currentLocation:CLLocation!
    let locationManager = CLLocationManager()
    var userLocation = CLLocation()
    
    
    //API Key: 603692cb177160a63d1eeeb0d2125bfd //This is my current API key
    
    //Variables for the weather:
    var feelsLikeTemperature = 0 //This is how it feels outside sooooooo windchill
    var highTemperature = 0 //This is the high temp for the entire day
    var daySummary = ""
    var currentCondition = ""
    var temperature = 0
    var jsonDict = [String: Any]()
    override init() { //This is going to handle all the data we need and store it into variables when we initialize it so we can just pull them
        super.init()
        print("init")
        let locationManager = CLLocationManager()
        if (CLLocationManager.authorizationStatus() == .authorizedAlways) {
            userLocation = locationManager.location!
            print("The latitude of the current location is: \(userLocation.coordinate.latitude)")
            print("The longitude of the current location is \(userLocation.coordinate.longitude)")
            let weatherURL = URL(string: "https://api.darksky.net/forecast/603692cb177160a63d1eeeb0d2125bfd/\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)")
            
            
            var currentConditions = [String: Any]()
            var dailyWeatherDict = [String: Any]()
            var dailyWeather = NSArray()
            var todaysWeather = [String: Any]()
            
            print("WeatherURL:  \(String(describing: weatherURL))")
            
            Alamofire.request(weatherURL!).responseJSON { (response) in
                self.jsonDict = response.result.value as! [String: Any]
                
                currentConditions = self.jsonDict["currently"] as! [String: Any]
                dailyWeatherDict = self.jsonDict["daily"] as! [String: Any]
                dailyWeather = dailyWeatherDict["data"] as! NSArray
                todaysWeather = dailyWeather.object(at: 0) as! [String: Any]
                print("High: \(todaysWeather["apparentTemperatureHigh"] as! Double)")
                print("Summary: \(todaysWeather["summary"]as! String)")
                print("the current temp is: \(currentConditions["apparentTemperature"] as! Double)")
                print("Weather grabbed from the URL: \(String(describing: weatherURL))")
                
                
                
                self.feelsLikeTemperature = Int(round(currentConditions["apparentTemperature"] as! Double))
                self.highTemperature = Int(round(todaysWeather["apparentTemperatureHigh"] as! Double))
                self.daySummary = todaysWeather["summary"] as! String
                self.currentCondition = currentConditions["summary"] as! String
                self.temperature = Int(round(currentConditions["temperature"] as! Double))
                self.testAllVariables()
                
            }
            
            
           
            
            
        }
        else{
            locationManager.requestAlwaysAuthorization() //This is going to be removed for something else when we have a setup page
        }
        
    }
    
    private func testAllVariables(){
        print("WEATHER HANDLER TESTING:")
        print("feelsLikeTemperature: \(feelsLikeTemperature)")
        print("highTemperature: \(highTemperature)")
        print("daySummary: \(daySummary)")
        print("currentCondition: \(currentCondition)")
        print("temperature: \(temperature)")
    }
}
