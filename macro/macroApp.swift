//
//  macroApp.swift
//  macro
//
//  Created by ohoud on 07/11/1446 AH.
//

//import SwiftUI
//
//@main
//struct macroApp: App {
//    @StateObject private var soundManager = SoundManager.shared
//    var body: some Scene {
//        WindowGroup {
//            LanguageSelectionView(onLanguageSelected: <#() -> Void#>)
////            StartView()
////            IntroView()
//                .environmentObject(soundManager)
//        }
//    }
//}
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


struct LanguageSelectionView: View {
    

    var onLanguageSelected: () -> Void

    var body: some View {
        ZStack{
//            Image("backgroundImageName")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
            Color(.blue3)
                    .ignoresSafeArea()
            VStack(spacing: 30) {
                Text("Choose Your Language")
                    .font(.title)
                    .foregroundColor(.white)
                
                HStack(spacing: 20) {
                    Button("English") {
                        saveLanguagePreference(.english)
                        onLanguageSelected()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue1)
                    .shadow(color: .blue1, radius: 5)
                    
                    
                    Button("العربية") {
                        saveLanguagePreference(.arabic)
                        onLanguageSelected()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue1)
                    .shadow(color: .blue1, radius: 5)

                }
            }
        }
    }
}
struct LanguageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSelectionView {}
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
