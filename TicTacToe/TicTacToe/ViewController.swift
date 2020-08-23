//
//  ViewController.swift
//  TicTacToe
//
//  Created by omrobbie on 23/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var btnCell: [UIButton]?
    @IBOutlet weak var lblWinner: UILabel!

    var activePlayer = 1
    var activeGame = true
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    let winState = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        lblWinner.text = ""
    }

    @IBAction func btnCellTapped(_ sender: UIButton) {
        let pos = sender.tag - 1

        if gameState[pos] == 0 {
            gameState[pos] = activePlayer
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "nought"), for: [])
                activePlayer = 2
            } else {
                sender.setImage(UIImage(named: "cross"), for: [])
                activePlayer = 1
            }
        }

        for win in winState {
            if gameState[win[0]] != 0 &&
                gameState[win[0]] == gameState[win[1]] &&
                gameState[win[1]] == gameState[win[2]] {
                activeGame = false

                let player = gameState[win[0]] == 1 ? "O" : "X"
                lblWinner.text = "Player \(player) is the Winner!"
            }
        }
    }

    @IBAction func btnPlayAgainTapped(_ sender: Any) {
        activeGame = true
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        lblWinner.text = ""

        if let btnCell = btnCell {
            for btn in btnCell {
                btn.setImage(nil, for: [])
            }
        }
    }
}
