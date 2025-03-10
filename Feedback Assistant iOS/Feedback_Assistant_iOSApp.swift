//
//  Feedback_Assistant_iOSApp.swift
//  Feedback Assistant iOS
//

import SwiftUI

@main
struct Feedback_Assistant_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(StateManager())
    }
}
