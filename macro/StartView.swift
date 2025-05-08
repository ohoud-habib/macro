//
//  startView.swift
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
//        ZStack {
//            Image("startScreen")
//                .resizable()
//               // .scaledToFill()
//                .ignoresSafeArea()
//
//            VStack {
//                Spacer()
//                Button(action: {
//                    goToNext = true
//                }) {
//                    Text("START")
//                    
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .foregroundColor(.black)
//                        .padding()
//                        .frame(maxWidth: 200)
//                        .background(Color("green1"))
//                        .cornerRadius(12)
//                }
//                .padding(.bottom, 0)
//            }
//
//            // التنقل للشاشة القادمة
////            NavigationLink(destination: CategoryView(), isActive: $goToNext) {
////                EmptyView()
////            }
//        }
//    }
//}
//
//struct StartView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            StartView()
//        }
//    }
//}
