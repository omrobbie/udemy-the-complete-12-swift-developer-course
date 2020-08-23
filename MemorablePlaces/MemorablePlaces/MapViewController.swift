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
    }

    private func loadData() {
        guard let placeName = places[activePlace]["name"] else {return}
        print(placeName)
    }
}
