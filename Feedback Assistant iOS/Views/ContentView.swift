//
//  ContentView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct ContentView: View {
    // Variables
    @AppStorage("AcceptedLicense") private var acceptedLicense = false
    @AppStorage("NeedsSignInPad") private var showingSignInSheet = false
    @AppStorage("NeedsSignInPhone") private var showingSignInCover = false
    @AppStorage("SignedIn") private var signedIn = false
    @Environment(\.scenePhase) var scenePhase
    @Environment(StateManager.self) var stateManager: StateManager
    @State var blurRadius: CGFloat = 0
    @State private var showingLicenseSheet = false
    
    var body: some View {
        ZStack {
            if signedIn {
                Color.primary
                    .ignoresSafeArea()
                    .opacity(0.3)
                HStack(spacing: 0.5) {
                    NavigationStack {
                        FeedbackView()
                    }
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 360 : nil)
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        NavigationStack {
                            stateManager.destination
                        }
                    }
                }
            }
        }
        .blur(radius: blurRadius)
        .onAppear {
            showingLicenseSheet = !acceptedLicense
            if acceptedLicense {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    showingSignInSheet = true
                } else {
                    showingSignInCover = true
                }
            }
        }
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .active, .inactive:
                blurRadius = 0
            case .background:
                blurRadius = 25
            @unknown default:
                blurRadius = 0
            }
        }
        .sheet(isPresented: $showingLicenseSheet) {
            NavigationStack {
                LicenseView()
                    .onDisappear {
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            showingSignInSheet = true
                        } else {
                            showingSignInCover = true
                        }
                    }
            }
            .interactiveDismissDisabled()
        }
        .sheet(isPresented: $showingSignInSheet) {
            SignInView(signedIn: $signedIn)
                .interactiveDismissDisabled()
        }
        .fullScreenCover(isPresented: $showingSignInCover) {
            ScrollView {
                SignInView(signedIn: $signedIn)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(StateManager())
}
