//
//  TextToSpeech.swift
//  SayMyName
//
//  Created by william boney on 4/22/19.
//  Copyright © 2019 william boney. All rights reserved.
//

import UIKit
import AVFoundation

class TextToSpeech: NSObject {
    
    
    class func SayText(input : String) {
        
        var synth : AVSpeechSynthesizer = AVSpeechSynthesizer()
        var utterance : AVSpeechUtterance = AVSpeechUtterance(string: input)
        utterance.rate = (AVSpeechUtteranceMinimumSpeechRate) * 0.25
        utterance.volume = 1
        utterance.pitchMultiplier = 1
        synth.speak(utterance)
    }

}
