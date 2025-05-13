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
                    .padding(.top)
                    
                    
                    Spacer()
                    
                    // Station Line with fixed position
                    HStack(spacing: 86) {
                        ForEach(stations.indices, id: \.self) { index in
                            ZStack {
                                Circle()
                                    .fill(selectedStationIndex == index ? Color.green : Color.black)
                                    .frame(width: 16, height: 16)
                                    .padding(.horizontal, -105)
.padding(.top, 25)
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
