//
//  ViewController.swift
//  WhatsMyNumber
//
//  Created by omrobbie on 22/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtNumber: UITextField!

    private let key = "number"

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    private func loadData() {
        if let number = UserDefaults.standard.string(forKey: key) {
            txtNumber.text = number
        }
    }

    @IBAction func btnSaveTapped(_ sender: Any) {
        UserDefaults.standard.set(txtNumber.text, forKey: key)
    }
}
