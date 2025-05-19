////import SwiftUI
////import AVFoundation
////import SwiftData
////
////// MARK: - App Language Enum & Helpers
////
////extension String {
////    func localized(for language: AppLanguage) -> String {
////        switch language {
////        case .english: return self
////        case .arabic: return Self.arabicTranslation[self] ?? self
////        }
////    }
////
////    static let arabicTranslation: [String: String] = [
////        "LANGUAGE": "اللغة",
////        "English": "الإنجليزية",
////        "Arabic": "العربية",
////        "Sound": "الصوت",
////        "Music": "الموسيقى",
////        "Reset Progress": "إعادة تعيين التقدم",
////        "Reset": "إعادة تعيين",
////        "KARMA SCORE": "نقاط الكارما"
////    ]
////}
////
////// MARK: - System Sound Manager
////
////enum SystemSoundType {
////    case toggle
////    case button
////
////    var soundID: SystemSoundID {
////        switch self {
////        case .toggle: return 1100 // Toggle sound
////        case .button: return 1567 // Button click
////        }
////    }
////}
////
////class BackgroundMusicManager: ObservableObject {
////    static let shared = BackgroundMusicManager()
////    private var player: AVAudioPlayer?
////    
////    // Play background music
////    func play() {
////        guard let url = Bundle.main.url(forResource: "GAME MAIN THEME", withExtension: "MP3") else {
////            print("❌ Background music file not found.")
////            return
////        }
////
////        do {
////            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
////            try AVAudioSession.sharedInstance().setActive(true)
////            player = try AVAudioPlayer(contentsOf: url)
////            player?.numberOfLoops = -1 // Loop indefinitely
////            player?.prepareToPlay()
////            player?.play()
////        } catch {
////            print("❌ Could not play background music: \(error.localizedDescription)")
////        }
////    }
////
////    // Stop background music
////    func stop() {
////        player?.stop()
////    }
////}
////
////
////class SystemSoundManager {
////    static let shared = SystemSoundManager()
////
////    func play(_ type: SystemSoundType) {
////        let isSoundOn = UserDefaults.standard.bool(forKey: "isSoundOn")
////        guard isSoundOn else { return }
////        AudioServicesPlaySystemSound(type.soundID)
////    }
////}
////
////// MARK: - Settings View
////    struct SettingsView: View {
////        @Query private var users: [UserModel]
////        @Environment(\.modelContext) private var modelContext
////        @AppStorage("isSoundOn") private var isSoundOn = true
////        @AppStorage("isMusicOn") private var isMusicOn = true // Add @AppStorage to control music toggle
////
////        @State private var selectedLanguage: AppLanguage = getLanguagePreference()
////
////        var body: some View {
////            ZStack(alignment: .topLeading) {
////                Image("SettingBG").resizable().scaledToFill().ignoresSafeArea()
////
////                sideButtons
////                    .padding(.top, 20)
////                    .padding(.leading, 20)
////                    .environment(\.layoutDirection, .leftToRight)
////
////                content
////                    .padding(.top, 70)
////                    .padding(.leading, 200)
////            }
////        }
////
////        private var sideButtons: some View {
////            VStack(spacing: 20) {
////                navButton("profileIcon", destination: ProfileView())
////                navButton("homeIcon", destination: StartView())
////                Spacer()
////            }
////            .padding(.top, 25)
////        }
////
////        private func navButton(_ image: String, destination: some View) -> some View {
////            NavigationLink(destination: destination.navigationBarBackButtonHidden(true)) {
////                Image(image).resizable().frame(width: 60, height: 60)
////            }
////            .simultaneousGesture(TapGesture().onEnded {
////                SystemSoundManager.shared.play(.button)
////            })
////        }
////
////        private var content: some View {
////            VStack(spacing: 20) {
////                languagePicker
////
////                SettingToggle(
////                    text: "Sound", onImage: "Sound", offImage: "Mute",
////                    isOn: $isSoundOn, activeColor: .black, language: selectedLanguage
////                )
////
////                // Music toggle added for controlling bg.mp3
////                SettingToggle(
////                    text: "Music", onImage: "Music", offImage: "musicOff",
////                    isOn: $isMusicOn, activeColor: .black, language: selectedLanguage
////                )
////                .onChange(of: isMusicOn) { newValue in
////                    if newValue {
////                        BackgroundMusicManager.shared.play()
////                    } else {
////                        BackgroundMusicManager.shared.stop()
////                    }
////                }
////
////                SettingResetButton(
////                    text: "Reset Progress", image: "Reset", language: selectedLanguage
////                ) {
////                    SystemSoundManager.shared.play(.button)
////                    users.first?.resetProgress(context: modelContext)
////                }
////
////                Spacer()
////            }
////        }
////
////        private var languagePicker: some View {
////            HStack {
////                if selectedLanguage == .arabic {
////                    languageMenu
////                    Spacer()
////                    Text("LANGUAGE".localized(for: selectedLanguage)).font(.headline).bold().padding(.trailing, 10)
////                    Image("languageIcon").resizable().frame(width: 50, height: 50)
////                } else {
////                    Image("languageIcon").resizable().frame(width: 50, height: 50)
////                    Text("LANGUAGE".localized(for: selectedLanguage)).font(.headline).bold().padding(.leading, 10)
////                    Spacer()
////                    languageMenu
////                }
////            }
////            .frame(width: 330)
////        }
////
////        private var languageMenu: some View {
////            Menu {
////                languageButton(.english)
////                languageButton(.arabic)
////            } label: {
////                HStack {
////                    Text(selectedLanguage == .english ? "English" : "العربية")
////                        .font(.system(size: 15, weight: .bold))
////                    Image(systemName: "chevron.down").font(.system(size: 12, weight: .medium))
////                }
////                .frame(width: 112, height: 38.3)
////                .background(Color.black)
////                .foregroundColor(.white)
////                .cornerRadius(10)
////                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5))
////            }
////        }
////
////        private func languageButton(_ language: AppLanguage) -> some View {
////            Button {
////                selectedLanguage = language
////                saveLanguagePreference(language)
////                SystemSoundManager.shared.play(.button)
////            } label: {
////                Label(
////                    (language == .english ? "English" : "Arabic").localized(for: selectedLanguage),
////                    systemImage: selectedLanguage == language ? "checkmark" : ""
////                )
////            }
////        }
////    }
////
////
////// MARK: - SettingToggle View
////
////struct SettingToggle: View {
////    let text: String
////    let onImage: String
////    let offImage: String
////    @Binding var isOn: Bool
////    let activeColor: Color
////    let language: AppLanguage
////
////    var body: some View {
////        HStack {
////            if language == .arabic {
////                Toggle("", isOn: Binding(
////                    get: { isOn },
////                    set: {
////                        isOn = $0
////                        SystemSoundManager.shared.play(.toggle)
////                    })
////                )
////                .labelsHidden()
////                .toggleStyle(SwitchToggleStyle(tint: isOn ? .black : .black))
////
////                Spacer()
////                Text(text.localized(for: language).uppercased())
////                    .font(.headline).bold().padding(.trailing, 10)
////                Image(isOn ? onImage : offImage)
////                    .resizable().frame(width: 50, height: 50)
////            } else {
////                Image(isOn ? onImage : offImage)
////                    .resizable().frame(width: 50, height: 50)
////                Text(text.localized(for: language).uppercased())
////                    .font(.headline).bold().padding(.leading, 10)
////                Spacer()
////                Toggle("", isOn: Binding(
////                    get: { isOn },
////                    set: {
////                        isOn = $0
////                        SystemSoundManager.shared.play(.toggle)
////                    })
////                )
////                .labelsHidden()
////                .toggleStyle(SwitchToggleStyle(tint: isOn ? .black : .gray))
////            }
////        }
////        .frame(width: 330)
////    }
////}
////
////// MARK: - SettingResetButton View
////
////struct SettingResetButton: View {
////    var text: String
////    var image: String
////    var language: AppLanguage
////    var action: () -> Void
////
////    var body: some View {
////        Button(action: action) {
////            HStack {
////                if language == .arabic {
////                    Spacer()
////                    Text(text.localized(for: language).uppercased())
////                        .font(.headline).bold().foregroundColor(.primary)
////                        .padding(.trailing, 10)
////                    Image(image).resizable().frame(width: 50, height: 50)
////                } else {
////                    Image(image).resizable().frame(width: 50, height: 50)
////                    Text(text.localized(for: language).uppercased())
////                        .font(.headline).bold().foregroundColor(.primary)
////                        .padding(.leading, 10)
////                    Spacer()
////                }
////            }
////            .frame(width: 330)
////        }
////    }
////}
////
////#Preview {
////    SettingsView()
////}
////New Code work great
//import SwiftUI
//import AVFoundation
//import SwiftData
//
//// MARK: - App Language Enum & Helpers
//
//extension String {
//    func localized(for language: AppLanguage) -> String {
//        switch language {
//        case .english: return self
//        case .arabic: return Self.arabicTranslation[self] ?? self
//        }
//    }
//
//    static let arabicTranslation: [String: String] = [
//        "LANGUAGE": "اللغة",
//        "English": "الإنجليزية",
//        "Arabic": "العربية",
//        "Sound": "الصوت",
//        "Music": "الموسيقى",
//        "Reset Progress": "إعادة تعيين التقدم",
//        "Reset": "إعادة تعيين",
//        "KARMA SCORE": "نقاط الكارما"
//    ]
//}
//
//// MARK: - System Sound Manager
//
//enum SystemSoundType {
//    case toggle
//    case button
//
//    var soundID: SystemSoundID {
//        switch self {
//        case .toggle: return 1100
//        case .button: return 1567
//        }
//    }
//}
//
//class BackgroundMusicManager: ObservableObject {
//    static let shared = BackgroundMusicManager()
//    private var player: AVAudioPlayer?
//
//    func play() {
//        guard let url = Bundle.main.url(forResource: "GAME MAIN THEME", withExtension: "MP3") else {
//            print("❌ Background music file not found.")
//            return
//        }
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//            player = try AVAudioPlayer(contentsOf: url)
//            player?.numberOfLoops = -1
//            player?.prepareToPlay()
//            player?.play()
//        } catch {
//            print("❌ Could not play background music: \(error.localizedDescription)")
//        }
//    }
//
//    func stop() {
//        player?.stop()
//    }
//}
//
//class SystemSoundManager {
//    static let shared = SystemSoundManager()
//
//    func play(_ type: SystemSoundType) {
//        let isSoundOn = UserDefaults.standard.bool(forKey: "isSoundOn")
//        guard isSoundOn else { return }
//        AudioServicesPlaySystemSound(type.soundID)
//    }
//}
//
//// MARK: - Settings View
//
//struct SettingsView: View {
//    @Query private var users: [UserModel]
//    @Environment(\.modelContext) private var modelContext
//    @AppStorage("isSoundOn") private var isSoundOn = true
//    @AppStorage("isMusicOn") private var isMusicOn = true
//    @State private var selectedLanguage: AppLanguage = getLanguagePreference()
//
//    var body: some View {
//        ZStack(alignment: .topLeading) {
//            Image("SettingBG").resizable().scaledToFill().ignoresSafeArea()
//
//            sideButtons
//                .padding(.top, 20)
//                .padding(.leading, 20)
//                .environment(\.layoutDirection, .leftToRight)
//
//            content
//                .padding(.top, 70)
//                .padding(.leading, 200)
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//
//    private var sideButtons: some View {
//        VStack(spacing: 20) {
//            navButton("profileIcon", destination: ProfileView())
//            navButton("homeIcon", destination: StartView())
//            Spacer()
//        }
//        .navigationBarBackButtonHidden(true)
//        .padding(.top, 25)
//    }
//
//    private func navButton(_ image: String, destination: some View) -> some View {
//        NavigationLink(destination: destination.navigationBarBackButtonHidden(true)) {
//            Image(image).resizable().frame(width: 60, height: 60)
//        }
//        .simultaneousGesture(TapGesture().onEnded {
//            SystemSoundManager.shared.play(.button)
//        })
//    }
//
//    private var content: some View {
//        VStack(spacing: 20) {
//            languagePicker
//
//            SettingToggle(
//                text: "Sound", onImage: "Sound", offImage: "Mute",
//                isOn: $isSoundOn, activeColor: .black, language: selectedLanguage
//            )
//
//            SettingToggle(
//                text: "Music", onImage: "Music", offImage: "musicOff",
//                isOn: $isMusicOn, activeColor: .black, language: selectedLanguage
//            )
//            .onChange(of: isMusicOn) { newValue in
//                if newValue {
//                    BackgroundMusicManager.shared.play()
//                } else {
//                    BackgroundMusicManager.shared.stop()
//                }
//            }
//
//            SettingResetButton(
//                text: "Reset Progress", image: "Reset", language: selectedLanguage
//            ) {
//                SystemSoundManager.shared.play(.button)
//                users.first?.resetProgress(context: modelContext)
//            }
//
//            Spacer()
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//
//    private var languagePicker: some View {
//        HStack {
//            if selectedLanguage == .arabic {
//                languageMenu
//                Spacer()
//                Text("LANGUAGE".localized(for: selectedLanguage))
//                    .font(.headline)
//                    .bold()
//                    .foregroundColor(.white)
//                    .padding(.trailing, 10)
//                Image("languageIcon").resizable().frame(width: 50, height: 50)
//            } else {
//                Image("languageIcon").resizable().frame(width: 50, height: 50)
//                Text("LANGUAGE".localized(for: selectedLanguage))
//                    .font(.headline)
//                    .bold()
//                    .foregroundColor(.white)
//                    .padding(.leading, 10)
//                Spacer()
//                languageMenu
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//        .frame(width: 330)
//    }
//
//    private var languageMenu: some View {
//        Menu {
//            languageButton(.english)
//            languageButton(.arabic)
//        } label: {
//            HStack {
//                Text(selectedLanguage == .english ? "English" : "العربية")
//                    .font(.system(size: 15, weight: .bold))
//                Image(systemName: "chevron.down")
//                    .font(.system(size: 12, weight: .medium))
//            }
//            .frame(width: 112, height: 38.3)
//            .background(Color.black)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5))
//        }
//    }
//
//    private func languageButton(_ language: AppLanguage) -> some View {
//        Button {
//            selectedLanguage = language
//            saveLanguagePreference(language)
//            SystemSoundManager.shared.play(.button)
//        } label: {
//            Label(
//                (language == .english ? "English" : "Arabic").localized(for: selectedLanguage),
//                systemImage: selectedLanguage == language ? "checkmark" : ""
//            )
//        }
//    }
//}
//
//// MARK: - SettingToggle View
//
//struct SettingToggle: View {
//    let text: String
//    let onImage: String
//    let offImage: String
//    @Binding var isOn: Bool
//    let activeColor: Color
//    let language: AppLanguage
//
//    var body: some View {
//        HStack {
//            if language == .arabic {
//                Toggle("", isOn: Binding(
//                    get: { isOn },
//                    set: {
//                        isOn = $0
//                        SystemSoundManager.shared.play(.toggle)
//                    })
//                )
//                .labelsHidden()
//                .toggleStyle(SwitchToggleStyle(tint: isOn ? .black : .black))
//
//                Spacer()
//                Text(text.localized(for: language).uppercased())
//                    .font(.headline).bold()
//                    .foregroundColor(.white)
//                    .padding(.trailing, 10)
//                Image(isOn ? onImage : offImage)
//                    .resizable().frame(width: 50, height: 50)
//            } else {
//                Image(isOn ? onImage : offImage)
//                    .resizable().frame(width: 50, height: 50)
//                Text(text.localized(for: language).uppercased())
//                    .font(.headline).bold()
//                    .foregroundColor(.white)
//                    .padding(.leading, 10)
//                Spacer()
//                Toggle("", isOn: Binding(
//                    get: { isOn },
//                    set: {
//                        isOn = $0
//                        SystemSoundManager.shared.play(.toggle)
//                    })
//                )
//                .labelsHidden()
//                .toggleStyle(SwitchToggleStyle(tint: isOn ? .black : .gray))
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//        .frame(width: 330)
//    }
//}
//
//// MARK: - SettingResetButton View
//
//struct SettingResetButton: View {
//    var text: String
//    var image: String
//    var language: AppLanguage
//    var action: () -> Void
//
//    var body: some View {
//        Button(action: action) {
//            HStack {
//                if language == .arabic {
//                    Spacer()
//                    Text(text.localized(for: language).uppercased())
//                        .font(.headline).bold()
//                        .foregroundColor(.white)
//                        .padding(.trailing, 10)
//                    Image(image).resizable().frame(width: 50, height: 50)
//                } else {
//                    Image(image).resizable().frame(width: 50, height: 50)
//                    Text(text.localized(for: language).uppercased())
//                        .font(.headline).bold()
//                        .foregroundColor(.white)
//                        .padding(.leading, 10)
//                    Spacer()
//                }
//            }
//            .frame(width: 330)
//        }
//    }
//}
//
//#Preview {
//    SettingsView()
//}









import SwiftUI
import AVFoundation
import SwiftData

// MARK: - App Language Enum & Helpers

extension String {
    func localized(for language: AppLanguage) -> String {
        switch language {
        case .english: return self
        case .arabic: return Self.arabicTranslation[self] ?? self
        }
    }

    static let arabicTranslation: [String: String] = [
        "LANGUAGE": "اللغة",
        "English": "الإنجليزية",
        "Arabic": "العربية",
        "Sound": "الصوت",
        "Music": "الموسيقى",
        "Reset Progress": "إعادة تعيين التقدم",
        "Reset": "إعادة تعيين",
        "KARMA SCORE": "نقاط الكارما"
    ]
}

// MARK: - System Sound Manager

enum SystemSoundType {
    case toggle
    case button

    var soundID: SystemSoundID {
        switch self {
        case .toggle: return 1100
        case .button: return 1567
        }
    }
}

class BackgroundMusicManager: ObservableObject {
    static let shared = BackgroundMusicManager()
    private var player: AVAudioPlayer?

    func play() {
        guard let url = Bundle.main.url(forResource: "GAME MAIN THEME", withExtension: "MP3") else {
            print("❌ Background music file not found.")
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("❌ Could not play background music: \(error.localizedDescription)")
        }
    }

    func stop() {
        player?.stop()
    }
}

class SystemSoundManager {
    static let shared = SystemSoundManager()

    func play(_ type: SystemSoundType) {
        let isSoundOn = UserDefaults.standard.bool(forKey: "isSoundOn")
        guard isSoundOn else { return }
        AudioServicesPlaySystemSound(type.soundID)
    }
}

// MARK: - Settings View

struct SettingsView: View {
    @Query private var users: [UserModel]
    @Environment(\.modelContext) private var modelContext
    @AppStorage("isSoundOn") private var isSoundOn = true
    @AppStorage("isMusicOn") private var isMusicOn = true
    @State private var selectedLanguage: AppLanguage = getLanguagePreference()

    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("SettingBG")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .accessibilityHidden(true) // Background image doesn't need VoiceOver
            
            sideButtons
                .padding(.top, 20)
                .padding(.leading, 20)
                .environment(\.layoutDirection, .leftToRight)

            content
                .padding(.top, 70)
                .padding(.leading, 200)
        }
        .navigationBarBackButtonHidden(true)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Settings Screen")
    }

    private var sideButtons: some View {
        VStack(spacing: 20) {
            navButton("profileIcon", destination: ProfileView())
                .accessibilityLabel("Profile")
                .accessibilityHint("Double tap to open your profile")
            
            navButton("homeIcon", destination: StartView())
                .accessibilityLabel("Home")
                .accessibilityHint("Double tap to return to home screen")
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .padding(.top, 25)
    }

    private func navButton(_ image: String, destination: some View) -> some View {
        NavigationLink(destination: destination.navigationBarBackButtonHidden(true)) {
            Image(image)
                .resizable()
                .frame(width: 60, height: 60)
                .accessibilityHidden(true) // The label provides the accessibility info
        }
        .simultaneousGesture(TapGesture().onEnded {
            SystemSoundManager.shared.play(.button)
        })
    }

    private var content: some View {
        VStack(spacing: 20) {
            languagePicker

            SettingToggle(
                text: "Sound", onImage: "Sound", offImage: "Mute",
                isOn: $isSoundOn, activeColor: .black, language: selectedLanguage
            )

            SettingToggle(
                text: "Music", onImage: "Music", offImage: "musicOff",
                isOn: $isMusicOn, activeColor: .black, language: selectedLanguage
            )
            .onChange(of: isMusicOn) { newValue in
                if newValue {
                    BackgroundMusicManager.shared.play()
                } else {
                    BackgroundMusicManager.shared.stop()
                }
            }

            SettingResetButton(
                text: "Reset Progress", image: "Reset", language: selectedLanguage
            ) {
                SystemSoundManager.shared.play(.button)
                users.first?.resetProgress(context: modelContext)
            }

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .accessibilityElement(children: .contain)
    }

    private var languagePicker: some View {
        HStack {
            if selectedLanguage == .arabic {
                languageMenu
                Spacer()
                Text("LANGUAGE".localized(for: selectedLanguage))
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
                    .accessibilityHidden(true) // Included in the menu's accessibility
                Image("languageIcon")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .accessibilityHidden(true)
            } else {
                Image("languageIcon")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .accessibilityHidden(true)
                Text("LANGUAGE".localized(for: selectedLanguage))
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                    .accessibilityHidden(true)
                Spacer()
                languageMenu
            }
        }
        .navigationBarBackButtonHidden(true)
        .frame(width: 330)
    }

    private var languageMenu: some View {
        Menu {
            languageButton(.english)
            languageButton(.arabic)
        } label: {
            HStack {
                Text(selectedLanguage == .english ? "English" : "العربية")
                    .font(.system(size: 15, weight: .bold))
                Image(systemName: "chevron.down")
                    .font(.system(size: 12, weight: .medium))
            }
            .frame(width: 112, height: 38.3)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5))
        }
        .accessibilityLabel("Language selector")
        .accessibilityValue(selectedLanguage == .english ? "English" : "Arabic")
        .accessibilityHint("Double tap to change language")
    }

    private func languageButton(_ language: AppLanguage) -> some View {
        Button {
            selectedLanguage = language
            saveLanguagePreference(language)
            SystemSoundManager.shared.play(.button)
        } label: {
            Label(
                (language == .english ? "English" : "Arabic").localized(for: selectedLanguage),
                systemImage: selectedLanguage == language ? "checkmark" : ""
            )
        }
        .accessibilityLabel(language == .english ? "English" : "Arabic")
        .accessibilityAddTraits(selectedLanguage == language ? [.isSelected] : [])
    }
}

// MARK: - SettingToggle View

struct SettingToggle: View {
    let text: String
    let onImage: String
    let offImage: String
    @Binding var isOn: Bool
    let activeColor: Color
    let language: AppLanguage

    var body: some View {
        HStack {
            if language == .arabic {
                Toggle("", isOn: Binding(
                    get: { isOn },
                    set: {
                        isOn = $0
                        SystemSoundManager.shared.play(.toggle)
                    })
                )
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: isOn ? .black : .black))
                .accessibilityLabel(text.localized(for: language))
                .accessibilityValue(isOn ? "On" : "Off")

                Spacer()
                Text(text.localized(for: language).uppercased())
                    .font(.headline).bold()
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
                    .accessibilityHidden(true)
                Image(isOn ? onImage : offImage)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .accessibilityHidden(true)
            } else {
                Image(isOn ? onImage : offImage)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .accessibilityHidden(true)
                Text(text.localized(for: language).uppercased())
                    .font(.headline).bold()
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                    .accessibilityHidden(true)
                Spacer()
                Toggle("", isOn: Binding(
                    get: { isOn },
                    set: {
                        isOn = $0
                        SystemSoundManager.shared.play(.toggle)
                    })
                )
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: isOn ? .black : .gray))
                .accessibilityLabel(text.localized(for: language))
                .accessibilityValue(isOn ? "On" : "Off")
            }
        }
        .navigationBarBackButtonHidden(true)
        .frame(width: 330)
        .accessibilityElement(children: .combine)
        .accessibilityHint("Double tap to toggle")
    }
}

// MARK: - SettingResetButton View

struct SettingResetButton: View {
    var text: String
    var image: String
    var language: AppLanguage
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                if language == .arabic {
                    Spacer()
                    Text(text.localized(for: language).uppercased())
                        .font(.headline).bold()
                        .foregroundColor(.white)
                        .padding(.trailing, 10)
                        .accessibilityHidden(true)
                    Image(image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .accessibilityHidden(true)
                } else {
                    Image(image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .accessibilityHidden(true)
                    Text(text.localized(for: language).uppercased())
                        .font(.headline).bold()
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                        .accessibilityHidden(true)
                    Spacer()
                }
            }
            .frame(width: 330)
        }
        .accessibilityLabel(text.localized(for: language))
        .accessibilityHint("Double tap to reset all progress")
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    SettingsView()
}
