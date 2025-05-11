//
//  ConsequencesView.swift
//  macro
//
//  Created by Maryam Bahwal on 11/11/1446 AH.
//
import SwiftUI
import AVFoundation

// MARK: - Mode Enum
enum Mode: String, CaseIterable {
    case Horror = "Horror"
    case Comics = "Comics"
    case UtopianDystopian = "Utopian/Dystopian"
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
    

    // Keep a strong reference to delegate to prevent deallocation
    @State private var audioDelegate: AVDelegate?

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
            _backgroundImages = State(initialValue: ["utopia_bg1", "utopia_bg2", "utopia_bg3"])
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Image(backgroundImages[currentIndex])
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
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
                            Button(action: {
                                nextAction()
                            }) {
                                Image("nextIcon")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding()
                            }
                        }
                    }
                }
            }
            .onAppear {
                playAudioAndShowContent()
            }
            .onDisappear {
                audioPlayer?.stop()
            }
            .navigationBarBackButtonHidden(true)
        }
        NavigationLink(destination: ProfileView(), isActive: $navigateToProfile) {
                    EmptyView()
                }
    }
    private var yearDisplayView: some View {
        ZStack {
            Color.blue3.opacity(0.8).edgesIgnoringSafeArea(.all)
            Text(years[currentIndex])
                .font(.system(size: 72, weight: .bold))
                .foregroundColor(.white)
        }
    }
    
    private var scenarioView: some View {
        VStack {
            Spacer()
            
            Text(TextContent[currentIndex])
                .multilineTextAlignment(.center)
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.6))
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 250)
            
            Spacer()
        }
    }
    
    private var closeButton: some View {
        VStack {
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                }
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
    
    private func playAudioAndShowContent() {
        guard currentIndex < soundFiles.count else { return }
        let soundFile = soundFiles[currentIndex]
        
        if let url = Bundle.main.url(forResource: soundFile, withExtension: nil) {
            do {
                let delegate = AVDelegate {
                    showNextButton = true
                }
                audioDelegate = delegate
                
                let player = try AVAudioPlayer(contentsOf: url)
                player.delegate = delegate
                audioPlayer = player
                player.play()
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        } else {
            print("Audio file not found: \(soundFile)")
        }

        showYearScreen = true
        showNextButton = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showYearScreen = false
        }
    }

//    private func nextAction() {
//        audioPlayer?.stop()
//        currentIndex += 1
//        
//        if currentIndex < soundFiles.count {
//            showYearScreen = true
//            showNextButton = false
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                playAudioAndShowContent()
//            }
//        } else {
//            presentationMode.wrappedValue.dismiss()
//        }
//    }
    private func nextAction() {
        audioPlayer?.stop()
        
        if currentIndex < soundFiles.count - 1 {
            currentIndex += 1
            playAudioAndShowContent()
        } else {
            // Final item reached, navigate to ProfileView
            navigateToProfile = true
        }
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
