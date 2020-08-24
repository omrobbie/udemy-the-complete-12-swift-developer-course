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

    private var centralManager: CBCentralManager?
    private var names: [String] = []
    private var rssi: [String] = []

    private var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBluetooth()
    }

    private func setupBluetooth() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    private func startScan() {
        names = []
        rssi = []
        tableView.reloadData()
        centralManager?.stopScan()
        centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }

    private func startTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (_) in
            self.startScan()
        })
    }

    @IBAction func btnReloadTapped(_ sender: Any) {
        startScan()
        startTimer()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = names[indexPath.row]
        cell.detailTextLabel?.text = "RSSI: \(rssi[indexPath.row])"
        return cell
    }
}

extension ViewController: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            startTimer()
            startTimer()
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let name = peripheral.name {
            if !names.contains(name) {
                names.append(name)
            }
        } else {
            if !names.contains(peripheral.identifier.uuidString) {
                names.append(peripheral.identifier.uuidString)
            }
        }

        peripheral.readRSSI()
        rssi.append(RSSI.stringValue)
        tableView.reloadData()
    }
}
