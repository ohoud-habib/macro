import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query private var users: [UserModel]
    let preferredLanguage = UserDefaults.standard.string(forKey: "preferredLanguage") ?? "en"

    var body: some View {
        NavigationStack {
            ZStack {
                Image("ProfileBG")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)) {
                                Image("settingIcon")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                // Play sound when Settings button is tapped
                                SystemSoundManager.shared.play(.button)
                            })

                            NavigationLink(destination: StartView().navigationBarBackButtonHidden(true)) {
                                Image("homeIcon")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                // Play sound when Home button is tapped
                                SystemSoundManager.shared.play(.button)
                            })

                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.top, 40)

                        Spacer()
                    }
                    
                    Spacer() // Push content to the top
                }
                
                HStack {
                    // Left: Angel or Devil
                    Image(currentKarma >= 0 ? "angel" : "devil")
                        .resizable()
                        .frame(width: 194.4, height: 278.8)
                        .padding(.leading, 150)
                        .padding(.top, 30)
                    
                    Spacer()
                    
                    // Right: Score Display
                    Text(getLanguagePreference() == .arabic ? "نقاطك:\n\(currentKarma)" : "SCORE:\n\(currentKarma)")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.trailing, 200)
                        .padding(.bottom, 100)
                        .lineSpacing(8)
                }
                .navigationBarBackButtonHidden(true)
                .padding()
            }
            .navigationBarBackButtonHidden(true)
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
