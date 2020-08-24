//
//  ViewController.swift
//  LoginDemo
//
//  Created by omrobbie on 24/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var lblWelcomeMessage: UILabel!

    private var context: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCoreData()
    }

    private func setupCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }

    private func saveData() {
        guard let context = context else {
            print("Error: Doesn't have view context!")
            return
        }

        let newValue = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        newValue.setValue(txtUserName.text, forKey: "name")

        do {
            try context.save()
            loginView.isHidden = true
            lblWelcomeMessage.text = "Welcome back,\n\(txtUserName.text!)"
            txtUserName.resignFirstResponder()
        } catch {
            print("Error", error.localizedDescription)
        }
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        saveData()
    }
}
