//
//  IntroView.swift
//  macro
//
//  Created by ohoud on 10/11/1446 AH.
//

import SwiftUI
import AVFoundation

// MARK: - SoundManager
class SoundManager: ObservableObject {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?

    func playIntroSound() {
        let userLanguage = getLanguagePreference()

        let fileName: String
        switch userLanguage {
        case .english:
            fileName = "INTROENGLISH"
        case .arabic:
            fileName = "INTRO ARABIC"
        }

        guard let url = Bundle.main.url(forResource: fileName, withExtension: "MP3") else {
            print("❌ Sound file '\(fileName).mp3' not found.")
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("❌ Could not play sound: \(error.localizedDescription)")
        }
    }
}

// MARK: - IntroView
struct IntroView: View {
    let userLanguage = getLanguagePreference()

    var images: [String] {
        switch userLanguage {
        case .arabic:
            return ["metroIntrance", "trainStation", "senasmile", "senasmile2", "man@tran", "sena", "sena2", "trainClosed", "trainOpen", "clock", "arabicname1", "arabicname2", "arabicname3"]
        case .english:
            return ["metroIntrance", "trainStation", "senasmile", "senasmile2", "man@tran", "sena", "sena2", "trainClosed", "trainOpen", "clock", "name1", "name2", "name3"]
        }
    }

    let durations: [Double] = [7.0, 9.0, 6.5, 9.0, 10.0, 9.5, 9.5, 5.0, 7.0, 4.0, 3.0, 2.0, 2.0]

    @State private var currentIndex = 0
    @State private var slideshowStarted = false
    @State private var showBlackTransition = false
    @State private var goToStartView = false

    var body: some View {
        NavigationStack {
            ZStack {
                if UserDefaults.standard.bool(forKey: "hasSeenIntro") {
                    StartView()
                } else {
                    Image(images[currentIndex])
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()

                    if showBlackTransition {
                        Color.black
                            .ignoresSafeArea()
                            .transition(.opacity)
                    }

                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: skipIntro) {
                                Text("Skip")
                                    .font(.headline)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.black.opacity(0.6))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding()
                            }
                        }
                    }

                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if !slideshowStarted {
                                slideshowStarted = true
                                SoundManager.shared.playIntroSound()
                                startSlideshow()
                            }
                        }

                    NavigationLink(destination: StartView(), isActive: $goToStartView) {
                        EmptyView()
                    }
                }
            }
            .onAppear {
                // Optional: Uncomment to auto-start without tap
                /*
                if !slideshowStarted {
                    slideshowStarted = true
                    SoundManager.shared.playIntroSound()
                    startSlideshow()
                }
                */
            }
        }
    }

    func skipIntro() {
        UserDefaults.standard.set(true, forKey: "hasSeenIntro")
        goToStartView = true
    }

    func startSlideshow() {
        var accumulatedDelay: Double = 0.0

        for i in 1..<images.count {
            accumulatedDelay += durations[i - 1]

            if i == 3 || i == 5 {
                DispatchQueue.main.asyncAfter(deadline: .now() + accumulatedDelay - 0.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showBlackTransition = true
                    }
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + accumulatedDelay) {
                currentIndex = i

                if i == 3 || i == 5 {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showBlackTransition = false
                    }
                }

                if i == images.count - 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + durations.last!) {
                        skipIntro()
                    }
                }
            }
        }
    }
}


#Preview {
    IntroView()
}
