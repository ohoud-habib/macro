//
//  trainDoorView.swift
//  macro
//
//  Created by ohoud on 10/11/1446 AH.
//
import SwiftUI

struct StartView: View {
    @State private var goToNext = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("startScreen")
                    .resizable()
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                    NavigationLink(destination: TrainDoorView(), isActive: $goToNext) {
                        Button(action: {
                            goToNext = true
                        }) {
                            Text("START")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: 200)
                                .background(Color("green1"))
                                .cornerRadius(12)
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

struct TrainDoorView: View {
    let images = ["trainClosed", "trainHalfOpen", "trainOpen", "trainDoor", "insidemetro1", "insidemetro2"]
    @State private var currentIndex = 0
    @State private var showButtons = false
    @State private var goToAfterMode = false
    @State private var goToEmptyView = false

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
                        NavigationLink(destination: EmptyViewScreen(), isActive: $goToEmptyView) {
                            Button(action: {
                                goToEmptyView = true
                            }) {
                                Text("Back")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.white.opacity(0.8))
                                    .foregroundColor(.black)
                                    .cornerRadius(12)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())

                        NavigationLink(destination: afterMode(), isActive: $goToAfterMode) {
                            Button(action: {
                                goToAfterMode = true
                            }) {
                                Text("Next")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.white.opacity(0.8))
                                    .foregroundColor(.black)
                                    .cornerRadius(12)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.bottom, 40)
                }
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
                if currentIndex < images.count - 1 {
                    currentIndex += 1
                } else {
                    timer.invalidate()
                    showButtons = true
                }
            }
        }
    }
}

struct afterMode: View {
    let images = ["door1", "door2", "door3","infoImage"]
    @State private var currentIndex = 0

    var body: some View {
        ZStack {
            Image(images[currentIndex])
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        currentIndex = (currentIndex + 1) % images.count
                    }
                }
        }
    }
}

struct EmptyViewScreen: View {
    var body: some View {
        Color.blue.ignoresSafeArea()
    }
}

#Preview {
    StartView()
}
