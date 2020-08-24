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
    private var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
    }

    private func setupPlayer() {
        guard let audioPath = audioPath else {return}

        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            sliderScrubber.maximumValue = Float(player.duration)
        } catch {
            print("Error", error.localizedDescription)
        }
    }

    @objc private func updateScrubber() {
        sliderScrubber.value = Float(player.currentTime)
    }

    @IBAction func sliderVolumeChanged(_ sender: Any) {
        player.volume = sliderVolume.value
    }

    @IBAction func sliderScrubberChanged(_ sender: Any) {
        player.currentTime = TimeInterval(sliderScrubber.value)
        player.play()
    }

    @IBAction func btnPlayTapped(_ sender: Any) {
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateScrubber), userInfo: nil, repeats: true)
    }

    @IBAction func btnPauseTapped(_ sender: Any) {
        player.pause()
        timer.invalidate()
    }

    @IBAction func btnStopTapped(_ sender: Any) {
        player.stop()
        timer.invalidate()
        setupPlayer()
    }
}
