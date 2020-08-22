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
        fetchData()
    }

    private func fetchData(city: String = "") {
        var apiKey = ""

        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) {
            apiKey = dict["ApiKey"] as! String
        }

        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)") else {return}

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let data = data else {return}

            do {
                if let decodeData = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary,
                    let main = decodeData["main"] as? NSDictionary,
                    let kelvinTemp = main["temp"] as? Double {
                    let celsiusTemp = kelvinTemp - 273.15
                    DispatchQueue.main.async {
                        self.lblResult.text = String(format: "%.0f", celsiusTemp) + "℃"
                    }
                }
            } catch {
                print("Error", error.localizedDescription)
            }
        }.resume()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtCity.resignFirstResponder()
        return true
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        fetchData(city: txtCity.text!)
    }
}
