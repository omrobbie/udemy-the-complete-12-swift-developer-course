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

    override func willActivate() {
        super.willActivate()
    }

    @IBAction func btnInOutTapped() {
    }

    @IBAction func mnHistoryTapped() {
    }

    @IBAction func mnResetTapped() {
    }
}
