//
//  ViewController.swift
//  MemorablePlaces
//
//  Created by omrobbie on 24/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

var places = [Dictionary<String, String>()]
var activePlace = -1

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    private func loadData() {
        if places[0].count == 0 {
            places.remove(at: 0)
        }

        places.append(["name": "Taj Mahal", "lat": "27.175277", "lon": "78.042128O"])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = places[indexPath.row]
        cell.textLabel?.text = item["name"]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        activePlace = indexPath.row
        performSegue(withIdentifier: "toMap", sender: nil)
    }
}
