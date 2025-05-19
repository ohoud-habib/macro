////
////  macroApp.swift
////  macro
////
////  Created by ohoud on 07/11/1446 AH.
////
//import SwiftUI
//import SwiftData
//enum AppLanguage: String {
//    case arabic
//    case english
//}
//
//func saveLanguagePreference(_ language: AppLanguage) {
//    UserDefaults.standard.set(language.rawValue, forKey: "AppLanguage")
//}
//
//func getLanguagePreference() -> AppLanguage {
//    let raw = UserDefaults.standard.string(forKey: "AppLanguage")
//    return AppLanguage(rawValue: raw ?? "") ?? .english
//}
//
//func isLanguageSet() -> Bool {
//    return UserDefaults.standard.string(forKey: "AppLanguage") != nil
//}
//
//import SwiftUI
//import AVFoundation
//import SwiftData
//
//// Sound Manager to play random startup sounds
//import AVFoundation
//
//class StartupSoundManager {
//    static let shared = StartupSoundManager()
//    
//    private var players: [AVAudioPlayer] = []
//    
//    func playRandomStartupSound() {
//        // Only play sound if the user has seen the intro before
//        let hasSeenIntro = UserDefaults.standard.bool(forKey: "hasSeenIntro")
//        
//        // If the intro hasn't been seen yet, don't play the sound
//        guard hasSeenIntro else { return }
//        
//        stopAllSounds()
//        
//        // Get language-specific sound files
//        let soundFiles: [String]
//        switch getLanguagePreference() {
//        case .arabic:
//            soundFiles = [
//                "RANDOM ARABIC 1.MP3",
//                "RANDOM ARABIC 2.MP3",
//                "RANDOM ARABIC 3.MP3",
//                "RANDOM ARABIC 4.MP3",
//                "RANDOM ARABIC 5.MP3"
//            ]
//        case .english:
//            soundFiles = [
//                "RANDOM ENGLISH 1.MP3",
//                "RANDOM ENGLISH 2.MP3",
//                "RANDOM ENGLISH 3.MP3",
//                "RANDOM ENGLISH 4.MP3",
//                "RANDOM ENGLISH 5.MP3"
//            ]
//        }
//        
//        // Pick a random sound from the list
//        let selectedSound = soundFiles.randomElement() ?? soundFiles.first!
//        
//        // Play the selected sound
//        if let url = Bundle.main.url(forResource: selectedSound, withExtension: nil) {
//            do {
//                let player = try AVAudioPlayer(contentsOf: url)
//                player.prepareToPlay()
//                player.play()
//                players.append(player)
//            } catch {
//                print("Error playing sound: \(selectedSound), error: \(error)")
//            }
//        }
//    }
//    
//    func stopAllSounds() {
//        for player in players {
//            player.stop()
//        }
//        players.removeAll()
//    }
//}
//
//
//import SwiftUI
//import SwiftData
//
//@main
//struct macroApp: App {
//    @State private var showLanguageSelection = !isLanguageSet()
//    @Environment(\.scenePhase) private var scenePhase
//    @State private var hasPlayedSound = false
//    @State private var showSplashScreen = true
//
//    // ✅ Use AppStorage to persist across app launches
//    @AppStorage("isSoundOn") private var isSoundOn = true
//    @AppStorage("isMusicOn") private var isMusicOn = true
//
//    var body: some Scene {
//        WindowGroup {
//            AppInitializerView(
//                showLanguageSelection: $showLanguageSelection,
//                showSplashScreen: $showSplashScreen
//            )
//            .onAppear {
//                // ✅ Play music on app launch if user enabled it
//                if isMusicOn {
//                    BackgroundMusicManager.shared.play()
//                }
//            }
//            .onChange(of: scenePhase) { newPhase in
//                if newPhase == .active && !hasPlayedSound {
//                    if UserDefaults.standard.bool(forKey: "hasSeenIntro") {
//                        // ✅ Play startup sound regardless of sound setting
//                        StartupSoundManager.shared.playRandomStartupSound()
//                        hasPlayedSound = true
//                    }
//                }
//            }
//
//        }
//        .modelContainer(for: UserModel.self)
//    }
//}
//
//
//
//
//
//
//
//import SwiftUI
//
//struct AppInitializerView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var users: [UserModel]
//    @Binding var showLanguageSelection: Bool
//    @Binding var showSplashScreen: Bool
//
//    var body: some View {
//        Group {
//            if showSplashScreen {
//                SplashPage()
//            } else {
//                if showLanguageSelection {
//                    LanguageSelectionView {
//                        showLanguageSelection = false
//                    }
//                } else {
//                    IntroView()
//                }
//            }
//        }
//        .onAppear {
//            if users.isEmpty {
//                let user = UserModel()
//                modelContext.insert(user)
//                try? modelContext.save()
//            }
//            // After the splash screen is shown for a few seconds, hide it and show the language selection or intro
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                showSplashScreen = false // Hide splash screen after 2 seconds
//            }
//        }
//    }
//}
//
//
//struct AppButton: View {
//    let title: String
//    let action: () -> Void
//
//    var body: some View {
//        Button(title, action: action)
//            .frame(width: 134.6, height: 46)
//            .font(.system(size: 20, weight: .bold))
//            .background(Color.btn)
//            .foregroundColor(.black)
//            .cornerRadius(10)
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.black, lineWidth: 0.5)
//            )
//    }
//}
//
//
//struct LanguageSelectionView: View {
//    
//
//    var onLanguageSelected: () -> Void
//
//    var body: some View {
//        ZStack{
//            Image("ChoosingLanguageBG")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//            
//                
//            VStack(alignment: .center, spacing: 30) {
//                Text("Choose your preferred language\nاختر لغتك المفضلة")
//                    .foregroundColor(.black)
//                    .multilineTextAlignment(.center)
//                    .font(.title)
//                    .bold()
//
//                AppButton(title: "English") {
//                    saveLanguagePreference(.english)
//                    onLanguageSelected()
//                }
//
//                AppButton(title: "العربية") {
//                    saveLanguagePreference(.arabic)
//                    onLanguageSelected()
//                }
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(.leading, 40)
//
//            
//        }
//    }
//}
//struct LanguageSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        LanguageSelectionView {}
//        .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
//
//
//import SwiftUI
//
//struct SplashPage: View {
//    @State private var isActive: Bool = false
//    @State private var currentImageIndex: Int = 0
//
//    // Array of image names to cycle through
//    let images = ["name1", "name2", "name3"] // Add your image names here
//    let animationDuration: Double = 0.0001 // Time interval for each image change
//    
//    var body: some View {
//        ZStack {
//            if self.isActive {
//                StartView() // Content to show after splash
//            } else {
//                // Display cycling images
//                Image(images[currentImageIndex])
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//                
//            }
//        }
//        .onAppear {
//            startImageCycling()
//            // Transition to the main view after a delay
//            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
//                withAnimation {
//                    self.isActive = true
//                }
//            }
//        }
//    }
//    
//    // Function to cycle through the images
//    private func startImageCycling() {
//        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
//            withAnimation {
//                currentImageIndex = (currentImageIndex + 1) % images.count
//            }
//        }
//    }
//}
//
//#Preview {
//    SplashPage()
//}
//
//  macroApp.swift
//  macro
//
//  Created by ohoud on 07/11/1446 AH.
//
import SwiftUI
import SwiftData
import AVFoundation

enum AppLanguage: String {
    case arabic
    case english
    
    var accessibilityLabel: String {
        switch self {
        case .arabic: return "Arabic"
        case .english: return "English"
        }
    }
}

func saveLanguagePreference(_ language: AppLanguage) {
    UserDefaults.standard.set(language.rawValue, forKey: "AppLanguage")
    UIAccessibility.post(notification: .announcement,
                        argument: "Language set to \(language.accessibilityLabel)")
}

func getLanguagePreference() -> AppLanguage {
    let raw = UserDefaults.standard.string(forKey: "AppLanguage")
    return AppLanguage(rawValue: raw ?? "") ?? .english
}

func isLanguageSet() -> Bool {
    return UserDefaults.standard.string(forKey: "AppLanguage") != nil
}

// MARK: - Startup Sound Manager with Accessibility
class StartupSoundManager {
    static let shared = StartupSoundManager()
    private var players: [AVAudioPlayer] = []
    
    func playRandomStartupSound() {
        let hasSeenIntro = UserDefaults.standard.bool(forKey: "hasSeenIntro")
        guard hasSeenIntro else { return }
        
        stopAllSounds()
        
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
        
        let selectedSound = soundFiles.randomElement() ?? soundFiles.first!
        
        if let url = Bundle.main.url(forResource: selectedSound, withExtension: nil) {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.play()
                players.append(player)
                
                // Accessibility announcement
                let announcement = getLanguagePreference() == .arabic ?
                "صوت بدء تشغيل عشوائي" : "Random startup sound playing"
                UIAccessibility.post(notification: .announcement, argument: announcement)
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

// MARK: - Main App
@main
struct macroApp: App {
    @State private var showLanguageSelection = !isLanguageSet()
    @Environment(\.scenePhase) private var scenePhase
    @State private var hasPlayedSound = false
    @State private var showSplashScreen = true
    @AppStorage("isSoundOn") private var isSoundOn = true
    @AppStorage("isMusicOn") private var isMusicOn = true

    var body: some Scene {
        WindowGroup {
            AppInitializerView(
                showLanguageSelection: $showLanguageSelection,
                showSplashScreen: $showSplashScreen
            )
            .onAppear {
                if isMusicOn {
                    BackgroundMusicManager.shared.play()
                    UIAccessibility.post(notification: .announcement,
                                       argument: "Background music started")
                }
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active && !hasPlayedSound {
                    if UserDefaults.standard.bool(forKey: "hasSeenIntro") {
                        StartupSoundManager.shared.playRandomStartupSound()
                        hasPlayedSound = true
                    }
                }
            }
        }
        .modelContainer(for: UserModel.self)
    }
}

// MARK: - App Initializer View
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
                UIAccessibility.post(notification: .announcement,
                                   argument: "New user profile created")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showSplashScreen = false
                UIAccessibility.post(notification: .screenChanged,
                                   argument: "App initialization complete")
            }
        }
    }
}

// MARK: - App Button with Accessibility
struct AppButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
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
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Language Selection View with Accessibility
struct LanguageSelectionView: View {
    var onLanguageSelected: () -> Void
    
    var body: some View {
        ZStack {
            Image("ChoosingLanguageBG")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            VStack(alignment: .center, spacing: 30) {
                Text("Choose your preferred language\nاختر لغتك المفضلة")
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .bold()
                    .accessibilityLabel("Choose your preferred language. اختر لغتك المفضلة")
                    .accessibilityAddTraits(.isHeader)
                
                AppButton(title: "English") {
                    saveLanguagePreference(.english)
                    onLanguageSelected()
                }
                .accessibilityHint("Double tap to select English language")
                
                AppButton(title: "العربية") {
                    saveLanguagePreference(.arabic)
                    onLanguageSelected()
                }
                .accessibilityHint("اضغط مرتين لاختيار اللغة العربية")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 40)
            .accessibilityElement(children: .contain)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Language selection screen")
    }
}

// MARK: - Splash Page with Accessibility
struct SplashPage: View {
    @State private var isActive: Bool = false
    @State private var currentImageIndex: Int = 0
    let images = ["name1", "name2", "name3"]
    let animationDuration: Double = 0.0001
    
    var body: some View {
        ZStack {
            if self.isActive {
                StartView()
            } else {
                Image(images[currentImageIndex])
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .accessibilityLabel("Application loading screen")
            }
        }
        .onAppear {
            startImageCycling()
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                withAnimation {
                    self.isActive = true
                    UIAccessibility.post(notification: .screenChanged,
                                       argument: "Loading complete. Application ready")
                }
            }
        }
        .accessibilityElement(children: .contain)
    }
    
    private func startImageCycling() {
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
            withAnimation {
                currentImageIndex = (currentImageIndex + 1) % images.count
            }
        }
    }
}

// MARK: - Preview
struct LanguageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSelectionView {}
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

#Preview {
    SplashPage()
}
