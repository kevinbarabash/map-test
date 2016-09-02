//
//  ViewController.swift
//  MapTest
//
//  Created by Kevin Barabash on 2016-09-01.
//  Copyright © 2016 Kevin Barabash. All rights reserved.
//

import Cocoa
import MapKit

class ViewController: NSViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 45.5087106878827, longitude: -73.5689424842366),
            span: MKCoordinateSpan(latitudeDelta: 0.0486797587433401, longitudeDelta: 0.0937941429641427)
        )
       
        mapView.setRegion(region, animated: true)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("region = \(mapView.region)")
    }
    
    @IBAction func search(sender: NSTextField) {
        print("searching for \(searchField.stringValue)")
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchField.stringValue
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler { (response, error) in
            guard let response = response else {
                print("Search error: \(error)")
                return
            }
            
            for item in response.mapItems {
                print("name = '\(item.name)'")
                print("description = '\(item.description)'")
                
                let pin = MKPointAnnotation()
                
                if let location = item.placemark.location {
                    pin.coordinate = location.coordinate
                    pin.title = item.name
                    
                    self.mapView.addAnnotation(pin)
                }
            }
        }
    }
}

