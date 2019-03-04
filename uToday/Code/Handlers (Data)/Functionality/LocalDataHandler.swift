//
//  LocalDataHandler.swift
//  uToday
//
//  Created by Matthew Jagiela on 1/21/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//
// THIS IS GOING TO HANDLE ALL THE SAVED DATA ON THE DEVICE ITSELF (This is going to be the main one used

import UIKit

class LocalDataHandler: NSObject {
    var defaults = UserDefaults()
    
    override init() { //We need to initialize something every time this method becomes available
        defaults = UserDefaults.init(suiteName: "group.com.uapps.uToday")! //This is the container where everything for the app is saved. If we code correctly this is the only place we will ever need to place this statement (if this is null which it shouldn't be it will not execute)
 
    }
    
    
    //Setters:
    //Startup Setters:
    func setFirstName(_ name: String){
        defaults.set(name, forKey: "firstName")
    }
    //Weather Setters:
    func setWeatherFeelsLikeTemperature(temperature: Int){
        defaults.set(temperature, forKey: "weatherFeelsTemperature")
    }
    func setWeatherHighTemperature(temperature: Int){
        defaults.set(temperature, forKey: "weatherHighTemperature")
    }
    func setWeatherDaySummary(summary: String){
        defaults.set(summary, forKey: "weatherDailySummary")
    }
    func setWeatherCurrentCondition(condition:String){
        defaults.set(condition, forKey: "weatherCondition")
    }
    func setWeatherTemperature(temperature:Int){
        defaults.set(temperature, forKey: "weatherTemperature")
    }
    func setWeatherLowTemperature(temperature:Int){
        defaults.set(temperature, forKey: "weatherLowTemperature")
    }
    func setWeatherIcon(icon: String){
        defaults.set(icon, forKey: "weatherImagePointer")
    }
    //Traffic Information:
    func setWorkAddress(address: String){
        defaults.set(address, forKey:"workAddress")
    }
    
    //Getters:
    //Setup Getters:
    func getFirstName() -> String{ //Get the users first name... If for some reason it is nill it will become Matthew.
        return defaults.string(forKey: "firstName") ?? "Matthew"
    }
    //Weather:
    func getWeatherFeelsLikeTemperature() ->Int{
        return defaults.integer(forKey: "weatherFeelsTemperature")
    }
    func getWeatherHighTemperature() ->Int{
        return defaults.integer(forKey: "weatherHighTemperature")
    }
    func getWeatherDaySumarray() -> String{
        return defaults.string(forKey: "weatherDailySummary")!
    }
    func getWeatherCurrentCondition() ->String{
        return defaults.string(forKey: "weatherCondition")!
    }
    func getWeatherTemperature() -> Int{
        return defaults.integer(forKey: "weatherTemperature")
    }
    func getWeatherLowTemperature() ->Int{
        return defaults.integer(forKey: "weatherLowTemperature")
    }
    func getWeatherIcon() -> String{
        return defaults.string(forKey: "weatherImagePointer")!
    }
    //Traffic Information:
    func getWorkAddress() -> String{
        return defaults.string(forKey: "workAddress")!
        //return "275 Mount Carmel Ave, Hamden, CT, 06518" //Testing use only.
    }
    
    
    

}
