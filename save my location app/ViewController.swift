//
//  ViewController.swift
//  save my location app
//
//  Created by lapacino on 8/8/15.
//  Copyright (c) 2015 lapacino. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        
        if activePlaces == -1 {
            
            manager.requestAlwaysAuthorization()
            manager.startUpdatingLocation()
            var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
            uilpgr.minimumPressDuration = 1.0
            mapView.addGestureRecognizer(uilpgr)
            
        }
        else{
        
        
        let lat = NSString(string: places[activePlaces]["lat"]!).doubleValue
        let lon = NSString(string: places[activePlaces]["lon"]!).doubleValue
        
        var latitude:CLLocationDegrees = lat
        var longitude:CLLocationDegrees = lon
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
            var annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Taj Mahal"
            mapView.addAnnotation(annotation)
        
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            
            var touchPoint = gestureRecognizer.locationInView(self.mapView)
            var newCoordinate:CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
            
            
            
            var loc = CLLocation(latitude:newCoordinate.latitude, longitude:newCoordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(loc) { (placeMarks, error) -> Void in
                
                if error != nil  {
                    println("error: \(error)")
                }
                else{
                    
                    var place = CLPlacemark(placemark: placeMarks?[0] as! CLPlacemark)
                    
                    
                    var newAnnotation = MKPointAnnotation()
                    newAnnotation.coordinate = newCoordinate
                    newAnnotation.title = "\(place.locality)"
                    self.mapView.addAnnotation(newAnnotation)
                    places.append(["name": "\(place.locality)", "lat": "\(newCoordinate.latitude)", "lon": "\(newCoordinate.longitude)"])
                    
                }
            }
            
            
        }
      
      
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation:CLLocation = locations[0] as! CLLocation
        var latitude:CLLocationDegrees = userLocation.coordinate.latitude
        var longitude:CLLocationDegrees = userLocation.coordinate.longitude
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        manager.stopUpdatingLocation()
 
       
    }
    
        func locationManager(manager: CLLocationManager!, didFinishDeferredUpdatesWithError error: NSError!) {
        
        println("error: \(error)")
    }
    
    @IBAction func findMeBarButton(sender: UIBarButtonItem) {
        
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }


}

