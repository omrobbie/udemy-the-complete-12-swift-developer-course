//
//  ViewController.swift
//  EggTimer
//
//  Created by omrobbie on 21/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    static let DEFAULT_TIME = 200

    @IBOutlet weak var lblTimeInSeconds: UILabel!

    enum OperationTypes {
        case increase
        case decrease
        case equal
    }

    var time = ViewController.DEFAULT_TIME
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTimeInSeconds.text = String(time)
    }

    private func refreshLabel(operation: OperationTypes, by value: Int) {
        switch operation {
        case .increase: time += value
        case .decrease: time -= value
        case .equal: time = value
        }

        lblTimeInSeconds.text = String(time)
    }

    @objc private func decreaseTime() {
        if time > 0 {
            refreshLabel(operation: .decrease, by: 1)
        } else {
            timer.invalidate()
        }
    }

    @IBAction func btnPlayTapped(_ sender: Any) {
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTime), userInfo: nil, repeats: true)
        }
    }

    @IBAction func btnPauseTapped(_ sender: Any) {
        timer.invalidate()
    }

    @IBAction func btnMinus10SecTapped(_ sender: Any) {
        refreshLabel(operation: .decrease, by: 10)
    }

    @IBAction func btnPlus10SecTapped(_ sender: Any) {
        refreshLabel(operation: .increase, by: 10)
    }

    @IBAction func btnResetTimeTapped(_ sender: Any) {
        refreshLabel(operation: .equal, by: ViewController.DEFAULT_TIME)
    }
}
