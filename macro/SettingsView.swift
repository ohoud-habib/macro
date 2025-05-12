import SwiftUI
import AVFoundation
import SwiftData

struct SettingsView: View {
    @Query private var users: [UserModel]
    @Environment(\.modelContext) private var modelContext

    @AppStorage("isSoundOn") private var isSoundOn = true

    var body: some View {
        ZStack {
            Image("SettingBG")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            HStack {
                VStack(spacing: 20) {
                    NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)) {
                        Image("profileIcon")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }

                    NavigationLink(destination: StartView().navigationBarBackButtonHidden(true)) {
                        Image("homeIcon")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }

                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 40)

                Spacer()
            }

            VStack(spacing: 32) {
                SettingToggle(
                    text: "Sound",
                    onImage: "Sound",
                    offImage: "Mute",
                    isOn: $isSoundOn,
                    activeColor: .black
                )

                SettingToggle(
                    text: "Music",
                    onImage: "Music",
                    offImage: "MusicOff",
                    isOn: .init(get: {
                        BackgroundMusicManager.shared.isMusicOn
                    }, set: { newValue in
                        BackgroundMusicManager.shared.isMusicOn = newValue
                    }), // Directly bind the toggle to the shared manager's isMusicOn
                    activeColor: .black
                )

                SettingResetButton(
                    text: "Reset Progress",
                    image: "Reset"
                ) {
                    if let user = users.first {
                        user.resetProgress(context: modelContext)
                    }
                }

                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .environmentObject(BackgroundMusicManager.shared) // Pass the shared instance to the environment
    }
}

struct SettingToggle: View {
    let text: String
    let onImage: String
    let offImage: String
    @Binding var isOn: Bool
    let activeColor: Color

    var body: some View {
        HStack {
            Image(isOn ? onImage : offImage)
                .resizable()
                .frame(width: 50, height: 50)

            Text(text.uppercased())
                .font(.headline)
                .bold()
                .padding(.leading, 10)

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: isOn ? .black : .gray))
        }
        .frame(width: 300)
    }
}

struct SettingResetButton: View {
    var text: String
    var image: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(text.uppercased())
                    .font(.headline)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                Spacer()
            }
            .frame(width: 300)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(BackgroundMusicManager.shared)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
