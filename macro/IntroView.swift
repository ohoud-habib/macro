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

    enum SoundType {
        case intro
    }

    func play(sound type: SoundType) {
        let fileName: String

        switch type {
        case .intro:
            switch getLanguagePreference() {
            case .english: fileName = "INTROENGLISH"
            case .arabic: fileName = "INTRO ARABIC"
            }
        }

        guard let url = Bundle.main.url(forResource: fileName, withExtension: "MP3") else {
            print("❌ Sound file '\(fileName).mp3' not found.")
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = 0
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("❌ Could not play sound: \(error.localizedDescription)")
        }
    }

    func stop() {
        player?.stop()
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
                        .accessibilityHidden(true)

                    if showBlackTransition {
                        Color.black
                            .ignoresSafeArea()
                            .transition(.opacity)
                            .accessibilityHidden(true)
                    }

                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: skipIntro) {
                                Text(userLanguage == .arabic ? "تخطي" : "Skip")
                                    .font(.headline)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.black.opacity(0.6))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding()
                                
                            }
                            .accessibilityLabel(userLanguage == .arabic ? "تخطي المقدمة" : "Skip Intro")
                                                        .accessibilityHint(userLanguage == .arabic ? "اضغط لتجاوز المقدمة والانتقال إلى الصفحة التالية" : "Tap to skip the intro and go to the next screen")
                                                        .accessibilityAddTraits(.isButton)
                        }
                    }

                    NavigationLink(destination: StartView(), isActive: $goToStartView) {
                        EmptyView()
                    }
                }
            }
            .onAppear {
                if !slideshowStarted && !UserDefaults.standard.bool(forKey: "hasSeenIntro") {
                    slideshowStarted = true
                    SoundManager.shared.play(sound: .intro)
                    startSlideshow()
                }
            }
        }
    }

    func skipIntro() {
        SoundManager.shared.stop()
        UserDefaults.standard.set(true, forKey: "hasSeenIntro")
        goToStartView = true
    }

    func startSlideshow() {
        var accumulatedDelay: Double = 0.0

        for i in 1..<images.count {
            accumulatedDelay += durations[i - 1]

            if i == 3 || i == 5 {
                DispatchQueue.main.asyncAfter(deadline: .now() + accumulatedDelay - 0.5) {
                    if !goToStartView {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showBlackTransition = true
                        }
                    }
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + accumulatedDelay) {
                if goToStartView { return }

                currentIndex = i

                if i == 3 || i == 5 {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showBlackTransition = false
                    }
                }

                if i == images.count - 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + durations.last!) {
                        if !goToStartView {
                            skipIntro()
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    IntroView()
}

