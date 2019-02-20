//
//  TrafficViewController.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/19/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit
import MapKit
class TrafficViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    let traffic = TrafficHanlder()
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        // Do any additional setup after loading the view.
        traffic.getETA {
            print("Executed Completely")
            //Load the route we found to be shown on a map:
            let directionsRequest = self.traffic.getDirectionsRequest()
            let directions = MKDirections(request: directionsRequest)
            directions.calculate { (response, error) in
                if let route = response?.routes.first{
                    print("ADD TO MAP")
                    self.mapView.addOverlay(route.polyline)
                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                }
                else{
                    print("TRAFFIC HANDLER: Route cannot be found...")
                }
            }
            self.summaryLabel.text = self.traffic.getSummary()
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print("Render")
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.green
        renderer.lineWidth = 2
        return renderer
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
