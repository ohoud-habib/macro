//
//  CategoriesView.swift
//  macro
//
//  Created by Maryam Bahwal on 10/11/1446 AH.
//
import SwiftUI

struct CategoriesView: View {
    @State private var selectedStationIndex: Int? = nil
    let stations = ["Art_in_History", "Legends_and_Myths", "Medicine_and_Mind", "Human_Rights"]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                // Background Image
                Image("categoriesBG")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    // Top bar icons
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
                    .padding(.top)
                    
                    
                    Spacer()
                    
                    // Station Line with fixed position
                    HStack(spacing: 86) {
                        ForEach(stations.indices, id: \.self) { index in
                            ZStack {
                                Circle()
                                    .fill(selectedStationIndex == index ? Color.green : Color.black)
                                    .frame(width: 13, height: 13)
                                    .padding(.horizontal, -105)
.padding(.top, 10)
                            }
                            .onTapGesture {
                                selectedStationIndex = index
                            }
                        }
                    }
                    .frame(height: 50) // Fix height to avoid layout shift
                    
                    Spacer()
                }
                
                // Bottom-left "Next" button
                if let selectedIndex = selectedStationIndex {
                    NavigationLink(destination: TrainDoorView(selectedCategory: stations[selectedIndex])) {
                        Image("nextIcon")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CategoriesView()
        .previewInterfaceOrientation(.landscapeLeft)
}

//
//import SwiftUI
//
//struct CategoriesView: View {
//    @State private var selectedStationIndex: Int? = nil
//    let stations = ["MEDICINE & MIND", "HEALTH & BODY", "ART & DESIGN", "HISTORY"]
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                // Background Image
//                Image("categoriesBG")
//                    .resizable()
//                    .ignoresSafeArea()
//
//
//                VStack {
//                    // Top bar icons
//                    HStack {
//                        Image("profileIcon")
//                            .resizable()
//                            .frame(width: 60, height: 60)
//
//                        Spacer()
//
//                        Image("settingIcon")
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                    }
//                    .padding(.top)
//
//                    Spacer()
//
//
//                    // Station Line
//                    HStack(spacing: 86) {
//                        ForEach(stations.indices, id: \.self) { index in
//                            VStack {
//                                ZStack {
//                                    if selectedStationIndex == index {
//                                        Circle()
//                                            .fill(Color.green)
//                                            .frame(width: 13, height: 13)
//                                            .padding(.horizontal, -105)
//                                            .padding(.top, 10)
//                                    } else {
//                                        Circle()
//                                            .fill(Color.black)
//                                            .frame(width: 13, height: 13)
//                                            .padding(.horizontal, -105)
//                                            .padding(.top, 10)
//                                    }
//                                }
//
//                            }
//                            .onTapGesture {
//                                selectedStationIndex = index
//                            }
//                        }
//
//
//                    }
//
//
//                    Spacer()
//
//                    // Navigation Button
//                    if let selectedIndex = selectedStationIndex {
//                        NavigationLink(destination: TrainDoorView(selectedCategory: stations[selectedIndex])) {
//                            Image("nextIcon")
//                                .resizable()
//                                .frame(width: 50, height: 50, alignment: .trailing)
//
//                        }
//                        .padding()
//                    }
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//#Preview {
//    CategoriesView()
//        .previewInterfaceOrientation(.landscapeLeft)
//}
