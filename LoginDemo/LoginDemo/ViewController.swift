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
        loadData()
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
            loadData()
        } catch {
            print("Error", error.localizedDescription)
        }
    }

    private func loadData() {
        guard let context = context else {
            print("Error: Doesn't have view context!")
            return
        }

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsDistinctResults = false

        do {
            let results = try context.fetch(request)

            for result in results as! [NSManagedObject] {
                if let username = result.value(forKey: "name") {
                    loginView.isHidden = true
                    lblWelcomeMessage.text = "Welcome back,\n\(username)"
                    txtUserName.resignFirstResponder()
                }
            }
        } catch {
            print("Error", error.localizedDescription)
        }
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        saveData()
    }
}
