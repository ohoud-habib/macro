//import SwiftUI
//import SwiftData
//
//struct FactView: View {
//    
//    @State private var navigateToConsequences = false
//    @State private var navigateToProfile = false
//    
//    @Environment(\.modelContext) private var modelContext
//    @Query private var users: [UserModel]
//    
//    var currentUser: UserModel? {
//        users.first
//    }
//    
//    @State private var goToProfile = false
//    
//    @State private var selectedOptionIndex: Int? = nil
//    @State private var navigate = false
//    @State private var currentImageIndex = 0
//    @Binding var mode: Mode
//    var factData: FactData
//    let slideshowImages = ["metro_exit_1", "metro_exit_2", "metro_exit_3", "FactBG"]
//    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
//    
//    var showContent: Bool {
//        currentImageIndex == slideshowImages.count - 1
//    }
//    
//    var navigationDestination: some View {
//        let selected = factData.options[selectedOptionIndex!]
//        return ConsequencesView(
//            mode: mode,
//            soundFiles: selected.parts.map { $0.sound },
//            years: selected.parts.map { $0.year },
//            TextContent: selected.parts.map { $0.text }
//        )
//    }
//    
//    
//    
//    var body: some View {
//        
//        ZStack {
//            // Slideshow background
//            Image(slideshowImages[currentImageIndex])
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//                .animation(.easeInOut(duration: 0.1), value: currentImageIndex)
//                .onReceive(timer) { _ in
//                    if currentImageIndex < slideshowImages.count - 1 {
//                        currentImageIndex += 1
//                    }
//                }
//            VStack {
//                HStack {
//                    NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)) {
//                        Image("profileIcon")
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                    }
//                    
//                    Spacer()
//                    
//                    NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)) {
//                        Image("settingIcon")
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                    }
//                }
//                .padding(.top, 40) // Adjust top padding if needed
//                
//                Spacer() // Pushes everything to the top
//            }
//            
//            if showContent {
//                ZStack {
//                    // Fact on the left
//                    VStack {
//                        Text(factData.fact)
//                            .lineSpacing(8)
//                            .font(.body)
//                            .multilineTextAlignment(.center)
//                            .padding()
//                            .foregroundColor(.white)
//                            .frame(width: 450, height: 205)
//                            .background(.blue3)
//                            .border(.black, width:10)
//                            .padding(.trailing, 270)
//                            .padding(.top, 50)
//                        
//                    }
//                    
//                    // Options on the right
//                    GeometryReader { geometry in
//                        VStack(spacing: 7) {
//                            ForEach(factData.options.indices, id: \.self) { i in
//                                Button(action: {
//                                    selectedOptionIndex = i
//                                }) {
//                                    Text(factData.options[i].title)
//                                        .multilineTextAlignment(.center)
//                                        .lineSpacing(7)
//                                        .font(.system(size: 10))
//                                        .foregroundColor(.white)
//                                        .frame(width: 280, height: 57)
//                                        .padding(.horizontal, 2)
//                                        .background(
//                                            selectedOptionIndex == i ? Color.green1.opacity(0.9) : Color.black
//                                        )
//                                        .cornerRadius(1)
//                                }
//                                .buttonStyle(PlainButtonStyle())
//                            }
//                        }
//                        // Responsive position: adjust these percentages as needed
//                        .position(
//                            x: geometry.size.width * 0.80,  // 636 / 768 ≈ 0.83
//                            y: geometry.size.height * 0.49  // 172 / 712 ≈ 0.24
//                        )
//                    }
//
//                }
//                // NEXT Button
//                if selectedOptionIndex != nil {
//                    VStack {
//                        Spacer()
//                        HStack {
//                            Spacer()
//                            NavigationLink(destination: navigationDestination, isActive: $navigate) {
//                                Button(action: {
//                                    if let user = currentUser,
//                                       let selectedIndex = selectedOptionIndex {
//                                        let selectedOption = factData.options[selectedIndex]
//                                        user.karma += selectedOption.karma
//                                        try? modelContext.save()
//                                        navigate = true
//                                    }
//                                }) {
//                                    Image("nextIcon")
//                                        .resizable()
//                                        .frame(width: 50, height: 50)
//                                        .padding()
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//// Preview
//#Preview {
//    FactView(
//        mode: .constant(.Horror),
//        factData: FactDatabase.getFact(for: "Art_in_History", mode: "Horror", language: "english")
//    )
//}
//
import SwiftUI
import SwiftData

struct FactView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [UserModel]
    @State private var selectedOptionIndex: Int? = nil
    @State private var shouldNavigate = false
    @State private var currentImageIndex = 0
    @Binding var mode: Mode
    var factData: FactData
    
    let slideshowImages = ["metro_exit_1", "metro_exit_2", "metro_exit_3", "FactBG"]
    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    
    // Current user with automatic creation if needed
    var currentUser: UserModel {
        users.first ?? {
            let newUser = UserModel()
            modelContext.insert(newUser)
            return newUser
        }()
    }
    
    // Accessibility
    var modeLabel: String {
        let isArabic = getLanguagePreference() == .arabic
        switch mode {
        case .Horror: return isArabic ? "وضع الرعب" : "Horror Mode"
        case .Comics: return isArabic ? "وضع الكوميكس" : "Comics Mode"
        case .UtopianDystopian: return isArabic ? "وضع اليوتوبيا والديستوبيا" : "Utopian/Dystopian Mode"
        case .main: return isArabic ? "الوضع الرئيسي" : "Main Mode"
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background slideshow
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
                    .accessibilityHidden(true)
                
                // Main content
                VStack {
                    headerButtons
                    Spacer()
                }
                
                // Fact content appears after slideshow
                if currentImageIndex == slideshowImages.count - 1 {
                    factContent
                }
                
                // Hidden navigation link
                NavigationLink(
                    destination: ConsequencesView(
                        mode: mode,
                        soundFiles: selectedOptionSoundFiles,
                        years: selectedOptionYears,
                        TextContent: selectedOptionTexts
                    ),
                    isActive: $shouldNavigate,
                    label: { EmptyView() }
                )
                .accessibilityHidden(true)
            }
            .navigationBarBackButtonHidden(true)
            .accessibilityElement(children: .contain)
            .accessibilityLabel("\(modeLabel), Fact Screen")
        }
    }
    
    // MARK: - Computed Properties for Selected Option
    private var selectedOptionSoundFiles: [String] {
        guard let index = selectedOptionIndex else { return [] }
        return factData.options[index].parts.map { $0.sound }
    }
    
    private var selectedOptionYears: [String] {
        guard let index = selectedOptionIndex else { return [] }
        return factData.options[index].parts.map { $0.year }
    }
    
    private var selectedOptionTexts: [String] {
        guard let index = selectedOptionIndex else { return [] }
        return factData.options[index].parts.map { $0.text }
    }
    
    // MARK: - View Components
    private var headerButtons: some View {
        HStack {
            NavigationLink(destination: ProfileView()) {
                Image("profileIcon")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .accessibilityLabel(getLanguagePreference() == .arabic ? "الملف الشخصي" : "Profile")
                    .accessibilityHint(getLanguagePreference() == .arabic ? "انتقل إلى الملف الشخصي" : "Go to profile")
            }
            
            Spacer()
            
            NavigationLink(destination: SettingsView()) {
                Image("settingIcon")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .accessibilityLabel(getLanguagePreference() == .arabic ? "الإعدادات" : "Settings")
                    .accessibilityHint(getLanguagePreference() == .arabic ? "انتقل إلى الإعدادات" : "Go to settings")
            }
        }
        .padding(.top, 40)
        .padding(.horizontal)
    }
    
    private var factContent: some View {
        ZStack {
            // Fact text
            Text(factData.fact)
                .lineSpacing(8)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.white)
                .frame(width: 450, height: 205)
                .background(.blue3)
                .border(.black, width: 10)
                .padding(.trailing, 270)
                .padding(.top, 50)
                .accessibilityLabel("Fact: \(factData.fact)")
                .accessibilityAddTraits(.isStaticText)
            
            // Decision options
            optionsGrid
            
            // Next button (only shows when option is selected)
            if selectedOptionIndex != nil {
                nextButton
            }
        }
    }
    
    private var optionsGrid: some View {
        GeometryReader { geometry in
            VStack(spacing: 7) {
                ForEach(factData.options.indices, id: \.self) { index in
                    Button(action: { selectOption(index: index) }) {
                        Text(factData.options[index].title)
                            .multilineTextAlignment(.center)
                            .lineSpacing(7)
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                            .frame(width: 280, height: 57)
                            .padding(.horizontal, 2)
                            .background(
                                selectedOptionIndex == index ? Color.green1.opacity(0.9) : Color.black
                            )
                            .cornerRadius(1)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel("\(getLanguagePreference() == .arabic ? "الخيار" : "Option") \(index + 1): \(factData.options[index].title)")
                    .accessibilityHint(getLanguagePreference() == .arabic ? "اضغط لتحديد هذا الخيار" : "Select this option")
                    .accessibilityAddTraits(selectedOptionIndex == index ? [.isSelected] : [])
                }
            }
            .position(x: geometry.size.width * 0.80, y: geometry.size.height * 0.49)
            .accessibilityElement(children: .contain)
            .accessibilityLabel("Decision Options")
        }
    }
    
    private var nextButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: proceedWithSelection) {
                    Image("nextIcon")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                }
                .accessibilityLabel(getLanguagePreference() == .arabic ? "التالي" : "Next")
                .accessibilityHint(getLanguagePreference() == .arabic ?
                                 "انتقل إلى النتائج" :
                                 "Continue to consequences")
            }
        }
    }
    
    // MARK: - Action Methods
    private func selectOption(index: Int) {
        selectedOptionIndex = index
        SystemSoundManager.shared.play(.button)
        
        let announcement = getLanguagePreference() == .arabic ?
        "تم اختيار الخيار \(index + 1)" :
        "Option \(index + 1) selected"
        UIAccessibility.post(notification: .announcement, argument: announcement)
    }
    
    private func proceedWithSelection() {
        guard let selectedIndex = selectedOptionIndex else { return }
        
        // Update karma
        let selectedOption = factData.options[selectedIndex]
        currentUser.karma += selectedOption.karma
        
        // Save and navigate
        do {
            try modelContext.save()
            SystemSoundManager.shared.play(.button)
            shouldNavigate = true
            
            let announcement = getLanguagePreference() == .arabic ?
            "تم تحديث الكارما. الانتقال إلى النتائج" :
            "Karma updated. Proceeding to consequences"
            UIAccessibility.post(notification: .screenChanged, argument: announcement)
        } catch {
            print("Error saving karma: \(error.localizedDescription)")
        }
    }
}

#Preview {
    FactView(
        mode: .constant(.Horror),
        factData: FactDatabase.getFact(for: "Art_in_History", mode: "Horror", language: "english")
    )
    .modelContainer(for: UserModel.self)
}
