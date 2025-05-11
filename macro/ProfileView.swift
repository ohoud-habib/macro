//
//  ProfileView.swift
//  macro
//
//  Created by Maryam Bahwal on 11/11/1446 AH.
//
//
//import SwiftData
//import SwiftUI
//
//struct ProfileView: View {
//    @StateObject private var soundManager = SoundManager.shared // Access the shared SoundManager
//    
////    @Query(sort: \SentimentScore.timestamp, order: .reverse) private var scores: [SentimentScore]
//    
////    var karmaImageName: String {
////        if let latestScore = scores.first {
////            if latestScore.score > 0 {
////                return "positive"
////            } else if latestScore.score == 0 {
////                return "normal"
////            } else {
////                return "negative"
////            }
////        }
////        return "normal"
////    }
////    
////    var karmaOffset: CGSize {
////        if let latestScore = scores.first {
////            if latestScore.score > 0 {
////                return CGSize(width: -143, height: -40)
////            } else if latestScore.score == 0 {
////                return CGSize(width: -40, height: -60)
////            } else {
////                return CGSize(width: 63, height: -40)
////            }
////        }
////        return CGSize(width: -40, height: -60)
////    }
////    
////    var dramaticMessage: String {
////        if let latestScore = scores.first {
////            let dateFormatter = DateFormatter()
////            dateFormatter.dateStyle = .long
////            dateFormatter.timeStyle = .short
////            
////            if latestScore.score > 0 {
////                return "On \(dateFormatter.string(from: latestScore.timestamp)), you changed the world for the better"
////            } else if latestScore.score < 0 {
////                return "On \(dateFormatter.string(from: latestScore.timestamp)), your actions left a mark on history"
////            } else {
////                return "On \(dateFormatter.string(from: latestScore.timestamp)), you stood at the crossroads of destiny"
////            }
////        }
////        return "Your journey to change the world begins now."
////    }
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Image("karmabg")
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//                
//                VStack {
////                    HStack {
////                        NavigationLink(destination: BoxOfficeView().navigationBarBackButtonHidden(true)) {
////                            Image("Home")
////                                .resizable()
////                                .frame(width: 60, height: 60)
////                        }
////                        .simultaneousGesture(TapGesture().onEnded {
////                            soundManager.playSound(type: .button) // Play sound if enabled
////                        })
////                        
////                        Spacer()
////                        
////                        NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)) {
////                            Image("sett")
////                                .resizable()
////                                .frame(width: 60, height: 60)
////                        }
////                        .simultaneousGesture(TapGesture().onEnded {
////                            soundManager.playSound(type: .button) // Play sound if enabled
////                        })
////                    }
////                    .padding()
//                    
//                    Spacer()
//                    
////                    Image(karmaImageName)
////                        .resizable()
////                        .frame(width: 70, height: 110)
////                        .offset(karmaOffset)
////                    ZStack{
////                        Rectangle()
////                            .frame(width: 405, height: 60)
////                            .background(.ourblack).opacity(0.8)
////                            .padding(.trailing, 52)
////                            .shadow(radius: 5)
////                        VStack( spacing: 5){
////                            if let latestScore = scores.first {
////                                VStack{
////                                    HStack{
////                                        Text("Latest Choice Karma:")
////                                        Text("\(String(format: "%.2f", latestScore.score))").foregroundColor(.ourgreen)
////                                    }
////                                    .font(.system(size: 12, weight: .bold)).foregroundStyle(.white)
////                                    HStack{
////                                        Text("Overall Karma:")
////                                        
////                                        Text("\(String(format: "%.2f", latestScore.cumulativeScore))")
////                                            .foregroundColor(.ourgreen)
////                                    }
////                                    .font(.system(size: 12, weight: .bold)).foregroundStyle(.white)
////                                }
////                                
////                            } else {
////                                Text("No sentiment scores available.")
////                                    .font(.system(size: 10)).foregroundStyle(.white)
////                                    .padding(.trailing, 10)
////                            }
////                            // Dramatic footer message
////                            Text(dramaticMessage)
////                                .font(.system(size: 10))
////                                .italic()
////                                .multilineTextAlignment(.center)
////                                .foregroundColor(.ourbrown).bold()
////                                .padding(.bottom, 20)
////                        }
////                        .padding(.top, 20)
////                        .padding(.trailing, 40)
////                    }
////                    .frame(width: 415, height: 50)
////                    .padding(.top, 20)
////                    .padding(.bottom, 10)
//                    
//                    
//                    
//                    
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//            .environmentObject(SoundManager.shared) // Provide the shared SoundManager
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query private var users: [UserModel]
    @State private var navigateToSettings = false
    @State private var navigateToStart = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("ProfileBG")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        VStack(spacing: 16) { // vertical spacing between icons
                            // Home Icon Button
                            Button(action: {
                                navigateToStart = true
                            }) {
                                Image("homeIcon")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .padding(.top)
                            }
                            
                            // Settings Icon Button
                            Button(action: {
                                navigateToSettings = true
                            }) {
                                Image("settingIcon")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                            }
                        }
                        .padding(.leading, 16)
                        
                        Spacer() // Push icons to the left
                    }
                    
                    Spacer() // Push content to the top
                }

                
                HStack {
                    // Left: Angel or Devil
                    Image(currentKarma >= 0 ? "angel" : "devil")
                        .resizable()
                        .frame(width: 150, height: 270)
                        .padding(.leading, 180)
                        .padding(.top, 30)
                    
                    Spacer()
                    
                    // Right: Score Display
                    Text("SCORE:\n\(currentKarma)")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.trailing, 200)
                        .padding(.bottom, 100)
                        .lineSpacing(8)
                }
                .padding()
                
                // Navigation Links
                NavigationLink(destination: SettingsView(), isActive: $navigateToSettings) {
                    EmptyView()
                }
                NavigationLink(destination: StartView(), isActive: $navigateToStart) {
                    EmptyView()
                }
            }
        }
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
