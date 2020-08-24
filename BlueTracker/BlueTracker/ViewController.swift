//
//  ViewController.swift
//  BlueTracker
//
//  Created by omrobbie on 24/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var centralManager: CBCentralManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBluetooth()
    }

    private func setupBluetooth() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = "Item \(indexPath.row)"
        cell.detailTextLabel?.text = "RSSI:"
        return cell
    }
}

extension ViewController: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            
        }
    }
}
