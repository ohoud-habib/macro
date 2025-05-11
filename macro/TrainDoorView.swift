//
//  trainDoorView.swift
//  macro
//
//  Created by ohoud on 10/11/1446 AH.
//

//import SwiftUI
//
//struct StartView: View {
//    @State private var goToNext = false
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Image("startScreen")
//                    .resizable()
//                    .ignoresSafeArea()
//
//                VStack {
//                    Spacer()
//                    NavigationLink(destination: CategoriesView(), isActive: $goToNext) {
//                        Button(action: {
//                            goToNext = true
//                        }) {
//                            Text("START")
//                                .font(.title2)
//                                .fontWeight(.bold)
//                                .foregroundColor(.black)
//                                .padding()
//                                .frame(maxWidth: 200)
//                                .background(Color("green1"))
//                                .cornerRadius(12)
//                        }
//                    }
//                    .navigationBarBackButtonHidden(true)
//                    .buttonStyle(PlainButtonStyle())
//                    .padding(.bottom, 40)
//                }
//            }
//        }
//    }
//}
//
//struct TrainDoorView: View {
//    let selectedCategory: String
//    let images = ["trainClosed", "trainHalfOpen", "trainOpen", "trainDoor", "insidemetro1", "insidemetro2"]
//    @State private var currentIndex = 0
//    @State private var showButtons = false
//    @State private var goToAfterMode = false
//    @State private var goToEmptyView = false
//
//    var body: some View {
//        ZStack {
//            Image(images[currentIndex])
//                .resizable()
//                .ignoresSafeArea()
//                .transition(.opacity)
//                .animation(.easeInOut(duration: 0.7), value: currentIndex)
//
//            if showButtons {
//                VStack {
//                    Spacer()
//                    HStack(spacing: 40) {
//                        NavigationLink(destination: FactView(category: selectedCategory, mode: "Horror")) {
//                            Button(action: {
//                                goToEmptyView = true
//                            }) {
//                                Image("previousIcon")
//                                    .resizable()
//                                    .frame(width: 50, height: 50)
//                            }
//                        }
//                        .buttonStyle(PlainButtonStyle())
//
//                        NavigationLink(destination: FactView(category: selectedCategory, mode: "Comic")) {
//                            Button(action: {
//                                goToAfterMode = true
//                            }) {
//                                Image("nextIcon")
//                                    .resizable()
//                                    .frame(width: 50, height: 50)
//                            }
//                        }
//                        .buttonStyle(PlainButtonStyle())
//                    }
//                }
//            }
//        }
//        .onAppear {
//            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
//                if currentIndex < images.count - 1 {
//                    currentIndex += 1
//                } else {
//                    timer.invalidate()
//                    showButtons = true
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//        
//        
//}
//
//struct afterMode: View {
//    let images = ["door1", "door2", "door3","infoImage"]
//    @State private var currentIndex = 0
//
//    var body: some View {
//        ZStack {
//            Image(images[currentIndex])
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//                .onTapGesture {
//                    withAnimation(.easeInOut) {
//                        currentIndex = (currentIndex + 1) % images.count
//                    }
//                }
//        }
//    }
//}
//
//struct FactView: View {
//    let category: String
//    let mode: String
//
//    var body: some View {
//        VStack {
//            Text("Category: \(category)")
//            Text("Mode: \(mode)")
//        }
//    }
//}
//
//
//#Preview {
//    StartView()
//}
import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("startScreen")
                    .resizable()
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                    NavigationLink(destination: CategoriesView()) {
                        Text("START")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color("green1"))
                            .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 40)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

//struct TrainDoorView: View {
//    let selectedCategory: String
//    let images = ["trainClosed", "trainHalfOpen", "trainOpen", "trainDoor", "insidemetro1", "insidemetro2"]
//    @State private var currentIndex = 0
//    @State private var showButtons = false
//    var body: some View {
//        ZStack {
//            Image(images[currentIndex])
//                .resizable()
//                .ignoresSafeArea()
//                .transition(.opacity)
//                .animation(.easeInOut(duration: 0.7), value: currentIndex)
//
//            if showButtons {
//                VStack {
//                    Spacer()
//                    HStack(spacing: 40) {
//                        NavigationLink(destination: FactView(category: selectedCategory, mode: "Horror")) {
//                            Image("previousIcon")
//                                .resizable()
//                                .frame(width: 50, height: 50)
//                        }
//                        .buttonStyle(PlainButtonStyle())
//
//                        NavigationLink(destination: FactView(category: selectedCategory, mode: "Comic")) {
//                            Image("nextIcon")
//                                .resizable()
//                                .frame(width: 50, height: 50)
//                        }
//                        .buttonStyle(PlainButtonStyle())
//                    }
//                    .padding(.bottom, 40)
//                }
//            }
//        }
//        .onAppear {
//            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
//                if currentIndex < images.count - 1 {
//                    currentIndex += 1
//                } else {
//                    timer.invalidate()
//                    showButtons = true
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
struct TrainDoorView: View {
    let selectedCategory: String
//    let images = ["trainClosed", "trainHalfOpen", "trainOpen", "trainDoor", "insidemetro1", "insidemetro2"]
    let images = ["metro_enter_1", "metro_enter_2", "metro_enter_3", "insidemetro1", "insidemetro2"]

    
    @State private var currentIndex = 0
    @State private var showButtons = false
    @State private var horrorMode: Mode = .Horror
    @State private var comicMode: Mode = .Comics

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
                                mode: $horrorMode,
                                factData: FactDatabase.getFact(for: selectedCategory, mode: "Horror", language: userLanguage)
                            )
                        ) {
                            Image("previousIcon")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        .buttonStyle(PlainButtonStyle())

                        NavigationLink(destination:
                            FactView(
                                mode: $comicMode,
                                factData: FactDatabase.getFact(for: selectedCategory, mode: "Comic", language: userLanguage)
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
}
