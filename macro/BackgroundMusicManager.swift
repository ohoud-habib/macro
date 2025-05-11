//
//  Untitled.swift
//  macro
//
//  Created by Manar Majeed Alrasheed on 13/11/1446 AH.
//

import Foundation
import AVFoundation
import SwiftUI

class BackgroundMusicManager: ObservableObject {
    static let shared = BackgroundMusicManager()
    private var audioPlayer: AVAudioPlayer?
    
    @AppStorage("isMusicOn") var isMusicOn: Bool = true {
        didSet {
            if isMusicOn {
                playMusic()
            } else {
                pauseMusic()
            }
        }
    }
    
    init() {
        setupAudioPlayer()
    }
    
    private func setupAudioPlayer() {
        if let path = Bundle.main.path(forResource: "the-unveiling-royalty-free-music", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.volume = 0.5
                if isMusicOn {
                    playMusic()
                }
            } catch {
                print("Error loading music: \(error.localizedDescription)")
            }
        }
    }
    
    func playMusic() {
        audioPlayer?.play()
    }
    
    func pauseMusic() {
        audioPlayer?.pause()
    }
}
