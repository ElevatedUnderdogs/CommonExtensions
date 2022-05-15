//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

#if os(iOS)
import Foundation
import AVFoundation


extension AVAudioSession {

    class func set(category: AVAudioSession.Category = .playback) {
        do {
            try AVAudioSession.sharedInstance().setCategory(category)
        } catch {
            print("Audio session failed", error)
        }
    }
}
#endif
