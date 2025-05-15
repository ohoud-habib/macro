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
        NavigationStack {
            GeometryReader { geometry in
                ZStack(alignment: .bottomTrailing) {
                    // Background Image (based on language)
                    Image(getLanguagePreference() == .arabic ? "categoriesBG_ar" : "categoriesBG_en")
                        .resizable()
                        .scaledToFill()
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
                        .padding(.horizontal)
                        .padding(.top, geometry.safeAreaInsets.top + 40)

                        Spacer()

                        // Station Dots
                        GeometryReader { geometry in
                                           ZStack {
                                               ForEach(stations.indices, id: \.self) { index in
                                                   let positions: [(CGFloat, CGFloat)] = [
                                                       (0.24, 0.489), // Art_in_History
                                                       (0.34, 0.489), // Legends_and_Myths
                                                       (0.44, 0.489), // Medicine_and_Mind
                                                       (0.537, 0.489)  // Human_Rights
                                                   ]
                                                   
                                                   let (x, y) = positions[index]
                                                   
                                                   Circle()
                                                       .fill(selectedStationIndex == index ? Color.green : Color.black)
                                                       .frame(width: 16, height: 16)
                                                       .position(x: geometry.size.width * x,
                                                                 y: geometry.size.height * y - 18.5)
                                                   
                                                       .onTapGesture {
                                                           selectedStationIndex = index
                                                       }
                                               }
                                           }
                                       }
                                       .ignoresSafeArea()
                    }
                    

                    // Bottom-right "Next" button
                    if let selectedIndex = selectedStationIndex {
                        NavigationLink(destination: TrainDoorView(selectedCategory: stations[selectedIndex])) {
                            Image("nextIcon")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.trailing, 40)
                                .padding(.bottom, 30)
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CategoriesView()
}

