//
//  macroApp.swift
//  macro
//
//  Created by ohoud on 07/11/1446 AH.
//
import SwiftUI
import SwiftData
enum AppLanguage: String {
    case arabic
    case english
}

func saveLanguagePreference(_ language: AppLanguage) {
    UserDefaults.standard.set(language.rawValue, forKey: "AppLanguage")
}

func getLanguagePreference() -> AppLanguage {
    let raw = UserDefaults.standard.string(forKey: "AppLanguage")
    return AppLanguage(rawValue: raw ?? "") ?? .english
}

func isLanguageSet() -> Bool {
    return UserDefaults.standard.string(forKey: "AppLanguage") != nil
}

import SwiftUI
import AVFoundation
import SwiftData

// Sound Manager to play random startup sounds
import AVFoundation

class StartupSoundManager {
    static let shared = StartupSoundManager()
    
    private var players: [AVAudioPlayer] = []
    
    func playRandomStartupSound() {
        // Only play sound if the user has seen the intro before
        let hasSeenIntro = UserDefaults.standard.bool(forKey: "hasSeenIntro")
        
        // If the intro hasn't been seen yet, don't play the sound
        guard hasSeenIntro else { return }
        
        stopAllSounds()
        
        // Get language-specific sound files
        let soundFiles: [String]
        switch getLanguagePreference() {
        case .arabic:
            soundFiles = [
                "RANDOM ARABIC 1.MP3",
                "RANDOM ARABIC 2.MP3",
                "RANDOM ARABIC 3.MP3",
                "RANDOM ARABIC 4.MP3",
                "RANDOM ARABIC 5.MP3"
            ]
        case .english:
            soundFiles = [
                "RANDOM ENGLISH 1.MP3",
                "RANDOM ENGLISH 2.MP3",
                "RANDOM ENGLISH 3.MP3",
                "RANDOM ENGLISH 4.MP3",
                "RANDOM ENGLISH 5.MP3"
            ]
        }
        
        // Pick a random sound from the list
        let selectedSound = soundFiles.randomElement() ?? soundFiles.first!
        
        // Play the selected sound
        if let url = Bundle.main.url(forResource: selectedSound, withExtension: nil) {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.play()
                players.append(player)
            } catch {
                print("Error playing sound: \(selectedSound), error: \(error)")
            }
        }
    }
    
    func stopAllSounds() {
        for player in players {
            player.stop()
        }
        players.removeAll()
    }
}


import SwiftUI
import SwiftData

@main
struct macroApp: App {
    @State private var showLanguageSelection = !isLanguageSet()
    @Environment(\.scenePhase) private var scenePhase // To track app lifecycle state
    @State private var hasPlayedSound = false // Track if the sound has been played
    @State private var showSplashScreen = true // Flag to show splash screen

    var body: some Scene {
        WindowGroup {
            AppInitializerView(showLanguageSelection: $showLanguageSelection, showSplashScreen: $showSplashScreen)
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active && !hasPlayedSound {
                        // Check if the intro has been seen
                        if UserDefaults.standard.bool(forKey: "hasSeenIntro") {
                            // Play the random startup sound
                            StartupSoundManager.shared.playRandomStartupSound()
                            hasPlayedSound = true // Set flag to true after playing the sound
                        }
                    }
                }
        }
        .modelContainer(for: UserModel.self)
    }
}







import SwiftUI

struct AppInitializerView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [UserModel]
    @Binding var showLanguageSelection: Bool
    @Binding var showSplashScreen: Bool

    var body: some View {
        Group {
            if showSplashScreen {
                SplashPage()
            } else {
                if showLanguageSelection {
                    LanguageSelectionView {
                        showLanguageSelection = false
                    }
                } else {
                    IntroView()
                }
            }
        }
        .onAppear {
            if users.isEmpty {
                let user = UserModel()
                modelContext.insert(user)
                try? modelContext.save()
            }
            // After the splash screen is shown for a few seconds, hide it and show the language selection or intro
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showSplashScreen = false // Hide splash screen after 2 seconds
            }
        }
    }
}


struct AppButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(title, action: action)
            .frame(width: 134.6, height: 46)
            .font(.system(size: 20, weight: .bold))
            .background(Color.btn)
            .foregroundColor(.black)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 0.5)
            )
    }
}


struct LanguageSelectionView: View {
    

    var onLanguageSelected: () -> Void

    var body: some View {
        ZStack{
            Image("ChoosingLanguageBG")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            
                
            VStack(alignment: .center, spacing: 30) {
                Text("Choose your preferred language\nاختر لغتك المفضلة")
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .bold()

                AppButton(title: "English") {
                    saveLanguagePreference(.english)
                    onLanguageSelected()
                }

                AppButton(title: "العربية") {
                    saveLanguagePreference(.arabic)
                    onLanguageSelected()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 40)

            
        }
    }
}
struct LanguageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSelectionView {}
        .previewInterfaceOrientation(.landscapeLeft)
    }
}


import SwiftUI

struct SplashPage: View {
    @State private var isActive: Bool = false
    @State private var currentImageIndex: Int = 0

    // Array of image names to cycle through
    let images = ["name1", "name2", "name3"] // Add your image names here
    let animationDuration: Double = 0.0001 // Time interval for each image change
    
    var body: some View {
        ZStack {
            if self.isActive {
                StartView() // Content to show after splash
            } else {
                // Display cycling images
                Image(images[currentImageIndex])
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
            }
        }
        .onAppear {
            startImageCycling()
            // Transition to the main view after a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
    // Function to cycle through the images
    private func startImageCycling() {
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
            withAnimation {
                currentImageIndex = (currentImageIndex + 1) % images.count
            }
        }
    }
}

#Preview {
    SplashPage()
}
