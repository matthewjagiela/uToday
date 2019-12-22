//
//  ServiceHandler.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/13/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit

class ServiceHandler: NSObject {
    var service = ""
    let weather = WeatherHandler() //If it is not needed it wont be stored in memory....
    let traffic = TrafficHandler()
    let calendar = CalendarHandler()
    let news = NewsHandler()
    let services = ["Weather", "Traffic", "Calendar", "News"]
    
    override init() {
        super.init()
    }
    init(Service: String) {
        super.init()
        service = Service //Set the service to this
    }
    func setService(_ service: String) {
        self.service = service
    }
    func getServiceSummary() -> String { //Figure out the handler and return the summary for the table
        //Do a switch statement to figure out what to return
        switch service {
        case "Weather":
            return weather.getSummary()
        case "Traffic":
            return traffic.getSummary()
        case "Calendar":
            return calendar.getSummary()
        case "News":
            print("DEBUG NEWS: GET SUMMARY HANDLER")
            return news.getSummary()
        default:
            return ""
        }
        
    }
    func loadingDone(completion: @escaping () -> Void) { //We need this because these services need to download the web and then display... It makes it do it first. 
        var completedSteps = 0 //When this is 3 we can pass the completion handler... (enabled - 1)
        weather.getData {
            print("Weather done")
            completedSteps += 1
            if completedSteps == 3 {
                completion()
            }
        }
        traffic.getETA {
            print("Traffic Done")
            completedSteps += 1
            if completedSteps == 3 {
                completion()
            }
        }
        news.getArticles {
            print("Headlines fetched")
            completedSteps += 1
            if completedSteps == 3 {completion()}
        }
        
    }
    func getServices(_ index: Int) -> String {
        return services[index]
    }
    func getAmountOfServices() -> Int {
        return services.count
    }
    func getSegue() -> String { //This might not be used... Not sure yet
        return service
    }
    func serviceName() -> String {
        return service
    }
    func getServiceImage() -> UIImage {
        switch service {
        case "Weather":
            return weather.getWeatherImage()
        case "Traffic":
            return UIImage(named: "traffic.png")!
        case "Calendar":
            return UIImage(named: "calendar.png")!
        case "News":
            return UIImage(named: "news.png")!
        default:
            return UIImage()
            
        }
    }

}
