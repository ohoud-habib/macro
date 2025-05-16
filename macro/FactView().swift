import SwiftUI
import SwiftData

struct FactView: View {
    
    @State private var navigateToConsequences = false
    @State private var navigateToProfile = false
    
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [UserModel]
    
    var currentUser: UserModel? {
        users.first
    }
    
    @State private var goToProfile = false
    
    @State private var selectedOptionIndex: Int? = nil
    @State private var navigate = false
    @State private var currentImageIndex = 0
    @Binding var mode: Mode
    var factData: FactData
    let slideshowImages = ["metro_exit_1", "metro_exit_2", "metro_exit_3", "FactBG"]
    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    
    var showContent: Bool {
        currentImageIndex == slideshowImages.count - 1
    }
    
    var navigationDestination: some View {
        let selected = factData.options[selectedOptionIndex!]
        return ConsequencesView(
            mode: mode,
            soundFiles: selected.parts.map { $0.sound },
            years: selected.parts.map { $0.year },
            TextContent: selected.parts.map { $0.text }
        )
    }
    
    
    
    var body: some View {
        
        ZStack {
            // Slideshow background
            Image(slideshowImages[currentImageIndex])
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.1), value: currentImageIndex)
                .onReceive(timer) { _ in
                    if currentImageIndex < slideshowImages.count - 1 {
                        currentImageIndex += 1
                    }
                }
            VStack {
                HStack {
                    NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)) {
                        Image("profileIcon")
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)) {
                        Image("settingIcon")
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                }
                .padding(.top, 40) // Adjust top padding if needed
                
                Spacer() // Pushes everything to the top
            }
            
            if showContent {
                ZStack {
                    // Fact on the left
                    VStack {
                        Text(factData.fact)
                            .lineSpacing(8)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 450, height: 205)
                            .background(.blue3)
                            .border(.black, width:10)
                            .padding(.trailing, 270)
                            .padding(.top, 50)
                        
                    }
                    
                    // Options on the right
                    GeometryReader { geometry in
                        VStack(spacing: 7) {
                            ForEach(factData.options.indices, id: \.self) { i in
                                Button(action: {
                                    selectedOptionIndex = i
                                }) {
                                    Text(factData.options[i].title)
                                        .multilineTextAlignment(.center)
                                        .lineSpacing(7)
                                        .font(.system(size: 10))
                                        .foregroundColor(.white)
                                        .frame(width: 280, height: 57)
                                        .padding(.horizontal, 2)
                                        .background(
                                            selectedOptionIndex == i ? Color.green1.opacity(0.9) : Color.black
                                        )
                                        .cornerRadius(1)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        // Responsive position: adjust these percentages as needed
                        .position(
                            x: geometry.size.width * 0.80,  // 636 / 768 ≈ 0.83
                            y: geometry.size.height * 0.49  // 172 / 712 ≈ 0.24
                        )
                    }

                }
                // NEXT Button
                if selectedOptionIndex != nil {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            NavigationLink(destination: navigationDestination, isActive: $navigate) {
                                Button(action: {
                                    if let user = currentUser,
                                       let selectedIndex = selectedOptionIndex {
                                        let selectedOption = factData.options[selectedIndex]
                                        user.karma += selectedOption.karma
                                        try? modelContext.save()
                                        navigate = true
                                    }
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
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Preview
#Preview {
    FactView(
        mode: .constant(.Horror),
        factData: FactDatabase.getFact(for: "Art_in_History", mode: "Horror", language: "english")
    )
}
