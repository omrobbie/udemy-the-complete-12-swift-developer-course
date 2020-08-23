//
//  ViewController.swift
//  LocationAware
//
//  Created by omrobbie on 23/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
    }

    private func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
    }
}

extension ViewController: CLLocationManagerDelegate {
    
}
