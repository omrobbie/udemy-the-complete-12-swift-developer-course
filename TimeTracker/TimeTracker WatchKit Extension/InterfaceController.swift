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

            standard.set(nil, forKey: keyClockedIn)
            standard.synchronize()
        }
    }

    private func updateView() {
        if clockedIn {
            lblDateSmall.setHidden(false)
            lblDateSmall.setText("Today: \(totalTimeWorkedAsString())")
            lblDateLarge.setText("")
            btnInOut.setTitle("Clock-Out")
            btnInOut.setBackgroundColor(.red)

            if let clockedInDate = standard.value(forKey: keyClockedIn) as? Date {
                let timeInterval = Int(Date().timeIntervalSince(clockedInDate))
                let hours = timeInterval / 3600
                let minutes = (timeInterval % 3600) / 60
                let seconds = timeInterval % 60

                var currentClockInString = ""

                if hours != 0 {
                    currentClockInString += "\(hours)h "
                }

                if minutes != 0 || hours != 0 {
                    currentClockInString += "\(minutes)m "
                }

                currentClockInString += "\(seconds)s"
                lblDateLarge.setText(currentClockInString)
                startTimer()
            }
        } else {
            lblDateSmall.setHidden(true)
            lblDateSmall.setText("")
            lblDateLarge.setText("Today\n\(totalTimeWorkedAsString())")
            btnInOut.setTitle("Clock-Out")
            btnInOut.setBackgroundColor(.green)
        }
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

    private func totalClockedTime() -> Int {
        if let clockedIns = standard.array(forKey: keyClockedIns) as? [Date] {
            if let clockedOuts = standard.array(forKey: keyClockedOuts) as? [Date] {
                var seconds = 0

                for i in 0..<clockedIns.count {
                    seconds += Int(clockedOuts[i].timeIntervalSince(clockedIns[i]))
                }

                return seconds
            }
        }

        return 0
    }

    private func totalTimeWorkedAsString() -> String {
        var currentClockedInSeconds = 0

        if let clockedInDate = standard.value(forKey: keyClockedIn) as? Date {
            currentClockedInSeconds = Int(Date().timeIntervalSince(clockedInDate))
        }

        let totalTimeInterval = currentClockedInSeconds + totalClockedTime()
        let totalHours = totalTimeInterval / 3600
        let totalMinutes = (totalTimeInterval % 3600) / 60

        return "\(totalHours)h \(totalMinutes)m"
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
