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
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let traffic = TrafficHandler()
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating() //The directions and info has not been found...
        self.summaryLabel.isHidden = true //Hide this so it doesn't show wrong data based on the wrong location...
        mapView.delegate = self //Make it so we can override delegate methods for the map
        // Do any additional setup after loading the view.
        traffic.getETA {
            print("Executed Completely")
            //Update the UI based on information we got from the handler...
            
            self.summaryLabel.text = self.traffic.getSummary()
            self.summaryLabel.isHidden = false //show now that we have information...
            self.mapView.showAnnotations([self.traffic.getDestinationAnnotation()], animated: true)
            self.mapView.addOverlay((self.traffic.getMapPolyLine()), level: MKOverlayLevel.aboveRoads)
            
            self.mapView.setRegion(MKCoordinateRegion(self.traffic.getMapRegion()), animated: true)
            self.activityIndicator.stopAnimating()
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print("Render")
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.green
        renderer.lineWidth = 3
        return renderer
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
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
