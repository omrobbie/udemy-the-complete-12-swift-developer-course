//
//  SecondViewController.swift
//  ToDoList
//
//  Created by omrobbie on 22/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtItem: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtItem.resignFirstResponder()
        return true
    }

    @IBAction func btnAddTapped(_ sender: Any) {
        var items = [String]()

        if let currentItems = UserDefaults.standard.stringArray(forKey: "items") {
            items = currentItems
        }

        items.append(txtItem.text!)
        txtItem.text = ""

        UserDefaults.standard.set(items, forKey: "items")
    }
}
