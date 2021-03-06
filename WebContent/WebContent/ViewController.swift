//
//  ViewController.swift
//  WebContent
//
//  Created by omrobbie on 22/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    private func loadData() {
        let url = URL(string: "https://omrobbie.com")!
        webView.load(URLRequest(url: url))
    }
}
