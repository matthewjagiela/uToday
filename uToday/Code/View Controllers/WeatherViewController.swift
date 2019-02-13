//
//  WeatherViewController.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/11/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var welcomeMessage: UILabel!
    @IBOutlet var conditionImage: UIImageView!
    @IBOutlet var currentMessage: UILabel!
    @IBOutlet var todaysWeather: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var HighTemperature: UILabel!
    @IBOutlet var FeelsLike: UILabel!
    @IBOutlet var LowTemperature: UILabel!
    @IBOutlet var activityMonitor: UIActivityIndicatorView!
    
    let savedData = LocalDataHandler()
    
    
    let weather = WeatherHandler() //Eventually ill pass the weather from the main screen to this so it doesn't use an API request...
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //We are going to populate with saved data and refresh in the background
        //populateSavedData()
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 1..<12 : welcomeMessage.text = "Good Morning,\nMatthew"
        case 12..<17 : welcomeMessage.text = "Good Afternoon,\nMatthew"
        case 17..<25 : welcomeMessage.text = "Good Evening,\nMatthew"
        default: welcomeMessage.text = "Good Night,\nMatthew"
        }
        activityMonitor.startAnimating()
        //self.populateSavedData()
        weather.getData {

            self.populateData()
            self.activityMonitor.isHidden = true
        }
    }
    func populateSavedData(){ //This is going to populate the view with already saved data while we refresh in the background...
        conditionImage.image = weather.getWeatherImage(image: savedData.getWeatherIcon())
        temperature.text = "Temperature: \(savedData.getWeatherTemperature())"
        FeelsLike.text = "Feels Like: \(savedData.getWeatherFeelsLikeTemperature())"
        HighTemperature.text = "High Temp: \(savedData.getWeatherHighTemperature())"
        LowTemperature.text = "Low Temp: \(savedData.getWeatherLowTemperature())"
        currentMessage.text = "Currently: \(savedData.getWeatherCurrentCondition())"
        todaysWeather.text = "Today: \(savedData.getWeatherDaySumarray())"
    }
    @objc func populateData(){
        conditionImage.image = weather.getWeatherImage()
        temperature.text = "Temperature: \(weather.getCurrentTemperature())"
        FeelsLike.text = "Feels Like: \(weather.getFeelsLikeTemperature())"
        HighTemperature.text = "High Temp: \(weather.getHighTemperature())"
        LowTemperature.text = "Low Temp: \(weather.getDailyLow())"
        currentMessage.text = "Currently: \(weather.getCurrentCondition())"
        todaysWeather.text = "Today: \(weather.getSummary())"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
