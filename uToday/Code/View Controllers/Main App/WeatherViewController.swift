//
//  WeatherViewController.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/11/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var welcomeMessage: UILabel!
    @IBOutlet var conditionImage: UIImageView!
    @IBOutlet var currentMessage: UILabel!
    @IBOutlet var todaysWeather: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var HighTemperature: UILabel!
    @IBOutlet var FeelsLike: UILabel!
    @IBOutlet var LowTemperature: UILabel!
    @IBOutlet var activityMonitor: UIActivityIndicatorView!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    let savedData = LocalDataHandler()
    let location = TrafficHandler()
    
    let weather = WeatherHandler() //Eventually ill pass the weather from the main screen to this so it doesn't use an API request...
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //We are going to populate with saved data and refresh in the background
        //populateSavedData()
        let hour = Calendar.current.component(.hour, from: Date())
        dayLabel.text = getDayOfWeek()
        let name = savedData.getFirstName()
        
        switch hour {
        case 1..<12 : welcomeMessage.text = "Good Morning,\n\(name)"
        case 12..<19 : welcomeMessage.text = "Good Afternoon,\n\(name)"
        case 19..<25 : welcomeMessage.text = "Good Evening,\n\(name)"
        default: welcomeMessage.text = "Good Night,\n\(name)"
        }
    
        activityMonitor.startAnimating()
        //self.populateSavedData()
        weather.getData {

            self.populateData()
            self.activityMonitor.isHidden = true
        }
    }
    override func viewWillAppear(_ animated: Bool) { //We did a bunch of stuff to kill the navigation bar so now we need to undo it.
        theming()
        
    }
    func theming() { //The notorious matthew jagiela theming method...
        if(weather.isSunUp()) {
            print("WEATHER CONTROLLER DEBUG: sun is up")
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.navigationItem.hidesBackButton = false
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
            
            navigationController?.navigationBar.barStyle = .default
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationController?.navigationBar.tintColor = .black
        } else { //Sun is down we can make things a little bit... Darker
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.navigationItem.hidesBackButton = false
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
            
            navigationController?.navigationBar.barStyle = .blackTranslucent
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController?.navigationBar.tintColor = .white
        }
        tabBarController?.tabBar.isHidden = true
    }
    func populateSavedData() { //This is going to populate the view with already saved data while we refresh in the background...
        conditionImage.image = weather.getWeatherImage(image: savedData.getWeatherIcon())
        temperature.text = "Temperature: \(savedData.getWeatherTemperature())"
        FeelsLike.text = "Feels Like: \(savedData.getWeatherFeelsLikeTemperature())"
        HighTemperature.text = "High Temp: \(savedData.getWeatherHighTemperature())"
        LowTemperature.text = "Low Temp: \(savedData.getWeatherLowTemperature())"
        currentMessage.text = "Currently: \(savedData.getWeatherCurrentCondition())"
        todaysWeather.text = "Today: \(savedData.getWeatherDaySummary())"
        
    }
    @objc func populateData() {
        conditionImage.image = weather.getWeatherImage()
        temperature.text = "Temperature: \(weather.getCurrentTemperature())"
        FeelsLike.text = "Feels Like: \(weather.getFeelsLikeTemperature())"
        HighTemperature.text = "High Temp: \(weather.getHighTemperature())"
        LowTemperature.text = "Low Temp: \(weather.getDailyLow())"
        currentMessage.text = "Currently: \(weather.getCurrentCondition())"
        todaysWeather.text = "Today: \(weather.getSummary())"
        if(weather.isSunUp()) {backgroundImage.image = UIImage(named: "Day Weather BG.png")} else {backgroundImage.image = UIImage(named: "Night Background.png")}
        location.lookupLocation {
            self.locationLabel.text = self.location.getCity()
            
        }
        //Determine based on location and time of day which image to use as the background (day or night)
        
    }
    func getDayOfWeek() -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: Date())
        switch weekDay {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "Unknown"
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle { //The status bar has to be set based on if the dark view or not is showing....
        if weather.isSunUp() { return .default} else {return .lightContent}
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
