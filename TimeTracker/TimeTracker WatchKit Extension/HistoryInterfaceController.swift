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

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        loadDataDummy()
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
}
