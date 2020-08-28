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
    @IBOutlet weak var tableView: NSTableView!

    private var currentPeriod: Period?
    private var timer: Timer?
    private var periods = [Period]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        btnGoalTime.removeAllItems()
        btnGoalTime.addItems(withTitles: titles())

        getPeriods()
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
            lblInOut.stringValue = "Currently: \(currentPeriod!.currentlyPeriod())"
        }
    }

    private func getPeriods() {
        if let context = (NSApp.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let name = Period.entity().name {
                let fetchRequest = NSFetchRequest<Period>(entityName: name)
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "outDate", ascending: false)]

                if let periods = try? context.fetch(fetchRequest) {
                    self.periods = periods

                    for period in periods {
                        if period.outDate == nil {
                            currentPeriod = period
                            startTimer()
                        }
                    }
                }
            }
        }

        tableView.reloadData()
        updateView()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            self.updateView()
        })
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

            startTimer()
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

extension ViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return periods.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cell"), owner: self) as? PeriodCell

        return cell
    }
}

class PeriodCell: NSTableCellView {

    @IBOutlet weak var lblTimeRange: NSTextField!
    @IBOutlet weak var lblTimeTotal: NSTextField!
}
