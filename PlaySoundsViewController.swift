//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Muhammad Nur Hakim Nordin on 12/3/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // MARK: IBOutlet for Buttons
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: Variables for Audio
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: Output for Recorded Audio
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    // MARK: Stop Recorded Audio Playback
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
        // MARK: Resize Image
        snailButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        chipmunkButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        rabbitButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        vaderButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        echoButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        reverbButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        stopButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }

}
