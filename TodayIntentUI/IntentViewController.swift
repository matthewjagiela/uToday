//
//  IntentViewController.swift
//  TodayIntentUI
//
//  Created by Matthew Jagiela on 4/1/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import IntentsUI
import MapKit

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    let traffic = TrafficHandler()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print("Render")
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.green
        renderer.lineWidth = 3
        return renderer
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        // Do configuration here, including preparing views and calculating a desired size for presentation.
        mapView.delegate = self
        traffic.getETA {
            self.mapView.showAnnotations([self.traffic.getDestinationAnnotation()], animated: true)
            self.mapView.addOverlay((self.traffic.getMapPolyLine()), level: MKOverlayLevel.aboveRoads)
            
            self.mapView.setRegion(MKCoordinateRegion(self.traffic.getMapRegion()), animated: true)
        }
        completion(true, parameters, self.desiredSize)
        
    }
    
    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
    
}
