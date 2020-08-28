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

    private let standard = UserDefaults.standard

    private var clockedIn = false
    private var timer: Timer?

    override func willActivate() {
        super.willActivate()
        checkClockedIn()
        updateView()
    }

    private func clockIn() {
        standard.set(Date(), forKey: "clockedIn")
        standard.synchronize()
    }

    private func clockOut() {
        timer?.invalidate()
        timer = nil

        if let clockedInDate = standard.value(forKey: "clockedIn") as? Date {
            if var clockedIns = standard.array(forKey: "clockedIns") as? [Date] {
                clockedIns.insert(clockedInDate, at: 0)
                standard.set(clockedIns, forKey: "clockedIns")
            } else {
                standard.set([clockedInDate], forKey: "clockedIns")
            }

            if var clockedOuts = standard.array(forKey: "clockedOuts") as? [Date] {
                clockedOuts.insert(clockedInDate, at: 0)
                standard.set(clockedOuts, forKey: "clockedOuts")
            } else {
                standard.set([clockedInDate], forKey: "clockedOuts")
            }
        }
    }

    private func updateView() {

    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            self.updateView()
        })
    }

    private func checkClockedIn() {
        if standard.value(forKey: "clockedIn") != nil {
            clockedIn = true

            if timer == nil {
                startTimer()
            }
        } else {
            clockedIn = false
        }
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
