//
//  ViewController.swift
//  ShakeAndSwipeExample
//
//  Created by omrobbie on 24/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        swipeObserver()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake {
            lblTitle.textAlignment = .center
            lblTitle.transform = CGAffineTransform(translationX: 20, y: 0)
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.lblTitle.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }

    private func swipeObserver() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSswiped(handle:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSswiped(handle:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }

    @objc private func handleSswiped(handle: UIGestureRecognizer) {
        guard let handle = handle as? UISwipeGestureRecognizer else {return}

        switch handle.direction {
        case .right: lblTitle.textAlignment = .right
        case .left: lblTitle.textAlignment = .left
        default: break
        }
    }
}
