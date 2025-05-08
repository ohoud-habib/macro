//import SwiftUI
//import AVFoundation
//
//class SoundManager: ObservableObject {
//    static let shared = SoundManager()
//    private var player: AVAudioPlayer?
//
//    func playIntroSound() {
//        guard let url = Bundle.main.url(forResource: "INTRO ARABIC", withExtension: "MP3") else {
//            print("❌ Sound file 'INTRO ARABIC.mp3' not found.")
//            return
//        }
//
//        do {
//            player = try AVAudioPlayer(contentsOf: url)
//            player?.prepareToPlay()
//            player?.play()
//        } catch {
//            print("❌ Could not play sound: \(error.localizedDescription)")
//        }
//    }
//}
//
//struct ContentView: View {
//    let images = ["metroIntrance","trainStation", "man@tran", "senasmile", "senasmile2", "sena", "sena2", "clock","clock2"]
//    
//    // 👇 Add a matching array of durations (in seconds)
//    let durations: [Double] = [5.0,5.0, 9.0, 9.0, 5.0, 6.5, 6.5, 5.0,5.0]
//
//    @State private var currentIndex = 0
//    @State private var slideshowStarted = false
//    @State private var showBlackTransition = false
//
//    var body: some View {
//        ZStack {
//            Image(images[currentIndex])
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//
//            if showBlackTransition {
//                Color.black
//                    .ignoresSafeArea()
//                    .transition(.opacity)
//            }
//
//            Color.clear
//                .contentShape(Rectangle())
//                .onTapGesture {
//                    if !slideshowStarted {
//                        slideshowStarted = true
//                        SoundManager.shared.playIntroSound()
//                        startSlideshow()
//                    }
//                }
//        }
//    }
//
//    func startSlideshow() {
//        var accumulatedDelay: Double = 0.0
//
//        for i in 1..<images.count {
//            accumulatedDelay += durations[i - 1]
//
//            if i == 3 || i == 5 {
//                DispatchQueue.main.asyncAfter(deadline: .now() + accumulatedDelay - 0.5) {
//                    withAnimation(.easeInOut(duration: 0.5)) {
//                        showBlackTransition = true
//                    }
//                }
//            }
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + accumulatedDelay) {
//                currentIndex = i
//
//                if i == 3 || i == 5 {
//                    withAnimation(.easeInOut(duration: 0.5)) {
//                        showBlackTransition = false
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
