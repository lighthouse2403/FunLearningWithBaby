//
//  SpeechViewController.swift
//  FunLearningWithBaby
//
//  Created by Hai Dang on 9/10/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit
import Speech

class SpeechViewController: UIViewController {

    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    static let shared = SpeechViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Check Authorization Status
    func requestSpeechAuthorization(authorization: @escaping (SFSpeechRecognizerAuthorizationStatus) -> ()) {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            authorization(authStatus)
        }
    }

    // Request speech
    func recordAndRecognizeSpeech(completionHandler: @escaping (Error?, SFSpeechRecognitionResult?) -> ()) {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            // "There has been an audio engine error.")
            completionHandler(error,nil)
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            completionHandler(nil,nil)

            // "Speech recognition is not supported for your current locale.")
            return
        }
        if !myRecognizer.isAvailable {
            // "Speech recognition is not currently available. Check back at a later time.")
            // Recognizer is not available right now
            completionHandler(nil,nil)

            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                // Accept
                completionHandler(nil,result)

            } else if let error = error {
                // Error
                // "There has been a speech recognition error.")
                completionHandler(error,nil)
            }
        })
    }
}
