////
////  SettingsView.swift
////  macro
////
////  Created by Maryam Bahwal on 11/11/1446 AH.
////
//
//import SwiftUI
//import AVFoundation
//import AudioToolbox
//
//// MARK: - SoundManager (Handles Sound Logic)
////class SoundManager: ObservableObject {
////    static let shared = SoundManager() // Singleton instance
////    @AppStorage("isSoundOn") var isSoundOn: Bool = true // Save state in UserDefaults
////    
////    func playSound(type: SoundType) {
////        guard isSoundOn else { return } // Play only if sound is enabled
////        
////        let soundID: SystemSoundID
////        switch type {
////        case .toggle:
////            soundID = 1100 // Toggle sound effect
////        case .button:
////            soundID = 1303 // Button click sound
////        case .thirdSound:
////            soundID = 1030
////        case .optionTap:
////            soundID = 1111
////        case .conTap:
////            soundID = 1567
////        }
////        
////        AudioServicesPlaySystemSound(soundID)
////    }
////    
////    enum SoundType {
////        case toggle
////        case button
////        case thirdSound
////        case optionTap
////        case conTap
////    }
////}
//
//// MARK: - BackgroundMusicManager (Handles Background Music)
//class BackgroundMusicManager: ObservableObject {
//    static let shared = BackgroundMusicManager()
//    private var audioPlayer: AVAudioPlayer?
//    
//    @AppStorage("isMusicOn") var isMusicOn: Bool = true {
//        didSet {
//            if isMusicOn {
//                playMusic() // Play music when toggled on
//            } else {
//                pauseMusic() // Pause music when toggled off
//            }
//        }
//    }
//    
//    init() {
//        setupAudioPlayer()
//    }
//    
//    private func setupAudioPlayer() {
//        if let path = Bundle.main.path(forResource: "the-unveiling-royalty-free-music", ofType: "mp3") {
//            let url = URL(fileURLWithPath: path)
//            do {
//                audioPlayer = try AVAudioPlayer(contentsOf: url)
//                audioPlayer?.numberOfLoops = -1 // Loop indefinitely
//                audioPlayer?.volume = 0.5 // Adjust volume as needed
//                
//                // Start music only if the toggle is on
//                if isMusicOn {
//                    playMusic()
//                }
//            } catch {
//                print("Error loading background music: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func playMusic() {
//        audioPlayer?.play()
//    }
//    
//    func pauseMusic() {
//        audioPlayer?.pause()
//    }
//}
//
//// MARK: - SettingsView (Main View)
//import SwiftUI
//import AVFoundation
//import AudioToolbox
//import SwiftData
//
//// MARK: - SettingsView (Main View)
//struct SettingsView: View {
//    @StateObject private var soundManager = SoundManager.shared // Singleton instance
//    @StateObject private var musicManager = BackgroundMusicManager.shared // Singleton instance for music
//    @Environment(\.modelContext) private var modelContext // Access SwiftData context
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Image("settings")
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//                
//                VStack {
////                    HStack {
////                        NavigationLink(destination: BoxOfficeView().navigationBarBackButtonHidden(true)) {
////                            Image("Home")
////                                .resizable()
////                                .frame(width: 60, height: 60)
////                        }
////                        .simultaneousGesture(TapGesture().onEnded {
////                            soundManager.playSound(type: .button)
////                        })
////                        
////                        Spacer()
////                        
////                        NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)) {
////                            Image("prof")
////                                .resizable()
////                                .frame(width: 60, height: 60)
////                        }
////                        .simultaneousGesture(TapGesture().onEnded {
////                            soundManager.playSound(type: .button)
////                        })
////                    }
////                    .padding()
//                    
//                    Spacer()
//                    
////                    VStack(spacing: 20) {
////                        SettingToggle(
////                            text: "Sound",
////                            onImage: "Sound",
////                            offImage: "Mute",
////                            isOn: $soundManager.isSoundOn,
////                            activeColor: .brown
////                        )
////                        .onChange(of: soundManager.isSoundOn) { _ in
////                            soundManager.playSound(type: .toggle)
////                        }
////                        
////                        SettingToggle(
////                            text: "Music",
////                            onImage: "Music",
////                            offImage: "MusicOff",
////                            isOn: $musicManager.isMusicOn,
////                            activeColor: .green
////                        )
////                        
//////                        Button(action: {
//////                            soundManager.playSound(type: .toggle)
//////                            resetProgress() // Call the reset function
//////                            print("Reset Progress tapped")
//////                        }) {
//////                            HStack {
//////                                Image("Reset")
//////                                    .resizable()
//////                                    .frame(width: 60, height: 60)
//////                                
//////                                Text("Reset Progress")
//////                                    .font(.custom("MedievalSharp", size: 24))
//////                                    .foregroundColor(.white)
//////                                    .padding(.leading, 14.0)
//////                            }
//////                            .frame(width: 250)
//////                        }
////                    }
//                    
//                    Spacer()
//                }
//            }
//        }
//        .environmentObject(soundManager)
//        .environmentObject(musicManager)
//    }
//    
//    // Function to reset progress
////    private func resetProgress() {
////        do {
////            // Fetch all SentimentScore entries
////            let scores = try modelContext.fetch(FetchDescriptor<SentimentScore>())
////            
////            // Delete all entries
////            for score in scores {
////                modelContext.delete(score)
////            }
////            
////            // Save the context to apply changes
////            try modelContext.save()
////            
////            print("All scores reset successfully.")
////        } catch {
////            print("Failed to reset scores: \(error.localizedDescription)")
////        }
////    }
//}
//
//// MARK: - SettingToggle (Reusable Toggle Component)
//struct SettingToggle: View {
//    let text: String
//    let onImage: String
//    let offImage: String
//    @Binding var isOn: Bool
//    let activeColor: Color
//    @EnvironmentObject var soundManager: SoundManager
//    
//    var body: some View {
//        HStack {
//            Image(isOn ? onImage : offImage)
//                .resizable()
//                .frame(width: 60, height: 60)
//            
//            Text(text)
//                .font(.custom("MedievalSharp", size: 24))
//                .bold()
//                .foregroundColor(.white)
//                .padding()
//            
//            Spacer()
//            
//            Toggle("", isOn: $isOn)
//                .labelsHidden()
//                .toggleStyle(CustomToggleStyle())
////                .onChange(of: isOn) { _ in
////                    soundManager.playSound(type: .toggle) // Play toggle sound
////                }
//        }
//        .frame(width: 250)
//    }
//}
//
//
//// MARK: - Preview
//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//            .environmentObject(SoundManager.shared)
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
//
//
//// Custom Toggle Style
//struct CustomToggleStyle: ToggleStyle {
////    var onColor: Color = Color(.toggleGreen) // Green when on
////    var offColor: Color = Color(.togglegray1) // Gray when off
////    var thumbColorOn: Color = Color(.toggleGray2) // Gray circle when on
////    var thumbColorOff: Color = Color(.toggleBrown) // Brown circle when off
//    
//    func makeBody(configuration: Configuration) -> some View {
////        ZStack {
////            RoundedRectangle(cornerRadius: 16)
////                .fill(configuration.isOn ? onColor : offColor)
////                .frame(width: 50, height: 30)
////                .overlay(
////                    Circle()
////                        .fill(configuration.isOn ? thumbColorOn : thumbColorOff)
////                        .frame(width: 26, height: 26)
////                        .offset(x: configuration.isOn ? 10 : -10)
////                        .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
////                )
////                .onTapGesture {
////                    configuration.isOn.toggle()
////                }
////        }
//    }
//}
//
//
import SwiftUI
import AVFoundation
import AudioToolbox
import SwiftData

// MARK: - SoundManager (Handles Sound Logic)
//class SoundManager: ObservableObject {
//    static let shared = SoundManager() // Singleton instance
//    @AppStorage("isSoundOn") var isSoundOn: Bool = true // Save state in UserDefaults
//    
//    func playSound(type: SoundType) {
//        guard isSoundOn else { return } // Play only if sound is enabled
//        
//        let soundID: SystemSoundID
//        switch type {
//        case .toggle:
//            soundID = 1100 // Toggle sound effect
//        case .button:
//            soundID = 1303 // Button click sound
//        case .thirdSound:
//            soundID = 1030
//        case .optionTap:
//            soundID = 1111
//        case .conTap:
//            soundID = 1567
//        }
//        
//        AudioServicesPlaySystemSound(soundID)
//    }
//    
//    enum SoundType {
//        case toggle
//        case button
//        case thirdSound
//        case optionTap
//        case conTap
//    }
//}

// MARK: - BackgroundMusicManager (Handles Background Music)
class BackgroundMusicManager: ObservableObject {
    static let shared = BackgroundMusicManager()
    private var audioPlayer: AVAudioPlayer?
    
    @AppStorage("isMusicOn") var isMusicOn: Bool = true {
        didSet {
            if isMusicOn {
                playMusic() // Play music when toggled on
            } else {
                pauseMusic() // Pause music when toggled off
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
                audioPlayer?.numberOfLoops = -1 // Loop indefinitely
                audioPlayer?.volume = 0.5 // Adjust volume as needed
                
                // Start music only if the toggle is on
                if isMusicOn {
                    playMusic()
                }
            } catch {
                print("Error loading background music: \(error.localizedDescription)")
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

// MARK: - SettingsView (Main View)
import SwiftUI
import AVFoundation
import AudioToolbox
import SwiftData

// MARK: - SettingsView (Main View)
struct SettingsView: View {
    @Query private var users: [UserModel]
    @StateObject private var soundManager = SoundManager.shared // Singleton instance
    @StateObject private var musicManager = BackgroundMusicManager.shared // Singleton instance for music
    @Environment(\.modelContext) private var modelContext // Access SwiftData context
    
    //
    @State private var isSoundOn = false

    var body: some View {
        NavigationView {
            ZStack {
                Image("SettingBG")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                    VStack {
                        NavigationLink(destination: StartView().navigationBarBackButtonHidden(true)) {
                            Image("homeIcon")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Spacer()
                        }
//                        .simultaneousGesture(TapGesture().onEnded {
//                            soundManager.playSound(type: .button)
//                        })
                        
//                        Spacer()
                        
                        NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)) {
                            Image("profileIcon")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Spacer()
                        }
//                        .simultaneousGesture(TapGesture().onEnded {
//                            soundManager.playSound(type: .button)
//                        })
                    }
                Spacer()
//                    .padding()
                    
//                    Spacer()
                    
                    VStack(spacing: 20) {
                        SettingToggle(
                            text: "Sound",
                            onImage: "Sound",
                            offImage: "Mute",
                            isOn: $isSoundOn, // <-- Use $ to pass Binding<Bool>
                            activeColor: .brown
                        )
//                        SettingToggle(
//                            text: "Sound",
//                            onImage: "Sound",
//                            offImage: "Mute",
//                            isOn: $soundManager.isSoundOn,
//                            activeColor: .brown
//                        )
//                        .onChange(of: soundManager.isSoundOn) { _ in
//                            soundManager.playSound(type: .toggle)
//                        }
                        
                        SettingToggle(
                            text: "Music",
                            onImage: "Music",
                            offImage: "MusicOff",
                            isOn: $musicManager.isMusicOn,
                            activeColor: .green
                        )
                        
//                        Button(action: {
//                            soundManager.playSound(type: .toggle)
//                            if let user = users.first {
//                                    user.resetProgress(context: modelContext)
//                                }
//                            print("Reset Progress tapped")
//                        }) {
//                            HStack {
//                                Image("Reset")
//                                    .resizable()
//                                    .frame(width: 60, height: 60)
//                                
//                                Text("Reset Progress")
//                                    .font(.custom("MedievalSharp", size: 24))
//                                    .foregroundColor(.white)
//                                    .padding(.leading, 14.0)
//                            }
//                            .frame(width: 250)
//                        }
                        Button(action: {
//                            soundManager.playSound(type: .toggle)
                            if let user = users.first {
                                user.resetProgress(context: modelContext)
                            }
                            print("Reset Progress tapped")
                        }) {
                            Text("Reset Progress")
                                .foregroundColor(.red)
                        }

                    }
                    
//                    Spacer()
                
            }
        }
        .environmentObject(soundManager)
        .environmentObject(musicManager)
    }
    
    // Function to reset progress
//    private func resetProgress() {
//        do {
//            // Fetch all SentimentScore entries
//            let scores = currentKarma
//            
//            // Delete all entries
//            for score in scores {
//                modelContext.delete(score)
//            }
//            
//            // Save the context to apply changes
//            try modelContext.save()
//            
//            print("All scores reset successfully.")
//        } catch {
//            print("Failed to reset scores: \(error.localizedDescription)")
//        }
//    }
    
    private var currentKarma: Int {
        users.first?.karma ?? 0
    }
    
}

// MARK: - SettingToggle (Reusable Toggle Component)
//struct SettingToggle: View {
//    let text: String
//    let onImage: String
//    let offImage: String
//    @Binding var isOn: Bool
//    let activeColor: Color
////    @EnvironmentObject var soundManager: SoundManager
//    
//    var body: some View {
//        HStack {
//            Image(isOn ? onImage : offImage)
//                .resizable()
//                .frame(width: 60, height: 60)
//            
//            Text(text)
//                .font(.custom("MedievalSharp", size: 24))
//                .bold()
//                .foregroundColor(.white)
//                .padding()
//            
//            Spacer()
//            
//            Toggle("", isOn: $isOn)
//                .labelsHidden()
//                .toggleStyle(CustomToggleStyle())
//                .onChange(of: isOn) { _ in
////                    soundManager.playSound(type: .toggle) // Play toggle sound
//                }
//        }
//        .frame(width: 250)
//    }
//}
struct SettingToggle: View {
    var text: String
    var onImage: String
    var offImage: String
    @Binding var isOn: Bool
    var activeColor: Color

    var body: some View {
        Toggle(isOn: $isOn) {
            Label(text, systemImage: isOn ? onImage : offImage)
        }
        .toggleStyle(SwitchToggleStyle(tint: activeColor))
    }
}


// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SoundManager.shared)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}


// Custom Toggle Style
struct CustomToggleStyle: ToggleStyle {
    var onColor: Color = Color(.green1) // Green when on
    var offColor: Color = Color(.white) // Gray when off
    var thumbColorOn: Color = Color(.white) // Gray circle when on
    var thumbColorOff: Color = Color(.blue3) // Brown circle when off
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? onColor : offColor)
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(configuration.isOn ? thumbColorOn : thumbColorOff)
                        .frame(width: 26, height: 26)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}


