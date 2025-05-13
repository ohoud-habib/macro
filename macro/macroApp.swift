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
import SwiftData

@main
struct macroApp: App {
    @StateObject private var soundManager = SoundManager.shared
    @State private var showLanguageSelection = !isLanguageSet()

    var body: some Scene {
        WindowGroup {
            AppInitializerView(showLanguageSelection: $showLanguageSelection)
                .environmentObject(soundManager)
                .onAppear {
                    // Ensure app language is set before playing any sounds
                    let currentLanguage = getLanguagePreference()
                    BackgroundMusicManager.shared.appLanguage = currentLanguage
                    BackgroundMusicManager.shared.playRandomIntroClipOnce() // Play intro clip in the correct language
                }
        }
        .modelContainer(for: UserModel.self)
    }
}




struct AppInitializerView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [UserModel]
    @Binding var showLanguageSelection: Bool

    var body: some View {
        Group {
            if showLanguageSelection {
                LanguageSelectionView {
                    showLanguageSelection = false
                }
            } else {
//                StartView()
                IntroView()
            }
        }
        .onAppear {
            if users.isEmpty {
                let user = UserModel()
                modelContext.insert(user)
                try? modelContext.save()
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
