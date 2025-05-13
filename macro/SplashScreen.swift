//
//  SplashScreen.swift
//  macro
//
//  Created by ohoud on 15/11/1446 AH.
//
//import SwiftUI
//
//struct SplashPage: View {
//    @State private var isActive: Bool = false
//    @State private var currentImageIndex: Int = 0
//
//    // Array of image names to cycle through
//    let images = ["name1", "name2", "name3"] // Add your image names here
//    let animationDuration: Double = 0.0001 // Time interval for each image change
//    
//    var body: some View {
//        ZStack {
//            if self.isActive {
//                StartView() // Content to show after splash
//            } else {
//                // Display cycling images
//                Image(images[currentImageIndex])
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//                
//            }
//        }
//        .onAppear {
//            startImageCycling()
//            // Transition to the main view after a delay
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                withAnimation {
//                    self.isActive = true
//                }
//            }
//        }
//    }
//    
//    // Function to cycle through the images
//    private func startImageCycling() {
//        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
//            withAnimation {
//                currentImageIndex = (currentImageIndex + 1) % images.count
//            }
//        }
//    }
//}
//
//#Preview {
//    SplashPage()
//}

