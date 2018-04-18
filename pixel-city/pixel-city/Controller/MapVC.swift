//
//  ViewController.swift
//  pixel-city
//
//  Created by David Brunstein on 2018-04-17.
//  Copyright © 2018 David Brunstein. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, UIGestureRecognizerDelegate {

    // Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // Variables
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadious: Double = 1000                // meters
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self

        configureLocationServices()
        addDoubleTap()
     }
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(MapVC.dropPin(sender:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        mapView.addGestureRecognizer(doubleTap)
    }


    @IBAction func centerMapBtnPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapInUserLocation()
        }
    }
    
}

extension MapVC: MKMapViewDelegate {
    
    func centerMapInUserLocation() {
//        guard let deviceLatitude = locationManager.location?.coordinate.latitude else { return }
//        guard let deviceLongitude = locationManager.location?.coordinate.longitude else { return }
//        let locationcoordinates = CLLocationCoordinate2D(latitude: deviceLatitude, longitude: deviceLongitude)
//        let zoomSpan = MKCoordinateSpan(latitudeDelta: regionRadious, longitudeDelta: regionRadious)
//        let coordinateRegion = MKCoordinateRegion(center: locationcoordinates, span: zoomSpan)

        guard let deviceCoordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(deviceCoordinate, regionRadious * REGION_ZOOM, regionRadious * REGION_ZOOM)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func dropPin(sender: UITapGestureRecognizer) {
        // drop the pin on the map
         removeAllPins()
        
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: PIN_IDENTIFIER)
        mapView.addAnnotation(annotation)
        
        // Set the annotation in the center of the map
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(touchCoordinate, regionRadious * REGION_ZOOM, regionRadious * REGION_ZOOM)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Check if the annotation is the blue location of the user location.
        // We don't want to change the user location
        if annotation is MKUserLocation {
            return nil
        }
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: PIN_IDENTIFIER)
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
    
    func removeAllPins() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
}

extension MapVC: CLLocationManagerDelegate {
    
    func configureLocationServices() {

        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapInUserLocation()
    }
}
