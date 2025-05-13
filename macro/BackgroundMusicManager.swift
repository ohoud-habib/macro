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
    private var introPlayer: AVAudioPlayer?

    private var hasPlayedIntroClipThisSession = false

    @AppStorage("isMusicOn") var isMusicOn: Bool = true {
        didSet {
            if isMusicOn {
                playMainTheme()
            } else {
                pauseAll()  // Pause all music when toggled off.
            }
        }
    }

    @AppStorage("appLanguage") private var appLanguageRawValue: String = AppLanguage.english.rawValue

    var appLanguage: AppLanguage {
        get {
            return AppLanguage(rawValue: appLanguageRawValue) ?? .english
        }
        set {
            appLanguageRawValue = newValue.rawValue
        }
    }

    override init() {
        super.init()
        setupMainTheme()
    }

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

    func playMainTheme() {
        guard isMusicOn, mainPlayer?.isPlaying == false else { return }
        mainPlayer?.play()
    }

    func pauseAll() {
        mainPlayer?.pause()
        modePlayer?.pause()
        introPlayer?.pause()
    }

    func playRandomIntroClipOnce() {
        guard !hasPlayedIntroClipThisSession else { return }

        let hasSeenIntro = UserDefaults.standard.bool(forKey: "hasSeenIntro")
        guard hasSeenIntro else {
            print("Intro not seen yet, skipping random clip.")
            return
        }

        hasPlayedIntroClipThisSession = true

        let arabicClips = ["RANDOM ARABIC 1", "RANDOM ARABIC 2", "RANDOM ARABIC 3", "RANDOM ARABIC 4", "RANDOM ARABIC 5"]
        let englishClips = ["RANDOM ENGLISH 1", "RANDOM ENGLISH 2", "RANDOM ENGLISH 3", "RANDOM ENGLISH 4", "RANDOM ENGLISH 5"]
        let clips = (appLanguage == .arabic) ? arabicClips : englishClips

        guard let randomClip = clips.randomElement(),
              let url = Bundle.main.url(forResource: randomClip, withExtension: "MP3") else {
            print("Intro clip not found for language \(appLanguage)")
            return
        }

        do {
            introPlayer = try AVAudioPlayer(contentsOf: url)
            introPlayer?.delegate = self
            introPlayer?.volume = 1.0
            introPlayer?.play()
        } catch {
            print("Failed to play intro clip: \(error)")
        }
    }

    func playModeTrack(for mode: Mode) {
        fadeOutMainTheme()  // Stop the main track when a mode starts.

        let filename: String
        switch mode {
        case .Horror:
            filename = "Horror Theme Mode"
        case .Comics:
            filename = "Comic Theme Mode"
        case .UtopianDystopian:
            filename = "Dystopian Theme Mode"
        case .main:
            filename = "GAME MAIN THEME"
        }

        if let url = Bundle.main.url(forResource: filename, withExtension: "MP3") {
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

    func fadeOutMainTheme(duration: TimeInterval = 1.0) {
        guard let player = mainPlayer, player.isPlaying else { return }
        fade(player: player, toVolume: 0, duration: duration) {
            player.stop() // Stop main music after fading out
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

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if player == modePlayer {
            modePlayer = nil
            fadeInMainTheme()  // Main theme should resume once the mode track finishes.
        }
    }
}




