//
//  TrafficHanlder.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/19/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class TrafficHanlder: NSObject {
    let savedData = LocalDataHandler()
    let locationManager = CLLocationManager()
    
    var destinationLocation = CLLocation()
    var timeSeconds = 0
    var distance:Double = 0.0
    var directionsRequest = MKDirections.Request()
    override init(){
        super.init()
        locationManager.requestAlwaysAuthorization() //Remove this in final product.
        
    }
    
    func getETA(completion: @escaping() -> ()){
        if(CLLocationManager.authorizationStatus() == .authorizedAlways){
            let address = savedData.getWorkAddress()
            print("DEBUG: TRAFFIC ADDRESS: \(address) ")
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address) { (placemarks, error) in
                print("DEBUG: \(String(describing: placemarks?.first?.location?.coordinate.latitude)) \(String(describing: placemarks?.first?.location?.coordinate.longitude))" )
                self.destinationLocation = (placemarks?.first?.location)!
                let userlocation = self.locationManager.location! //This is our location...
                let sourcePlacemark = MKPlacemark(coordinate: userlocation.coordinate, addressDictionary: nil)
                let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
                //Destination handling:
                print("DEBUG TRAFFIC: Destination Coordinates: \(self.destinationLocation.coordinate.latitude)")
                let destinationPlacemark = MKPlacemark(coordinate: self.destinationLocation.coordinate, addressDictionary: nil)
                let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
                //Let's make the request for routing:
                
                
                self.directionsRequest.source = sourceMapItem
                self.directionsRequest.destination = destinationMapItem
                self.directionsRequest.transportType = .automobile
                self.directionsRequest.requestsAlternateRoutes = false //Making this false for right now
                let directions = MKDirections(request: self.directionsRequest)
                directions.calculate { (response, error) in
                    if let route = response?.routes.first{
                        let meterDistance = Measurement(value: route.distance, unit: UnitLength.meters)
                        self.distance = meterDistance.converted(to: UnitLength.miles).value
                        self.timeSeconds = Int(route.expectedTravelTime)
                        print("DEBUG: TRAFFIC HANDLER: Distance = \(self.distance) ETA: \(self.secondsToHoursMinutesSeconds(seconds: Int(route.expectedTravelTime)))")
                    }
                    else{
                        print("TRAFFIC HANDLER: Route cannot be found...")
                    }
                }
                completion()
            }
            
                
        }
            
    }
    
    func getDirectionsRequest() -> MKDirections.Request{
        return directionsRequest
    }
    //Conversion Method:
    func secondsToHoursMinutesSeconds(seconds:Int) ->(Int, Int, Int){
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    //Summary for the module page:
    func getSummary() -> String{
        let (h,m,s) = secondsToHoursMinutesSeconds(seconds: timeSeconds)
        print("DEBUG: SECONDS \(timeSeconds)")
        if(h == 0){ //No hours
            return "It will take \(m) Minutes and \(s) Seconds to get to work"
        }
        else{
            return "It will take \(h) Hours \(m) Minutes and \(s) Seconds to get to work "
        }
        
        
    }

}
