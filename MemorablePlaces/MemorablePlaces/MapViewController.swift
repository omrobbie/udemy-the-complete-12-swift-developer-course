//
//  MapViewController.swift
//  MemorablePlaces
//
//  Created by omrobbie on 24/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        gestureObserver()
    }

    private func loadData() {
        if activePlace < 0 {return}
        let place = places[activePlace]

        if let name = place["name"],
            let lat = place["lat"],
            let lon = place["lon"] {
            if let latitude = Double(lat),
                let longitude = Double(lon) {
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let region = MKCoordinateRegion(center: coordinate, span: span)

                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = name

                map.setRegion(region, animated: true)
                map.addAnnotation(annotation)
            }
        }
    }

    private func gestureObserver() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(handle:)))
        gesture.minimumPressDuration = 2
        map.addGestureRecognizer(gesture)
    }

    @objc private func handleLongPress(handle: UIGestureRecognizer) {
        let touchPoint = handle.location(in: map)
        let coordinate = map.convert(touchPoint, toCoordinateFrom: map)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let placemark = placemarks?.first else {return}
            var title = ""

            if let subThoroughfare = placemark.subThoroughfare {
                title += subThoroughfare + " "
            }

            if let thoroughfare = placemark.thoroughfare {
                title += thoroughfare
            }

            if title.isEmpty {
                title = "Added \(NSDate())"
            }

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = title
            self.map.addAnnotation(annotation)

            places.append(["name": title, "lat": String(coordinate.latitude), "lon": String(coordinate.longitude)])
        }
    }
}
