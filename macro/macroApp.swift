//
//  macroApp.swift
//  macro
//
//  Created by ohoud on 07/11/1446 AH.
//

import SwiftUI

@main
struct macroApp: App {
    @StateObject private var soundManager = SoundManager.shared
    var body: some Scene {
        WindowGroup {
            IntroView()
                .environmentObject(soundManager)
        }
    }
}
