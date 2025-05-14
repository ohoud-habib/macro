//
//  trainDoorView.swift
//  macro
//
//  Created by ohoud on 10/11/1446 AH.



import SwiftUI

struct StartView: View {
    var startButtonTitle: String {
        getLanguagePreference() == .arabic ? "ابدأ" : "START"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("startScreen")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)) {
                            Image("profileIcon")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            // Play sound when profile icon is tapped
                            SystemSoundManager.shared.play(.button)
                        })
                        
                        Spacer()
                        
                        NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)) {
                            Image("settingIcon")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            // Play sound when settings icon is tapped
                            SystemSoundManager.shared.play(.button)
                        })
                    }
                    .padding(.top, 20) // Adjust top padding if needed
                    
                    Spacer() // Pushes everything to the top
                }
                
                VStack {
                    Spacer()
                    NavigationLink(destination: CategoriesView()) {
                        AppButton(title: getLanguagePreference() == .arabic ? "ابدأ" : "START") {
                            // You can add additional actions here if needed
                        }
                        .disabled(true)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 40)
                    .simultaneousGesture(TapGesture().onEnded {
                        // Play sound when start button is tapped
                        SystemSoundManager.shared.play(.button)
                    })
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
        
            .previewInterfaceOrientation(.landscapeLeft)
    }
}



struct TrainDoorView: View {
    let selectedCategory: String
    @State private var previousMode: Mode = .Horror
    @State private var nextMode: Mode = .Comics
    
    var images: [String] {
        var baseImages = ["trainClosed", "trainHalfOpen", "trainOpen", "trainDoor", "insidemetro1"]
        
        switch selectedCategory {
        case "Art_in_History", "Legends_and_Myths":
            baseImages.append("Horror_and_Comics_Modes_BG")
        case "Medicine_and_Mind":
            baseImages.append("UtopianDystopian_and_Comics_Modes_BG")
        case "Human_Rights":
            baseImages.append("UtopianDystopian_and_Horror_Modes_BG")
        default:
            break
        }
        
        return baseImages
    }
    
    
    
    
    @State private var currentIndex = 0
    @State private var showButtons = false
    @State private var horrorMode: Mode = .Horror
    @State private var comicsMode: Mode = .Comics
    @State private var UtopianDystopianMode: Mode = .UtopianDystopian
    
    // Computed property to get the language dynamically
    var userLanguage: String {
        return getLanguagePreference().rawValue
    }
    
    var body: some View {
        ZStack {
            Image(images[currentIndex])
                .resizable()
                .ignoresSafeArea()
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.7), value: currentIndex)
            
            if showButtons {
                VStack {
                    Spacer()
                    
                    HStack(spacing: 40) {
                        NavigationLink(destination:
                                        FactView(
                                            mode: $previousMode,
                                            factData: FactDatabase.getFact(for: selectedCategory, mode: previousMode.rawValue, language: userLanguage)
                                        )
                        ) {
                            Image("previousIcon")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination:
                                        FactView(
                                            mode: $nextMode,
                                            factData: FactDatabase.getFact(for: selectedCategory, mode: nextMode.rawValue, language: userLanguage)
                                        )
                        ) {
                            Image("nextIcon")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.bottom, 40)
                }
                .onAppear {
                    updateModes()
                }
                
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                if currentIndex < images.count - 1 {
                    currentIndex += 1
                } else {
                    timer.invalidate()
                    showButtons = true
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
    private func updateModes() {
        switch selectedCategory {
        case "Art_in_History", "Legends_and_Myths":
            previousMode = .Horror
            nextMode = .Comics
        case "Medicine_and_Mind":
            previousMode = .UtopianDystopian
            nextMode = .Comics
        case "Human_Rights":
            previousMode = .UtopianDystopian
            nextMode = .Horror
        default:
            previousMode = .Horror
            nextMode = .Comics
        }
    }
}
