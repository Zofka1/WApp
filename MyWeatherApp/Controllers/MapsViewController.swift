//
//  MapsViewController.swift
//  MyWeatherApp
//
//  Created by Zofka Jostakova on 26/07/2021.
//

import UIKit
import MapKit
import CoreLocation

class MapsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var typeOfMap: UISegmentedControl!
    
    
    
    @IBAction func changeOfMap(_ sender: UISegmentedControl) {
        switch typeOfMap.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
       
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
               gestureRecognizer.minimumPressDuration = 1
               mapView.addGestureRecognizer(gestureRecognizer)

        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate =  self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    
    }
    
    
  

    @objc func chooseLocation(gestureRecognizer:UILongPressGestureRecognizer){
           if gestureRecognizer.state == .began {
               let touchedPoint = gestureRecognizer.location(in: self.mapView)
               let toucheCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
               let annotation = MKPointAnnotation()
               annotation.coordinate = toucheCoordinates
               annotation.title = "ChoosenLocation"
               self.mapView.addAnnotation(annotation)
           }
   
    }
  
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                locationManager.stopUpdatingLocation()
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
               
                
            }
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)  {
            print(error)
        }
    }
    
 
 


