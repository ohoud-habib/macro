
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

// MARK: - Settings View

// MARK: - Settings View

struct SettingsView: View {
    @Query private var users: [UserModel]
    @Environment(\.modelContext) private var modelContext
    @State private var selectedLanguage: AppLanguage = getLanguagePreference()
    @AppStorage("isSoundOn") private var isSoundOn = true

    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("SettingBG").resizable().scaledToFill().ignoresSafeArea()

            sideButtons
                .padding(.top, 20)
                .padding(.leading, 20)
                .environment(\.layoutDirection, .leftToRight)

            content
                .padding(.top, 70)
                .padding(.leading, 200)
        }
    }

    private var sideButtons: some View {
        VStack(spacing: 20) {
            navButton("profileIcon", destination: ProfileView())
            navButton("homeIcon", destination: StartView())
            Spacer()
        }
    }

    private func navButton(_ image: String, destination: some View) -> some View {
        NavigationLink(destination: destination.navigationBarBackButtonHidden(true)) {
            Image(image).resizable().frame(width: 60, height: 60)
        }
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
                isOn: .init(
                    get: { BackgroundMusicManager.shared.isMusicOn },
                    set: { BackgroundMusicManager.shared.isMusicOn = $0 }
                ),
                activeColor: .black, language: selectedLanguage
            )

            SettingResetButton(
                text: "Reset Progress", image: "Reset", language: selectedLanguage
            ) {
                users.first?.resetProgress(context: modelContext)
            }

            Spacer()
        }
    }

    private var languagePicker: some View {
        HStack {
            if selectedLanguage == .arabic {
                languageMenu
                Spacer()
                Text("LANGUAGE".localized(for: selectedLanguage)).font(.headline).bold().padding(.trailing, 10)
                Image("languageIcon").resizable().frame(width: 50, height: 50)
            } else {
                Image("languageIcon").resizable().frame(width: 50, height: 50)
                Text("LANGUAGE".localized(for: selectedLanguage)).font(.headline).bold().padding(.leading, 10)
                Spacer()
                languageMenu
            }
        }
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
                Image(systemName: "chevron.down").font(.system(size: 12, weight: .medium))
            }
            .frame(width: 112, height: 38.3)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5))
        }
    }

    private func languageButton(_ language: AppLanguage) -> some View {
        Button {
            selectedLanguage = language
            saveLanguagePreference(language)

            // Update language in BackgroundMusicManager and play intro clip
            BackgroundMusicManager.shared.appLanguage = language
            BackgroundMusicManager.shared.playRandomIntroClipOnce() // Play intro clip for the new language
        } label: {
            Label(
                (language == .english ? "English" : "Arabic").localized(for: selectedLanguage),
                systemImage: selectedLanguage == language ? "checkmark" : ""
            )
        }
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
                Toggle("", isOn: $isOn).labelsHidden().toggleStyle(SwitchToggleStyle(tint: isOn ? .black : .black))
                Spacer()
                Text(text.localized(for: language).uppercased()).font(.headline).bold().padding(.trailing, 10)
                Image(isOn ? onImage : offImage).resizable().frame(width: 50, height: 50)
            } else {
                Image(isOn ? onImage : offImage).resizable().frame(width: 50, height: 50)
                Text(text.localized(for: language).uppercased()).font(.headline).bold().padding(.leading, 10)
                Spacer()
                Toggle("", isOn: $isOn).labelsHidden().toggleStyle(SwitchToggleStyle(tint: isOn ? .black : .gray))
            }
        }
        .frame(width: 330)
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
                    Text(text.localized(for: language).uppercased()).font(.headline).bold().foregroundColor(.primary).padding(.trailing, 10)
                    Image(image).resizable().frame(width: 50, height: 50)
                } else {
                    Image(image).resizable().frame(width: 50, height: 50)
                    Text(text.localized(for: language).uppercased()).font(.headline).bold().foregroundColor(.primary).padding(.leading, 10)
                    Spacer()
                }
            }
            .frame(width: 330)
        }
    }
}

#Preview {
    SettingsView()
}
