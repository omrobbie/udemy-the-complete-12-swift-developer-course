//
//  HistoryInterfaceController.swift
//  TimeTracker WatchKit Extension
//
//  Created by omrobbie on 28/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import WatchKit

class HistoryInterfaceController: WKInterfaceController {

    @IBOutlet weak var table: WKInterfaceTable!

    private var clockIns = [Date]()
    private var clockOuts = [Date]()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        loadData()
    }

    private func loadDataDummy() {
        let count = 3

        table.setNumberOfRows(count, withRowType: "row")

        for i in 0..<count {
            if let rowController = table.rowController(at: i) as? HistoryRow {
                rowController.label.setText("Item \(i)")
            }
        }
    }

    private func loadData() {
        if let clockIns = standard.array(forKey: keyClockedIns) as? [Date] {
            self.clockIns = clockIns
        }

        if let clockOuts = standard.array(forKey: keyClockedOuts) as? [Date] {
            self.clockOuts = clockOuts
        }

        table.setNumberOfRows(clockIns.count, withRowType: "row")

        for i in 0..<clockIns.count {
            if let rowController = table.rowController(at: i) as? HistoryRow {
                rowController.label.setText(getCurrentClockInString(date1: clockOuts[i], date2: clockIns[i]))
            }
        }
    }
}
