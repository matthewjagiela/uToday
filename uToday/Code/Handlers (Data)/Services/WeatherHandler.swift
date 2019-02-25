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
    let savedData = LocalDataHandler()
    
    
    //API Key: 603692cb177160a63d1eeeb0d2125bfd //This is my current API key
    
    //Variables for the weather:
    var feelsLikeTemperature = 0 //This is how it feels outside sooooooo windchill
    var highTemperature = 0 //This is the high temp for the entire day
    var daySummary = ""
    var currentCondition = ""
    var temperature = 0
    var dayLowTemperature = 0
    var iconToFind = ""
    var currentConditionImg = UIImage()
    var isDayTime = Bool()
    
    var apiDict = [String: Any]()
    override init() { //This is going to handle all the data we need and store it into variables when we initialize it so we can just pull them
        
    }
    
    func getData(completion: @escaping () -> ()){
       
        print("getData")
        if (CLLocationManager.authorizationStatus() == .authorizedAlways) { //The application has actually been authorized to use locations
            userLocation = locationManager.location! //This is the actual user location
            print("The latitude of the current location is: \(userLocation.coordinate.latitude)") //Used for testing
            print("The longitude of the current location is \(userLocation.coordinate.longitude)") //Used for testing
            let weatherURL = URL(string: "https://api.darksky.net/forecast/603692cb177160a63d1eeeb0d2125bfd/\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)") //This is the url we need to make the URL request to get the weather DATA
            
            
            var currentConditions = [String: Any]() //This is going to be the data for the current conditions
            var dailyWeatherDict = [String: Any]() //This is going to be the daily conditions for the day
            var dailyWeather = NSArray() //The api splits the day into sperate parts. This is going to allow us to get the first part (recent)
            var todaysWeather = [String: Any]() //This is going to be all of the data from the first part of the weather stuff
            
            print("WeatherURL:  \(String(describing: weatherURL))") //Testing to make sure the URL is valid
            
            Alamofire.request(weatherURL!).responseJSON { (response) in //So this is going to go to the API and get the data
                self.apiDict = response.result.value as! [String: Any] //This is the entire data set from the API
                
                currentConditions = self.apiDict["currently"] as! [String: Any]
                dailyWeatherDict = self.apiDict["daily"] as! [String: Any]
                dailyWeather = dailyWeatherDict["data"] as! NSArray
                todaysWeather = dailyWeather.object(at: 0) as! [String: Any]
                //Testing to make sure the variables are filled
                print("High: \(todaysWeather["apparentTemperatureHigh"] as! Double)")
                print("Summary: \(todaysWeather["summary"]as! String)")
                print("the current temp is: \(currentConditions["apparentTemperature"] as! Double)")
                print("Weather grabbed from the URL: \(String(describing: weatherURL))")
                
                
                //This is going to set all the variables that we need to return later.
                self.iconToFind = currentConditions["icon"] as! String
                self.feelsLikeTemperature = Int(round(currentConditions["apparentTemperature"] as! Double))
                self.highTemperature = Int(round(todaysWeather["apparentTemperatureHigh"] as! Double))
                self.daySummary = todaysWeather["summary"] as! String
                self.currentCondition = currentConditions["summary"] as! String
                self.temperature = Int(round(currentConditions["temperature"] as! Double))
                self.dayLowTemperature = Int(round(todaysWeather["apparentTemperatureLow"] as! Double))
                //This is going to make sure all of the variables have something in it
                //self.getWeatherImage()
                self.saveAllData()
                self.testAllVariables()
                completion()
            }
        }
        else{
            locationManager.requestAlwaysAuthorization() //This is going to be removed for something else when we have a setup page
        }
    }
    func saveAllData(){ //We are going to save the data locally so we can have something to load
        savedData.setWeatherFeelsLikeTemperature(temperature: feelsLikeTemperature)
        savedData.setWeatherHighTemperature(temperature: highTemperature)
        savedData.setWeatherDaySummary(summary: daySummary)
        savedData.setWeatherCurrentCondition(condition: currentCondition)
        savedData.setWeatherTemperature(temperature: temperature)
        savedData.setWeatherLowTemperature(temperature: dayLowTemperature)
        savedData.setWeatherIcon(icon: iconToFind)
        
    }
    func getFeelsLikeTemperature() -> Int{
        return feelsLikeTemperature
    }
    func getHighTemperature() -> Int{
        return highTemperature
    }
    func getSummary() -> String{
        return daySummary
    }
    func getCurrentCondition() -> String{
        return currentCondition
    }
    func getCurrentTemperature() ->Int{
        return temperature
    }
    func getDailyLow() -> Int{
        return dayLowTemperature
    }
    func getWeatherImage() -> UIImage{ //ALRIGHT sooooo.... This is going to determine the image we want to show based on the weather conditions and time.
        print("Icon To Find: \(iconToFind)")
        if(iconToFind == "rain"){
            currentConditionImg = UIImage(named: "Rain.png")!
        }
        if(iconToFind == "partly-cloudy-day"){
            print("IF = partly cloudy day")
            currentConditionImg = UIImage(named: "Partly Cloudy.png")!
        }
        else if(iconToFind == "partly-cloudy-night"){
            currentConditionImg = UIImage(named: "NightCloudy.png")!
        }
        else if(iconToFind == "cloudy" || iconToFind == "fog"){
            currentConditionImg = UIImage(named: "Cloudy.png")!
        }
        else if(iconToFind == "clear-day"){
            currentConditionImg = UIImage(named: "Sunny.png")!
        }
        else if(iconToFind == "clear-night"){
            currentConditionImg = UIImage(named: "Moon.png")!
        }
        else if(iconToFind == "snow" || iconToFind == "sleet" || iconToFind == "hail"){
            currentConditionImg = UIImage(named: "Snow.png")!
        }
        
        return currentConditionImg
        
    }
    func getWeatherImage(image: String) -> UIImage{ //ALRIGHT sooooo.... This is going to determine the image we want to show based on the weather conditions and time.
        print("Icon To Find: \(iconToFind)")
        if(image == "rain"){
            currentConditionImg = UIImage(named: "Rain.png")!
        }
        if(image == "partly-cloudy-day"){
            print("IF = partly cloudy day")
            currentConditionImg = UIImage(named: "Partly Cloudy.png")!
        }
        else if(image == "partly-cloudy-night"){
            currentConditionImg = UIImage(named: "NightCloudy.png")!
        }
        else if(image == "cloudy" || iconToFind == "fog"){
            currentConditionImg = UIImage(named: "Cloudy.png")!
        }
        else if(image == "clear-day"){
            currentConditionImg = UIImage(named: "Sunny.png")!
        }
        else if(image == "clear-night"){
            currentConditionImg = UIImage(named: "Moon.png")!
        }
        else if(image == "snow" || iconToFind == "sleet" || iconToFind == "hail"){
            currentConditionImg = UIImage(named: "Snow.png")!
        }
        
        return currentConditionImg
        
    }
    
    private func testAllVariables(){
        print("WEATHER HANDLER TESTING:")
        print("feelsLikeTemperature: \(feelsLikeTemperature)")
        print("highTemperature: \(highTemperature)")
        print("daySummary: \(daySummary)")
        print("currentCondition: \(currentCondition)")
        print("temperature: \(temperature)")
        print("Low Temperature: \(dayLowTemperature)")
        print("Icon: \(iconToFind)")
    }
}