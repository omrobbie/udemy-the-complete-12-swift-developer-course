//
//  ViewController.swift
//  EggTimer
//
//  Created by omrobbie on 21/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblTimeInSeconds: UILabel!

    var time = 200
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTimeInSeconds.text = String(time)
    }

    @objc private func decreaseTime() {
        if time > 0 {
            time -= 1
            lblTimeInSeconds.text = String(time)
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
        time -= 10
        lblTimeInSeconds.text = String(time)
    }

    @IBAction func btnPlus10SecTapped(_ sender: Any) {
        time += 10
        lblTimeInSeconds.text = String(time)
    }

    @IBAction func btnResetTimeTapped(_ sender: Any) {
        time = 200
        lblTimeInSeconds.text = String(time)
    }
}
