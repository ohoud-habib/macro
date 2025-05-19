////
////  Backstory.swift
////  macro
////
////  Created by ohoud on 18/11/1446 AH.
////
//
//import SwiftUI
//import SwiftData
//
//
//struct BackStoryRouterView: View {
//    let karma: Int
//
//    var body: some View {
//        NavigationStack {
//            Group {
//                if karma >= 40 {
//                    PlayerStoryView()
//                } else if karma <= -25 {
//                    SenaStoryView()
//                } else {
//                    BackStoryView()
//                }
//            }
//        }
//    }
//}
//
//
//struct PlayerStoryView: View {
//    @State private var showCards = false
//
//    var body: some View {
//        ZStack {
//            Image("playerStory")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//
//            Button(action: {
//                showCards = true
//            }) {
//                Rectangle()
//                    .fill(Color.clear)
//                    .frame(width: 220, height: 300)
//            }
//            .position(x:250, y: 220)
//
//            // Trigger navigation when showCards is true
//            NavigationLink(destination: PstoryView(), isActive: $showCards){
//                EmptyView()
//            }
//            HStack {
//                navButton("profileIcon", destination: ProfileView())
//                Spacer()
//                navButton("homeIcon", destination: StartView())
//                
//            }
//            .navigationBarBackButtonHidden(true)
//            .padding(.top, -145)
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
// 
//
//
//struct SenaStoryView: View {
//    @State private var showCards = false
//
//    var body: some View {
//        ZStack {
//            Image("senastory")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//
//            Button(action: {
//                showCards = true
//            }) {
//                Rectangle()
//                    .fill(Color.clear) // almost invisible
//                    .frame(width: 220, height: 300)
//            }
//            .position(x:550, y: 220) // Adjust to match your layout
//
//            // Trigger navigation when showCards is true
//            NavigationLink(destination: SstoryView(), isActive: $showCards) {
//                EmptyView()
//            }
//            HStack {
//                navButton("profileIcon", destination: ProfileView())
//                Spacer()
//                navButton("homeIcon", destination: StartView())
//                
//            }
//            .navigationBarBackButtonHidden(true)
//            .padding(.top, -145)
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//
//
//struct BackStoryView: View {
//    var body: some View {
//        ZStack {
//            Image("bothLock")
//                .resizable()
//              //  .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            HStack {
//                navButton("profileIcon", destination: ProfileView())
//                Spacer()
//                navButton("homeIcon", destination: StartView())
//                
//            }
//            .navigationBarBackButtonHidden(true)
//            .padding(.top, -145)
//            
//        }
//    }
//}
//
//
//private func navButton(_ image: String, destination: some View) -> some View {
//    NavigationLink(destination: destination.navigationBarBackButtonHidden(true)) {
//        Image(image).resizable().frame(width: 60, height: 60)
//    }
//    .simultaneousGesture(TapGesture().onEnded {
//        SystemSoundManager.shared.play(.button)
//    })
//}
//
//struct FlippableCard: View {
//    let frontText: String
//    let backText: String
//    let frontFont: Font
//    let frontColor: Color
//    let backFont: Font
//    let backColor: Color
//
//    @State private var flipped = false
//
//    var body: some View {
//        ZStack {
//            
//            
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color.blue3)
//                .border(.black, width:3)
//                .frame(width: 200, height: 300)
//
//            Text(flipped ? backText : frontText)
//                .font(flipped ? backFont : frontFont)
//                .foregroundColor(flipped ? backColor : frontColor)
//                .bold()
//                .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
//        }
//        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
//        .onTapGesture {
//            withAnimation {
//                flipped.toggle()
//            }
//        }
//        
//    }
//}
//
//struct CardStyle {
//    let frontText: String
//    let frontFont: Font
//    let frontColor: Color
//    let backText: String
//    let backFont: Font
//    let backColor: Color
//}
//
//
//struct StoryCardView: View {
//    let cards: [CardStyle]
//
//    var body: some View {
//        ZStack {
//            Image("blurredbg")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//
//            HStack(spacing: 20) {
//                ForEach(0..<cards.count, id: \.self) { index in
//                    let style = cards[index]
//                    FlippableCard(
//                        frontText: style.frontText,
//                        backText: style.backText,
//                        frontFont: style.frontFont,
//                        frontColor: style.frontColor,
//                        backFont: style.backFont,
//                        backColor: style.backColor
//                    )
//                }
//            }
//        }
//    }
//}
//
//
//struct PstoryView: View {
//    let language = getLanguagePreference()
//
//    var body: some View {
//        let cards: [CardStyle] = {
//            switch language {
//            case .arabic:
//                return [
//                    CardStyle(frontText: "من؟", frontFont: .title2, frontColor: .black, backText: "هي المعمارية", backFont: .system(size: 18), backColor: .black),
//                    CardStyle(frontText: "لماذا؟", frontFont: .title2, frontColor: .black, backText: "لإعادة التوازن", backFont: .body, backColor: .black),
//                    CardStyle(frontText: "وماذا بعد؟", frontFont: .title2, frontColor: .black, backText: "اصنع إرثك", backFont: .title3, backColor: .black)
//                ]
//            case .english:
//                return [
//                    CardStyle(frontText: "WHO?", frontFont: .title2, frontColor: .black, backText: "She is the Architect", backFont: .system(size: 18), backColor: .black),
//                    CardStyle(frontText: "WHY?", frontFont: .title2, frontColor: .black, backText: "To restore balance", backFont: .body, backColor: .black),
//                    CardStyle(frontText: "WHAT’S NEXT?", frontFont: .title2, frontColor: .black, backText: "Forge your legacy", backFont: .title3, backColor: .black)
//                ]
//            }
//        }()
//
//        return ZStack {
//            StoryCardView(cards: cards)
//            HStack {
//                navButton("profileIcon", destination: ProfileView())
//                Spacer()
//                navButton("homeIcon", destination: StartView())
//            }
//            .navigationBarBackButtonHidden(true)
//            .padding(.top, -145)
//        }
//    }
//}
//
//
//
//
//
//struct SstoryView: View {
//    let language = getLanguagePreference()
//
//    var body: some View {
//        let cards: [CardStyle] = {
//            switch language {
//            case .arabic:
//                return [
//                    CardStyle(frontText: "من؟", frontFont: .largeTitle, frontColor: .black, backText: "كل من تقف هنا…\nكان لديه احتمال،\nنسي أن يختاره.\nأنا فقط… جمعتك مع البقيّة", backFont: .system(size: 16), backColor: .black),
//                    CardStyle(frontText: "لماذا؟", frontFont: .title, frontColor: .black, backText: "لإعادة التوازن", backFont: .body, backColor: .black),
//                    CardStyle(frontText: "ماذا بعد؟", frontFont: .title2, frontColor: .black, backText: "اصنع إرثك", backFont: .title3, backColor: .black)
//                ]
//            case .english:
//                return [
//                    CardStyle(frontText: "WHO?", frontFont: .largeTitle, frontColor: .black, backText: "You are the Reclaimer", backFont: .system(size: 18), backColor: .black),
//                    CardStyle(frontText: "WHY?", frontFont: .title, frontColor: .black, backText: "To restore balance", backFont: .body, backColor: .black),
//                    CardStyle(frontText: "WHAT’S NEXT?", frontFont: .title2, frontColor: .black, backText: "Forge your legacy", backFont: .title3, backColor: .black)
//                ]
//            }
//        }()
//
//        return ZStack {
//            StoryCardView(cards: cards)
//            HStack {
//                navButton("profileIcon", destination: ProfileView())
//                Spacer()
//                navButton("homeIcon", destination: StartView())
//            }
//            .navigationBarBackButtonHidden(true)
//            .padding(.top, -145)
//        }
//    }
//}
//
//#Preview {
//    BackStoryRouterView(karma: 90)
//}
//
//  Backstory.swift
//  macro
//
//  Created by ohoud on 18/11/1446 AH.
//

import SwiftUI
import SwiftData

struct BackStoryRouterView: View {
    let karma: Int
    
    var body: some View {
        NavigationStack {
            Group {
                if karma >= 40 {
                    PlayerStoryView()
                } else if karma <= -25 {
                    SenaStoryView()
                } else {
                    BackStoryView()
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Story selection based on your karma level")
        }
        .accessibilityElement(children: .contain)
    }
}

struct PlayerStoryView: View {
    @State private var showCards = false
    
    var body: some View {
        ZStack {
            Image("playerStory")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .accessibilityHidden(true)
            
            Button(action: {
                showCards = true
            }) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 220, height: 300)
            }
            .position(x:250, y: 220)
            .accessibilityLabel("Player story")
            .accessibilityHint("Double tap to view player story cards")
            
            // Trigger navigation when showCards is true
            NavigationLink(destination: PstoryView(), isActive: $showCards){
                EmptyView()
            }
            .accessibilityHidden(true)
            
            HStack {
                navButton("profileIcon", destination: ProfileView())
                Spacer()
                navButton("homeIcon", destination: StartView())
            }
            .navigationBarBackButtonHidden(true)
            .padding(.top, -145)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SenaStoryView: View {
    @State private var showCards = false
    
    var body: some View {
        ZStack {
            Image("senastory")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .accessibilityHidden(true)
            
            Button(action: {
                showCards = true
            }) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 220, height: 300)
            }
            .position(x:550, y: 220)
            .accessibilityLabel("Sena story")
            .accessibilityHint("Double tap to view Sena story cards")
            
            // Trigger navigation when showCards is true
            NavigationLink(destination: SstoryView(), isActive: $showCards) {
                EmptyView()
            }
            .accessibilityHidden(true)
            
            HStack {
                navButton("profileIcon", destination: ProfileView())
                Spacer()
                navButton("homeIcon", destination: StartView())
            }
            .navigationBarBackButtonHidden(true)
            .padding(.top, -145)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct BackStoryView: View {
    var body: some View {
        ZStack {
            Image("bothLock")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .accessibilityHidden(true)
            
            HStack {
                navButton("profileIcon", destination: ProfileView())
                Spacer()
                navButton("homeIcon", destination: StartView())
            }
            .navigationBarBackButtonHidden(true)
            .padding(.top, -145)
        }
        .accessibilityLabel("Both stories are locked. Continue playing to unlock them.")
    }
}

private func navButton(_ image: String, destination: some View) -> some View {
    NavigationLink(destination: destination.navigationBarBackButtonHidden(true)) {
        Image(image)
            .resizable()
            .frame(width: 60, height: 60)
            .accessibilityLabel(image == "profileIcon" ? "Profile" : "Home")
    }
    .simultaneousGesture(TapGesture().onEnded {
        SystemSoundManager.shared.play(.button)
    })
}

struct FlippableCard: View {
    let frontText: String
    let backText: String
    let frontFont: Font
    let frontColor: Color
    let backFont: Font
    let backColor: Color
    
    @State private var flipped = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue3)
                .border(.black, width:3)
                .frame(width: 200, height: 300)
                .accessibilityHidden(true)
            
            Text(flipped ? backText : frontText)
                .font(flipped ? backFont : frontFont)
                .foregroundColor(flipped ? backColor : frontColor)
                .bold()
                .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                .accessibilityLabel(flipped ? backText : frontText)
        }
        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .onTapGesture {
            withAnimation {
                flipped.toggle()
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityHint("Double tap to flip the card")
        .accessibilityAddTraits(.isButton)
    }
}

struct CardStyle {
    let frontText: String
    let frontFont: Font
    let frontColor: Color
    let backText: String
    let backFont: Font
    let backColor: Color
}

struct StoryCardView: View {
    let cards: [CardStyle]
    
    var body: some View {
        ZStack {
            Image("blurredbg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .accessibilityHidden(true)
            
            HStack(spacing: 20) {
                ForEach(0..<cards.count, id: \.self) { index in
                    let style = cards[index]
                    FlippableCard(
                        frontText: style.frontText,
                        backText: style.backText,
                        frontFont: style.frontFont,
                        frontColor: style.frontColor,
                        backFont: style.backFont,
                        backColor: style.backColor
                    )
                }
            }
            .accessibilityElement(children: .contain)
        }
    }
}

struct PstoryView: View {
    let language = getLanguagePreference()
    
    var body: some View {
        let cards: [CardStyle] = {
            switch language {
            case .arabic:
                return [
                    CardStyle(frontText: "من؟", frontFont: .title2, frontColor: .black, backText: "هي المعمارية", backFont: .system(size: 18), backColor: .black),
                    CardStyle(frontText: "لماذا؟", frontFont: .title2, frontColor: .black, backText: "لإعادة التوازن", backFont: .body, backColor: .black),
                    CardStyle(frontText: "وماذا بعد؟", frontFont: .title2, frontColor: .black, backText: "اصنع إرثك", backFont: .title3, backColor: .black)
                ]
            case .english:
                return [
                    CardStyle(frontText: "WHO?", frontFont: .title2, frontColor: .black, backText: "She is the Architect", backFont: .system(size: 18), backColor: .black),
                    CardStyle(frontText: "WHY?", frontFont: .title2, frontColor: .black, backText: "To restore balance", backFont: .body, backColor: .black),
                    CardStyle(frontText: "WHAT'S NEXT?", frontFont: .title2, frontColor: .black, backText: "Forge your legacy", backFont: .title3, backColor: .black)
                ]
            }
        }()
        
        return ZStack {
            StoryCardView(cards: cards)
            HStack {
                navButton("profileIcon", destination: ProfileView())
                Spacer()
                navButton("homeIcon", destination: StartView())
            }
            .navigationBarBackButtonHidden(true)
            .padding(.top, -145)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Player story cards")
    }
}

struct SstoryView: View {
    let language = getLanguagePreference()
    
    var body: some View {
        let cards: [CardStyle] = {
            switch language {
            case .arabic:
                return [
                    CardStyle(frontText: "من؟", frontFont: .largeTitle, frontColor: .black, backText: "كل من تقف هنا…\nكان لديه احتمال،\nنسي أن يختاره.\nأنا فقط… جمعتك مع البقيّة", backFont: .system(size: 16), backColor: .black),
                    CardStyle(frontText: "لماذا؟", frontFont: .title, frontColor: .black, backText: "لإعادة التوازن", backFont: .body, backColor: .black),
                    CardStyle(frontText: "ماذا بعد؟", frontFont: .title2, frontColor: .black, backText: "اصنع إرثك", backFont: .title3, backColor: .black)
                ]
            case .english:
                return [
                    CardStyle(frontText: "WHO?", frontFont: .largeTitle, frontColor: .black, backText: "You are the Reclaimer", backFont: .system(size: 18), backColor: .black),
                    CardStyle(frontText: "WHY?", frontFont: .title, frontColor: .black, backText: "To restore balance", backFont: .body, backColor: .black),
                    CardStyle(frontText: "WHAT'S NEXT?", frontFont: .title2, frontColor: .black, backText: "Forge your legacy", backFont: .title3, backColor: .black)
                ]
            }
        }()
        
        return ZStack {
            StoryCardView(cards: cards)
            HStack {
                navButton("profileIcon", destination: ProfileView())
                Spacer()
                navButton("homeIcon", destination: StartView())
            }
            .navigationBarBackButtonHidden(true)
            .padding(.top, -145)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Sena story cards")
    }
}

#Preview {
    BackStoryRouterView(karma: 90)
}
