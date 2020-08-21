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

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTime), userInfo: nil, repeats: true)
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
    }

    @IBAction func btnPauseTapped(_ sender: Any) {
    }

    @IBAction func btnMinus10SecTapped(_ sender: Any) {
    }

    @IBAction func btnPlus10SecTapped(_ sender: Any) {
    }

    @IBAction func btnResetTimeTapped(_ sender: Any) {
    }
}
