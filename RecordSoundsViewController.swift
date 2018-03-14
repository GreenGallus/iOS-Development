//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Muhammad Nur Hakim Nordin on 12/3/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    
    // MARK: IBOutlet for Button
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecording: UIButton!
    
    // MARK: RecordingState (raw values correspond to sender tags)
    enum RecordingState { case recording, notRecording }
    
    // MARK: Button Functions
    func configureButton(_ isRecording: Bool) {
        recordButton.isEnabled = !isRecording
        stopRecording.isEnabled = isRecording
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton(false)
        recordButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        stopRecording.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Record Button When Pressed To Start Recording
    @IBAction func recordAudio(_ sender: Any) {
        recordLabel.text = "Recording in Progress"
        configureButton(true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // MARK: Stop Audio Recording
    @IBAction func stopRecording(_ sender: Any) {
        configureButton(false)
        recordLabel.text = "Tap To Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: Audio Recorder Delegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording Unsuccessful")
        }
    }
    
    // MARK: Segue to Next ViewUI After Finish Recording
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}

