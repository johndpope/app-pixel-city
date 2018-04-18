//
//  ViewController.swift
//  pixel-city
//
//  Created by David Brunstein on 2018-04-17.
//  Copyright © 2018 David Brunstein. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    // Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
     }


    @IBAction func centerMapBtnPressed(_ sender: Any) {
    }
    
}

extension MapVC: MKMapViewDelegate {
    
}
