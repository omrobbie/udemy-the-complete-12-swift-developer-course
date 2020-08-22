//
//  ViewController.swift
//  WhatsTheWeather
//
//  Created by omrobbie on 22/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var lblResult: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtCity.resignFirstResponder()
        return true
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
    }
}
