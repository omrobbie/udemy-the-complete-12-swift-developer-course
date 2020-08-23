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

    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblCourse: UILabel!
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var lblAltitude: UILabel!
    @IBOutlet weak var lblAddress: UILabel!

    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
    }

    private func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension ViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}

        lblLatitude.text = String(location.coordinate.latitude)
        lblLongitude.text = String(location.coordinate.longitude)
        lblCourse.text = String(location.course)
        lblSpeed.text = String(location.speed)
        lblAltitude.text = String(location.altitude)

        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            if let placemark = placemarks?.first {
                var address = ""

                if let subThoroughfare = placemark.subThoroughfare {
                    address += subThoroughfare + " "
                }

                if let thoroughfare = placemark.thoroughfare {
                    address += thoroughfare + "\n"
                }

                if let subLocality = placemark.subLocality {
                    address += subLocality + "\n"
                }

                if let subAdministrativeArea = placemark.subAdministrativeArea {
                    address += subAdministrativeArea + "\n"
                }

                if let postalCode = placemark.postalCode {
                    address += postalCode + "\n"
                }

                if let country = placemark.country {
                    address += country + "\n"
                }

                self.lblAddress.text = address
            }
        }
    }
}
