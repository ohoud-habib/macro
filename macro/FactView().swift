
//import SwiftUI
//
//struct FactView: View {
//    @State private var selectedOptionIndex: Int? = nil
//    @State private var navigate = false
//    @State private var currentImageIndex = 0
//    @Binding var mode: Mode
//    var factData: FactData
//
////    let slideshowImages = ["metro_exit_1", "metro_exit_1", "metro_exit_1", "FactBG"]
//    let slideshowImages = ["FactBG"]
//    let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
//
//    var showContent: Bool {
//        currentImageIndex == slideshowImages.count - 1
//    }
//
//    var body: some View {
//        ZStack {
//            // Slideshow background
//            Image(slideshowImages[currentImageIndex])
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//                .animation(.easeInOut(duration: 1.0), value: currentImageIndex)
//                .onReceive(timer) { _ in
//                    if currentImageIndex < slideshowImages.count - 1 {
//                        currentImageIndex += 1
//                    }
//                }
//            if showContent {
//                ZStack {
//                    // Fact on the left
//                    VStack {
//                        Text(factData.fact)
//                            .font(.body)
//                            .multilineTextAlignment(.center)
//                            .foregroundColor(.black)
//                            .padding()
//                            .frame(width: 430, height: 205) // Increase height here
//                            .background(Color.red)
//                            .position(x: 265, y: 230) // Fixed position
//                    }
//
//                    // Options on the right
//                    VStack(spacing: 7) {
//                        ForEach(factData.options.indices, id: \.self) { i in
//                            Button(action: {
//                                selectedOptionIndex = i
//                            }) {
//                                Text(factData.options[i].title)
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(.white)
//                                    .frame(width: 237, height: 57)
//                                    .background(
//                                        selectedOptionIndex == i ? Color.green.opacity(0.5) : Color.red
//                                            .padding(0)
//                                    )
//                            }
//                            .buttonStyle(PlainButtonStyle())
//                        }
//                    }
//                    .position(x: 655, y: 142) // Adjust as needed
//                }
//
//                // Floating NEXT button (same as before)
//                if let selectedIndex = selectedOptionIndex {
//                    VStack {
//                        Spacer()
//                        HStack {
//                            Spacer()
//                            NavigationLink(
//                                destination: ConsequencesView(
//                                    mode: mode,
//                                    soundFiles: factData.options[selectedIndex].parts.map { $0.sound },
//                                    years: factData.options[selectedIndex].parts.map { $0.year },
//                                    TextContent: factData.options[selectedIndex].parts.map { $0.text }
//                                ),
//                                isActive: $navigate
//                            ) {
//                                Button(action: {
//                                    navigate = true
//                                }) {
//                                    Image("nextIcon")
//                                        .resizable()
//                                        .frame(width: 40, height: 40)
//                                }
//                            }
//                        }
////                        .padding()
//                    }
//                }
//            }
//
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//#Preview {
//    FactView(
//        mode: .constant(.Horror),
//        factData: FactDatabase.getFact(for: "Art_in_History", mode: "Horror", language: "arabic")
//    )
//}

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
//    let slideshowImages = ["FactBG"] // Replace with your slideshow images
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
//            ,
//            onFinished: {
//                navigateToProfile = true // navigate to Profile when finished
//            }
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

            if showContent {
                ZStack {
                    // Fact on the left
                    VStack {
                        Text(factData.fact)
                            .lineSpacing(8)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 430, height: 205)
                            .position(x: 265, y: 230)
                    }

                    // Options on the right
                    VStack(spacing: 7) {
                        ForEach(factData.options.indices, id: \.self) { i in
                            Button(action: {
                                selectedOptionIndex = i
                            }) {
                                Text(factData.options[i].title)
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(7)
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 280, height: 57)
                                    .padding(.horizontal, 2)
                                    .background(
                                        selectedOptionIndex == i ? Color.green1.opacity(0.5) : Color.black
                                    )
                                    .cornerRadius(1)
                                    
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .position(x: 656, y: 142)
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
