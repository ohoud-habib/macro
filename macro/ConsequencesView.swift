//
//  ConsequencesView.swift
//  macro
//
//  Created by Maryam Bahwal on 11/11/1446 AH.
//
//import SwiftUI
//import AVFoundation
//
//// MARK: - Mode Enum
//enum Mode: String, CaseIterable {
//    case Horror = "Horror"
//    case Comics = "Comics"
//    case UtopianDystopian = "UtopianDystopian"
//    case main = "Main"
//}
//
//// MARK: - Main View
//struct ConsequencesView: View {
//    
//    let mode: Mode
//    let soundFiles: [String]
//    let years: [String]
//    let TextContent: [String]
//
//    @State private var navigateToProfile = false
//    @State private var backgroundImages: [String] = []
//    @State private var currentIndex = 0
//    @State private var showYearScreen = true
//    @State private var showNextButton = false
//    @Environment(\.presentationMode) var presentationMode
//    @State private var audioPlayer: AVAudioPlayer?
//    @State private var audioDelegate: AVDelegate?
//
//    init(mode: Mode, soundFiles: [String], years: [String], TextContent: [String]) {
//        self.mode = mode
//        self.soundFiles = soundFiles
//        self.years = years
//        self.TextContent = TextContent
//
//        switch mode {
//        case .Horror:
//            _backgroundImages = State(initialValue: ["horror_bg_1", "horror_bg_2", "horror_bg_3"])
//        case .Comics:
//            _backgroundImages = State(initialValue: ["comic_bg_1", "comic_bg_2", "comic_bg_3"])
//        case .UtopianDystopian:
//            _backgroundImages = State(initialValue: ["UtopianDystopian_bg_1", "UtopianDystopian_bg_2", "UtopianDystopian_bg_3"])
//        case .main:
//            _backgroundImages = State(initialValue: ["", "", ""])
//        }
//    }
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Image(backgroundImages[currentIndex])
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//                
//                if showYearScreen {
//                    yearDisplayView
//                } else {
//                    scenarioView
//                }
//                
//                closeButton
//                
//                if showNextButton {
//                    VStack {
//                        Spacer()
//                        HStack {
//                            Spacer()
//                            Button(action: {
//                                nextAction()
//                            }) {
//                                Image("nextIcon")
//                                    .resizable()
//                                    .frame(width: 50, height: 50)
//                                    .padding()
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationBarBackButtonHidden(true)
//            .onAppear {
//          //      BackgroundMusicManager.shared.playModeTrack(for: mode)
//                playAudioAndShowContent()
//            }
//            .onDisappear {
//                audioPlayer?.stop()
//            }
//            .navigationBarBackButtonHidden(true)
//        }
//        .navigationBarBackButtonHidden(true)
//        NavigationLink(destination: ProfileView(), isActive: $navigateToProfile) {
//            EmptyView()
//        }
//    }
//        
//    private var yearDisplayView: some View {
//            ZStack {
//                Color.blue3.opacity(0.8).edgesIgnoringSafeArea(.all)
//                Text(years[currentIndex])
//                    .font(.system(size: 72, weight: .bold))
//                    .foregroundColor(.white)
//            }
//        }
//        
//        private var scenarioView: some View {
//            VStack {
//                Spacer()
//                Text(TextContent[currentIndex])
//                    .multilineTextAlignment(.center)
//                    .font(.system(size: 18, weight: .medium))
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.black.opacity(0.6))
//                    .cornerRadius(12)
//                    .padding(.horizontal)
//                    .padding(.top, 220)
//            }
//        }
//        
//        private var closeButton: some View {
//            VStack {
//                HStack {
//                    Button(action: { presentationMode.wrappedValue.dismiss()
//        //                BackgroundMusicManager.shared.playModeTrack(for: .main)
//                    }) {
//                        Image(systemName: "xmark.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.black.opacity(0.7))
//                            .clipShape(Circle())
//                    }
//                    Spacer()
//                }
//                Spacer()
//            }
//            .padding()
//        }
//        
//        private func playAudioAndShowContent() {
//            guard currentIndex < soundFiles.count else { return }
//            let soundFile = soundFiles[currentIndex]
//            
//            if let url = Bundle.main.url(forResource: soundFile, withExtension: nil) {
//                do {
//                    let delegate = AVDelegate {
//                        showNextButton = true
//                    }
//                    audioDelegate = delegate
//                    
//                    let player = try AVAudioPlayer(contentsOf: url)
//                    player.delegate = delegate
//                    audioPlayer = player
//                    player.play()
//                } catch {
//                    print("Error playing audio: \(error.localizedDescription)")
//                }
//            } else {
//                print("Audio file not found: \(soundFile)")
//            }
//
//            showYearScreen = true
//            showNextButton = false
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
//                showYearScreen = false
//            }
//        }
//
//        private func nextAction() {
//            audioPlayer?.stop()
//            
//            if currentIndex < soundFiles.count - 1 {
//                currentIndex += 1
//                playAudioAndShowContent()
//            } else {
//                navigateToProfile = true
//            }
//        }
//    }
//
//    // MARK: - AVAudioPlayerDelegate Wrapper
//    class AVDelegate: NSObject, AVAudioPlayerDelegate {
//        var completion: () -> Void
//
//        init(completion: @escaping () -> Void) {
//            self.completion = completion
//        }
//
//        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//            completion()
//        }
//    }
//
//    // MARK: - Preview
//    struct ConsequencesView_Previews: PreviewProvider {
//        static var previews: some View {
//            ConsequencesView(
//                mode: .Comics,
//                soundFiles: [
//                    "ART IN HISTORY_Comics Mode_OP1 Q1 ENGLISH.MP3",
//                    "ART IN HISTORY_Comics Mode_OP1 Q2 ENGLISH.MP3",
//                    "ART IN HISTORY_Comics Mode_OP1 Q3 ENGLISH.MP3"
//                ],
//                years: ["1984", "1999", "2023"],
//                TextContent: [
//                    "In 1984, the world had turned...",
//                    "By 1999, a new era emerged...",
//                    "2023 brought unexpected consequences..."
//                ]
//            )
//            .previewInterfaceOrientation(.landscapeLeft)
//        }
//    }
import SwiftUI
import AVFoundation

// MARK: - Mode Enum
enum Mode: String, CaseIterable {
    case Horror = "Horror"
    case Comics = "Comics"
    case UtopianDystopian = "UtopianDystopian"
    case main = "Main"
    
    var accessibilityLabel: String {
        switch self {
        case .Horror: return "Horror Mode"
        case .Comics: return "Comics Mode"
        case .UtopianDystopian: return "Utopian Dystopian Mode"
        case .main: return "Main Mode"
        }
    }
}

// MARK: - Main View
struct ConsequencesView: View {
    
    let mode: Mode
    let soundFiles: [String]
    let years: [String]
    let TextContent: [String]

    @State private var navigateToProfile = false
    @State private var backgroundImages: [String] = []
    @State private var currentIndex = 0
    @State private var showYearScreen = true
    @State private var showNextButton = false
    @Environment(\.presentationMode) var presentationMode
    @State private var audioPlayer: AVAudioPlayer?
    @State private var audioDelegate: AVDelegate?
    
    // Accessibility state
    @State private var accessibilityAnnouncement = ""

    init(mode: Mode, soundFiles: [String], years: [String], TextContent: [String]) {
        self.mode = mode
        self.soundFiles = soundFiles
        self.years = years
        self.TextContent = TextContent

        switch mode {
        case .Horror:
            _backgroundImages = State(initialValue: ["horror_bg_1", "horror_bg_2", "horror_bg_3"])
        case .Comics:
            _backgroundImages = State(initialValue: ["comic_bg_1", "comic_bg_2", "comic_bg_3"])
        case .UtopianDystopian:
            _backgroundImages = State(initialValue: ["UtopianDystopian_bg_1", "UtopianDystopian_bg_2", "UtopianDystopian_bg_3"])
        case .main:
            _backgroundImages = State(initialValue: ["", "", ""])
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Background image (hidden from VoiceOver)
                Image(backgroundImages[currentIndex])
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .accessibilityHidden(true)
                
                if showYearScreen {
                    yearDisplayView
                } else {
                    scenarioView
                }
                
                closeButton
                
                if showNextButton {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            nextButton
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                playAudioAndShowContent()
            }
            .onDisappear {
                audioPlayer?.stop()
            }
            .onChange(of: currentIndex) { _ in
                announceCurrentContent()
            }
            .accessibilityElement(children: .contain)
            .accessibilityLabel("Consequences View, \(mode.accessibilityLabel)")
        }
        .navigationBarBackButtonHidden(true)
        NavigationLink(destination: ProfileView(), isActive: $navigateToProfile) {
            EmptyView()
        }
        .accessibilityHidden(true)
    }
    
    // MARK: - Subviews with Accessibility
    
    private var yearDisplayView: some View {
        ZStack {
            Color.blue3.opacity(0.8)
                .edgesIgnoringSafeArea(.all)
                .accessibilityHidden(true)
            
            Text(years[currentIndex])
                .font(.system(size: 72, weight: .bold))
                .foregroundColor(.white)
                .accessibilityLabel("Year: \(years[currentIndex])")
                .accessibilityAddTraits(.isHeader)
        }
        .accessibilityElement(children: .combine)
    }
    
    private var scenarioView: some View {
        VStack {
            Spacer()
            Text(TextContent[currentIndex])
                .multilineTextAlignment(.center)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.6))
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 220)
                .accessibilityHidden(true)
//                .accessibilityLabel("Scenario: \(TextContent[currentIndex])")
        }
        .accessibilityHidden(true)
//        .accessibilityElement(children: .combine)
    }
    
    private var closeButton: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                }
                .accessibilityLabel("Close")
                .accessibilityHint("Double tap to exit consequences view")
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
    
    private var nextButton: some View {
        Button(action: {
            nextAction()
        }) {
            Image("nextIcon")
                .resizable()
                .frame(width: 50, height: 50)
                .padding()
        }
        .accessibilityLabel("Next")
        .accessibilityHint("Double tap to proceed to the next scenario")
    }
    
    // MARK: - Audio and Content Management
    
    private func playAudioAndShowContent() {
        guard currentIndex < soundFiles.count else { return }
        let soundFile = soundFiles[currentIndex]
        
        if let url = Bundle.main.url(forResource: soundFile, withExtension: nil) {
            do {
                let delegate = AVDelegate {
                    showNextButton = true
                    announceAudioCompletion()
                }
                audioDelegate = delegate
                
                let player = try AVAudioPlayer(contentsOf: url)
                player.delegate = delegate
                audioPlayer = player
                player.play()
                
                // Announce audio start for VoiceOver
                let audioName = soundFile.replacingOccurrences(of: ".MP3", with: "")
                UIAccessibility.post(notification: .announcement,
                                     argument: "Playing audio: \(audioName)")
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        } else {
            print("Audio file not found: \(soundFile)")
        }

        showYearScreen = true
        showNextButton = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            showYearScreen = false
            announceCurrentContent()
        }
    }
    
    private func nextAction() {
        audioPlayer?.stop()
        
        if currentIndex < soundFiles.count - 1 {
            currentIndex += 1
            playAudioAndShowContent()
        } else {
            navigateToProfile = true
            UIAccessibility.post(notification: .announcement,
                               argument: "All scenarios completed. Navigating to profile.")
        }
    }
    
    // MARK: - Accessibility Announcements
    
    private func announceCurrentContent() {
        let announcement = """
        Year \(years[currentIndex]). 
        Scenario: \(TextContent[currentIndex])
        """
        accessibilityAnnouncement = announcement
        UIAccessibility.post(notification: .screenChanged, argument: announcement)
    }
    
    private func announceAudioCompletion() {
        let announcement = "Audio finished playing. Ready for next scenario."
        UIAccessibility.post(notification: .announcement, argument: announcement)
    }
}

// MARK: - AVAudioPlayerDelegate Wrapper
class AVDelegate: NSObject, AVAudioPlayerDelegate {
    var completion: () -> Void

    init(completion: @escaping () -> Void) {
        self.completion = completion
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        completion()
    }
}

// MARK: - Preview
struct ConsequencesView_Previews: PreviewProvider {
    static var previews: some View {
        ConsequencesView(
            mode: .Comics,
            soundFiles: [
                "ART IN HISTORY_Comics Mode_OP1 Q1 ENGLISH.MP3",
                "ART IN HISTORY_Comics Mode_OP1 Q2 ENGLISH.MP3",
                "ART IN HISTORY_Comics Mode_OP1 Q3 ENGLISH.MP3"
            ],
            years: ["1984", "1999", "2023"],
            TextContent: [
                "In 1984, the world had turned...",
                "By 1999, a new era emerged...",
                "2023 brought unexpected consequences..."
            ]
        )
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
