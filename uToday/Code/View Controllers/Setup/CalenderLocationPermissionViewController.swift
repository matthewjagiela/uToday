//
//  CalanderLocationPermissionViewController.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/24/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//  This class soley makes it so that the user knows and grants access to letting us use their location and access their calender

import UIKit
import CoreLocation

class CalenderLocationPermissionViewController: UIViewController {

    let locationManager = CLLocationManager()
    var calendarAccess = false
    var locationAccess = false
    let calendar = CalendarHandler()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //navigationController?.navigationBar.isTranslucent = false
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @IBAction func requestCalendar(_ sender: Any) {
        calendar.requestCalenderAccess()
        calendarAccess = true
        
    }
    @IBAction func requestLocation(_ sender: Any) {
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.authorizationStatus() == .denied {
            let alert = UIAlertController(title: "Location Denied", message: "You have denied uToday location services. Note you will not be allowed to use weather or traffic information till granted...", preferredStyle: .alert)
            self.present(alert, animated: true)
        } else {
            print("LOCATION AUTHORIZED")
        }
        locationAccess = true
        if calendarAccess && locationAccess {self.performSegue(withIdentifier: "stageThree", sender: self)}
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
