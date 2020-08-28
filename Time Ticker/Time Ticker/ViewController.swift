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
    @IBOutlet weak var lblRemaining: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        btnGoalTime.removeAllItems()
        btnGoalTime.addItems(withTitles: titles())
    }

    private func titles() -> [String] {
        var titles = [String]()

        for number in 1...40 {
            titles.append("\(number)h")
        }

        return titles
    }

    @IBAction func btnGoalTimeChanged(_ sender: Any) {
    }
}
