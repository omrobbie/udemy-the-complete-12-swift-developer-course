//
//  InterfaceController.swift
//  TimeTracker WatchKit Extension
//
//  Created by omrobbie on 28/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var lblDateSmall: WKInterfaceLabel!
    @IBOutlet weak var lblDateLarge: WKInterfaceLabel!
    @IBOutlet weak var btnInOut: WKInterfaceButton!

    private var clockedIn = false

    override func willActivate() {
        super.willActivate()
    }

    private func clockIn() {

    }

    private func clockOut() {

    }

    private func updateView() {

    }

    @IBAction func btnInOutTapped() {
        if clockedIn {
            clockOut()
        } else {
            clockIn()
        }

        clockedIn.toggle()
        updateView()
    }

    @IBAction func mnHistoryTapped() {
    }

    @IBAction func mnResetTapped() {
    }
}
