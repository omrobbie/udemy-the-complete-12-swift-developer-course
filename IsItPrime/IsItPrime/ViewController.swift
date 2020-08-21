//
//  ViewController.swift
//  IsItPrime
//
//  Created by omrobbie on 21/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var lblResult: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnPrimeCheckerTapped(_ sender: Any) {
        if let numberInput = txtNumber.text {
            if let numberInt = Int(numberInput) {
                var isPrime = true
                var i = 2

                if numberInt == 1 {
                    isPrime = false
                }

                while i < numberInt {
                    if numberInt % i == 0 {
                        isPrime = false
                    }
                    i += 1
                }

                if isPrime {
                    lblResult.text = "\(numberInt) is prime!"
                } else {
                    lblResult.text = "\(numberInt) is not prime!"
                }
            } else {
                lblResult.text = "Please enter a positive whole number."
            }
        }
    }
}
