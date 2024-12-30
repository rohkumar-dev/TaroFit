//
//  SoundManager.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 9/6/22.
//

import Foundation
import AVKit

class SoundManager {
    static let shared = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound(_ soundName: String, extensionName: String = ".mp3") {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: extensionName) else { return }
        do {
            try AVAudioSession.sharedInstance()
                .setCategory(.playback, options: .mixWithOthers)
            try AVAudioSession.sharedInstance()
                .setActive(true)
        } catch {
            print(error)
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
