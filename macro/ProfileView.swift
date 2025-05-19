//import SwiftUI
//import SwiftData
//
//struct ProfileView: View {
//    @Query private var users: [UserModel]
//    let preferredLanguage = UserDefaults.standard.string(forKey: "preferredLanguage") ?? "en"
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Image("ProfileBG")
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//                
//                VStack {
//                    HStack {
//                        VStack(spacing: 20) {
//                            NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)) {
//                                Image("settingIcon")
//                                    .resizable()
//                                    .frame(width: 60, height: 60)
//                            }
//                            .simultaneousGesture(TapGesture().onEnded {
//                                // Play sound when Settings button is tapped
//                                SystemSoundManager.shared.play(.button)
//                            })
//
//                            NavigationLink(destination: StartView().navigationBarBackButtonHidden(true)) {
//                                Image("homeIcon")
//                                    .resizable()
//                                    .frame(width: 60, height: 60)
//                            }
//                            .simultaneousGesture(TapGesture().onEnded {
//                                // Play sound when Home button is tapped
//                                SystemSoundManager.shared.play(.button)
//                            })
//
//                            Spacer()
//                            
//                        }
//                        .padding(.leading)
//                        .padding(.top, 40)
//                        Spacer()
//                                                HStack{ NavigationLink(destination: BackStoryRouterView(karma: currentKarma).navigationBarBackButtonHidden(true)) {
//                                                    Image("storyIcon")
//                                                        .resizable()
//                                                        .frame(width: 60, height: 60)
//                                                }
//                                                .simultaneousGesture(TapGesture().onEnded {
//                                                    // Play sound when Home button is tapped
//                                                    SystemSoundManager.shared.play(.button)
//                                                    
//                                                })
//                                                .padding(.bottom, 230)
//                                                }
////                        Spacer()
//                        
//                    }
//                    
//                    Spacer() // Push content to the top
//                }
//                
//                HStack {
//                    // Left: Angel or Devil
//                    Image(currentKarma >= 0 ? "angel" : "devil")
//                        .resizable()
//                        .frame(width: 194.4, height: 278.8)
//                        .padding(.leading, 150)
//                        .padding(.top, 30)
//                    
//                    Spacer()
//                    
//                    // Right: Score Display
//                    Text(getLanguagePreference() == .arabic ? "نقاطك:\n\(currentKarma)" : "SCORE:\n\(currentKarma)")
//                        .font(.system(size: 40))
//                        .fontWeight(.bold)
//                        .foregroundColor(.black)
//                        .multilineTextAlignment(.center)
//                        .padding(.trailing, 200)
//                        .padding(.bottom, 100)
//                        .lineSpacing(8)
//                }
//                .navigationBarBackButtonHidden(true)
//                .padding()
//            }
//            .navigationBarBackButtonHidden(true)
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//    
//    private var currentKarma: Int {
//        users.first?.karma ?? 0
//    }
//}
//
//// MARK: - Preview
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//            .modelContainer(for: UserModel.self)
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query private var users: [UserModel]
    let preferredLanguage = UserDefaults.standard.string(forKey: "preferredLanguage") ?? "en"
    
    // Accessibility properties
    var isArabic: Bool {
        getLanguagePreference() == .arabic
    }
    var karmaAccessibilityLabel: String {
        isArabic ? "نقاطك: \(currentKarma)" : "Your score: \(currentKarma)"
    }
    var characterAccessibilityLabel: String {
        currentKarma >= 0 ?
            (isArabic ? "ملاك" : "Angel") :
            (isArabic ? "شيطان" : "Devil")
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Background image (hidden from VoiceOver)
                Image("ProfileBG")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .accessibilityHidden(true)
                
                VStack {
                    // Navigation buttons
                    HStack {
                        VStack(spacing: 20) {
                            // Settings button
                            NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)) {
                                Image("settingIcon")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .accessibilityLabel(isArabic ? "الإعدادات" : "Settings")
                                    .accessibilityHint(isArabic ? "اضغط مرتين لفتح الإعدادات" : "Double tap to open settings")
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                SystemSoundManager.shared.play(.button)
                            })

                            // Home button
                            NavigationLink(destination: StartView().navigationBarBackButtonHidden(true)) {
                                Image("homeIcon")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .accessibilityLabel(isArabic ? "الصفحة الرئيسية" : "Home")
                                    .accessibilityHint(isArabic ? "اضغط مرتين للعودة إلى الصفحة الرئيسية" : "Double tap to return home")
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                SystemSoundManager.shared.play(.button)
                            })

                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.top, 40)
                        
                        Spacer()
                        
                        // Story button
                        HStack {
                            NavigationLink(destination: BackStoryRouterView(karma: currentKarma).navigationBarBackButtonHidden(true)) {
                                Image("storyIcon")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .accessibilityLabel(isArabic ? "القصة" : "Story")
                                    .accessibilityHint(isArabic ? "اضغط مرتين لعرض القصة" : "Double tap to view your story")
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                SystemSoundManager.shared.play(.button)
                            })
                            .padding(.bottom, 230)
                        }
                    }
                    
                    Spacer()
                }
                .accessibilityElement(children: .contain)
                .accessibilityLabel(isArabic ? "أزرار التنقل" : "Navigation buttons")
                
                // Profile content
                HStack {
                    // Character image
                    Image(currentKarma >= 0 ? "angel" : "devil")
                        .resizable()
                        .frame(width: 194.4, height: 278.8)
                        .padding(.leading, 150)
                        .padding(.top, 30)
                        .accessibilityLabel(characterAccessibilityLabel)
                        .accessibilityHint(isArabic ?
                                         "يظهر هذا المخلوق بناءً على نقاطك" :
                                         "This creature appears based on your score")
                    
                    Spacer()
                    
                    // Karma score
                    Text(isArabic ? "نقاطك:\n\(currentKarma)" : "SCORE:\n\(currentKarma)")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.trailing, 200)
                        .padding(.bottom, 100)
                        .lineSpacing(8)
                        .accessibilityLabel(karmaAccessibilityLabel)
                        .accessibilityAddTraits(.isStaticText)
                }
                .navigationBarBackButtonHidden(true)
                .padding()
                .accessibilityElement(children: .contain)
                .accessibilityLabel(isArabic ? "معلومات الملف الشخصي" : "Profile information")
            }
            .navigationBarBackButtonHidden(true)
            .accessibilityElement(children: .contain)
            .accessibilityLabel(isArabic ? "صفحة الملف الشخصي" : "Profile page")
            .onAppear {
                // Announce profile screen when it appears
                let announcement = isArabic ?
                "صفحة الملف الشخصي، نقاطك: \(currentKarma)" :
                "Profile page, your score: \(currentKarma)"
                UIAccessibility.post(notification: .screenChanged, argument: announcement)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var currentKarma: Int {
        users.first?.karma ?? 0
    }
}

// MARK: - Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .modelContainer(for: UserModel.self)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
