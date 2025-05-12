//
//  Untitled.swift
//  macro
//
//  Created by Manar Majeed Alrasheed on 13/11/1446 AH.
//
import Foundation
import AVFoundation
import SwiftUI

class BackgroundMusicManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    static let shared = BackgroundMusicManager()
    
    private var mainPlayer: AVAudioPlayer?
    private var modePlayer: AVAudioPlayer?
    
    @AppStorage("isMusicOn") var isMusicOn: Bool = true {
        didSet {
            if isMusicOn {
                playMainTheme()
            } else {
                pauseAll()
            }
        }
    }
    
    override init() {
        super.init()
        setupMainTheme()
    }
    
    // MARK: - Setup
    private func setupMainTheme() {
        if let path = Bundle.main.path(forResource: "GAME MAIN THEME", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                mainPlayer = try AVAudioPlayer(contentsOf: url)
                mainPlayer?.numberOfLoops = -1
                mainPlayer?.volume = 0.5
                if isMusicOn {
                    playMainTheme()
                }
            } catch {
                print("Error loading main theme: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Main Theme Controls
    func playMainTheme() {
        guard isMusicOn, mainPlayer?.isPlaying == false else { return }
        mainPlayer?.play()
    }
    
    func pauseMainTheme() {
        mainPlayer?.pause()
    }
    
    func pauseAll() {
        mainPlayer?.pause()
        modePlayer?.pause()
    }

    func fadeOutMainTheme(duration: TimeInterval = 1.0) {
        guard let player = mainPlayer, player.isPlaying else { return }
        fade(player: player, toVolume: 0, duration: duration) {
            player.pause()
            player.volume = 0.5
        }
    }

    func fadeInMainTheme(duration: TimeInterval = 1.0) {
        guard let player = mainPlayer, !player.isPlaying, isMusicOn else { return }
        player.volume = 0
        player.play()
        fade(player: player, toVolume: 0.5, duration: duration)
    }

    private func fade(player: AVAudioPlayer, toVolume target: Float, duration: TimeInterval, completion: (() -> Void)? = nil) {
        let steps = Int(duration / 0.1)
        let delta = (target - player.volume) / Float(steps)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            player.volume += delta
            if (delta > 0 && player.volume >= target) || (delta < 0 && player.volume <= target) {
                player.volume = target
                timer.invalidate()
                completion?()
            }
        }
    }

    // MARK: - Mode Music Playback
    func playModeTrack(for mode: Mode) {
        fadeOutMainTheme()

        let filename: String
        switch mode {
        case .Horror:
            filename = "Horror Theme Mode"
        case .Comics:
            filename = "Comic Theme Mode"
        case .UtopianDystopian:
            filename = "Dystopian Theme Mode"
        }

        if let url = Bundle.main.url(forResource: filename, withExtension: "mp3") {
            do {
                modePlayer = try AVAudioPlayer(contentsOf: url)
                modePlayer?.delegate = self
                modePlayer?.volume = 1.0
                modePlayer?.play()
            } catch {
                print("Failed to play mode track: \(error)")
            }
        } else {
            print("Track not found: \(filename)")
        }
    }
    
    // MARK: - AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if player == modePlayer {
            modePlayer = nil
            fadeInMainTheme()
        }
    }
}





