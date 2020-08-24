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

    @IBAction func btnSubmitTapped(_ sender: Any) {
    }
}
