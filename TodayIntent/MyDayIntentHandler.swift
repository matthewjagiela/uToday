//
//  MyDayIntentHandler.swift
//  TodayIntent
//
// This is going to handle all of the Siri Request type things
//
//  Created by Matthew Jagiela on 4/1/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit

class MyDayIntentHandler: NSObject, MyDayIntentHandling {
    let services = ServiceHandler()
    let savedData = LocalDataHandler() //To get the name only...
    func confirm(intent: MyDayIntent, completion: @escaping (MyDayIntentResponse) -> Void) { //If this is "MyDayIntent" which is the only intent erverything in this block should load...
        services.loadingDone { //When this is done Siri is able to display results
            print("DEBUG SIRI: FINISHED")
            completion(MyDayIntentResponse(code: .ready, userActivity: nil)) //The data has been downloaded and Siri is going to be able to read everything
            
        }
    }
    func handle(intent: MyDayIntent, completion: @escaping (MyDayIntentResponse) -> Void) { //This is what Siri is going to use to handle the intent...
        let calendarSummary = services.calendar.getSummary()
        let trafficSummary = savedData.getTrafficSummary()
        let weatherSummary = savedData.getWeatherDaySummary()
        let newsSummary = savedData.getNewsSummary()
        completion(MyDayIntentResponse.success(name: savedData.getFirstName(), weather: weatherSummary, calendar: calendarSummary, traffic: trafficSummary, news: newsSummary)) //Siri reads this
        
    }

}
