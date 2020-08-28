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
    @IBOutlet weak var progressIndicator: NSProgressIndicator!

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

        lblRemaining.stringValue = remainingTimeAsString()

        let ratio = totalTimeInterval() / goalTimeInterval()
        progressIndicator.doubleValue = ratio
    }

    private func getPeriods() {
        if let context = (NSApp.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let name = Period.entity().name {
                let fetchRequest = NSFetchRequest<Period>(entityName: name)
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "outDate", ascending: false)]

                if var periods = try? context.fetch(fetchRequest) {
                    for i in 0..<periods.count {
                        let period = periods[i]

                        if period.outDate == nil {
                            currentPeriod = period
                            startTimer()
                            periods.remove(at: i)
                            break
                        }
                    }

                    self.periods = periods
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

    private func totalTimeInterval() -> TimeInterval {
        var time = 0.0

        for period in periods {
            time += period.time()
        }

        if let currentPeriod = self.currentPeriod {
            time += currentPeriod.time()
        }

        return time
    }

    private func goalTimeInterval() -> TimeInterval {
        return Double(btnGoalTime.indexOfSelectedItem + 1) * 60 * 60
    }

    private func remainingTimeAsString() -> String {
        let remainingTime = goalTimeInterval() - totalTimeInterval()

        if remainingTime <= 0 {
            return "Finished! \(Period.stringFromDates(date1: Date(), date2: Date(timeIntervalSinceNow: totalTimeInterval())))"
        } else {
            return "Remaining: \(Period.stringFromDates(date1: Date(), date2: Date(timeIntervalSinceNow: remainingTime)))"
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
                currentPeriod?.inDate = Date()
            }

            startTimer()
        } else {
            // check out
            currentPeriod!.outDate = Date()
            currentPeriod = nil
            timer?.invalidate()
            timer = nil
            getPeriods()
        }

        updateView()
        (NSApp.delegate as? AppDelegate)?.saveAction(nil)
    }

    @IBAction func btnResetTapped(_ sender: Any) {
        if let context = (NSApp.delegate as? AppDelegate)?.persistentContainer.viewContext {
            for period in periods {
                context.delete(period)
            }

            if let currentPeriod = self.currentPeriod {
                context.delete(currentPeriod)
                self.currentPeriod = nil
            }

            getPeriods()
        }
    }
}

extension ViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return periods.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cell"), owner: self) as? PeriodCell
        let period = periods[row]
        cell?.lblTimeRange.stringValue = "\(period.prettyInDate()) - \(period.prettyOutDate())"
        cell?.lblTimeTotal.stringValue = "\(Period.stringFromDates(date1: Date(), date2: Date(timeIntervalSinceNow: period.time())))"
        return cell
    }
}

class PeriodCell: NSTableCellView {

    @IBOutlet weak var lblTimeRange: NSTextField!
    @IBOutlet weak var lblTimeTotal: NSTextField!
}
