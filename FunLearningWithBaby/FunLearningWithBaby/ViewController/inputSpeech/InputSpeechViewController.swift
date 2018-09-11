//
//  InputSpeechViewController.swift
//  FunLearningWithBaby
//
//  Created by Hai Dang on 9/11/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class InputSpeechViewController: OriginalViewController, CPSliderDelegate {

    var imagesArray = [String]()
    
    @IBOutlet weak var slider : CPImageSlider!
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var microButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSlider()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK - Set up Navigation Bar
    func setupNavigationBar() {
        
    }
    
    // MARK: Set up UI
    func setupSlider() {
        imagesArray = ["wallpaper1.jpg","wallpaper2.jpg","wallpaper3.jpg","wallpaper4.jpg"]
        slider.images = imagesArray
        slider.delegate = self

    }
    
    // MARK: - Slider delegate
    func sliderImageTapped(slider: CPImageSlider, index: Int) {
        print("\(index)")
    }
    
    // MARK: - Action
    @IBAction func tappedSpeak(_ sender: UIButton) {
        if sender.isSelected {
            // Start speaking
            SpeechViewController.shared.speechAction(isRecording: sender.isSelected, completionHandler: {(error,result) in
                self.inputLabel.text = result?.bestTranscription.formattedString
            })
        } else {
            // Stop speaking
            SpeechViewController.shared.stopSpeech()
        }
    }
}
