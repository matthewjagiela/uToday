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
    lazy var weather = WeatherHandler() //If it is not needed it wont be stored in memory....
    lazy var traffic = TrafficHandler()
    init(Service:String){
        super.init()
        service = Service //Set the service to this
    }
    
    func getServiceSummary() ->String { //Figure out the handler and return the summary for the table
        //Do a switch statement to figure out what to return
        switch service {
        case "weather":
            return weather.getSummary()
        case "traffic":
            return traffic.getSummary()
        default:
            return ""
        }
        
    }
    func getSegue(service: String) -> String{
        
        return ""
    }
    

}
