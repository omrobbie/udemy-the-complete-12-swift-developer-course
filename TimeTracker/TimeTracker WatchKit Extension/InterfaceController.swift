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
    private let keyClockedIn = "clockedIn"
    private let keyClockedIns = "clockedIns"
    private let keyClockedOuts = "clockedOuts"

    private var clockedIn = false
    private var timer: Timer?

    override func willActivate() {
        super.willActivate()
        checkClockedIn()
        updateView()
    }

    private func clockIn() {
        standard.set(Date(), forKey: keyClockedIn)
        standard.synchronize()
    }

    private func clockOut() {
        timer?.invalidate()
        timer = nil

        if let clockedInDate = standard.value(forKey: keyClockedIn) as? Date {
            if var clockedIns = standard.array(forKey: keyClockedIns) as? [Date] {
                clockedIns.insert(clockedInDate, at: 0)
                standard.set(clockedIns, forKey: keyClockedIns)
            } else {
                standard.set([clockedInDate], forKey: keyClockedIns)
            }

            if var clockedOuts = standard.array(forKey: keyClockedOuts) as? [Date] {
                clockedOuts.insert(clockedInDate, at: 0)
                standard.set(clockedOuts, forKey: keyClockedOuts)
            } else {
                standard.set([clockedInDate], forKey: keyClockedOuts)
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
        if standard.value(forKey: keyClockedIn) != nil {
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
