//
//  Feedback_Assistant_iOSApp.swift
//  Feedback Assistant iOS
//

import SwiftUI

@main
struct Feedback_Assistant_iOSApp: App {
    @State var stateManager = StateManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(StateManager())
    }
}
