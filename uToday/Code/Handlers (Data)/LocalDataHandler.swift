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
    
    
    //Getters:
    

}
