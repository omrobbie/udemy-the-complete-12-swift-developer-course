//
//  ViewController.swift
//  Time Ticker
//
//  Created by omrobbie on 27/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var btnGoalTime: NSPopUpButton!
    @IBOutlet weak var lblTitle: NSTextField!
    @IBOutlet weak var lblRemaining: NSTextField!
    @IBOutlet weak var btnInOut: NSButton!
    @IBOutlet weak var lblInOut: NSTextField!

    private var currentPeriod: Period?
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        btnGoalTime.removeAllItems()
        btnGoalTime.addItems(withTitles: titles())
        updateView()
    }

    private func titles() -> [String] {
        var titles = [String]()

        for number in 1...40 {
            titles.append("\(number)h")
        }

        return titles
    }

    private func updateView() {
        let goalTime = btnGoalTime.indexOfSelectedItem + 1
        lblTitle.stringValue = "Goal: \(goalTime) Hour\(goalTime == 1 ? "" : "s")"

        if currentPeriod == nil {
            btnInOut.title = "IN"
            lblInOut.isHidden = true
            lblInOut.stringValue = ""
        } else {
            btnInOut.title = "OUT"
            lblInOut.isHidden = false
            lblInOut.stringValue = "Currently:"
        }
    }

    @IBAction func btnGoalTimeChanged(_ sender: Any) {
        updateView()
    }

    @IBAction func btnInOutTapped(_ sender: Any) {
        if currentPeriod == nil {
            // check in
            if let context = (NSApp.delegate as? AppDelegate)?.persistentContainer.viewContext {
                currentPeriod = Period(context: context)
                currentPeriod?.inDate = Date(timeIntervalSinceNow: -1404)
            }

            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
                self.updateView()
            })
        } else {
            // check out
            currentPeriod!.outDate = Date()
            currentPeriod = nil
            timer?.invalidate()
            timer = nil
        }

        updateView()
        (NSApp.delegate as? AppDelegate)?.saveAction(nil)
    }
}
