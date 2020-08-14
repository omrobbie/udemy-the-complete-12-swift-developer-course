//
//  ViewController.swift
//  CatYears
//
//  Created by omrobbie on 14/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var lblResult: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnGetAgeTapped(_ sender: Any) {
        if let age = txtAge.text {
            if let ageAsNumber = Int(age) {
                let ageInCatYears = ageAsNumber * 7
                lblResult.text = "Your cat is \(ageInCatYears) in cat years."
            }
        }
    }
}
