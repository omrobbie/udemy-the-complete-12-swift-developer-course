//
//  ViewController.swift
//  BackToBach
//
//  Created by omrobbie on 24/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var sliderVolume: UISlider!
    @IBOutlet weak var sliderScrubber: UISlider!

    private let audioPath = Bundle.main.path(forResource: "song", ofType: "mp3")
    private var player = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
    }

    private func setupPlayer() {
        guard let audioPath = audioPath else {return}

        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
        } catch {
            print("Error", error.localizedDescription)
        }
    }

    @IBAction func sliderVolumeChanged(_ sender: Any) {
        player.volume = sliderVolume.value
    }

    @IBAction func sliderScrubberChanged(_ sender: Any) {
    }

    @IBAction func btnPlayTapped(_ sender: Any) {
        player.play()
    }

    @IBAction func btnPauseTapped(_ sender: Any) {
        player.pause()
    }

    @IBAction func btnStopTapped(_ sender: Any) {
        player.stop()
    }
}
