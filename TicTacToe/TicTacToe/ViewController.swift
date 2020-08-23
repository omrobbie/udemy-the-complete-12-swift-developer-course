//
//  ViewController.swift
//  TicTacToe
//
//  Created by omrobbie on 23/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var activePlayer = 1

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnCellTapped(_ sender: UIButton) {
        if activePlayer == 1 {
            sender.setImage(UIImage(named: "nought"), for: [])
            activePlayer = 2
        } else {
            sender.setImage(UIImage(named: "cross"), for: [])
            activePlayer = 1
        }
    }
}
