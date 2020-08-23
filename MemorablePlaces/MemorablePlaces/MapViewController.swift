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

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "You pinned here"
        map.addAnnotation(annotation)
    }
}
